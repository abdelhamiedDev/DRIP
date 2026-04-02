// ========================
// CONFIGURATION
// ========================
const API = 'https://drip-production-deca.up.railway.app/api';


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
  nav.innerHTML = `
    <nav class="navbar">
      <a href="index.html" class="navbar-logo">DRIP</a>
      <div class="navbar-links">
        <a href="index.html">Home</a>
        <a href="shop.html">Shop</a>
        <a href="admin.html">Admin</a>
      </div>
      <div class="navbar-actions">
        <a href="cart.html" class="cart-btn">
          🛒 Cart <span id="cart-count">0</span>
        </a>
      </div>
    </nav>
  `;
  updateCartCount();
}


// ========================
// RUN ON EVERY PAGE LOAD
// ========================
document.addEventListener('DOMContentLoaded', () => {
  renderNavbar();
});
