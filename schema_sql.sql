-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Nov 14, 2026 at 10:34 AM
-- Server version: 8.4.7
-- PHP Version: 8.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `schema.sql`
--

-- --------------------------------------------------------

--
-- Table structure for table `login_attempts`
--

DROP TABLE IF EXISTS `login_attempts`;
CREATE TABLE IF NOT EXISTS `login_attempts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip_address` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `attempt_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `success` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_user_time` (`username`,`attempt_time`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `menus`
--

DROP TABLE IF EXISTS `menus`;
CREATE TABLE IF NOT EXISTS `menus` (
  `id` int NOT NULL AUTO_INCREMENT,
  `restaurant_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `is_available` tinyint(1) DEFAULT '1',
  `description` text COLLATE utf8mb4_unicode_ci,
  `category` enum('Burgers','Combos','Sides','Drinks') COLLATE utf8mb4_unicode_ci DEFAULT 'Burgers',
  `image_url` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ;

--
-- Dumping data for table `menus`
--

INSERT INTO `menus` (`id`, `restaurant_name`, `item_name`, `price`, `is_available`, `description`, `category`, `image_url`, `created_at`) VALUES
(1, 'Burger King', 'Whopper', 15.50, 1, 'Our signature flame-grilled beef burger.', 'Burgers', 'images/Whopper.jpg', '2026-11-14 08:25:05'),
(2, 'Burger King', 'French Fries', 6.50, 1, 'Golden crispy fries.', 'Sides', 'images/fries.jpg', '2026-11-14 08:25:05'),
(3, 'Burger King', 'Coke', 4.50, 1, 'Ice cold Coca-Cola.', 'Drinks', 'images/coke.jpg', '2026-11-14 08:25:05'),
(4, 'Burger King', 'Whopper Combo Meal', 25.50, 1, 'Flame-grilled Whopper + French Fries + Soft Drink.', 'Combos', 'images/combo1.jpg', '2026-11-14 10:27:06'),
(5, 'Burger King', 'Sprite', 4.50, 1, 'Refreshing lemon-lime soda.', 'Drinks', 'images/sprite.jpg', '2026-11-14 10:27:06'),
(6, 'Burger King', 'Chocolate ice Cream', 5.50, 1, 'Creamy and smooth chocolate soft serve.', 'Sides', 'images/icecream_choc.jpg', '2026-11-14 10:27:06');

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
CREATE TABLE IF NOT EXISTS `orders` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `total_amount` decimal(10,2) NOT NULL,
  `delivery_address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` enum('pending','accepted','delivering','delivered','cancelled','preparing') COLLATE utf8mb4_unicode_ci DEFAULT 'pending',
  `payment_method` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `total_amount`, `delivery_address`, `status`, `payment_method`, `created_at`) VALUES
(11, 2, 11.00, '123, Jalan Ampang, KL', 'delivered', 'E-Wallet', '2026-11-14 10:19:34');

-- --------------------------------------------------------

--
-- Table structure for table `order_items`
--

DROP TABLE IF EXISTS `order_items`;
CREATE TABLE IF NOT EXISTS `order_items` (
  `id` int NOT NULL AUTO_INCREMENT,
  `order_id` int NOT NULL,
  `menu_id` int NOT NULL,
  `quantity` int NOT NULL,
  `price_at_order` decimal(10,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `order_id` (`order_id`),
  KEY `menu_id` (`menu_id`)
) ;

--
-- Dumping data for table `order_items`
--

INSERT INTO `order_items` (`id`, `order_id`, `menu_id`, `quantity`, `price_at_order`) VALUES
(16, 11, 3, 1, 4.50),
(15, 11, 2, 1, 6.50);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password_hash` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mfa_enabled` tinyint(1) NOT NULL DEFAULT '1',
  `mfa_code` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mfa_expiry` datetime DEFAULT NULL,
  `role` enum('user','admin','rider','merchant') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'user',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `email` (`email`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `email`, `password_hash`, `mfa_enabled`, `mfa_code`, `mfa_expiry`, `role`, `created_at`) VALUES
(1, 'hanis', 'hanis@gmail.com', '$argon2id$v=19$m=65536,t=4,p=2$WmtUWWdtbkI3YkhXUmVTQw$LdTRGzwnnNG0lK7FDtCsaz/iz6bF4QRvpDH4TFQ5CbI', 1, NULL, NULL, 'user', '2026-11-14 08:26:50'),
(2, 'nnanisni', 'nani@gmail.com', '$2y$10$XruIKywqrtAVUMIZZEoxKOWlN7uTzNMJczmjg831dgGPHmkF4YyzS', 1, NULL, NULL, 'user', '2026-11-14 08:52:01');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
