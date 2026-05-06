const express = require('express');
const mysql = require('mysql2/promise');
const cors = require('cors');
require('dotenv').config();

const app = express();

app.use(cors());
app.use(express.json());

const pool = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  port: process.env.DB_PORT || 3306
});

pool.getConnection()
  .then(conn => {
    console.log('Connected to MySQL');
    conn.release();
  })
  .catch(err => console.error('DB Connection Failed:', err.message));

// PRODUCTS
app.get('/api/products', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM products');
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

app.get('/api/products/:id', async (req, res) => {
  try {
    const [rows] = await pool.query(
      'SELECT * FROM products WHERE id = ?',
      [req.params.id]
    );

    if (rows.length === 0) {
      return res.status(404).json({ error: 'Product not found' });
    }

    res.json(rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

app.post('/api/products', requireAdmin, async (req, res) => {
  try {

    const { name, price, category, image_url, description } = req.body;

    if (!name || !price || !category || !image_url) {
      return res.status(400).json({ error: 'Missing required fields' });
    }

    const [result] = await pool.query(
      'INSERT INTO products (name, price, category, image_url, description) VALUES (?, ?, ?, ?, ?)',
      [name, price, category, image_url, description]
    );

    res.status(201).json({
      message: 'Product added successfully',
      productId: result.insertId
    });
  } catch (err) {
    console.log('ADD PRODUCT ERROR:', err.message);
    res.status(500).json({ error: err.message });
  }
});

app.delete('/api/products/:id', requireAdmin, async (req, res) => {
  try {
    await pool.query('DELETE FROM products WHERE id = ?', [req.params.id]);
    res.json({ message: 'Product deleted' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// ORDERS
app.post('/api/orders', async (req, res) => {
  const connection = await pool.getConnection();

  try {
    const { customer_name, customer_email, items } = req.body;

    if (!customer_name || !customer_email || !Array.isArray(items) || items.length === 0) {
      return res.status(400).json({ error: 'Invalid order data' });
    }

    await connection.beginTransaction();

    let total = 0;
    const orderItems = [];

    for (const item of items) {
      const productId = Number(item.product_id);
      const quantity = Number(item.quantity);

      if (!productId || !quantity || quantity <= 0) {
        throw new Error('Invalid product or quantity');
      }

      const [products] = await connection.query(
        'SELECT id, price FROM products WHERE id = ?',
        [productId]
      );

      if (products.length === 0) {
        throw new Error(`Product not found: ${productId}`);
      }

      const product = products[0];
      const price = Number(product.price);

      total += price * quantity;

      orderItems.push({
        product_id: product.id,
        quantity,
        price
      });
    }

    const [result] = await connection.query(
      'INSERT INTO orders (customer_name, customer_email, total) VALUES (?, ?, ?)',
      [customer_name, customer_email, total]
    );

    const orderId = result.insertId;

    for (const item of orderItems) {
      await connection.query(
        'INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)',
        [orderId, item.product_id, item.quantity, item.price]
      );
    }

    await connection.commit();

    res.status(201).json({
      message: 'Order placed!',
      orderId,
      total
    });

  } catch (err) {
    await connection.rollback();
    console.log('ORDER ERROR:', err.message);
    res.status(500).json({ error: err.message });
  } finally {
    connection.release();
  }
});

app.get('/api/orders', requireAdmin, async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM orders ORDER BY created_at DESC');
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});


const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');

const JWT_SECRET = process.env.JWT_SECRET || 'drip_secret_key';

function requireAdmin(req, res, next) {
  
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];

  if (!token) {
    return res.status(401).json({ error: 'No token' });
  }

  try {
    const decoded = jwt.verify(token, JWT_SECRET);

    if (decoded.role !== 'admin') {
      return res.status(403).json({ error: 'Admins only' });
    }

    req.user = decoded;
    next();
  } catch (err) {
    console.log('JWT ERROR:', err.message);
    return res.status(401).json({ error: 'Invalid token' });
  }
}

// REGISTER
app.post('/api/register', async (req, res) => {
  try {
    const { full_name, email, password } = req.body;
    const hashed = await bcrypt.hash(password, 10);
    await pool.query(
      'INSERT INTO users (full_name, email, password) VALUES (?, ?, ?)',
      [full_name, email, hashed]
    );
    res.json({ message: 'Account created' });
  } catch (err) {
    if (err.code === 'ER_DUP_ENTRY') {
      res.status(400).json({ error: 'Email already registered' });
    } else {
      res.status(500).json({ error: err.message });
    }
  }
});

// LOGIN
app.post('/api/login', async (req, res) => {
  try {
    const { email, password } = req.body;
    const [rows] = await pool.query('SELECT * FROM users WHERE email = ?', [email]);
    if (rows.length === 0) return res.status(401).json({ error: 'Invalid credentials' });
    const user = rows[0];
    const match = await bcrypt.compare(password, user.password);
    if (!match) return res.status(401).json({ error: 'Invalid credentials' });
    const token = jwt.sign({ id: user.id, role: user.role }, JWT_SECRET, { expiresIn: '7d' });
    res.json({ token, role: user.role, full_name: user.full_name });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});


const PORT = process.env.PORT || 5001;
app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});