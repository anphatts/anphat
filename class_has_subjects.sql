-- phpMyAdmin SQL Dump
-- version 4.1.6
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Mar 02, 2016 at 11:56 AM
-- Server version: 5.6.16
-- PHP Version: 5.5.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `elearning`
--

-- --------------------------------------------------------

--
-- Table structure for table `class_has_subjects`
--

CREATE TABLE IF NOT EXISTS `class_has_subjects` (
  `class_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  PRIMARY KEY (`class_id`,`subject_id`),
  KEY `fk_classes_has_subjects_subjects1_idx` (`subject_id`),
  KEY `fk_classes_has_subjects_classes1_idx` (`class_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `class_has_subjects`
--

INSERT INTO `class_has_subjects` (`class_id`, `subject_id`) VALUES
(6, 1),
(7, 1),
(8, 1),
(9, 1),
(10, 1),
(11, 1),
(12, 1),
(13, 1),
(14, 1),
(6, 2),
(7, 2),
(8, 2),
(9, 2),
(10, 2),
(6, 3),
(7, 3),
(8, 3),
(9, 3),
(10, 3),
(6, 4),
(6, 5),
(7, 5),
(9, 5),
(10, 5),
(6, 6),
(7, 6),
(8, 6),
(9, 6),
(10, 6),
(11, 6),
(12, 6),
(13, 6),
(14, 6),
(6, 7),
(7, 7),
(8, 7),
(9, 7),
(10, 7),
(6, 8),
(7, 8),
(8, 8),
(6, 9),
(7, 9),
(8, 9),
(6, 10),
(7, 10),
(8, 10),
(9, 10),
(10, 10),
(6, 11),
(7, 11),
(8, 11),
(9, 11),
(10, 11),
(11, 11),
(12, 11),
(13, 11),
(14, 11),
(15, 11),
(16, 11),
(17, 11),
(6, 12),
(7, 12),
(8, 12),
(7, 13),
(8, 13),
(9, 13),
(10, 13),
(7, 14),
(8, 14),
(9, 14),
(10, 14),
(8, 19),
(9, 19),
(10, 19),
(11, 19),
(12, 19),
(13, 19),
(14, 19),
(15, 19),
(16, 19),
(17, 19),
(9, 20),
(10, 20),
(9, 21),
(10, 21),
(15, 21),
(16, 21),
(17, 21),
(9, 22),
(10, 22),
(9, 23),
(10, 23),
(11, 23),
(12, 23),
(13, 23),
(14, 23),
(15, 23),
(16, 23),
(17, 23),
(9, 24),
(10, 24),
(11, 24),
(12, 24),
(13, 24),
(14, 24),
(15, 24),
(16, 24),
(17, 24),
(11, 33),
(12, 33),
(13, 33),
(14, 33),
(15, 33),
(16, 33),
(17, 33),
(11, 34),
(12, 34),
(13, 34),
(14, 34),
(15, 34),
(16, 34),
(17, 34),
(13, 35),
(14, 35),
(15, 35),
(16, 35),
(17, 35),
(11, 36),
(12, 36),
(13, 36),
(14, 36),
(15, 36),
(16, 36),
(17, 36),
(10, 37),
(11, 37),
(12, 37),
(13, 37),
(14, 37),
(15, 37),
(16, 37),
(11, 38),
(12, 38),
(13, 38),
(14, 38),
(15, 38),
(16, 38),
(17, 38),
(11, 42),
(11, 43),
(12, 43),
(13, 43),
(14, 43),
(15, 43),
(16, 43),
(17, 43),
(12, 44),
(13, 44),
(14, 44),
(15, 44),
(16, 45),
(17, 46),
(15, 47),
(16, 47),
(17, 47);

--
-- Constraints for dumped tables
--


/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
