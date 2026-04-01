const express = require('express');
const mysql   = require('mysql2/promise');
const cors    = require('cors');
require('dotenv').config();
console.log("Database Name from ENV:", process.env.DB_NAME);

const app = express();
app.use(cors());
app.use(express.json());

// --- Database Connection Pool ---
// A "pool" is just a collection of reusable connections.
// Instead of opening/closing a connection on every request,
// the pool keeps a few open and reuses them — faster and cleaner.
const pool = mysql.createPool({
  host: '127.0.0.1',     // Use the IP instead of 'localhost'
  user: 'root',
  password: '',          // Keep this empty
  database: 'drip_store',
  port: 3306             // Explicitly use the DB port
});

// Test the connection on startup
pool.getConnection()
  .then(() => console.log('✅ Connected to MySQL'))
  .catch(err => console.error('❌ DB Connection Failed:', err.message));


// =====================
//   PRODUCTS ROUTES
// =====================

// GET all products
app.get('/api/products', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM products');
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// GET one product by ID
app.get('/api/products/:id', async (req, res) => {
  try {
    const [rows] = await pool.query(
      'SELECT * FROM products WHERE id = ?',
      [req.params.id]
    );
    if (rows.length === 0)
      return res.status(404).json({ error: 'Product not found' });
    res.json(rows[0]);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// POST add a product (admin)
app.post('/api/products', async (req, res) => {
  try {
    const { name, price, category, image_url, description } = req.body;
    await pool.query(
      'INSERT INTO products (name, price, category, image_url, description) VALUES (?, ?, ?, ?, ?)',
      [name, price, category, image_url, description]
    );
    res.json({ message: 'Product added successfully' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// DELETE a product (admin)
app.delete('/api/products/:id', async (req, res) => {
  try {
    await pool.query('DELETE FROM products WHERE id = ?', [req.params.id]);
    res.json({ message: 'Product deleted' });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});


// =====================
//    ORDERS ROUTES
// =====================

// POST place an order
app.post('/api/orders', async (req, res) => {
  try {
    const { customer_name, customer_email, total, items } = req.body;

    // 1. Insert the order, get back its new ID
    const [result] = await pool.query(
      'INSERT INTO orders (customer_name, customer_email, total) VALUES (?, ?, ?)',
      [customer_name, customer_email, total]
    );
    const orderId = result.insertId; // MySQL gives you the new row's ID here

    // 2. Insert each cart item linked to that order
    for (const item of items) {
      await pool.query(
        'INSERT INTO order_items (order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)',
        [orderId, item.product_id, item.quantity, item.price]
      );
    }

    res.json({ message: 'Order placed!', orderId });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// GET all orders (admin view)
app.get('/api/orders', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM orders ORDER BY created_at DESC');
    res.json(rows);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});


// --- Start Server ---
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`🚀 Server running on http://localhost:${PORT}`));