-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Apr 02, 2026 at 07:20 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `drip_store`
--

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `customer_name` varchar(255) NOT NULL,
  `customer_email` varchar(255) NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `customer_name`, `customer_email`, `total`, `created_at`) VALUES
(1, 'Ahmed Ramzy', 'rody78787@gmail.com', 90.00, '2026-04-01 17:15:45');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

CREATE TABLE `order_items` (
  `id` int(11) NOT NULL,
  `order_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL,
  `quantity` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `product_id`, `quantity`, `price`) VALUES
(1, 1, 6, 1, 90.00);

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `category` enum('tops','bottoms','accessories') NOT NULL,
  `image_url` text NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Table structure for table `users` 
--
CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  full_name VARCHAR(100) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  role ENUM('user', 'admin') DEFAULT 'user',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `price`, `category`, `image_url`, `description`, `created_at`) VALUES
(1, 'Void Oversized Tee', 35.00, 'tops', 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=800', 'Heavyweight cotton oversized fit.', '2026-03-31 01:05:31'),
(2, 'Phantom Cargoes', 65.00, 'bottoms', 'https://i.pinimg.com/736x/6c/80/5a/6c805a1b61ee619b871b8e376b12f2ba.jpg', 'Multi-pocket tactical pants.', '2026-03-31 01:05:31'),
(3, 'Neon Beanie', 20.00, 'accessories', 'https://images.unsplash.com/photo-1576871337632-b9aef4c17ab9?w=800', 'Signature lime green knit.', '2026-03-31 01:05:31'),
(4, 'Oversized Tee', 35.00, 'tops', 'https://images.unsplash.com/photo-1693443688057-85f57b872a3c?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'A clean oversized tee', '2026-03-31 01:08:34'),
(5, 'Cargo Pants', 75.00, 'bottoms', 'https://i.pinimg.com/736x/2a/0b/9f/2a0b9fad35f71555fa763eb1365b30e9.jpg', 'Utility cargo pants', '2026-03-31 01:08:34'),
(6, 'Hoodie', 90.00, 'tops', 'https://i.pinimg.com/avif/1200x/7a/b5/0d/7ab50d17b4173cbe17c8c89c970b0cd6.avf', 'Heavy blend hoodie', '2026-03-31 01:08:34'),
(7, 'Bucket Hat', 40.00, 'accessories', 'https://i.pinimg.com/1200x/c9/c1/dd/c9c1ddac7b8b10fa561d5ec4ee3444a4.jpg', 'Structured bucket hat', '2026-03-31 01:08:34'),
(8, 'Joggers', 60.00, 'bottoms', 'https://i.pinimg.com/1200x/bd/27/96/bd27968a69a239e3945eab97d2d17cfc.jpg', 'Slim fit joggers', '2026-03-31 01:08:34'),
(9, 'Bomber Jacket', 130.00, 'tops', 'https://i.pinimg.com/avif/1200x/07/8c/68/078c689fe8f9aacb08168de93a552cca.avf', 'Satin bomber jacket', '2026-03-31 01:08:34');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `order_items`
--
ALTER TABLE `order_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `order_id` (`order_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `order_items`
--
ALTER TABLE `order_items`
  ADD CONSTRAINT `order_items_ibfk_1` FOREIGN KEY (`order_id`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `order_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
