-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: mysql
-- Generation Time: Dec 02, 2025 at 07:47 AM
-- Server version: 8.0.44
-- PHP Version: 8.3.28

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tday`
--

-- --------------------------------------------------------

--
-- Table structure for table `tb_commit`
--

CREATE TABLE `tb_commit` (
  `id_commit` int NOT NULL,
  `id_member` int NOT NULL,
  `id_eva` int NOT NULL,
  `status_commit` varchar(1) NOT NULL,
  `level_commit` varchar(100) NOT NULL,
  `detail_commit` text,
  `signature` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tb_commit`
--

INSERT INTO `tb_commit` (`id_commit`, `id_member`, `id_eva`, `status_commit`, `level_commit`, `detail_commit`, `signature`) VALUES
(1, 3, 1, 'y', 'ประธาน', 'sdfsd', NULL),
(2, 4, 1, 'y', 'กรรมการ', '5555', NULL),
(3, 5, 1, 'y', 'เลขา', 'hhhh', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tb_doc`
--

CREATE TABLE `tb_doc` (
  `id_doc` int NOT NULL,
  `name_doc` varchar(100) NOT NULL,
  `day_day` date NOT NULL,
  `file` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tb_eva`
--

CREATE TABLE `tb_eva` (
  `id_eva` int NOT NULL,
  `id_member` int NOT NULL,
  `id_sys` int NOT NULL,
  `day_eva` date NOT NULL,
  `total_eva` double(10,2) DEFAULT NULL,
  `total_commit` double(10,2) DEFAULT NULL,
  `status_eva` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tb_eva`
--

INSERT INTO `tb_eva` (`id_eva`, `id_member`, `id_sys`, `day_eva`, `total_eva`, `total_commit`, `status_eva`) VALUES
(1, 2, 1, '2025-12-02', 60.00, 150.00, 3);

-- --------------------------------------------------------

--
-- Table structure for table `tb_evadetail`
--

CREATE TABLE `tb_evadetail` (
  `id_eva` int NOT NULL,
  `id_indicate` int NOT NULL,
  `status_eva` int NOT NULL,
  `score_member` int DEFAULT NULL,
  `score_commit` int DEFAULT NULL,
  `detail_eva` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci,
  `file_eva` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tb_evadetail`
--

INSERT INTO `tb_evadetail` (`id_eva`, `id_indicate`, `status_eva`, `score_member`, `score_commit`, `detail_eva`, `file_eva`) VALUES
(1, 1, 1, 1, NULL, 'aaaaa', '1764649473365576g45l5dti.jpg'),
(1, 2, 1, 3, NULL, NULL, '1764649473367btimz4fc7h.jfif'),
(1, 3, 1, 4, NULL, NULL, NULL),
(1, 4, 1, 4, NULL, 'bbbb', '1764649473367zdsp95w5dn.jfif'),
(1, 1, 2, NULL, 2, NULL, NULL),
(1, 2, 2, NULL, 2, NULL, NULL),
(1, 3, 2, NULL, 3, NULL, NULL),
(1, 4, 2, NULL, 2, NULL, NULL),
(1, 1, 3, NULL, 2, NULL, NULL),
(1, 2, 3, NULL, 2, NULL, NULL),
(1, 3, 3, NULL, 2, NULL, NULL),
(1, 4, 3, NULL, 4, NULL, NULL),
(1, 1, 4, NULL, 3, NULL, NULL),
(1, 2, 4, NULL, 2, NULL, NULL),
(1, 3, 4, NULL, 4, NULL, NULL),
(1, 4, 4, NULL, 2, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `tb_indicate`
--

CREATE TABLE `tb_indicate` (
  `id_indicate` int NOT NULL,
  `id_topic` int NOT NULL,
  `name_indicate` varchar(100) NOT NULL,
  `detail_indicate` text NOT NULL,
  `point_indicate` int NOT NULL,
  `check_indicate` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tb_indicate`
--

INSERT INTO `tb_indicate` (`id_indicate`, `id_topic`, `name_indicate`, `detail_indicate`, `point_indicate`, `check_indicate`) VALUES
(1, 1, 'WWWW', 'SSSS', 5, 'y'),
(2, 1, 'EEEE', 'DDDD', 5, 'n'),
(3, 2, 'TTTT', 'GGGG', 5, 'n'),
(4, 2, 'YYYY', 'HHHH', 5, 'y');

-- --------------------------------------------------------

--
-- Table structure for table `tb_member`
--

CREATE TABLE `tb_member` (
  `id_member` int NOT NULL,
  `first_name` varchar(100) NOT NULL,
  `last_name` varchar(100) NOT NULL,
  `email` varchar(255) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `role` enum('ฝ่ายบุคลากร','กรรมการประเมิน','ผู้รับการประเมินผล') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tb_member`
--

INSERT INTO `tb_member` (`id_member`, `first_name`, `last_name`, `email`, `username`, `password`, `role`) VALUES
(1, 'Admin', '1', 'admin@gmail.com', 'aaaa', 'aaaaaa', 'ฝ่ายบุคลากร'),
(2, 'eeee', 'eeee', 'eeee@gmail.com', 'eeee', 'eeeeee', 'ผู้รับการประเมินผล'),
(3, 'ssss', 'ssss', 'ssss@gmail.com', 'ssss', 'ssssss', 'กรรมการประเมิน'),
(4, 'dddd', 'dddd', 'dddd@gmail.com', 'dddd', 'dddddd', 'กรรมการประเมิน'),
(5, 'ffff', 'ffff', 'ffff@gmail.com', 'ffff', 'ffffff', 'กรรมการประเมิน');

-- --------------------------------------------------------

--
-- Table structure for table `tb_system`
--

CREATE TABLE `tb_system` (
  `id_sys` int NOT NULL,
  `day_open` date NOT NULL,
  `day_out` date NOT NULL,
  `round_sys` varchar(1) NOT NULL,
  `year_sys` varchar(4) NOT NULL,
  `status_sys` varchar(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tb_system`
--

INSERT INTO `tb_system` (`id_sys`, `day_open`, `day_out`, `round_sys`, `year_sys`, `status_sys`) VALUES
(1, '2025-12-02', '2025-12-06', '1', '2568', 'y');

-- --------------------------------------------------------

--
-- Table structure for table `tb_topic`
--

CREATE TABLE `tb_topic` (
  `id_topic` int NOT NULL,
  `name_topic` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `tb_topic`
--

INSERT INTO `tb_topic` (`id_topic`, `name_topic`) VALUES
(1, 'QQQQ'),
(2, 'RRRR');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_commit`
--
ALTER TABLE `tb_commit`
  ADD PRIMARY KEY (`id_commit`);

--
-- Indexes for table `tb_doc`
--
ALTER TABLE `tb_doc`
  ADD PRIMARY KEY (`id_doc`);

--
-- Indexes for table `tb_eva`
--
ALTER TABLE `tb_eva`
  ADD PRIMARY KEY (`id_eva`);

--
-- Indexes for table `tb_indicate`
--
ALTER TABLE `tb_indicate`
  ADD PRIMARY KEY (`id_indicate`);

--
-- Indexes for table `tb_member`
--
ALTER TABLE `tb_member`
  ADD PRIMARY KEY (`id_member`);

--
-- Indexes for table `tb_system`
--
ALTER TABLE `tb_system`
  ADD PRIMARY KEY (`id_sys`);

--
-- Indexes for table `tb_topic`
--
ALTER TABLE `tb_topic`
  ADD PRIMARY KEY (`id_topic`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tb_commit`
--
ALTER TABLE `tb_commit`
  MODIFY `id_commit` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tb_doc`
--
ALTER TABLE `tb_doc`
  MODIFY `id_doc` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_eva`
--
ALTER TABLE `tb_eva`
  MODIFY `id_eva` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tb_indicate`
--
ALTER TABLE `tb_indicate`
  MODIFY `id_indicate` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `tb_member`
--
ALTER TABLE `tb_member`
  MODIFY `id_member` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tb_system`
--
ALTER TABLE `tb_system`
  MODIFY `id_sys` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tb_topic`
--
ALTER TABLE `tb_topic`
  MODIFY `id_topic` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
