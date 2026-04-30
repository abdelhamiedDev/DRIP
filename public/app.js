// ========================
// CONFIGURATION
// ========================
const API = (window.location.hostname === 'localhost' || window.location.hostname === '127.0.0.1')
  ? 'http://localhost:5000/api'
  : 'https://drip-production-deca.up.railway.app/api'; // Change this to your actual API endpoint


// ========================
// CART (stored in localStorage)
// localStorage is like a tiny notepad built into the browser.
// It saves data even after you close the tab.
// ========================
function getCart() {
  return JSON.parse(localStorage.getItem('cart') || '[]');
}

function saveCart(cart) {
  localStorage.setItem('cart', JSON.stringify(cart));
  updateCartCount();
}

function addToCart(product) {
  const cart = getCart();
  const existing = cart.find(item => item.id === product.id);
  if (existing) {
    existing.quantity += 1;
  } else {
    cart.push({ ...product, quantity: 1 });
  }
  saveCart(cart);
  showToast(`${product.name} added to cart!`);
}

function removeFromCart(productId) {
  const cart = getCart().filter(item => item.id !== productId);
  saveCart(cart);
}

function clearCart() {
  localStorage.removeItem('cart');
  updateCartCount();
}

function getCartTotal() {
  return getCart().reduce((sum, item) => sum + item.price * item.quantity, 0);
}

function updateCartCount() {
  const countEl = document.getElementById('cart-count');
  if (!countEl) return;
  const total = getCart().reduce((sum, item) => sum + item.quantity, 0);
  countEl.textContent = total;
}


// ========================
// TOAST NOTIFICATION
// A toast is a small popup message that appears briefly.
// ========================
function showToast(message) {
  let toast = document.getElementById('toast');
  if (!toast) {
    toast = document.createElement('div');
    toast.id = 'toast';
    document.body.appendChild(toast);
  }
  toast.textContent = message;
  toast.classList.add('show');
  setTimeout(() => toast.classList.remove('show'), 2500);
}


// ========================
// NAVBAR — injected into every page
// ========================
function renderNavbar() {
  const nav = document.getElementById('navbar');
  if (!nav) return;
  const role = localStorage.getItem('role');
  const token = localStorage.getItem('token');
  const full_name = localStorage.getItem('full_name');

  nav.innerHTML = `
    <nav class="navbar">
      <a href="index.html" class="navbar-logo">DRIP</a>
      <div class="navbar-links">
        <a href="index.html">Home</a>
        <a href="shop.html">Shop</a>
        ${role === 'admin' ? '<a href="admin.html">Admin</a>' : ''}
      </div>
      <div class="navbar-actions">
        ${token
          ? `<span style="font-size:12px;color:var(--muted);letter-spacing:1px">${full_name}</span>
             <button onclick="logout()" class="btn-outline" style="padding:8px 16px;font-size:12px">Logout</button>`
          : `<a href="login.html" style="font-size:13px;letter-spacing:2px;color:var(--muted)">Sign In</a>
             <a href="register.html" style="font-size:13px;letter-spacing:2px;color:var(--muted)">Register</a>`
        }
        <a href="cart.html" class="cart-btn">
          🛒 Cart <span id="cart-count">0</span>
        </a>
      </div>
    </nav>
  `;
  updateCartCount();
}

function logout() {
  localStorage.removeItem('token');
  localStorage.removeItem('role');
  localStorage.removeItem('full_name');
  localStorage.removeItem('cart');
  window.location.href = 'index.html';
}

// ========================
// RUN ON EVERY PAGE LOAD
// ========================
document.addEventListener('DOMContentLoaded', () => {
  renderNavbar();
});
