# DRIP Store

DRIP Store is a simple full-stack e-commerce website built for a university project.

It uses:

- Vanilla JavaScript for the frontend
- Express.js for the backend
- MySQL for the database

## Features

- View all products
- View product details
- Add products to cart
- Checkout and place orders
- Admin page to add products
- Admin page to delete products
- Orders stored in MySQL

## Tech Stack

### Frontend
- HTML
- CSS
- Vanilla JavaScript

### Backend
- Node.js
- Express.js

### Database
- MySQL

## Project Structure

```bash
DRIP/
│
├── index.html
├── shop.html
├── product.html
├── cart.html
├── checkout.html
├── admin.html
├── style.css
├── app.js
│
├── backend/
│   ├── server.js
│   ├── package.json
│   └── .env
│
└── drip_store.sql
```

## Live Demo

### Frontend
Hosted on Netlify

### Backend API
Hosted on Railway

### Database
Hosted on Railway MySQL

## API Base URL

The frontend automatically switches between local and deployed backend:

```js
const API =
  window.location.hostname === '127.0.0.1' ||
  window.location.hostname === 'localhost'
    ? 'http://localhost:5000/api'
    : 'https://drip-production-deca.up.railway.app/api';
```

## Local Setup

Follow these steps to run the project locally.

### 1. Clone the repository

```bash
git clone <your-repo-url>
cd DRIP
```

### 2. Import the database

Open phpMyAdmin or MySQL Workbench and import the file:

```bash
drip_store.sql
```

This will create the required tables:

- `products`
- `orders`
- `order_items`

### 3. Configure backend environment variables

Inside `backend/.env` add:

```env
DB_HOST=127.0.0.1
DB_PORT=3306
DB_USER=root
DB_PASSWORD=
DB_NAME=drip_store
PORT=5000
```

Adjust these values if your local MySQL setup is different.

### 4. Install backend dependencies

```bash
cd backend
npm install
```

### 5. Start the backend server

```bash
npm start
```

The backend should run on:

```bash
http://localhost:5000
```

### 6. Run the frontend

Open the frontend files with Live Server in VS Code or open `index.html` in the browser.

Recommended:
- Right click `index.html`
- Choose **Open with Live Server**

The frontend should open on something like:

```bash
http://127.0.0.1:5500
```

Since the frontend detects localhost automatically, it will connect to:

```bash
http://localhost:5000/api
```

## Deployment Setup

This project was deployed using:

- **Frontend:** Netlify
- **Backend:** Railway
- **Database:** Railway MySQL

## Railway Backend Environment Variables

The backend service on Railway uses:

```env
DB_HOST=${{MySQL.MYSQLHOST}}
DB_PORT=${{MySQL.MYSQLPORT}}
DB_USER=${{MySQL.MYSQLUSER}}
DB_PASSWORD=${{MySQL.MYSQLPASSWORD}}
DB_NAME=${{MySQL.MYSQLDATABASE}}
```

## Important Notes

- Do not upload `.env` to GitHub
- Do not upload `node_modules`
- Make sure MySQL is running before starting the backend locally
- Make sure the database `drip_store` exists locally
- Make sure the SQL dump is imported before testing orders or products

## Troubleshooting

### Products do not load
Check:

- backend server is running
- MySQL is running
- database is imported
- API URL is correct

### CORS error
Make sure backend uses:

```js
app.use(cors());
```

### Local database connection fails
Check your `.env` values and verify MySQL credentials.

## Future Improvements

- User authentication
- Search and filtering
- Edit product feature
- Better admin dashboard
- Payment integration
- Image upload instead of image URL

## Author

Built by AbdelHameed as a university project.