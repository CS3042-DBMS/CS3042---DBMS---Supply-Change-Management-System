-- phpMyAdmin SQL Dump
-- version 5.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 14, 2021 at 05:43 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cs3042-dbms`
--

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE `customer` (
  `customer_id` int(11) NOT NULL,
  `customer_name` varchar(100) NOT NULL,
  `customer_address` text NOT NULL,
  `city` varchar(50) NOT NULL,
  `password` text NOT NULL,
  `email` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_id`, `customer_name`, `customer_address`, `city`, `password`, `email`) VALUES
(3, 'aaaa', 'aaaa', 'New Hampton', '$2b$10$uiSWRvrR/SKORmQ15mDDuukkBk2Dq5EFQWYEZ0oDbRvugRfXLv3ae', 'lisasulu999@gmail.com'),
(4, 'aaaa', 'aaaa', 'New Hampton', '$2b$10$E0ZccGi1TUdRCWzcKgmZwepGfZZFMj1RfBQ3zOER1P1veYafsX0Nu', 'lisasulu999@gmail.com'),
(5, 'aaaa', 'awwawaw', 'New Hampton', '$2b$10$GsUNBBY5CJvMM.3nKHc9y.ISKDMdqa.blKl0HpsVryR3w/C8iucS6', 'lisasulu999@gmail.com'),
(6, 'aaaa', 'awwawaw', 'New Hampton', '$2b$10$ALtBvOU237YMbtXdp0SgVOXP8fUucadfd87i23e847yBIuK0.JAdq', 'lisasulu999@gmail.com'),
(7, 'aaaa', 'awwawaw', 'New Hampton', '$2b$10$VlFIpaNwdTFe4Tm3ur1OF.lTgJNADB9CT.Rv35Ivt4gyfM.c71O2a', 'lisasulu999@gmail.com'),
(8, 'aaaa', 'awwawaw', 'New Hampton', '$2b$10$JUKfIhgeBHp.vzVwUTNDz.OBiJ51pO6o/7qrGmgqvyGJGZWzeW59W', 'lisasulu999@gmail.com'),
(9, 'aaaa', 'awwawaw', 'New Hampton', '$2b$10$lJvOT.lnyDokYyOrxboAWuiorcLcp26s/O1/qza8FfQ.4hsRaJ4uG', 'lisasulu999@gmail.com'),
(10, 'aaaa', 'awwawaw', 'New Hampton', '$2b$10$I.hUCSGjhVIbVEpuckdlS.ANN0avlsl/6BAQn/C7g.kIAVBEjln3i', 'lisasulu999@gmail.com'),
(11, 'aaaa', 'awwawaw', 'New Hampton', '$2b$10$v46U.2a2gIvdM99OSpBmjudNisbhgAITPOMo82zWYoZPmYYmalhMO', 'lisasulu999@gmail.com'),
(12, 'aaaa', 'awwawaw', 'New Hampton', '$2b$10$QNyFWDIc1NFaysGVN/BAmer7jXqZugqkl1ZOzkwaQuUnieOq0AZRK', 'lisasulu999@gmail.com'),
(13, 'aaaa', 'awwawaw', 'New Hampton', '$2b$10$N9VYnD/ljcF26BipnuqZMOTet7vLvhvM..YVvUV77gEM8ouUmfMru', 'lisasulu999@gmail.com'),
(14, 'aaaa', 'aaaa', 'New Hampton', '$2b$10$i0mHoGlHloHF5ReUWRCWsuQU8QIk.smljB0DEZr.yk8/B6ZJ7RAUq', 'lisasulu999@gmail.com');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
