-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 04, 2026 at 08:12 PM
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
(1, 'Ahmed Ramzy', 'rody78787@gmail.com', 90.00, '2026-04-01 17:15:45'),
(2, 'zeyad Mohamed', 'Zeyad.moh@gmail.com', 35.00, '2026-05-04 12:15:46'),
(3, 'zeyad Mohamed', 'Zeyad.moh@gmail.com', 225.00, '2026-05-04 12:18:27'),
(4, 'zeyad Mohamed', 'Zeyad.moh@gmail.com', 35.00, '2026-05-04 12:20:24'),
(5, 'zeyad Mohamed', 'Zeyad.moh@gmail.com', 35.00, '2026-05-04 12:25:01'),
(6, 'zeyad Mohamed', 'Zeyad.moh@gmail.com', 65.00, '2026-05-04 12:25:59'),
(7, 'zeyad Mohamed', 'Zeyad.moh@gmail.com', 35.00, '2026-05-04 12:29:28'),
(8, 'zeyad Mohamed', 'Zeyad.moh@gmail.com', 35.00, '2026-05-04 12:30:30'),
(9, 'zeyad Mohamed', 'Zeyad.moh@gmail.com', 35.00, '2026-05-04 12:38:49'),
(10, 'zeyad Mohamed', 'Zeyad.moh@gmail.com', 65.00, '2026-05-04 12:47:04'),
(11, 'zeyad Mohamed', 'Zeyad.moh@gmail.com', 35.00, '2026-05-04 13:30:04');

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
(1, 1, 6, 1, 90.00),
(2, 2, 1, 1, 35.00),
(3, 3, 9, 1, 130.00),
(4, 3, 8, 1, 60.00),
(5, 3, 1, 1, 35.00),
(6, 4, 1, 1, 35.00),
(7, 5, 1, 1, 35.00),
(8, 6, 2, 1, 65.00),
(9, 7, 1, 1, 35.00),
(10, 8, 1, 1, 35.00),
(11, 9, 4, 1, 35.00),
(12, 10, 2, 1, 65.00),
(13, 11, 1, 1, 35.00);

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
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `price`, `category`, `image_url`, `description`, `created_at`) VALUES
(1, 'Void Oversized Tee', 35.00, 'tops', 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=800', 'Heavyweight cotton oversized fit.', '2026-03-31 01:05:31'),
(2, 'Phantom Cargoes', 65.00, 'bottoms', 'https://i.pinimg.com/736x/6c/80/5a/6c805a1b61ee619b871b8e376b12f2ba.jpg', 'Multi-pocket tactical pants.', '2026-03-31 01:05:31'),
(4, 'Oversized Tee', 35.00, 'tops', 'https://images.unsplash.com/photo-1693443688057-85f57b872a3c?q=80&w=1974&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 'A clean oversized tee', '2026-03-31 01:08:34'),
(5, 'Cargo Pants', 75.00, 'bottoms', 'https://i.pinimg.com/736x/2a/0b/9f/2a0b9fad35f71555fa763eb1365b30e9.jpg', 'Utility cargo pants', '2026-03-31 01:08:34'),
(6, 'Hoodie', 90.00, 'tops', 'https://i.pinimg.com/avif/1200x/7a/b5/0d/7ab50d17b4173cbe17c8c89c970b0cd6.avf', 'Heavy blend hoodie', '2026-03-31 01:08:34'),
(7, 'Bucket Hat', 40.00, 'accessories', 'https://i.pinimg.com/1200x/c9/c1/dd/c9c1ddac7b8b10fa561d5ec4ee3444a4.jpg', 'Structured bucket hat', '2026-03-31 01:08:34'),
(8, 'Joggers', 60.00, 'bottoms', 'https://i.pinimg.com/1200x/bd/27/96/bd27968a69a239e3945eab97d2d17cfc.jpg', 'Slim fit joggers', '2026-03-31 01:08:34'),
(9, 'Bomber Jacket', 130.00, 'tops', 'https://i.pinimg.com/avif/1200x/07/8c/68/078c689fe8f9aacb08168de93a552cca.avf', 'Satin bomber jacket', '2026-03-31 01:08:34');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `full_name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `role` enum('user','admin') DEFAULT 'user',
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `full_name`, `email`, `password`, `role`, `created_at`) VALUES
(1, 'Test User', 'test@test.com', '$2b$10$yFgBEaMFBm9eIfo3oOKHzOrsXNQ8riBrzpJJdoKC5jXx6I7Sp/zze', 'user', '2026-04-30 15:48:16'),
(2, 'alaaeldin', 'medo91057@gmail.com', '$2b$10$iQTlCzTkfW48HWmJuWGyJu9eqVFWN6tjdsB4mJ72fU6E5Ygto5I4m', 'admin', '2026-04-30 15:52:59'),
(3, 'Zeyad Mohamed', 'Zeyad.moh@gmail.com', '$2b$10$qQX4yV51N2VDXDN1tUDlO.a2ZTJvW0gomOdCohllxoFO6s5O7NSx6', 'user', '2026-05-04 12:13:09'),
(4, 'abdelrahman Mohamed', 'abdelrahman.moh@gmail.com', '$2b$10$PNomoAL1o0wEBqXwAPsgEePUHamFXgMhEoKk1AxJL0Vsvl955Kiv6', 'user', '2026-05-04 12:17:18');
  
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
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `order_items`
--
ALTER TABLE `order_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

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
