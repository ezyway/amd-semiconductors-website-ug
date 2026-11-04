-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 16, 2019 at 01:41 AM
-- Server version: 10.3.15-MariaDB
-- PHP Version: 7.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `project`
--

-- --------------------------------------------------------

--
-- Table structure for table `cpu`
--

CREATE TABLE `cpu` (
  `no` int(11) NOT NULL,
  `series` varchar(20) NOT NULL,
  `name` varchar(50) NOT NULL,
  `cores_threads` varchar(10) NOT NULL,
  `stock_freq` varchar(11) NOT NULL,
  `boost_freq` varchar(11) NOT NULL,
  `transistor_size` varchar(11) NOT NULL,
  `total_cache` varchar(11) NOT NULL,
  `l1` varchar(11) NOT NULL,
  `l2` varchar(11) NOT NULL,
  `l3` varchar(11) NOT NULL,
  `cooler` varchar(40) NOT NULL,
  `TDP` varchar(11) NOT NULL,
  `prize` varchar(11) NOT NULL,
  `discount` int(11) NOT NULL,
  `url` varchar(10000) NOT NULL,
  `type` varchar(10) NOT NULL,
  `img` varchar(10000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cpu`
--

INSERT INTO `cpu` (`no`, `series`, `name`, `cores_threads`, `stock_freq`, `boost_freq`, `transistor_size`, `total_cache`, `l1`, `l2`, `l3`, `cooler`, `TDP`, `prize`, `discount`, `url`, `type`, `img`) VALUES
(1, 'Ryzen 9', '3900X', '12/24', '3.8 GHz', '4.6 GHz', '7 nm', '64 KB', '64 KB', '6 MB', '64 MB', 'Wraith Prism RGB', '105', '45,000', 0, 'https://www.amazon.in/s?k=Ryzen+9+3900X', 'server', 'upload/cpu/Ryzen9_3900X.jpg'),
(2, 'Ryzen 9', '3950X', '16/32', '3.5 GHz', '4.7 GHz', '7 nm', '-', '-', '8 MB', '64 MB', 'Wraith Prism RGB', '105', '53,000', 0, 'https://www.amazon.in/s?k=Ryzen+9+3950X', 'consumer', 'upload/cpu/Ryzen9_3950X.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE `feedback` (
  `no` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(200) NOT NULL,
  `phone` int(10) NOT NULL,
  `date` varchar(100) NOT NULL,
  `time` varchar(100) NOT NULL,
  `ip` varchar(200) NOT NULL,
  `feedback` varchar(10000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `feedback`
--

INSERT INTO `feedback` (`no`, `name`, `email`, `phone`, `date`, `time`, `ip`, `feedback`) VALUES
(13, 'Sreyas CV', 'sreyas@gmail.com', 1234567890, '22 - August - 2019', '0:34:47 PM', '::1', 'fdg'),
(14, 'Sreyas CV', 'sreyas@gmail.com', 1234567890, '22 - August - 2019', '0:35:51 PM', '::1', 'sadasdsa'),
(15, 'Sreyas CV', 'sreyas@gmail.com', 1234567890, '22 - August - 2019', '0:37:18 PM', '::1', 'as12312312'),
(17, 'Sreyas CV', 'sreyas@gmail.com', 1234567890, '22 - August - 2019', '0:59:17 PM', '::1', 'sd'),
(18, 'Sreyas CV', 'sreyas@gmail.com', 1234567890, '22 - August - 2019', '1:07:56 PM', '::1', 'sadd'),
(19, 'Sreyas CV', 'sreyas@gmail.com', 1234567890, '22 - August - 2019', '1:20:42 PM', '::1', 'sfs'),
(22, 'Sreyas CV', 'sreyas@gmail.com', 1234567890, '16 - September - 2019', '3:36:26 AM', '::1', 'sklad');

-- --------------------------------------------------------

--
-- Table structure for table `gpu`
--

CREATE TABLE `gpu` (
  `no` int(11) NOT NULL,
  `series` varchar(50) NOT NULL,
  `name` varchar(50) NOT NULL,
  `compute_units` varchar(11) NOT NULL,
  `stream_processors` varchar(11) NOT NULL,
  `texture_units` varchar(11) NOT NULL,
  `stock_freq` varchar(20) NOT NULL,
  `boost_freq` varchar(20) NOT NULL,
  `game_freq` varchar(20) NOT NULL,
  `transistor_size` varchar(20) NOT NULL,
  `transistor_count` varchar(20) NOT NULL,
  `output` varchar(200) NOT NULL,
  `memory_type` varchar(10) NOT NULL,
  `VRAM` varchar(10) NOT NULL,
  `prize` varchar(90) NOT NULL,
  `discount` int(11) NOT NULL,
  `url` varchar(10000) NOT NULL,
  `type` varchar(10) NOT NULL,
  `img` varchar(10000) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `gpu`
--

INSERT INTO `gpu` (`no`, `series`, `name`, `compute_units`, `stream_processors`, `texture_units`, `stock_freq`, `boost_freq`, `game_freq`, `transistor_size`, `transistor_count`, `output`, `memory_type`, `VRAM`, `prize`, `discount`, `url`, `type`, `img`) VALUES
(1, 'Radeon', 'RX 5700 XT', '40', '2560', '160', '1605 MHz', '1905 MHz', '1755 MHz', '7 nm', '10.3 Billion', 'Display Port 1.4 with DSC\r\nHDMI 4K 60FPS', 'GDDR6', '8 GB', '40,000', 0, 'https://www.amazon.in/s?k=rx+5700+xt', 'consumer', 'upload/gpu/Radeon_RX_5700_XT.jpg'),
(2, 'Radeon', 'RX 5700', '36', '2304', '144', '1465 MHz', '1725 MHz', '1625 MHz', '7 nm', '10.3 Billion', 'Display Port 1.4 with DSC,\r\nHDMI 4K 60FPS', 'GDDR6', '8 GB', '32,000', 0, 'https://www.amazon.in/s?k=rx+5700', 'consumer', 'upload/gpu/Radeon_RX_5700.jpg'),
(3, 'Vega', '56', '56', '3584', '256', '1156 MHz', '1471 MHz', '-', '-', '12.5 Billion', 'Display Port 1.4,\r\nHDMI 4K 60FPS', 'HBM 2', '8 GB', '22,000', 0, 'https://www.amazon.in/s?k=vega+56+graphics+card', 'consumer', 'upload/gpu/Radeon_Vega_56.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `index_page_visits`
--

CREATE TABLE `index_page_visits` (
  `sr` int(11) NOT NULL,
  `ip` varchar(255) NOT NULL,
  `time` varchar(100) NOT NULL,
  `date` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `index_page_visits`
--

INSERT INTO `index_page_visits` (`sr`, `ip`, `time`, `date`) VALUES
(1, '::1', '2:39:08 PM', '30 - July - 2019'),
(2, '::1', '11:02:12 PM', '3 - August - 2019'),
(3, '::1', '10:13:40 PM', '5 - August - 2019'),
(4, '::1', '3:49:47 PM', '7 - August - 2019'),
(5, '::1', '1:56:31 AM', '8 - August - 2019'),
(6, '::1', '2:13:00 AM', '8 - August - 2019'),
(7, '::1', '2:13:28 AM', '8 - August - 2019'),
(8, '::1', '11:43:23 AM', '8 - August - 2019'),
(9, '::1', '11:43:28 AM', '8 - August - 2019'),
(10, '::1', '11:43:28 AM', '8 - August - 2019'),
(11, '::1', '11:43:28 AM', '8 - August - 2019'),
(12, '::1', '11:43:29 AM', '8 - August - 2019'),
(13, '::1', '11:43:29 AM', '8 - August - 2019'),
(14, '::1', '11:43:29 AM', '8 - August - 2019'),
(15, '::1', '11:43:29 AM', '8 - August - 2019'),
(16, '::1', '11:43:29 AM', '8 - August - 2019'),
(17, '::1', '11:43:29 AM', '8 - August - 2019'),
(18, '::1', '11:43:30 AM', '8 - August - 2019'),
(19, '::1', '11:43:30 AM', '8 - August - 2019'),
(20, '::1', '5:07:59 PM', '9 - August - 2019'),
(21, '::1', '5:27:51 PM', '9 - August - 2019'),
(22, '::1', '5:27:59 PM', '9 - August - 2019'),
(23, '::1', '10:06:02 AM', '31 - August - 2019'),
(24, '::1', '1:21:49 PM', '31 - August - 2019'),
(25, '::1', '1:21:57 PM', '31 - August - 2019'),
(26, '::1', '1:29:03 PM', '31 - August - 2019'),
(27, '::1', '3:06:09 PM', '31 - August - 2019'),
(28, '::1', '3:06:22 PM', '31 - August - 2019'),
(29, '::1', '3:06:46 PM', '31 - August - 2019'),
(30, '::1', '3:06:58 PM', '31 - August - 2019'),
(31, '::1', '3:07:44 PM', '31 - August - 2019'),
(32, '::1', '3:07:58 PM', '31 - August - 2019'),
(33, '::1', '3:09:18 PM', '31 - August - 2019'),
(34, '::1', '3:09:26 PM', '31 - August - 2019'),
(35, '::1', '3:11:53 PM', '31 - August - 2019'),
(36, '::1', '3:22:16 PM', '31 - August - 2019'),
(37, '::1', '4:02:47 PM', '31 - August - 2019'),
(38, '::1', '0:40:00 PM', '2 - September - 2019'),
(39, '::1', '4:10:38 AM', '3 - September - 2019'),
(40, '::1', '10:07:54 AM', '3 - September - 2019'),
(41, '::1', '10:12:52 AM', '3 - September - 2019'),
(42, '::1', '3:51:13 PM', '3 - September - 2019'),
(43, '::1', '9:54:19 AM', '4 - September - 2019'),
(44, '::1', '9:54:48 AM', '4 - September - 2019'),
(45, '::1', '10:13:47 AM', '4 - September - 2019'),
(46, '::1', '10:54:21 AM', '4 - September - 2019'),
(47, '::1', '1:20:23 PM', '4 - September - 2019'),
(48, '::1', '2:17:23 PM', '4 - September - 2019'),
(49, '::1', '3:45:36 PM', '4 - September - 2019'),
(50, '::1', '4:11:25 PM', '4 - September - 2019'),
(51, '::1', '4:11:48 PM', '4 - September - 2019'),
(52, '::1', '4:15:12 PM', '4 - September - 2019'),
(53, '::1', '4:20:16 PM', '4 - September - 2019'),
(54, '::1', '4:20:22 PM', '4 - September - 2019'),
(55, '::1', '4:20:25 PM', '4 - September - 2019'),
(56, '::1', '4:21:03 PM', '4 - September - 2019'),
(57, '::1', '4:21:06 PM', '4 - September - 2019'),
(58, '::1', '4:21:21 PM', '4 - September - 2019'),
(59, '::1', '4:21:23 PM', '4 - September - 2019'),
(60, '::1', '4:21:38 PM', '4 - September - 2019'),
(61, '::1', '4:21:59 PM', '4 - September - 2019'),
(62, '::1', '5:15:24 PM', '4 - September - 2019'),
(63, '::1', '5:15:28 PM', '4 - September - 2019'),
(64, '::1', '5:15:31 PM', '4 - September - 2019'),
(65, '::1', '5:15:45 PM', '4 - September - 2019'),
(66, '::1', '5:17:43 PM', '4 - September - 2019'),
(67, '::1', '5:27:35 PM', '4 - September - 2019'),
(68, '::1', '5:57:42 PM', '4 - September - 2019'),
(69, '::1', '5:58:57 PM', '4 - September - 2019'),
(70, '::1', '6:01:44 PM', '4 - September - 2019'),
(71, '::1', '6:01:49 PM', '4 - September - 2019'),
(72, '::1', '6:03:07 PM', '4 - September - 2019'),
(73, '::1', '6:03:20 PM', '4 - September - 2019'),
(74, '::1', '6:07:35 PM', '4 - September - 2019'),
(75, '::1', '6:07:58 PM', '4 - September - 2019'),
(76, '::1', '6:11:48 PM', '4 - September - 2019'),
(77, '::1', '6:12:13 PM', '4 - September - 2019'),
(78, '::1', '6:26:20 PM', '4 - September - 2019'),
(79, '::1', '6:56:18 PM', '4 - September - 2019'),
(80, '::1', '6:58:23 PM', '4 - September - 2019'),
(81, '::1', '7:01:57 PM', '4 - September - 2019'),
(82, '::1', '7:04:17 PM', '4 - September - 2019'),
(83, '::1', '7:05:01 PM', '4 - September - 2019'),
(84, '::1', '7:05:08 PM', '4 - September - 2019'),
(85, '::1', '7:05:27 PM', '4 - September - 2019'),
(86, '::1', '7:06:57 PM', '4 - September - 2019'),
(87, '::1', '8:40:30 PM', '5 - September - 2019'),
(88, '::1', '8:42:18 PM', '5 - September - 2019'),
(89, '::1', '9:46:21 PM', '5 - September - 2019'),
(90, '::1', '9:56:16 PM', '5 - September - 2019'),
(91, '::1', '10:20:06 PM', '5 - September - 2019'),
(92, '::1', '2:55:40 PM', '6 - September - 2019'),
(93, '::1', '5:53:39 PM', '6 - September - 2019'),
(94, '::1', '6:17:58 PM', '6 - September - 2019'),
(95, '::1', '6:18:12 PM', '6 - September - 2019'),
(96, '::1', '0:18:50 PM', '7 - September - 2019'),
(97, '::1', '4:20:44 PM', '8 - September - 2019'),
(98, '::1', '6:49:14 PM', '8 - September - 2019'),
(99, '::1', '1:52:57 PM', '9 - September - 2019'),
(100, '192.168.10.150', '2:00:03 PM', '9 - September - 2019'),
(101, '::1', '2:01:33 PM', '9 - September - 2019'),
(102, '192.168.10.150', '2:16:27 PM', '9 - September - 2019'),
(103, '::1', '3:19:04 PM', '9 - September - 2019'),
(104, '::1', '3:52:53 PM', '9 - September - 2019'),
(105, '::1', '10:51:29 PM', '9 - September - 2019'),
(106, '::1', '11:19:10 PM', '9 - September - 2019'),
(107, '::1', '9:53:29 AM', '10 - September - 2019'),
(108, '::1', '10:03:26 AM', '10 - September - 2019'),
(109, '::1', '10:03:34 AM', '10 - September - 2019'),
(110, '::1', '10:08:17 AM', '10 - September - 2019'),
(111, '::1', '10:08:29 AM', '10 - September - 2019'),
(112, '::1', '2:37:54 PM', '10 - September - 2019'),
(113, '::1', '2:48:45 PM', '10 - September - 2019'),
(114, '::1', '2:48:47 PM', '10 - September - 2019'),
(115, '::1', '2:48:51 PM', '10 - September - 2019'),
(116, '::1', '10:46:40 PM', '10 - September - 2019'),
(117, '::1', '10:46:42 PM', '10 - September - 2019'),
(118, '::1', '10:46:42 PM', '10 - September - 2019'),
(119, '::1', '10:46:42 PM', '10 - September - 2019'),
(120, '::1', '10:46:44 PM', '10 - September - 2019'),
(121, '::1', '10:46:44 PM', '10 - September - 2019'),
(122, '::1', '10:46:44 PM', '10 - September - 2019'),
(123, '::1', '3:51:11 PM', '11 - September - 2019'),
(124, '192.168.10.150', '3:51:30 PM', '11 - September - 2019'),
(125, '192.168.10.150', '3:55:04 PM', '11 - September - 2019'),
(126, '::1', '4:04:47 PM', '11 - September - 2019'),
(127, '::1', '4:06:16 PM', '11 - September - 2019'),
(128, '::1', '4:07:44 PM', '11 - September - 2019'),
(129, '::1', '4:25:39 PM', '11 - September - 2019'),
(130, '::1', '4:26:45 PM', '11 - September - 2019'),
(131, '192.168.10.150', '4:27:34 PM', '11 - September - 2019'),
(132, '::1', '4:29:38 PM', '11 - September - 2019'),
(133, '::1', '5:38:39 PM', '11 - September - 2019'),
(134, '::1', '5:39:49 PM', '11 - September - 2019'),
(135, '::1', '5:39:54 PM', '11 - September - 2019'),
(136, '::1', '5:39:56 PM', '11 - September - 2019'),
(137, '::1', '2:10:37 PM', '12 - September - 2019'),
(138, '::1', '2:11:11 PM', '12 - September - 2019'),
(139, '::1', '8:40:28 PM', '12 - September - 2019'),
(140, '::1', '10:18:36 AM', '14 - September - 2019'),
(141, '::1', '2:35:36 PM', '14 - September - 2019'),
(142, '::1', '2:41:54 PM', '14 - September - 2019'),
(143, '::1', '3:18:35 AM', '16 - September - 2019'),
(144, '::1', '3:26:48 AM', '16 - September - 2019'),
(145, '::1', '3:36:21 AM', '16 - September - 2019'),
(146, '::1', '4:03:37 AM', '16 - September - 2019'),
(147, '::1', '4:24:57 AM', '16 - September - 2019'),
(148, '::1', '4:45:29 AM', '16 - September - 2019'),
(149, '::1', '4:49:32 AM', '16 - September - 2019'),
(150, '::1', '4:54:12 AM', '16 - September - 2019');

-- --------------------------------------------------------

--
-- Table structure for table `login`
--

CREATE TABLE `login` (
  `no` int(11) NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `username` varchar(30) NOT NULL,
  `password` varchar(30) NOT NULL,
  `admin` tinyint(1) NOT NULL,
  `mobile_number` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `dob` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `login`
--

INSERT INTO `login` (`no`, `first_name`, `last_name`, `username`, `password`, `admin`, `mobile_number`, `email`, `dob`) VALUES
(1, 'Sreyas', 'CV', 'sreyas', '12', 1, '1234567890', 'sreyas@gmail.com', '13-June-2019'),
(8, 'q', 'q', 'q', 'q', 0, 'q', 'q', '2019-09-02');

-- --------------------------------------------------------

--
-- Table structure for table `news`
--

CREATE TABLE `news` (
  `id` int(11) NOT NULL,
  `name` varchar(20) NOT NULL,
  `about` varchar(100) NOT NULL,
  `content` varchar(10000) NOT NULL,
  `date` varchar(100) NOT NULL,
  `time` varchar(50) NOT NULL,
  `ip` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `news`
--

INSERT INTO `news` (`id`, `name`, `about`, `content`, `date`, `time`, `ip`) VALUES
(5, 'Sreyas CV', 'SAD', 'Intel is trying to hold onto its standing as the processor (CPU) champion after the launch of AMD\'s Ryzen 3000-series processors, and the company\'s latest attempt comes in the form of benchmarks comparing the Intel Core i7-9700K to the Ryzen 9 3900X, MSPowerUser reports.\r\n\r\n', '13 - August - 2019', '4:34:31 PM', '::1'),
(6, 'Jack', 'CPU', 'Description:  This functionality will be used for authenticate access of Admin.\r\nState: This is the beginning point, an admin screen with username and Password will be displayed.\r\nInput: Input to the system would be password & username.\r\nOutput: Output \r\n', '16 - September - 2019', '4:45:18 AM', '::1');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cpu`
--
ALTER TABLE `cpu`
  ADD PRIMARY KEY (`no`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`no`);

--
-- Indexes for table `gpu`
--
ALTER TABLE `gpu`
  ADD PRIMARY KEY (`no`);

--
-- Indexes for table `index_page_visits`
--
ALTER TABLE `index_page_visits`
  ADD PRIMARY KEY (`sr`);

--
-- Indexes for table `login`
--
ALTER TABLE `login`
  ADD PRIMARY KEY (`no`);

--
-- Indexes for table `news`
--
ALTER TABLE `news`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cpu`
--
ALTER TABLE `cpu`
  MODIFY `no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=59;

--
-- AUTO_INCREMENT for table `feedback`
--
ALTER TABLE `feedback`
  MODIFY `no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `gpu`
--
ALTER TABLE `gpu`
  MODIFY `no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `index_page_visits`
--
ALTER TABLE `index_page_visits`
  MODIFY `sr` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=151;

--
-- AUTO_INCREMENT for table `login`
--
ALTER TABLE `login`
  MODIFY `no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `news`
--
ALTER TABLE `news`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
