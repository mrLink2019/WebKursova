-- phpMyAdmin SQL Dump
-- version 4.8.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Aug 06, 2019 at 08:20 PM
-- Server version: 10.1.37-MariaDB
-- PHP Version: 7.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bus_ticket`
--

-- --------------------------------------------------------

--
-- Table structure for table `buses`
--

CREATE TABLE `buses` (
  `id` int(5) NOT NULL,
  `bname` varchar(25) NOT NULL,
  `bus_no` varchar(25) NOT NULL,
  `owner_id` int(5) NOT NULL,
  `from_loc` varchar(20) NOT NULL,
  `from_time` varchar(8) NOT NULL,
  `to_loc` varchar(20) NOT NULL,
  `to_time` varchar(8) NOT NULL,
  `fare` int(5) NOT NULL,
  `approved` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `buses`
--

INSERT INTO `buses` (`id`, `bname`, `bus_no`, `owner_id`, `from_loc`, `from_time`, `to_loc`, `to_time`, `fare`, `approved`) VALUES
(1, 'Bohdan', 'AV16854LK', 3, 'Lviv', '10:30', 'Kyiv', '18:00', 400, 1),
(2, 'Bohdan', 'AB16451KH', 3, 'Lviv', '09:45', 'Ivano-Frankivsk', '12:15', 250, 0),
(4, 'Icarus', 'BK78915HY', 3, 'Ivano-Frankivsk', '11:50', 'Ternopil', '14:30', 200, 0);

-- --------------------------------------------------------

--
-- Table structure for table `earnings`
--

CREATE TABLE `earnings` (
  `id` int(5) NOT NULL,
  `bus_id` int(5) NOT NULL,
  `date` varchar(10) NOT NULL,
  `ssold` int(3) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE `locations` (
  `id` int(5) NOT NULL,
  `name` varchar(25) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`id`, `name`) VALUES
(1, 'Lviv'),
(2, 'Ivano-Frankivsk'),
(3, 'Kyiv'),
(4, 'Ternopil');

-- --------------------------------------------------------

--
-- Table structure for table `notices`
--

CREATE TABLE `notices` (
  `id` int(5) NOT NULL,
  `recep` int(5) NOT NULL,
  `message` varchar(120) NOT NULL,
  `from` int(5) NOT NULL,
  `title` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tickets`
--

CREATE TABLE `tickets` (
  `id` int(5) NOT NULL,
  `passenger_id` int(5) NOT NULL,
  `bus_id` int(5) NOT NULL,
  `jdate` varchar(25) NOT NULL,
  `seats` varchar(120) NOT NULL,
  `fare` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tickets`
--

INSERT INTO `tickets` (`id`, `passenger_id`, `bus_id`, `jdate`, `seats`, `fare`) VALUES
(9, 2, 2, '10/05/2022', 'a:2:{i:0;s:2:\"D1\";i:1;s:2:\"D2\";}', 520),
(11, 2, 2, '13/05/2022', 'a:1:{i:0;s:2:\"E1\";}', 270),
(24, 2, 2, '11/06/2022', 'a:2:{i:0;s:2:\"D3\";i:1;s:2:\"D4\";}', 520),
(25, 2, 2, '13/06/2022', 'a:1:{i:0;s:2:\"E4\";}', 270),
(26, 5, 2, '15/06/2022', 'a:2:{i:0;s:2:\"C3\";i:1;s:2:\"C4\";}', 520),
(27, 2, 2, '16/06/2022', 'a:2:{i:0;s:2:\"E1\";i:1;s:2:\"E2\";}', 520);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(5) NOT NULL,
  `uname` varchar(20) NOT NULL,
  `name` varchar(25) NOT NULL,
  `email` varchar(40) NOT NULL,
  `password` varchar(25) NOT NULL,
  `gender` enum('Male','Female','Other') NOT NULL,
  `utype` enum('Admin','Owner','Passenger') NOT NULL,
  `address` varchar(120) NOT NULL,
  `mobile` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `uname`, `name`, `email`, `password`, `gender`, `utype`, `address`, `mobile`) VALUES
(1, 'admin', 'Admin', '----', 'admin', 'Male', 'Admin', '----', '0'),
(2, 'andriy', 'Andriy Lianh', 'something@gmail.com', '123456', 'Male', 'Passenger', 'Ivano-Frankivsk', '380990001111'),
(3, 'owner', 'Vasyl Random', 'random@gmail.com', '123456', 'Male', 'Owner', '', '3805768428'),
(4, 'user1', 'Ivan Dead', 'death@gmail.com', '123456', 'Male', 'Owner', 'Lviv', '3809734685'),
(5, 'user2', 'Ruslan Someone', 'someemail@gmail.com', '123456', 'Male', 'Passenger', 'Lviv', '3805468739');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `buses`
--
ALTER TABLE `buses`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_usr_bus` (`owner_id`);

--
-- Indexes for table `earnings`
--
ALTER TABLE `earnings`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_ear_bus` (`bus_id`);

--
-- Indexes for table `locations`
--
ALTER TABLE `locations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `notices`
--
ALTER TABLE `notices`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_usrf_not` (`from`),
  ADD KEY `fk_usrt_not` (`recep`);

--
-- Indexes for table `tickets`
--
ALTER TABLE `tickets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_usr_tic` (`passenger_id`),
  ADD KEY `fk_bus_tic` (`bus_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `id` (`uname`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `buses`
--
ALTER TABLE `buses`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `earnings`
--
ALTER TABLE `earnings`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `locations`
--
ALTER TABLE `locations`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `notices`
--
ALTER TABLE `notices`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tickets`
--
ALTER TABLE `tickets`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=28;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(5) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `buses`
--
ALTER TABLE `buses`
  ADD CONSTRAINT `fk_usr_bus` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`);

--
-- Constraints for table `earnings`
--
ALTER TABLE `earnings`
  ADD CONSTRAINT `fk_ear_bus` FOREIGN KEY (`bus_id`) REFERENCES `buses` (`id`);

--
-- Constraints for table `notices`
--
ALTER TABLE `notices`
  ADD CONSTRAINT `fk_usrf_not` FOREIGN KEY (`from`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `fk_usrt_not` FOREIGN KEY (`recep`) REFERENCES `users` (`id`);

--
-- Constraints for table `tickets`
--
ALTER TABLE `tickets`
  ADD CONSTRAINT `fk_bus_tic` FOREIGN KEY (`bus_id`) REFERENCES `buses` (`id`),
  ADD CONSTRAINT `fk_usr_tic` FOREIGN KEY (`passenger_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
