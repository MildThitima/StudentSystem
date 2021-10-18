-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Oct 11, 2021 at 12:41 PM
-- Server version: 10.4.18-MariaDB
-- PHP Version: 8.0.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `studentgroupingsystem`
--

-- --------------------------------------------------------

--
-- Table structure for table `assignment`
--

CREATE TABLE `assignment` (
  `assignID` int(11) NOT NULL COMMENT 'รหัสลำดับการมอบหมายงาน',
  `regisID` int(11) NOT NULL COMMENT 'รหัสลำดับรายวิชาที่เปิดสอน',
  `groupTypeID` int(11) NOT NULL COMMENT 'รหัสลำดับประเภทการจับกลุ่ม',
  `assignTitle` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'หัวข้อการมอบหมายงาน',
  `assignDescription` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'รายละเอียดการมอบหมายงาน',
  `assignDate` datetime NOT NULL COMMENT 'วันที่เวลามอบหมายงาน',
  `deadline` datetime DEFAULT NULL COMMENT 'วันที่เวลากำหนดส่ง ค่าว่าง คือ ไม่กำหนด',
  `numGroup` int(11) NOT NULL DEFAULT 1 COMMENT 'จำนวนกลุ่ม ขั้นต่ำ 1 กลุ่ม',
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'สถานะการใช้งาน 0 ระงัย 1 ใช้งาน'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ข้อมูลการมอบหมายงาน';

--
-- Dumping data for table `assignment`
--

INSERT INTO `assignment` (`assignID`, `regisID`, `groupTypeID`, `assignTitle`, `assignDescription`, `assignDate`, `deadline`, `numGroup`, `status`) VALUES
(34, 1, 2, 'clinic today', 'hello teacher', '2021-09-25 18:13:00', '2021-09-30 23:18:00', 6, 1),
(35, 1, 3, 'clinic functional', 'ใส่รหัสนักศึกษาก่อนส่งงาน', '2021-09-24 18:13:00', '2021-09-30 20:15:00', 8, 1),
(36, 5, 3, 'cobal clinic', 'clear fast 7', '2021-09-25 18:25:00', '2021-09-30 22:30:00', 5, 1),
(37, 5, 2, 'clinic fast 9', 'plus ultra', '2021-09-24 18:25:00', '2021-09-30 20:30:00', 3, 1),
(38, 5, 1, 'clinic test tokyo', 'how to drift in tokyo', '2021-09-23 18:30:00', '2021-09-30 20:30:00', 6, 1),
(39, 9, 1, 'Clinic Lisa', 'new music ', '2021-09-25 18:59:00', '2021-09-26 18:59:00', 4, 1);

-- --------------------------------------------------------

--
-- Table structure for table `course_information`
--

CREATE TABLE `course_information` (
  `courseID` int(11) NOT NULL COMMENT 'รหัสลำดับรายวิชา',
  `courseCode` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'รหัสวิชา',
  `courseName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'ชื่อวิชา',
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'สถานะการใช้งาน 0 ระงัย 1 ใช้งาน'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ข้อมูลรายวิชา';

--
-- Dumping data for table `course_information`
--

INSERT INTO `course_information` (`courseID`, `courseCode`, `courseName`, `status`) VALUES
(1, 'INT353', 'Information Technology Project I', 1),
(2, 'LNG201', 'English for communication', 1),
(4, 'INT306', 'E - Business', 1),
(6, 'INT304', 'STAT FOR IT', 1),
(7, 'INT100', 'Basic Servival', 1),
(8, 'INT200', 'Basic IT Service', 1),
(9, 'INT300', 'Basic IT Service 3', 1),
(10, 'INT400', 'IT STAT 4 ', 1),
(11, 'INT500', 'IT SECURITY 2', 1),
(12, 'INT666', 'SUUKID SUBJECT', 1);

-- --------------------------------------------------------

--
-- Table structure for table `discussion`
--

CREATE TABLE `discussion` (
  `discussID` int(11) NOT NULL COMMENT 'รหัสลำดับการอภิปรายผล',
  `assignID` int(11) NOT NULL COMMENT 'รหัสลำดับการมอบหมายงาน',
  `groupNum` int(11) NOT NULL COMMENT 'รหัสกลุ่ม',
  `userID` int(11) NOT NULL COMMENT 'รหัสลำดับข้อมูลผู้ใช้',
  `message` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'ข้อมูลข้อความ',
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'ข้อมูลรูปภาพ',
  `dateTimeSend` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() COMMENT 'วันที่และเวลาที่ส่งข้อมูล'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ข้อมูลการอภิปรายผล';

--
-- Dumping data for table `discussion`
--

INSERT INTO `discussion` (`discussID`, `assignID`, `groupNum`, `userID`, `message`, `photo`, `dateTimeSend`) VALUES
(19, 7, 2, 11, 'hi girl', NULL, '2021-04-19 02:03:19'),
(20, 7, 2, 11, 'r u ready', NULL, '2021-04-19 02:03:23'),
(23, 0, 1, 3, 'fsfsd', NULL, '2021-04-19 19:16:21'),
(25, 9, 1, 2, 'วันนี้มีใคร', NULL, '2021-04-19 20:46:39');

-- --------------------------------------------------------

--
-- Table structure for table `evaluation_answer`
--

CREATE TABLE `evaluation_answer` (
  `answerID` int(11) NOT NULL COMMENT 'รหัสลำดับคำตอบ',
  `questionNo` int(11) NOT NULL COMMENT 'รหัสลำดับข้อคำถาม',
  `assignID` int(11) NOT NULL COMMENT 'รหัสลำดับการมอบหมายงาน',
  `groupNum` int(11) NOT NULL COMMENT 'รหัสกลุ่ม เลขที่กลุ่ม',
  `assessorID` int(11) NOT NULL COMMENT 'รหัสผู้ประเมิน',
  `userID` int(11) NOT NULL COMMENT 'รหัสลำดับข้อมูลผู้ใช้ (ผู้ถูกประเมิน)',
  `answer` int(11) DEFAULT NULL COMMENT 'ข้อคำตอบ',
  `suggestion` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'ข้อเสนอแนะ'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ข้อมูลคำตอบประเมินผลการปฏิบัติงาน';

-- --------------------------------------------------------

--
-- Table structure for table `evaluation_question`
--

CREATE TABLE `evaluation_question` (
  `questionID` int(11) NOT NULL COMMENT 'รหัสลำดับข้อคำถาม',
  `questionNo` int(11) NOT NULL DEFAULT 0 COMMENT 'คำถามข้อที่',
  `question` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ข้อคำถาม'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ข้อมูลคำถามประเมินผลการปฏิบัติงาน';

--
-- Dumping data for table `evaluation_question`
--

INSERT INTO `evaluation_question` (`questionID`, `questionNo`, `question`) VALUES
(1, 1, 'การมาทำงาน'),
(2, 2, 'ผลงานเป็นที่ยอมรับ'),
(3, 3, 'คุณภาพของงาน'),
(4, 4, 'ปริมาณงาน'),
(5, 5, 'ความสัมพันธ์กับผู้อื่น'),
(6, 6, 'ข้อเสนอแนะ');

-- --------------------------------------------------------

--
-- Table structure for table `group_information`
--

CREATE TABLE `group_information` (
  `groupInfoID` int(11) NOT NULL COMMENT 'รหัสลำดับการจับกลุ่ม',
  `assignID` int(11) NOT NULL COMMENT 'รหัสลำดับการมอบหมายงาน',
  `groupNum` int(11) NOT NULL COMMENT 'รหัสกลุ่ม เลขที่กลุ่ม',
  `userID` int(11) NOT NULL COMMENT 'รหัสลำดับข้อมูลผู้ใช้ (นักศึกษา)',
  `responsibility` tinytext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'หน้าที่รับผิดชอบภายในกลุ่ม'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ข้อมูลการจับกลุ่มของนักศึกษา';

--
-- Dumping data for table `group_information`
--

INSERT INTO `group_information` (`groupInfoID`, `assignID`, `groupNum`, `userID`, `responsibility`) VALUES
(204, 35, 1, 29, NULL),
(205, 35, 1, 3, NULL),
(206, 35, 1, 35, NULL),
(207, 35, 1, 22, NULL),
(208, 35, 1, 60, NULL),
(209, 35, 2, 4, NULL),
(210, 35, 2, 34, NULL),
(211, 35, 2, 36, NULL),
(212, 35, 2, 21, NULL),
(213, 35, 3, 5, NULL),
(214, 35, 3, 7, NULL),
(215, 35, 3, 37, NULL),
(216, 35, 3, 20, NULL),
(217, 35, 4, 6, NULL),
(218, 35, 4, 9, NULL),
(219, 35, 4, 13, NULL),
(220, 35, 4, 18, NULL),
(221, 35, 5, 10, NULL),
(222, 35, 5, 31, NULL),
(223, 35, 5, 12, NULL),
(224, 35, 5, 17, NULL),
(225, 35, 6, 28, NULL),
(226, 35, 6, 32, NULL),
(227, 35, 6, 11, NULL),
(228, 35, 6, 16, NULL),
(229, 35, 7, 27, NULL),
(230, 35, 7, 33, NULL),
(231, 35, 7, 2, NULL),
(232, 35, 7, 15, NULL),
(233, 35, 8, 30, 'ประธาน'),
(234, 35, 8, 38, 'สมาชิก'),
(235, 35, 8, 19, 'สมาชิก'),
(236, 35, 8, 14, 'รองประธาน'),
(237, 36, 1, 46, NULL),
(238, 36, 1, 49, NULL),
(239, 36, 1, 52, NULL),
(240, 36, 1, 39, NULL),
(241, 36, 1, 58, NULL),
(242, 36, 2, 59, NULL),
(243, 36, 2, 50, NULL),
(244, 36, 2, 53, NULL),
(245, 36, 2, 40, NULL),
(246, 36, 2, 25, NULL),
(247, 36, 3, 43, NULL),
(248, 36, 3, 47, NULL),
(249, 36, 3, 54, NULL),
(250, 36, 3, 55, NULL),
(251, 36, 3, 62, NULL),
(252, 36, 4, 44, NULL),
(253, 36, 4, 48, NULL),
(254, 36, 4, 42, NULL),
(255, 36, 4, 56, NULL),
(256, 36, 5, 45, NULL),
(257, 36, 5, 51, NULL),
(258, 36, 5, 41, NULL),
(259, 36, 5, 57, NULL),
(260, 34, 4, 9, 'ประธาน');

-- --------------------------------------------------------

--
-- Table structure for table `group_type`
--

CREATE TABLE `group_type` (
  `groupTypeID` int(11) NOT NULL COMMENT 'รหัสลำดับประเภทการจับกลุ่ม',
  `groupType` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'ประเภทการจับกลุ่ม',
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'สถานะการใช้งาน 0 ระงัย 1 ใช้งาน'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ข้อมูลประเภทการจับกลุ่ม';

--
-- Dumping data for table `group_type`
--

INSERT INTO `group_type` (`groupTypeID`, `groupType`, `status`) VALUES
(1, 'Voluntary grouping', 1),
(2, 'Random grouping', 1),
(3, 'MBTI grouping', 1);

-- --------------------------------------------------------

--
-- Table structure for table `mbti_answer`
--

CREATE TABLE `mbti_answer` (
  `answerID` int(11) NOT NULL COMMENT 'รหัสลำดับคำตอบ',
  `questionNo` int(11) NOT NULL COMMENT 'รหัสลำดับข้อคำถาม',
  `userID` int(11) NOT NULL COMMENT 'รหัสลำดับข้อมูลผู้ใช้',
  `answer` int(11) NOT NULL COMMENT 'ข้อคำตอบ'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ข้อมูลคำตอบแบบทดสอบบุคคลิกภาพ';

--
-- Dumping data for table `mbti_answer`
--

INSERT INTO `mbti_answer` (`answerID`, `questionNo`, `userID`, `answer`) VALUES
(1, 1, 4, 1),
(2, 2, 4, 1),
(3, 3, 4, 2),
(4, 4, 4, 1),
(5, 5, 4, 1),
(6, 6, 4, 1),
(7, 7, 4, 2);

-- --------------------------------------------------------

--
-- Table structure for table `mbti_question`
--

CREATE TABLE `mbti_question` (
  `questionID` int(11) NOT NULL COMMENT 'รหัสลำดับข้อคำถาม',
  `questionNo` int(11) NOT NULL DEFAULT 0 COMMENT 'ข้อคำถามที่',
  `question` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'คำถาม',
  `choiceA` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'ตัวเลือก ก',
  `choiceB` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'ตัวเลือก ข'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ข้อมูลคำถามทดสอบบุคคลิกภาพ';

--
-- Dumping data for table `mbti_question`
--

INSERT INTO `mbti_question` (`questionID`, `questionNo`, `question`, `choiceA`, `choiceB`) VALUES
(1, 1, 'ข้าพเจ้าชอบที่จะ', 'แก้ปัญหาใหม่ ๆ ที่มีความสลับซับซ้อน', 'เลือกทำงานที่เคยทำสำเร็จมาแล้ว'),
(2, 2, 'ข้าพเจ้าชอบที่จะ', 'ทำงานตามลำพังในที่สงบเงียบ', 'อยู่ตรงที่งานกำลังดำเนินอยู่'),
(3, 3, 'ข้าพเจ้าชอบหัวหน้าที่', 'ได้สร้างและกำหนดเกณฑ์การทำงานและการตัดสินใจไว้ให้แล้ว', 'ใส่ใจต่อความต้องการและช่วยเหลือลูกน้องรายบุคคล'),
(4, 4, 'เมื่อข้าพเจ้าทำงานเกี่ยวกับโครงการ ข้าพเจ้าต้องการ', 'ทำให้เสร็จและปิดโครงการทันที', 'ไม่รีบปิดโครงการเผื่อไว้หากต้องปรับปรุงเปลี่ยนแปลง'),
(5, 5, 'เมื่อต้องตัดสินใจ สิ่งสำคัญที่สุดที่ต้องคำนึงถึง คือ', 'การคิดเชิงเหตุผล การมีข้อมูลและความคิดเห็น', 'ความรู้สึกและค่านิยมของคน'),
(6, 6, 'เมื่อต้องทำงานโครงการ ข้าพเจ้าจะ…', 'คิดทบทวนหลายครั้งก่อนที่จะตัดสินใจว่าจะเริ่มดำเนินการอย่างไร', 'เริ่มต้นลงมือทำงานทันที พร้อมกับคิดไปทำไปทีละขั้น'),
(7, 7, 'เมื่อต้องทำงานโครงการ ข้าพเจ้าชอบที่จะ …', 'คงวิธีการควบคุมให้มากที่สุดเท่าที่จะเป็นไปได้', 'ตรวจสอบหาแนวทางต่าง ๆ ที่สามารถนำมาใช้ดาเนินการ'),
(8, 8, 'ในการทำงานของข้าพเจ้า ข้าพเจ้ามักจะ …', 'ทำพร้อมกันหลายโครงการ และพยายามหาความรู้จากแต่ละโครงการให้มากที่สุด เท่าที่จะทำได้', 'เลือกทำโครงการที่มีความท้าทายมากที่สุดเพียงโครงการเดียวและจะทุ่มเทอย่างเต็มที่'),
(9, 9, 'ข้าพเจ้ามักจะ …', 'จัดทำรายการและแผนการทำงานก่อนที่จะเริ่มต้นทำงาน และไม่พอใจอย่างยิ่งถ้าถูกปรับเปลี่ยนไปจากแผนที่กำหนดไว้นี้', 'หลีกเลี่ยงการทำแผนแต่จะปล่อยให้งานคืบหน้าไปเองขณะที่ทำงานนั้น'),
(10, 10, 'เมื่ออภิปรายปัญหากับเพื่อน ข้าพเจ้าสามารถ...', 'มองเห็นภาพรวมได้โดยง่าย', 'เข้าใจจุดใดจุดหนึ่งของสถานการณ์นั้นได้อย่างลึกซึ้งได้โดยง่าย'),
(11, 11, 'เมื่อมีเสียงกริ่งโทรศัพท์ดังขึ้นที่ทำงานหรือที่บ้าน ปกติข้าพเจ้า', 'รู้สึกว่าเป็นเสียงที่รบกวนการทำงาน', 'ไม่รังเกียจที่จะรับสายโทรศัพท์นั้น'),
(12, 12, 'คำใดที่อธิบายตรงกับตัวข้าพเจ้าได้ดีกว่ากัน ระหว่าง …', 'การวิเคราะห์ (analytical)', 'ความเข้าอกเข้าใจ (empathetic)'),
(13, 13, 'เมื่อข้าพเจ้าลงมือทำการบ้าน ข้าพเจ้ามักจะ …', 'ทำอย่างสม่ำเสมอและคงเส้นคงวา', 'ทำอย่างเต็มที่แต่มีช่วงหยุดเป็นช่วง ๆ'),
(14, 14, 'เมื่อข้าพเจ้าเกิดได้ยินใครพูดถึงเรื่องใดเรื่องหนึ่ง ข้าพเจ้ามักจะพยายาม…', 'นำมาเกี่ยวข้องกับประสบการณ์เก่าของข้าพเจ้าและดูว่าคล้ายกันไหม', 'วิเคราะห์และประเมินเนื้อหาที่ได้ยินนั้น'),
(15, 15, 'เมื่อข้าพเจ้าเกิดความคิดใหม่ขึ้น ข้าพเจ้ามักจะ …', 'ลงมือทำดู', 'ลองพิจารณาใคร่ครวญความคิดใหม่นั้นอีกหลายครั้ง'),
(16, 16, 'เมื่อต้องทำงานโครงการ ข้าพเจ้ามักจะ …', 'ตีกรอบงานให้แคบลง เพื่อที่จะมองเห็นภาพได้ชัดเจนและตรงประเด็นยิ่งขึ้น', 'ขยายขอบเขตงานออกไป เพื่อให้สามารถครอบคลุมประเด็นที่เกี่ยวข้องได้ครบ'),
(17, 17, 'เมื่อข้าพเจ้าอ่านอะไรก็แล้วแต่ ข้าพเจ้ามักจะ …', 'เพ่งความคิดไปยังข้อความที่เขียนนั้น', 'อ่านแต่ละบรรทัด เพื่อหาคำสาคัญที่เกี่ยวข้องกับความคิดต่าง ๆ'),
(18, 18, 'เมื่อข้าพเจ้าจำเป็นต้องตัดสินใจโดยเร่งด่วน ข้าพเจ้ามัก…', 'รู้สึกอึดอัดใจและอยากได้ข้อมูลเพิ่มเติม', 'สามารถตัดสินใจได้จากข้อมูลเท่าที่มีอยู่'),
(19, 19, 'ในการประชุม ข้าพเจ้ามักจะ…', 'ค่อย ๆ ประมวลความคิดตนเองในขณะที่พูดถึงเรื่องนั้น', 'พูดออกไปก็ต่อเมื่อได้ใคร่ครวญความคิดเกี่ยวกับเรื่องนั้นอย่างดีแล้ว'),
(20, 20, 'ในการทำงาน ประเด็นที่ข้าพเจ้าชอบใช้เวลาค่อนข้างมากกว่าคือ', 'ประเด็นที่เกี่ยวกับความคิด', 'ประเด็นที่เกี่ยวกับคน'),
(21, 21, 'ในการประชุม ข้าพเจ้ามักถูกรบกวนให้รำคาญใจกับคนที่…', 'ชอบเสนอความคิดมากมายที่ยังขาดความชัดเจน', 'ทำให้เสียเวลาที่ประชุมไปกับการพูดถึงรายละเอียดของการทำงานอย่างถี่ยิบ'),
(22, 22, 'ข้าพเจ้าชอบเป็น…', 'คนตื่นเช้า', 'คนนอนดึก'),
(23, 23, 'รูปแบบการเตรียมพร้อมก่อนเข้าร่วมประชุมของข้าพเจ้า คือ', 'อยากเข้าประชุมและได้แสดงความคิดเห็นต่อที่ประชุม', 'เตรียมตัวพร้อมเต็มที่ และขีดเขียนวาระหัวข้อการประชุมนั้นออกมา'),
(24, 24, 'ในที่ประชุมข้าพเจ้าชอบคนที่ …', 'สามารถแสดงออกทางอารมณ์ได้ดี', 'ให้ความสาคัญกับงาน'),
(25, 25, 'ข้าพเจ้าชอบการทำงานกับหน่วยงานที่ …', 'กระตุ้นการใช้ปัญญาในการทำงานให้กับข้าพเจ้า', 'ข้าพเจ้าผูกพันกับเป้าหมายและพันธกิจ'),
(26, 26, 'ช่วงสุดสัปดาห์ ข้าพเจ้ามักจะ…', 'วางแผนล่วงหน้าว่าจะทำอะไรบ้าง', 'ไปดูว่ามีอะไรเกิดขึ้นบ้าง แล้วจึงตัดสินใจเข้าร่วมตามนั้น'),
(27, 27, 'ข้าพเจ้าเป็นคนประเภท…', 'ชอบออกไปพบปะผู้คน', 'ชอบใช้ความคิดไตร่ตรอง'),
(28, 28, 'ข้าพเจ้าชอบทำงานกับหัวหน้าที่…', 'เต็มไปด้วยความคิดใหม่ ๆ', 'เป็นนักปฏิบัติที่ดี'),
(29, 29, 'เลือกเพียงอย่างเดียวระหว่าง “ก” หรือ “ข” ที่แสดงลักษณะที่ตรงกับตัวท่านมากที่สุด', 'สังคม (social)', 'เป็นทฤษฎี (theoretical)'),
(30, 30, 'เลือกเพียงอย่างเดียวระหว่าง “ก” หรือ “ข” ที่แสดงลักษณะที่ตรงกับตัวท่านมากที่สุด', 'ความเป็นเจ้าความคิด (ingenuity)', 'ความเป็นนักปฏิบัติ (practicality)'),
(31, 31, 'เลือกเพียงอย่างเดียวระหว่าง “ก” หรือ “ข” ที่แสดงลักษณะที่ตรงกับตัวท่านมากที่สุด', 'การจัดรูปแบบ (organized)', 'การยืดหยุ่นได้ (adaptable)'),
(32, 32, 'เลือกเพียงอย่างเดียวระหว่าง “ก” หรือ “ข” ที่แสดงลักษณะที่ตรงกับตัวท่านมากที่สุด', 'คล่องแคล่ว (active)', 'การมีสมาธิ (concentration)');

-- --------------------------------------------------------

--
-- Table structure for table `registration_information`
--

CREATE TABLE `registration_information` (
  `regisID` int(11) NOT NULL COMMENT 'รหัสลำดับรายวิชาที่เปิดสอน',
  `courseID` int(11) NOT NULL COMMENT 'รหัสลำดับรายวิชา',
  `userID` int(11) NOT NULL COMMENT 'รหัสลำดับข้อมูลผู้ใช้ (รหัสอาจารย์)',
  `classGroup` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'กลุ่มเรียน',
  `year` year(4) NOT NULL COMMENT 'ปีการศึกษา',
  `semester` int(1) NOT NULL COMMENT 'ภาคการศึกษา',
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'สถานะการใช้งาน 0 ระงัย 1 ใช้งาน'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ข้อมูลการลงทะเบียน รายวิชาที่เปิดสอน';

--
-- Dumping data for table `registration_information`
--

INSERT INTO `registration_information` (`regisID`, `courseID`, `userID`, `classGroup`, `year`, `semester`, `status`) VALUES
(1, 1, 2, 'A', 2021, 1, 1),
(2, 2, 2, 'A', 2021, 1, 1),
(4, 4, 25, 'A', 2020, 2, 1),
(5, 4, 25, 'B', 2021, 1, 1),
(6, 6, 2, 'A', 2021, 1, 1),
(7, 7, 60, 'A', 2021, 1, 1),
(8, 8, 60, 'A', 2021, 1, 1),
(9, 9, 60, 'A', 2021, 1, 1),
(10, 10, 62, 'B', 2021, 1, 1),
(11, 11, 62, 'B', 2021, 1, 1),
(12, 12, 62, 'B', 2021, 1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `userID` int(11) NOT NULL COMMENT 'รหัสลำดับข้อมูลผู้ใช้',
  `userTypeID` int(11) DEFAULT 3 COMMENT 'รหัสประเภทผู้ใช้  3 นักศึกษา 2 อาจารย์ 1 ผู้ดูแลระบบ',
  `userCode` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'รหัสนักศึกษา/รหัสอาจารย์',
  `classGroup` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'กลุ่มเรียน',
  `fullName` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'ชื่อ สกุล',
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'อีเมล',
  `password` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'รหัสผ่าน',
  `mbti` varchar(4) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'รหัสรูปแบบบุคคลิกภาพ',
  `setting` mediumtext COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'การตั้งค่ารายบุคคล',
  `status` tinyint(4) DEFAULT 0 COMMENT 'สถานะการใช้งาน 0 ระงัย 1 ใช้งาน'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ฐานข้อมูลผู้ใช้งานระบบ';

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`userID`, `userTypeID`, `userCode`, `classGroup`, `fullName`, `email`, `password`, `mbti`, `setting`, `status`) VALUES
(1, 1, 'admin', '', 'Administrator', 'admin@kmutt.ac.th', '9075571a91e0af0b553b72ebb0bcd086ed8e9fa6234c430d73066378063f890d', '', '{\"lang\":\"en\"}', 1),
(2, 2, 'teacher', 'A', 'อาจารย์อรุณ ทิพย์', 'teacher@kmutt.ac.th', '628442f41779721e03d9cb77629b6383003bb9d8b3fb3eb7218532c85b510aa2', '', '{\"lang\":\"en\"}', 1),
(3, 3, '61130500001', 'A', 'นายโยธิต กองการ', '61130500001@mail.kmutt.ac.th', '770c1d74124166d495f7de49b47a76fca7dee327b82177648a09a17489768abd', 'ENTP', '{\"lang\":\"th\"}', 1),
(4, 3, '61130500002', 'A', 'นายปิติ ดิเรกวิทยา', '61130500002@mail.kmutt.ac.th', '7e2d40524c6f021fe7f49ff670eea9d802cc0d0b02c5bf5b86c69e8e39e1448c', 'INTP', '{\"lang\":\"en\"}', 1),
(5, 3, '61130500003', 'A', 'นางสาวอัจฉราพร ทองม่วง', '61130500003@mail.kmutt.ac.th', 'a6c42ba29738b55c69b5408607769163052aaa16807b894f8ba73811f6b60a32', 'ENTJ', NULL, 1),
(6, 3, '61130500004', 'A', 'นายวลัยพร เกิดความสุข', '61130500004@mail.kmutt.ac.th', 'c5c42ff2502e1f74acb70a77754e17e2e8817069de962a484e5cff6fb017389a', 'ENTP', NULL, 1),
(7, 3, '61130500005', 'A', 'นายมานะ วิทยเขตปภา', '61130500005@mail.kmutt.ac.th', '74fc0a112da894fac9b04d4c7f6676a43047f4da2bef54813032b6ac03d66c51', 'INFJ', '{\"lang\":\"th\"}', 1),
(9, 3, '61130500006', 'A', 'นางสาวอรพิมล กล้านอนหงาย', '61130500006@mail.kmutt.ac.th', '57d9fa560b3d2577f24b8a2f14a382a4aa3bab993311222cab32913322f2a931', 'INFP', '{\"lang\":\"en\"}', 1),
(10, 3, '61130500007', 'A', 'นายจิดาภา จิตสะอาด', '61130500007@mail.kmutt.ac.th', '69d514ae2d2759e80de7436c491fcae5e90e6a8589f6de50513a57ee74a7318f', 'INTJ', NULL, 1),
(11, 3, '61130500008', 'A', 'นายอรรณวุฒิ แก้วมณีงาม', '61130500008@mail.kmutt.ac.th', 'd5cb0e43721dbb1d2f7332f1ca471cf693c1335e6fc25bea4674e35ab7c12c8d', 'ESFP', NULL, 1),
(12, 3, '61130500009', 'A', 'นางสาวปิยนุช มนูญศักดิ์', '61130500009@mail.kmutt.ac.th', '7b072816ebe47518400c38766739bec7d0047b94fbe34beccea5a31470090998', 'ESFJ', NULL, 1),
(13, 3, '61130500010', 'A', 'นายอาชวิน สมุทรเทวา', '61130500010@mail.kmutt.ac.th', 'b50ae6f563e4d19c01036bee9b8d6c157c485e234c4c99906f8ac94db274274a', 'ESTJ', NULL, 1),
(14, 3, '61130500011', 'A', 'นายจุมพล พิทักษ์ไทย', '61130500011@mail.kmutt.ac.th', 'c31d5b7d5371e0a2fa39165d8b089ea6de2d4b9dd7e5e69d46a84362d99f8b00', '', NULL, 1),
(15, 3, '61130500012', 'A', 'นางสาวชัชชัย จิรามณี', '61130500012@mail.kmutt.ac.th', '79574a41d638b377468e4120937f8d3680dea4549e0b61182c5216512e3b45df', '', NULL, 1),
(16, 3, '61130500013', 'A', 'นายเผ่าเทพ กิจจานุรักษ์', '61130500013@mail.kmutt.ac.th', '4f72f83e6b150b671627cfe9b8e6bab77e5c4187f76874278588b6b4aaf3aa06', '', NULL, 1),
(17, 3, '61130500014', 'A', 'นางสาวธัญพิมล มนูญศักดิ์', '61130500014@mail.kmutt.ac.th', 'b2f37e2eaf02a0e5a60cff7491a1b1460cfc13e2e5d9f7fadc719af8e18d968a', '', NULL, 1),
(18, 3, '61130500016', 'A', 'นางสาวอัคคเดช กางมุ้งคอย', '61130500016@mail.kmutt.ac.th', 'b043c60a544f5b8e9d22cef506f4c49a4f93a81574a1842ba3f86caf51d5d813', '', NULL, 1),
(19, 3, '61130500017', 'A', 'นางสาวชุติกา พึ่งสุข', '61130500017@mail.kmutt.ac.th', 'bd2bcc4f142a332780209d368e0635e78a258d2c5456530194b43307e5860f33', '', NULL, 1),
(20, 3, '61130500018', 'A', 'นายจินตพร พึ่งสุข', '61130500018@mail.kmutt.ac.th', 'bb15a4fcefd1c212ade74e4a859655198d960d351d85db3e4eef443b7c57a3db', '', NULL, 1),
(21, 3, '61130500019', 'A', 'นางสาวอรพิมพ์ อัศวเรืองฤทธิ์', '61130500019@mail.kmutt.ac.th', 'a63c8856f3df12842cfdbd1a58a03fd1c09a55dbc4823c65ac04ba037965324d', '', NULL, 1),
(22, 3, '61130500020', 'A', 'นางสาวกมลา บุญมั่น', '61130500020@mail.kmutt.ac.th', 'a2a0dfa4de11f212308cd05e4063ae0720f388d374f86ebe1767726d476f3149', '', NULL, 1),
(25, 2, 'teacher', 'B', 'ผอ.รักสันติสุข ผดุงธรรม', 'teacher02@kmutt.ac.th', 'c51399ed3f509a773ca3d71874c7834a2ee9fd0b815e6b7b93f0ed5fc48bafd9', '', NULL, 1),
(26, 1, 'admin2', '', 'admin02', 'admin02@kmutt.ac.th', '39239f3230a2a785bc0cadacf9247a317f0b3a0dee82e8a484406b35c0811322', '', NULL, 0),
(27, 3, '61130500015', 'A', 'นายกฤษณ์ รอดคงรวย', '61130500015@mail.kmutt.ac.th', '41a95acdd28a40f9b1978b608656436225a3360481255e1bd071d40a9190b7c2', 'INTJ', NULL, 1),
(28, 3, '61130500021', 'A', 'นางสาวนันทิชา กางมุ้งคอย', '61130500021@mail.kmutt.ac.th', '6a6257ed3bf8792a44c14e162171ac9c53003df878773d8b8d53ce4e64bbdbc3', 'INTP', '{\"lang\":\"th\"}', 1),
(29, 3, '61130500022', 'A', 'นายธนกฤต อัศวรัช', '61130500022@mail.kmutt.ac.th', 'c1e22780bd7d70c46e1467646e948c3f60a075352d1bb623b1545745c1b48bfc', 'ENTJ', NULL, 1),
(30, 3, '61130500023', 'A', 'นางสาวกรกมล ศิลามหาฤกษ์', '61130500023@mail.kmutt.ac.th', 'ae967fa411e90dd32633e81890912dfd371daeab8ef7fbe76c6f336dba74ed1c', 'ENTP', NULL, 1),
(31, 3, '61130500024', 'A', 'นายธนภูมิ สมคำนึง', '61130500024@mail.kmutt.ac.th', '3b43899f1a80e623c13e5651ec7620774831c8d73f3fea70c76c7d20a313a877', 'INFJ', NULL, 1),
(32, 3, '61130500025', 'A', 'นายณัฐชา เกตุอารี', '61130500025@mail.kmutt.ac.th', '48e1b5ac1b7566865a1c31cd9eeb2c8618d28911921880ba01665bab61f580fc', 'INFP', NULL, 1),
(33, 3, '61130500026', 'A', 'นายปกรณ์ บินทะลุบ้าน', '61130500026@mail.kmutt.ac.th', 'b372f7e6f3e980af258e0b74ea7a553e924c1914426eb2186722d6c29115ec13', 'ENFJ', NULL, 1),
(34, 3, '61130500027', 'A', 'นางสาวณัฐชา เกตุอารี', '61130500027@mail.kmutt.ac.th', 'cb6525d63ff1f18bca29e2021c914605724d9a51f0ec7beb8b0a2032e129cc71', 'ENFP', NULL, 1),
(35, 3, '61130500028', 'A', 'นายป้องเกียรติ หนึ่งในยุทธจักร', '61130500028@mail.kmutt.ac.th', '0466cf91a58c05e33453fe3b536c0fda84a1e9fe8da50e5b6cd15aabc0658228', 'ISTJ', NULL, 1),
(36, 3, '61130500029', 'A', 'นางสาวชุติกา วิทยเขตปภา', '61130500029@mail.kmutt.ac.th', '333e98654de83ed0dc468d704b7ca58dff842f968a3e603880ff5e3d78159578', 'ISFJ', NULL, 1),
(37, 3, '61130500030', 'A', 'นางสาววุฒิเดช อัศวเรืองฤทธิ์', '61130500030@mail.kmutt.ac.th', '4e5713fd98b6faa3cedf475cb5d39f9c79d9f522c24052994fe45ac90d53b1d3', 'ESTJ', NULL, 1),
(38, 3, '61130511111', 'A', 'นางสาวทราย บ้านทรายทอง', '61130511111@mail.kmutt.ac.th', '67ee1d91e1565d8361f7e7a88364d018681f125b6d93a001817f5fd8a84a8bb6', 'ESFJ', NULL, 1),
(39, 3, '61130500031', 'B', 'นางสาวณิชมน อดุสาระดี', '61130500031@mail.kmutt.ac.th', '3c87ff8fd9ff56094ad46a5c34efbbeace0a579b39c43873e2861fd51a72ef41', 'ISTP', NULL, 1),
(40, 3, '61130500032', 'B', 'นายปัญญารัตน์ วรรณดำรง', '61130500032@mail.kmutt.ac.th', '3c381ef2a1422c3d2c107ca8c5ad7c67bf161e8005ecff2a2ab656e38a4f6aa5', 'ISFP', NULL, 1),
(41, 3, '61130500033', 'B', 'นางสาวปัญญารัตน์ ดำรงสอง', '61130500033@mail.kmutt.ac.th', 'd867e429fbdb5af120e1c14f3c79940ae01569479e80c3e18ffd3c9b591db338', 'ESTP', NULL, 1),
(42, 3, '61130500034', 'B', 'นายผดุงพร ศิลามหาฤกษ์', '61130500034@mail.kmutt.ac.th', '03263069633c7ae12e81457086d1a82306afcf96edec6670b7b0439049d6cd89', 'ESFP', NULL, 1),
(43, 3, '61130500035', 'B', 'นายกันตภณ พรรณาราย', '61130500035@mail.kmutt.ac.th', '2f56c4d309c0f2483dc5680fdc5a211a364ecd5f13fb4e7d65b79045f2113986', 'INTJ', NULL, 1),
(44, 3, '61130500036', 'B', 'นายชิษณุพงศ์ ทองดี', '61130500036@mail.kmutt.ac.th', '237e81bf1dcae8efc6144a01ee1071a82f1b4b19f230cacfc1318d607d3b1984', 'INTP', NULL, 1),
(45, 3, '61130500037', 'B', 'นางสาวไฉววงศ์ วังชัยศรี', '61130500037@mail.kmutt.ac.th', 'a457e2d18ea8324e806c98af228d2248d811e549cb6ccbcd7b81299cbd1a1fea', 'ENTJ', NULL, 1),
(46, 3, '61130500038', 'B', 'นายอรรณพ มหานิยม', '61130500038@mail.kmutt.ac.th', '79cb95dbf09dd101b21d5c30646d7999eb2114ca40ff4634e3d4b73850a8ccc1', 'ENTP', NULL, 1),
(47, 3, '61130500039', 'B', 'นางสาวฐิติพรรณ บินทะลุบ้าน', '61130500039@mail.kmutt.ac.th', '64714ac9a6dbb6c56c51bae4d83f9a748d608ddc559ec2cad272aa8b06d412db', 'INFJ', NULL, 1),
(48, 3, '61130500040', 'B', 'นางสาวชนิดา ปืนครก', '61130500040@mail.kmutt.ac.th', '0ad60b157c31df7a147c2ea563706acd6c5bc76a3c5a5beca6aa3a3047798356', 'INFP', '{\"lang\":\"th\"}', 1),
(49, 3, '61130500041', 'B', 'นางสาวปรางทิพย์ รัตนเดชากร', '61130500041@mail.kmutt.ac.th', 'c5cc0bfc7c79adfa2790bd7872ff5a7190c05397351a7e3c22b3d410ba48df80', 'ENFJ', NULL, 1),
(50, 3, '61130500042', 'B', 'นายอนุรักข์ รัตนเดชากร', '61130500042@mail.kmutt.ac.th', '03a0befe7831725c43cda160ba5879536d8d958c95330e4e0a79eaba1e4456e1', 'ENFP', NULL, 1),
(51, 3, '61130500043', 'B', 'นายธงคลชัย ศรีเจริญ', '61130500043@mail.kmutt.ac.th', '09c24763badcba8a10b92fcddd6e40f48a3c8e764891c28f7bf9d58fda08c42a', 'ISTJ', NULL, 1),
(52, 3, '61130500044', 'B', 'นายอนันตชัย บาดตาแมว', '61130500044@mail.kmutt.ac.th', '81cd76ffff730de4b6767fe46577a8f4dce340cb8cac0c1a03bf6442987749e5', 'ISFJ', NULL, 1),
(53, 3, '61130500045', 'B', 'นางสาวกัลยา พุ่มฉัตร', '61130500045@mail.kmutt.ac.th', 'eb927e717959b13c04f283ae689418ef34d71c0166ee49086691f6386354ffce', 'ESTJ', NULL, 1),
(54, 3, '61130500046', 'B', 'นางสาวกมลรัตน์ ตาลือ', '61130500046@mail.kmutt.ac.th', 'a92cfa7cc3c4897505670cb779caf25ec5b39595648828ab4705dfb729835b1b', 'ESFJ', NULL, 1),
(55, 3, '61130500047', 'B', 'นายแสงโชติ สุรบดินทร์', '61130500047@mail.kmutt.ac.th', '27eb4e0dd0eec500a03bfcfcd10741f740f3b969827abb5ff9bd31a44e1283a7', 'ISTP', NULL, 1),
(56, 3, '61130500048', 'B', 'นายปัญญารัตน์ เกิดความสุข', '61130500048@mail.kmutt.ac.th', '1fa1c08213828d76e78116cc6c0383739e5ebe880def2419a44c97ba00157a91', 'ISFP', NULL, 1),
(57, 3, '61130500049', 'B', 'นางสาวเพ็ญประภา ทองดี', '61130500049@mail.kmutt.ac.th', '62cb7e17cc5add8c8efbddef442b2580c7a5857af2a1c345bfac47ef5d975d21', 'ESTP', NULL, 1),
(58, 3, '61130500050', 'B', 'นางสาวบุณยพร มหานิยม', '61130500050@mail.kmutt.ac.th', '0cbae7304697034b4c36969d9e0f8a5227e5540d4b4548bed1dd0c55eef0d5b2', 'ESFP', NULL, 1),
(59, 3, '61130522222', 'B', 'นายข้าวตัง บ้านทรายเงิน', '61130522222@mail.kmutt.ac.th', '1d3f52f9c6bc15890c88bc32ceeda763aa7d71ea41ffedea574c2a9a79e0e69f', 'INTJ', NULL, 1),
(60, 2, 'teacherx', 'A', 'ผศ.เอมเค สุกกี้', 'teacherx1@kmutt.ac.th', 'd58bd579c75964638d15ab2eab017862cd157b578570394224a232071e995ddd', '', '{\"lang\":\"en\"}', 1),
(61, 1, 'adminx', '', 'ผู้ช่วยสอนหล่อ เท่', 'adminx@kmutt.ac.th', '8d96ada08b3fc0e4cb66415524b70ac0b795c7391be9befe11deb8fc107a7c22', '', NULL, 1),
(62, 2, 'teacherx2', 'B', 'อาจารย์ข้าวมันไก่ ไม่หนัง', 'teacherx2@kmutt.ac.th', '35cbbc4c97eefaaba799c40732e9a27baec04616cf0ce80a8e8e6bf3839d093f', '', NULL, 1);

-- --------------------------------------------------------

--
-- Table structure for table `user_type`
--

CREATE TABLE `user_type` (
  `userTypeID` int(11) NOT NULL COMMENT 'รหัสลำดับประเภทผู้ใช้',
  `userType` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'ประเภทผู้ใช้',
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'สถานะการใช้งาน 0 ระงับ 1 ใช้งาน'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='ฐานข้อมูลประเภทผู้ใช้';

--
-- Dumping data for table `user_type`
--

INSERT INTO `user_type` (`userTypeID`, `userType`, `status`) VALUES
(1, 'ผู้ช่วยสอน', 1),
(2, 'อาจารย์', 1),
(3, 'นักศึกษา', 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `assignment`
--
ALTER TABLE `assignment`
  ADD PRIMARY KEY (`assignID`);

--
-- Indexes for table `course_information`
--
ALTER TABLE `course_information`
  ADD PRIMARY KEY (`courseID`);

--
-- Indexes for table `discussion`
--
ALTER TABLE `discussion`
  ADD PRIMARY KEY (`discussID`);

--
-- Indexes for table `evaluation_answer`
--
ALTER TABLE `evaluation_answer`
  ADD PRIMARY KEY (`answerID`);

--
-- Indexes for table `evaluation_question`
--
ALTER TABLE `evaluation_question`
  ADD PRIMARY KEY (`questionID`);

--
-- Indexes for table `group_information`
--
ALTER TABLE `group_information`
  ADD PRIMARY KEY (`groupInfoID`) USING BTREE,
  ADD KEY `assignID` (`assignID`);

--
-- Indexes for table `group_type`
--
ALTER TABLE `group_type`
  ADD PRIMARY KEY (`groupTypeID`);

--
-- Indexes for table `mbti_answer`
--
ALTER TABLE `mbti_answer`
  ADD PRIMARY KEY (`answerID`);

--
-- Indexes for table `mbti_question`
--
ALTER TABLE `mbti_question`
  ADD PRIMARY KEY (`questionID`) USING BTREE;

--
-- Indexes for table `registration_information`
--
ALTER TABLE `registration_information`
  ADD PRIMARY KEY (`regisID`),
  ADD KEY `courseID` (`courseID`),
  ADD KEY `userID` (`userID`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`userID`),
  ADD KEY `userTypeID` (`userTypeID`);

--
-- Indexes for table `user_type`
--
ALTER TABLE `user_type`
  ADD PRIMARY KEY (`userTypeID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `assignment`
--
ALTER TABLE `assignment`
  MODIFY `assignID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'รหัสลำดับการมอบหมายงาน', AUTO_INCREMENT=40;

--
-- AUTO_INCREMENT for table `course_information`
--
ALTER TABLE `course_information`
  MODIFY `courseID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'รหัสลำดับรายวิชา', AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `discussion`
--
ALTER TABLE `discussion`
  MODIFY `discussID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'รหัสลำดับการอภิปรายผล', AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `evaluation_answer`
--
ALTER TABLE `evaluation_answer`
  MODIFY `answerID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'รหัสลำดับคำตอบ', AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT for table `evaluation_question`
--
ALTER TABLE `evaluation_question`
  MODIFY `questionID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'รหัสลำดับข้อคำถาม', AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `group_information`
--
ALTER TABLE `group_information`
  MODIFY `groupInfoID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'รหัสลำดับการจับกลุ่ม', AUTO_INCREMENT=261;

--
-- AUTO_INCREMENT for table `group_type`
--
ALTER TABLE `group_type`
  MODIFY `groupTypeID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'รหัสลำดับประเภทการจับกลุ่ม', AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `mbti_answer`
--
ALTER TABLE `mbti_answer`
  MODIFY `answerID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'รหัสลำดับคำตอบ', AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `mbti_question`
--
ALTER TABLE `mbti_question`
  MODIFY `questionID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'รหัสลำดับข้อคำถาม', AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `registration_information`
--
ALTER TABLE `registration_information`
  MODIFY `regisID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'รหัสลำดับรายวิชาที่เปิดสอน', AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `userID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'รหัสลำดับข้อมูลผู้ใช้', AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT for table `user_type`
--
ALTER TABLE `user_type`
  MODIFY `userTypeID` int(11) NOT NULL AUTO_INCREMENT COMMENT 'รหัสลำดับประเภทผู้ใช้', AUTO_INCREMENT=5;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
