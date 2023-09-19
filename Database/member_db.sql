-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 19, 2023 at 08:44 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `member_db`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `username`, `password`) VALUES
(1, 'admin', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `attendance`
--

CREATE TABLE `attendance` (
  `AttendanceID` int(11) NOT NULL,
  `MemberID` int(11) NOT NULL,
  `ClassID` int(11) NOT NULL,
  `Attendance_Date` date NOT NULL,
  `Check_in_Time` time NOT NULL,
  `Check_out_Time` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `classes`
--

CREATE TABLE `classes` (
  `ClassID` int(11) NOT NULL,
  `Level_id` int(11) NOT NULL,
  `Class_Name` varchar(100) NOT NULL,
  `Instructor_Name` varchar(100) NOT NULL,
  `Schedule` datetime NOT NULL,
  `Maximum_Capacity` int(11) NOT NULL,
  `Description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `classes`
--

INSERT INTO `classes` (`ClassID`, `Level_id`, `Class_Name`, `Instructor_Name`, `Schedule`, `Maximum_Capacity`, `Description`) VALUES
(1, 1, 'Yoga Basics', 'Instructor Sarah Miller', '2023-09-25 08:00:00', 20, 'Introductory yoga class for beginners.'),
(2, 1, 'Pilates Fundamentals', 'Instructor John Smith', '2023-09-26 18:30:00', 15, 'Learn the basics of Pilates and core strengthening.'),
(3, 1, 'Cardio Kickboxing', 'Instructor Lisa Davis', '2023-09-27 18:00:00', 25, 'High-intensity kickboxing workout.'),
(4, 1, 'Spin Cycling', 'Instructor Michael Johnson', '2023-09-28 07:00:00', 30, 'Indoor cycling for cardiovascular fitness.'),
(5, 1, 'Bootcamp Fitness', 'Instructor Emily Wilson', '2023-09-29 17:30:00', 20, 'Total body workout with various exercises.'),
(6, 1, 'Strength Training', 'Instructor Robert Brown', '2023-09-26 17:00:00', 15, 'Focus on building strength and muscle.'),
(7, 1, 'Zumba Dance', 'Instructor Maria Gonzalez', '2023-09-30 10:00:00', 25, 'Dance-based fitness class.'),
(8, 1, 'Hatha Yoga', 'Instructor Daniel Clark', '2023-09-27 07:30:00', 20, 'Traditional yoga practice for relaxation.'),
(9, 1, 'CrossFit Conditioning', 'Instructor Laura White', '2023-09-25 06:30:00', 20, 'High-intensity functional fitness training.'),
(10, 1, 'Aqua Aerobics', 'Instructor James Turner', '2023-09-26 09:00:00', 15, 'Water-based aerobics for joint-friendly exercise.'),
(11, 3, 'Advanced Yoga', 'Instructor Sarah Miller', '2023-09-25 09:30:00', 15, 'Advanced yoga techniques and meditation.'),
(12, 3, 'High-Intensity Interval Training', 'Instructor John Smith', '2023-09-26 17:30:00', 20, 'HIIT workouts for advanced fitness levels.'),
(13, 3, 'Muay Thai Kickboxing', 'Instructor Lisa Davis', '2023-09-27 19:00:00', 25, 'Advanced kickboxing and self-defense.'),
(14, 3, 'Advanced Spinning', 'Instructor Michael Johnson', '2023-09-28 06:00:00', 20, 'Advanced indoor cycling with intensity.'),
(15, 3, 'CrossFit Elite', 'Instructor Emily Wilson', '2023-09-29 18:00:00', 15, 'High-level CrossFit training with competition.'),
(16, 3, 'Powerlifting Workshop', 'Instructor Robert Brown', '2023-09-26 19:30:00', 10, 'Advanced strength training and powerlifting.'),
(17, 3, 'Salsa Dance Mastery', 'Instructor Maria Gonzalez', '2023-09-30 14:00:00', 20, 'Advanced salsa dance and choreography.'),
(18, 3, 'Ashtanga Yoga', 'Instructor Daniel Clark', '2023-09-27 09:00:00', 15, 'Dynamic yoga practice for advanced practitioners.'),
(19, 3, 'Olympic Weightlifting', 'Instructor Laura White', '2023-09-25 17:00:00', 10, 'Advanced weightlifting techniques.'),
(20, 3, 'Triathlon Training', 'Instructor James Turner', '2023-09-26 06:30:00', 12, 'Training for triathlon competitions and endurance.');

-- --------------------------------------------------------

--
-- Table structure for table `diet_plans`
--

CREATE TABLE `diet_plans` (
  `DietPlanID` int(11) NOT NULL,
  `MemberID` int(11) NOT NULL,
  `Plan_Name` varchar(255) NOT NULL,
  `Description` text NOT NULL,
  `Date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `discounts`
--

CREATE TABLE `discounts` (
  `DiscountID` int(11) NOT NULL,
  `discount_details` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `discounts`
--

INSERT INTO `discounts` (`DiscountID`, `discount_details`) VALUES
(1, '10% off for first-time gym members.'),
(2, '20% off on annual memberships if you refer a friend.'),
(3, '15% off for students with a valid ID.'),
(4, 'Family discount: 25% off for each family member when you sign up together.'),
(5, 'Weekend special: Enjoy a 10% discount on weekend gym access.'),
(6, 'Senior citizen discount: 30% off for members aged 65 and above.'),
(7, 'Group discount: 15% off on group fitness classes for groups of 5 or more.'),
(8, 'Annual membership sale: Save 35% when you commit to a full year.'),
(9, 'Personal training discount: Buy 10 sessions and get 2 sessions free.'),
(10, 'Early bird discount: 10% off for morning workout sessions.');

-- --------------------------------------------------------

--
-- Table structure for table `events`
--

CREATE TABLE `events` (
  `EventID` int(11) NOT NULL,
  `event_details` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `events`
--

INSERT INTO `events` (`EventID`, `event_details`) VALUES
(1, 'Yoga Workshop: Join us for a relaxing yoga session this Saturday at 10 AM.'),
(2, 'Zumba Party: Get your groove on at our Zumba dance party on Friday night!'),
(3, 'Weightlifting Competition: Test your strength and win exciting prizes on Sunday.'),
(4, 'Nutrition Seminar: Learn about healthy eating habits and meal planning on Wednesday.'),
(5, 'Running Club: Join our running club and improve your fitness every Tuesday and Thursday.'),
(6, 'Boxing Bootcamp: Get in shape with our intense boxing workouts every Monday.'),
(7, 'Cycling Tour: Explore scenic routes with our cycling tour group this weekend.'),
(8, 'Swimming Lessons: Sign up for swimming lessons for beginners starting next month.'),
(9, 'Bodybuilding Expo: Donot miss our bodybuilding expo featuring top athletes.'),
(10, 'Dance Fitness Class: Dance your way to fitness in our dance fitness class every Friday evening.');

-- --------------------------------------------------------

--
-- Table structure for table `fitness_training_routines`
--

CREATE TABLE `fitness_training_routines` (
  `RoutineID` int(11) NOT NULL,
  `MemberID` int(11) NOT NULL,
  `Routine_Name` varchar(100) NOT NULL,
  `Description` text NOT NULL,
  `Date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `members`
--

CREATE TABLE `members` (
  `MemberID` int(11) NOT NULL,
  `profileimage` varchar(255) NOT NULL,
  `name` varchar(100) NOT NULL,
  `gender` varchar(10) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `phone` varchar(20) NOT NULL,
  `address` varchar(255) NOT NULL,
  `membership_start_date` date NOT NULL,
  `membership_expiry_date` date NOT NULL,
  `membership_level` int(11) NOT NULL,
  `verification_token` varchar(255) DEFAULT NULL,
  `status` enum('unverified','verified') DEFAULT 'unverified'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `members`
--

INSERT INTO `members` (`MemberID`, `profileimage`, `name`, `gender`, `email`, `password`, `phone`, `address`, `membership_start_date`, `membership_expiry_date`, `membership_level`, `verification_token`, `status`) VALUES
(21, 'CS619 Final Viva Prepartion.png', 'NASIR ABBAS', 'Male', 'nasiryt.827@gmail.com', '123', '3176526827', 'Street jeff xxxx', '2023-09-29', '2023-12-28', 1, '65093d694eeaf', 'verified'),
(24, 'Challan Submit.jpeg', 'Saif', 'Male', 'saifx280@gmail.com', '123', '538465', 'Street jeff xxxx', '2023-09-29', '2023-12-28', 1, '65093fca3768c', 'verified');

-- --------------------------------------------------------

--
-- Table structure for table `membership_levels`
--

CREATE TABLE `membership_levels` (
  `LevelID` int(11) NOT NULL,
  `level_name` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `features` text NOT NULL,
  `duration` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `membership_levels`
--

INSERT INTO `membership_levels` (`LevelID`, `level_name`, `description`, `price`, `features`, `duration`) VALUES
(1, 'Primary', 'This is Primary Membership Level , Here all the benefits about Primary Membership will be provided', 4000.00, 'trainer , 2 hour fitness Classes ', '3'),
(3, 'Secondary', 'This is Sceonday Level, Here all the Facilities provided', 8000.00, 'Fitness Trainer , 3 Month Regular Classes ', '6');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `receiver_id` int(11) NOT NULL,
  `message_text` text DEFAULT NULL,
  `sent_datetime` datetime DEFAULT current_timestamp(),
  `reply_text` text DEFAULT NULL,
  `reply_datetime` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `offers`
--

CREATE TABLE `offers` (
  `OfferID` int(11) NOT NULL,
  `offer_details` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `offers`
--

INSERT INTO `offers` (`OfferID`, `offer_details`) VALUES
(1, 'New Year Special: Join now and get the first month free!'),
(2, 'Refer a friend and both of you receive a 10% discount on membership renewal.'),
(3, 'Student Discount: Students with a valid ID enjoy 20% off monthly memberships.'),
(4, 'Family Package: Sign up with your family and save 15% on each membership.'),
(5, 'Weekend Warrior: Access the gym for free every weekend this month.'),
(6, 'Senior Citizen Discount: Members aged 65 and above receive a 25% discount on all plans.'),
(7, 'Group Fitness Classes: Buy one class package, get one at half price.'),
(8, 'Annual Membership Sale: Save 30% when you sign up for an annual membership.'),
(9, 'Personal Training Bundle: Get 10 personal training sessions for the price of 8.'),
(10, 'Early Bird Special: Sign up for a morning membership and get 15% off.');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `PaymentID` int(11) NOT NULL,
  `MemberID` int(11) NOT NULL,
  `LevelID` int(11) NOT NULL,
  `PaymentDate` date NOT NULL,
  `PaymentAmount` decimal(10,2) NOT NULL,
  `PaymentMethod` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`PaymentID`, `MemberID`, `LevelID`, `PaymentDate`, `PaymentAmount`, `PaymentMethod`) VALUES
(17, 21, 1, '2023-09-19', 4000.00, 'Physical'),
(18, 24, 1, '2023-09-19', 4000.00, 'Physical');

-- --------------------------------------------------------

--
-- Table structure for table `progress_tracking`
--

CREATE TABLE `progress_tracking` (
  `ProgressID` int(11) NOT NULL,
  `MemberID` int(11) DEFAULT NULL,
  `Date` date NOT NULL,
  `Weight` decimal(5,2) NOT NULL,
  `Body_Measurements` varchar(255) NOT NULL,
  `Fitness_Achievements` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `attendance`
--
ALTER TABLE `attendance`
  ADD PRIMARY KEY (`AttendanceID`),
  ADD KEY `MemberID` (`MemberID`),
  ADD KEY `ClassID` (`ClassID`);

--
-- Indexes for table `classes`
--
ALTER TABLE `classes`
  ADD PRIMARY KEY (`ClassID`),
  ADD KEY `Level_id` (`Level_id`);

--
-- Indexes for table `diet_plans`
--
ALTER TABLE `diet_plans`
  ADD PRIMARY KEY (`DietPlanID`),
  ADD KEY `MemberID` (`MemberID`);

--
-- Indexes for table `discounts`
--
ALTER TABLE `discounts`
  ADD PRIMARY KEY (`DiscountID`);

--
-- Indexes for table `events`
--
ALTER TABLE `events`
  ADD PRIMARY KEY (`EventID`);

--
-- Indexes for table `fitness_training_routines`
--
ALTER TABLE `fitness_training_routines`
  ADD PRIMARY KEY (`RoutineID`),
  ADD KEY `MemberID` (`MemberID`);

--
-- Indexes for table `members`
--
ALTER TABLE `members`
  ADD PRIMARY KEY (`MemberID`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `membership_level` (`membership_level`);

--
-- Indexes for table `membership_levels`
--
ALTER TABLE `membership_levels`
  ADD PRIMARY KEY (`LevelID`);

--
-- Indexes for table `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `offers`
--
ALTER TABLE `offers`
  ADD PRIMARY KEY (`OfferID`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`PaymentID`),
  ADD KEY `MemberID` (`MemberID`),
  ADD KEY `LevelID` (`LevelID`);

--
-- Indexes for table `progress_tracking`
--
ALTER TABLE `progress_tracking`
  ADD PRIMARY KEY (`ProgressID`),
  ADD KEY `MemberID` (`MemberID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `attendance`
--
ALTER TABLE `attendance`
  MODIFY `AttendanceID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `classes`
--
ALTER TABLE `classes`
  MODIFY `ClassID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `diet_plans`
--
ALTER TABLE `diet_plans`
  MODIFY `DietPlanID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `discounts`
--
ALTER TABLE `discounts`
  MODIFY `DiscountID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `events`
--
ALTER TABLE `events`
  MODIFY `EventID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `fitness_training_routines`
--
ALTER TABLE `fitness_training_routines`
  MODIFY `RoutineID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `members`
--
ALTER TABLE `members`
  MODIFY `MemberID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `membership_levels`
--
ALTER TABLE `membership_levels`
  MODIFY `LevelID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `offers`
--
ALTER TABLE `offers`
  MODIFY `OfferID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `PaymentID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `progress_tracking`
--
ALTER TABLE `progress_tracking`
  MODIFY `ProgressID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `attendance`
--
ALTER TABLE `attendance`
  ADD CONSTRAINT `attendance_ibfk_1` FOREIGN KEY (`MemberID`) REFERENCES `members` (`MemberID`),
  ADD CONSTRAINT `attendance_ibfk_2` FOREIGN KEY (`ClassID`) REFERENCES `classes` (`ClassID`);

--
-- Constraints for table `classes`
--
ALTER TABLE `classes`
  ADD CONSTRAINT `classes_ibfk_1` FOREIGN KEY (`Level_id`) REFERENCES `membership_levels` (`LevelID`);

--
-- Constraints for table `diet_plans`
--
ALTER TABLE `diet_plans`
  ADD CONSTRAINT `diet_plans_ibfk_1` FOREIGN KEY (`MemberID`) REFERENCES `members` (`MemberID`);

--
-- Constraints for table `fitness_training_routines`
--
ALTER TABLE `fitness_training_routines`
  ADD CONSTRAINT `fitness_training_routines_ibfk_1` FOREIGN KEY (`MemberID`) REFERENCES `members` (`MemberID`);

--
-- Constraints for table `members`
--
ALTER TABLE `members`
  ADD CONSTRAINT `members_ibfk_1` FOREIGN KEY (`membership_level`) REFERENCES `membership_levels` (`LevelID`);

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`MemberID`) REFERENCES `members` (`MemberID`),
  ADD CONSTRAINT `payments_ibfk_2` FOREIGN KEY (`LevelID`) REFERENCES `membership_levels` (`LevelID`);

--
-- Constraints for table `progress_tracking`
--
ALTER TABLE `progress_tracking`
  ADD CONSTRAINT `progress_tracking_ibfk_1` FOREIGN KEY (`MemberID`) REFERENCES `members` (`MemberID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
