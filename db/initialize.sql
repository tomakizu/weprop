
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+08:00";

CREATE TABLE `announcement_recipient` (
  `record_id` int(10) NOT NULL,
  `recipient` varchar(20) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `announcement_record` (
  `record_id` int(10) NOT NULL,
  `staff_id` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `announcement_title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `announcement_content` varchar(1024) COLLATE utf8_unicode_ci NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp(),
  `expire_date` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `building` (
  `building_id` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `chi_building_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `eng_building_name` varchar(100) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `department` (
  `department_id` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `department_chi_name` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `department_eng_name` varchar(40) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `department` (`department_id`, `department_chi_name`, `department_eng_name`) VALUES
('admin', '系統管理員', 'System Administrator'),
('mainten', '維修部', 'Maintenance department');

CREATE TABLE `feedback` (
  `record_id` int(10) NOT NULL,
  `user_email` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `category_id` char(5) COLLATE utf8_unicode_ci NOT NULL,
  `record_details` varchar(1024) COLLATE utf8_unicode_ci NOT NULL,
  `feedback_photo` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `status` int(1) NOT NULL DEFAULT 0 COMMENT '0 = submitted, 1 = case transferred, 2 = file closed',
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `feedback_category` (
  `status` int(1) NOT NULL DEFAULT 1 COMMENT '0 = disabled, 1 = enabled',
  `category_id` char(5) COLLATE utf8_unicode_ci NOT NULL,
  `category_chi_name` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `category_eng_name` varchar(40) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `feedback_category` (`status`, `category_id`, `category_chi_name`, `category_eng_name`) VALUES
(1, 'CAT01', '電力', 'electricity'),
(1, 'CAT02', '水喉', 'aqueduct');

CREATE TABLE `feedback_referral` (
  `record_id` int(10) NOT NULL,
  `department_id` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `feedback_response` (
  `record_id` int(10) NOT NULL,
  `staff_id` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `response` varchar(1024) COLLATE utf8_unicode_ci NOT NULL,
  `percentage` int(3) NOT NULL,
  `timestamp` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `issue` (
  `issue_id` int(10) NOT NULL,
  `issue_title` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `issue_details` varchar(1024) COLLATE utf8_unicode_ci NOT NULL,
  `raise_flag` int(1) NOT NULL COMMENT '0 = raised by owners, 1 = raised by management',
  `raised_by` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `cutoff_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `issue_choice` (
  `issue_id` int(10) NOT NULL,
  `choice_id` varchar(5) COLLATE utf8_unicode_ci NOT NULL,
  `choice_chi_desc` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `choice_eng_desc` varchar(50) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `owner` (
  `property_id` int(10) NOT NULL,
  `user_email` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `parcel` (
  `row_id` int(10) NOT NULL,
  `resident_email` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `tracking_num` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `ref_num` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `status` int(1) NOT NULL DEFAULT 0 COMMENT '0 = keeping, 1 = returned'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `property` (
  `property_id` int(10) NOT NULL,
  `building_id` varchar(20) COLLATE utf8_unicode_ci DEFAULT NULL,
  `floor` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `room_no` varchar(5) COLLATE utf8_unicode_ci DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `qr_code` (
  `record_id` int(10) NOT NULL,
  `code` char(128) COLLATE utf8_unicode_ci NOT NULL,
  `status` int(1) NOT NULL DEFAULT 1 COMMENT '0 = unavailable, 1 = available',
  `access_time` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `resident` (
  `status` int(1) NOT NULL DEFAULT 2 COMMENT '0 = disabled, 1 = enabled, 2 = temporary',
  `email` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `hashed_email` char(128) COLLATE utf8_unicode_ci NOT NULL,
  `password` char(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `eng_first_name` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `eng_last_name` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `chi_first_name` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `chi_last_name` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mobile_phone` char(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `property_id` int(10) DEFAULT NULL,
  `lang` char(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'zh'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;


INSERT INTO `resident` (`status`, `email`, `hashed_email`, `password`, `eng_first_name`, `eng_last_name`, `chi_first_name`, `chi_last_name`, `mobile_phone`, `property_id`, `lang`) VALUES
(1, 'user', 'user', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'User', 'USER', NULL, NULL, '123', 1, 'zh');

CREATE TABLE `resident_qr_code` (
  `email` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `qr_code` varchar(128) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `staff` (
  `status` int(1) NOT NULL DEFAULT 1 COMMENT '0 = disabled, 1 = enabled',
  `staff_id` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `password` char(128) COLLATE utf8_unicode_ci NOT NULL,
  `eng_first_name` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `eng_last_name` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `chi_first_name` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `chi_last_name` varchar(6) COLLATE utf8_unicode_ci DEFAULT NULL,
  `mobile_phone` char(8) COLLATE utf8_unicode_ci DEFAULT NULL,
  `address` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `position_id` varchar(10) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `staff` (`status`, `staff_id`, `password`, `eng_first_name`, `eng_last_name`, `chi_first_name`, `chi_last_name`, `mobile_phone`, `address`, `position_id`) VALUES
(1, 'admin', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'Admin', 'Admin', NULL, NULL, NULL, 'Administrator', 'admin'),
(1, 'mainten', 'ba3253876aed6bc22d4a6ff53d8406c6ad864195ed144ab5c87621b6c233b548baeae6956df346ec8c17f5ea10f35ee3cbc514797ed7ddd3145464e2a0bab413', 'mainten', 'mainten', NULL, NULL, NULL, '', 'mainten');

CREATE TABLE `staff_position` (
  `position_id` varchar(10) COLLATE utf8_unicode_ci NOT NULL,
  `position_chi_name` varchar(20) COLLATE utf8_unicode_ci NOT NULL,
  `position_eng_name` varchar(40) COLLATE utf8_unicode_ci NOT NULL,
  `department_id` varchar(10) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

INSERT INTO `staff_position` (`position_id`, `position_chi_name`, `position_eng_name`, `department_id`) VALUES
('admin', '系統管理員', 'System Administrator', 'admin'),
('mainten', '維修員', 'Maintenance Staff', 'mainten');

CREATE TABLE `visitor` (
  `record_id` int(10) NOT NULL,
  `status` int(1) NOT NULL DEFAULT 2 COMMENT '0 = disabled, 1 = enabled, 2 = temporary',
  `email` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `hash` char(128) COLLATE utf8_unicode_ci NOT NULL,
  `resident_email` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `staff_id` varchar(128) COLLATE utf8_unicode_ci DEFAULT NULL,
  `eng_first_name` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `eng_last_name` varchar(40) COLLATE utf8_unicode_ci DEFAULT NULL,
  `id_no` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `access_date` date NOT NULL,
  `lang` char(2) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'zh'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

CREATE TABLE `voting_record` (
  `issue_id` int(10) NOT NULL,
  `owner_email` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  `owner_choice` varchar(5) COLLATE utf8_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

ALTER TABLE `announcement_recipient`
  ADD PRIMARY KEY (`record_id`,`recipient`);

ALTER TABLE `announcement_record`
  ADD PRIMARY KEY (`record_id`),
  ADD KEY `staff_id` (`staff_id`);

ALTER TABLE `building`
  ADD PRIMARY KEY (`building_id`);

ALTER TABLE `department`
  ADD PRIMARY KEY (`department_id`);

ALTER TABLE `feedback`
  ADD PRIMARY KEY (`record_id`),
  ADD KEY `user_email` (`user_email`),
  ADD KEY `category_id` (`category_id`);

ALTER TABLE `feedback_category`
  ADD PRIMARY KEY (`category_id`);

ALTER TABLE `feedback_referral`
  ADD PRIMARY KEY (`record_id`),
  ADD KEY `department_id` (`department_id`);

ALTER TABLE `feedback_response`
  ADD PRIMARY KEY (`record_id`),
  ADD KEY `staff_id` (`staff_id`);

ALTER TABLE `issue`
  ADD PRIMARY KEY (`issue_id`);

ALTER TABLE `issue_choice`
  ADD PRIMARY KEY (`issue_id`,`choice_id`),
  ADD KEY `issue_choice_index` (`choice_id`);

ALTER TABLE `owner`
  ADD PRIMARY KEY (`property_id`),
  ADD KEY `user_email` (`user_email`);

ALTER TABLE `parcel`
  ADD PRIMARY KEY (`row_id`),
  ADD KEY `resident_email` (`resident_email`);

ALTER TABLE `property`
  ADD PRIMARY KEY (`property_id`),
  ADD KEY `building_id` (`building_id`);

ALTER TABLE `qr_code`
  ADD PRIMARY KEY (`record_id`);

ALTER TABLE `resident`
  ADD PRIMARY KEY (`email`),
  ADD KEY `property_id` (`property_id`);

ALTER TABLE `resident_qr_code`
  ADD PRIMARY KEY (`email`);

ALTER TABLE `staff`
  ADD PRIMARY KEY (`staff_id`),
  ADD KEY `position_id` (`position_id`);

ALTER TABLE `staff_position`
  ADD PRIMARY KEY (`position_id`),
  ADD KEY `department_id` (`department_id`);

ALTER TABLE `visitor`
  ADD PRIMARY KEY (`record_id`),
  ADD KEY `resident_email` (`resident_email`),
  ADD KEY `staff_id` (`staff_id`);

ALTER TABLE `voting_record`
  ADD PRIMARY KEY (`issue_id`,`owner_email`),
  ADD KEY `owner_email` (`owner_email`),
  ADD KEY `owner_choice` (`owner_choice`);

ALTER TABLE `announcement_record`
  MODIFY `record_id` int(10) NOT NULL AUTO_INCREMENT;

ALTER TABLE `feedback`
  MODIFY `record_id` int(10) NOT NULL AUTO_INCREMENT;


ALTER TABLE `issue`
  MODIFY `issue_id` int(10) NOT NULL AUTO_INCREMENT;

ALTER TABLE `parcel`
  MODIFY `row_id` int(10) NOT NULL AUTO_INCREMENT;

ALTER TABLE `property`
  MODIFY `property_id` int(10) NOT NULL AUTO_INCREMENT;

ALTER TABLE `visitor`
  MODIFY `record_id` int(10) NOT NULL AUTO_INCREMENT;

ALTER TABLE `announcement_recipient`
  ADD CONSTRAINT `announcement_recipient_ibfk_1` FOREIGN KEY (`record_id`) REFERENCES `announcement_record` (`record_id`);

ALTER TABLE `announcement_record`
  ADD CONSTRAINT `announcement_record_ibfk_1` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`);

ALTER TABLE `feedback`
  ADD CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`user_email`) REFERENCES `resident` (`email`),
  ADD CONSTRAINT `feedback_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `feedback_category` (`category_id`);

ALTER TABLE `feedback_referral`
  ADD CONSTRAINT `feedback_referral_ibfk_1` FOREIGN KEY (`record_id`) REFERENCES `feedback` (`record_id`),
  ADD CONSTRAINT `feedback_referral_ibfk_2` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`);

ALTER TABLE `feedback_response`
  ADD CONSTRAINT `feedback_response_ibfk_1` FOREIGN KEY (`record_id`) REFERENCES `feedback` (`record_id`),
  ADD CONSTRAINT `feedback_response_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`);

ALTER TABLE `issue_choice`
  ADD CONSTRAINT `issue_choice_ibfk_1` FOREIGN KEY (`issue_id`) REFERENCES `issue` (`issue_id`);

ALTER TABLE `owner`
  ADD CONSTRAINT `owner_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `property` (`property_id`),
  ADD CONSTRAINT `owner_ibfk_2` FOREIGN KEY (`user_email`) REFERENCES `resident` (`email`);

ALTER TABLE `parcel`
  ADD CONSTRAINT `parcel_ibfk_1` FOREIGN KEY (`resident_email`) REFERENCES `resident` (`email`);

ALTER TABLE `property`
  ADD CONSTRAINT `property_ibfk_1` FOREIGN KEY (`building_id`) REFERENCES `building` (`building_id`);

ALTER TABLE `qr_code`
  ADD CONSTRAINT `qr_code_ibfk_1` FOREIGN KEY (`record_id`) REFERENCES `visitor` (`record_id`);

ALTER TABLE `resident`
  ADD CONSTRAINT `resident_ibfk_1` FOREIGN KEY (`property_id`) REFERENCES `property` (`property_id`);

ALTER TABLE `resident_qr_code`
  ADD CONSTRAINT `resident_qr_code_ibfk_1` FOREIGN KEY (`email`) REFERENCES `resident` (`email`);

ALTER TABLE `staff`
  ADD CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`position_id`) REFERENCES `staff_position` (`position_id`);

ALTER TABLE `staff_position`
  ADD CONSTRAINT `staff_position_ibfk_1` FOREIGN KEY (`department_id`) REFERENCES `department` (`department_id`);

ALTER TABLE `visitor`
  ADD CONSTRAINT `visitor_ibfk_1` FOREIGN KEY (`resident_email`) REFERENCES `resident` (`email`),
  ADD CONSTRAINT `visitor_ibfk_2` FOREIGN KEY (`staff_id`) REFERENCES `staff` (`staff_id`);

ALTER TABLE `voting_record`
  ADD CONSTRAINT `voting_record_ibfk_1` FOREIGN KEY (`issue_id`) REFERENCES `issue` (`issue_id`),
  ADD CONSTRAINT `voting_record_ibfk_2` FOREIGN KEY (`owner_email`) REFERENCES `resident` (`email`),
  ADD CONSTRAINT `voting_record_ibfk_3` FOREIGN KEY (`owner_choice`) REFERENCES `issue_choice` (`choice_id`);
COMMIT;
