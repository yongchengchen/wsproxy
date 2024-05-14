CREATE TABLE `access_day` (
  `id` int(11) NOT NULL,
  `serial` varchar(12) COLLATE utf8mb4_bin DEFAULT NULL,
  `name` varchar(20) COLLATE utf8mb4_bin DEFAULT NULL,
  `start_time1` varchar(20) COLLATE utf8mb4_bin NOT NULL,
  `end_time1` varchar(20) COLLATE utf8mb4_bin NOT NULL,
  `start_time2` varchar(20) COLLATE utf8mb4_bin NOT NULL,
  `end_time2` varchar(20) COLLATE utf8mb4_bin NOT NULL,
  `start_time3` varchar(20) COLLATE utf8mb4_bin NOT NULL,
  `end_time3` varchar(20) COLLATE utf8mb4_bin NOT NULL,
  `start_time4` varchar(20) COLLATE utf8mb4_bin NOT NULL,
  `end_time4` varchar(20) COLLATE utf8mb4_bin NOT NULL,
  `start_time5` varchar(20) COLLATE utf8mb4_bin NOT NULL,
  `end_time5` varchar(20) COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

CREATE TABLE `access_week` (
  `id` int(11) NOT NULL,
  `serial` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `monday` int(20) NOT NULL,
  `tuesday` int(20) NOT NULL,
  `wednesday` int(20) NOT NULL,
  `thursday` int(20) NOT NULL,
  `friday` int(20) NOT NULL,
  `saturday` int(20) NOT NULL,
  `sunday` int(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

CREATE TABLE `device` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serial_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `deviceid` int(11) NOT NULL DEFAULT '0',
  `language` int(11) NOT NULL DEFAULT '0',
  `volume` int(11) NOT NULL DEFAULT '0',
  `screensaver` int(11) NOT NULL DEFAULT '0',
  `verifymode` int(11) NOT NULL DEFAULT '0',
  `sleep` int(11) NOT NULL DEFAULT '0',
  `userfpnum` int(11) NOT NULL DEFAULT '0',
  `loghint` int(11) NOT NULL DEFAULT '0',
  `reverifytime` int(11) NOT NULL DEFAULT '0',
  `status` int(11) NOT NULL,
  `ping` int(11) NOT NULL DEFAULT '0',
  `mac` varchar(80) DEFAULT NULL,
  `info` varchar(512) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

CREATE TABLE `enrollinfo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `enroll_id` bigint(20) NOT NULL,
  `backupnum` int(11) DEFAULT NULL,
  `imagepath` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `signatures` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

CREATE TABLE `machine_command` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `serial` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `content` mediumtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `status` int(11) NOT NULL DEFAULT '0',
  `send_status` int(11) NOT NULL DEFAULT '0',
  `err_count` int(11) NOT NULL DEFAULT '0',
  `run_time` datetime DEFAULT NULL,
  `gmt_crate` datetime NOT NULL,
  `gmt_modified` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

CREATE TABLE `person` (
  `id` bigint(12) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL,
  `roll_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

CREATE TABLE `records` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `logindex` int(11) DEFAULT '-1',
  `enroll_id` bigint(20) NOT NULL,
  `records_time` datetime NOT NULL,
  `mode` int(11) NOT NULL,
  `intOut` int(11) NOT NULL,
  `event` int(11) NOT NULL,
  `device_serial_num` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `temperature` double DEFAULT NULL,
  `image` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uc_enroll_records` (`enroll_id`,`records_time`,`device_serial_num`)
) ENGINE=InnoDB;