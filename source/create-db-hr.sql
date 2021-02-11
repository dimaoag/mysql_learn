DROP DATABASE IF EXISTS `sql_hr`;
CREATE DATABASE `sql_hr`;
USE `sql_hr`;

CREATE TABLE `regions` (
  `region_id` int(11) NOT NULL,
  `region_name` varchar(50) NOT NULL,
  PRIMARY KEY (`region_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `regions` VALUES (1,'Europe');
INSERT INTO `regions` VALUES (2,'Americas');
INSERT INTO `regions` VALUES (3,'Asia');
INSERT INTO `regions` VALUES (4,'Middle East and Africa');

DROP TABLE IF EXISTS `countries`;
CREATE TABLE `countries` (
  `country_id` varchar(2) NOT NULL,
  `country_name` varchar(50) NULL,
  `region_id` int(11) NULL,
  PRIMARY KEY (`country_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `countries` VALUES ('AR','Argentina', 2);
INSERT INTO `countries` VALUES ('AU','Australia', 3);
INSERT INTO `countries` VALUES ('BE','Belgium', 1);
INSERT INTO `countries` VALUES ('BR','Brazil', 2);
INSERT INTO `countries` VALUES ('CA','Canada', 2);
INSERT INTO `countries` VALUES ('CH','Switzerland', 1);
INSERT INTO `countries` VALUES ('CN','China', 3);
INSERT INTO `countries` VALUES ('DE','Germany', 1);
INSERT INTO `countries` VALUES ('DK','Denmark', 1);
INSERT INTO `countries` VALUES ('EG','Egypt', 4);
INSERT INTO `countries` VALUES ('FR','France', 1);
INSERT INTO `countries` VALUES ('IL','Israel', 4);
INSERT INTO `countries` VALUES ('IN','India', 3);
INSERT INTO `countries` VALUES ('IT','Italy', 1);
INSERT INTO `countries` VALUES ('JP','Japan', 3);
INSERT INTO `countries` VALUES ('KU','Kuwain', 4);
INSERT INTO `countries` VALUES ('MY','Malaysia', 3);
INSERT INTO `countries` VALUES ('MX','Mexico', 2);
INSERT INTO `countries` VALUES ('NG','Nigeria', 4);
INSERT INTO `countries` VALUES ('NL','Netherlands', 1);
INSERT INTO `countries` VALUES ('SG','Singapore', 3);
INSERT INTO `countries` VALUES ('UK','United Kingdom', 1);
INSERT INTO `countries` VALUES ('US','United States of America', 2);
INSERT INTO `countries` VALUES ('ZM','Zambia', 4);
INSERT INTO `countries` VALUES ('ZI','Zimbabwe', 4);


CREATE TABLE `locations` (
  `location_id` int(11) NOT NULL,
  `street_address` varchar(50) NOT NULL,
  `postal_code` varchar(50) NOT NULL,
  `city` varchar(50) NOT NULL,
  `state_province` varchar(50) NULL,
  `country_id` varchar (2) NOT NULL,
  PRIMARY KEY (`location_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `locations` VALUES (1000,'1297 Via Cola di Rie', '00989', 'Roma', null, 'IT');
INSERT INTO `locations` VALUES (1100,'93091 Cale della Testa', '10934', 'Venice', null, 'IT');
INSERT INTO `locations` VALUES (1200,'2017 Shinguku ku', '1689', 'Tokyo', 'Tokyo', 'JP');
INSERT INTO `locations` VALUES (1300,'9450 Kamia cho', '6823', 'Hiroshima', null, 'JP');
INSERT INTO `locations` VALUES (1400,'2014 Jaberwosky', '26192', 'Southlake', 'Texas', 'US');
INSERT INTO `locations` VALUES (1500,'2011 Interiors', '99236', 'South San Francisco', 'California', 'US');
INSERT INTO `locations` VALUES (1600,'2007 Zaqora', '50090', 'South Brunswick', 'New Jersey', 'US');
INSERT INTO `locations` VALUES (1700,'2004 Charade', '98199', 'Seattle', 'Washington', 'US');
INSERT INTO `locations` VALUES (1800,'147 Spadina ave', 'M5V 2L7', 'Toronto', 'Ontario', 'CA');
INSERT INTO `locations` VALUES (1900,'6092 Boxwood', 'YSM 9T2', 'Whitehorse', 'Yukon', 'CA');
INSERT INTO `locations` VALUES (2000,'3434 Some one', '32233', 'Jojo', null, 'ZI');


CREATE TABLE `jobs` (
  `job_id` varchar(50) NOT NULL,
  `job_title` varchar(50) NOT NULL,
  `min_salary` int(11) NOT NULL,
  `max_salary` int(11) NOT NULL,
  PRIMARY KEY (`job_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `jobs` VALUES ('AD PRES','President',20080,40000);
INSERT INTO `jobs` VALUES ('AD VP','Administration Vice President',15000,30000);
INSERT INTO `jobs` VALUES ('AD ASST','Administration Assistant',3000,6000);
INSERT INTO `jobs` VALUES ('FI MGR','Finance Manager',8200,16000);
INSERT INTO `jobs` VALUES ('FI ACCOUNT','Accountant',4200,9000);
INSERT INTO `jobs` VALUES ('AC MGR','Accounting Manager',8200,16000);
INSERT INTO `jobs` VALUES ('AC ACCOUNT','Public Accountant',4200,9000);
INSERT INTO `jobs` VALUES ('SA MAN','Sales Manager',10000,20080);
INSERT INTO `jobs` VALUES ('SA REP','Sales Representative',6000,12008);
INSERT INTO `jobs` VALUES ('PU MAN','Purchasing Manager',8000,15000);
INSERT INTO `jobs` VALUES ('PU CLERC','Purchasing Clerk',2500,5500);


CREATE TABLE `job_history` (
  `employee_id` int(11) NOT NULL,
  `start_date` date NULL,
  `end_date` date NULL,
  `job_id` varchar(50) NOT NULL,
  `department_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `job_history` VALUES (100,'2001-01-13','2006-07-24','SA REP',60);
INSERT INTO `job_history` VALUES (100,'1997-09-21','2001-10-27','AC ACCOUNT',110);
INSERT INTO `job_history` VALUES (101,'2001-10-28','2005-03-15','AC MGR',110);
INSERT INTO `job_history` VALUES (101,'2004-02-17','2007-12-19','PU MAN',20);
INSERT INTO `job_history` VALUES (102,'2006-03-24','2007-12-31','PU CLERC',50);
INSERT INTO `job_history` VALUES (102,'2007-01-01','2007-12-31','PU CLERC',50);
INSERT INTO `job_history` VALUES (103,'1995-09-17','2001-06-17','AD ASST',90);
INSERT INTO `job_history` VALUES (103,'2006-03-24','2006-12-31','SA REP',80);
INSERT INTO `job_history` VALUES (104,'2007-01-01','2007-12-31','SA MAN',80);
INSERT INTO `job_history` VALUES (105,'2002-07-01','2006-12-31','AC ACCOUNT',90);



CREATE TABLE `departments` (
  `department_id` int(11) NOT NULL,
  `department_name` varchar(50) NOT NULL,
  `manager_id` int(11) DEFAULT NULL,
  `location_id` int(11) NOT NULL,
  PRIMARY KEY (`department_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `departments` VALUES (10,'Administration',100,1700);
INSERT INTO `departments` VALUES (20,'Marketing',101,1200);
INSERT INTO `departments` VALUES (30,'Purchasing',102,1400);
INSERT INTO `departments` VALUES (40,'Human Resources',103,1700);
INSERT INTO `departments` VALUES (50,'Shipping',104,1800);
INSERT INTO `departments` VALUES (60,'IT',105,1900);
INSERT INTO `departments` VALUES (70,'Public Relations',106,1200);
INSERT INTO `departments` VALUES (80,'Sales',107,1500);
INSERT INTO `departments` VALUES (90,'Executive',108,1700);
INSERT INTO `departments` VALUES (100,'Finance',109,1700);
INSERT INTO `departments` VALUES (110,'Accounting',109,1700);
INSERT INTO `departments` VALUES (120,'IT Support',null,1700);


DROP TABLE IF EXISTS `employees`;
CREATE TABLE `employees` (
  `employee_id` int(11) NOT NULL,
  `first_name` varchar(50) NULL,
  `last_name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `phone_number` int(11) NOT NULL,
  `hire_date` date NULL,
  `job_id` varchar(50) NOT NULL,
  `salary` int(11) NULL,
  `commission_pct` int(11) NULL,
  `manager_id` int(11) DEFAULT NULL,
  `department_id` int(11) NULL,
  PRIMARY KEY (`employee_id`),
  KEY `fk_employees_department_idx` (`department_id`),
  KEY `fk_employees_employees_idx` (`manager_id`),
  CONSTRAINT `fk_employees_managers` FOREIGN KEY (`manager_id`) REFERENCES `employees` (`employee_id`),
  CONSTRAINT `fk_employees_departments` FOREIGN KEY (`department_id`) REFERENCES `departments` (`department_id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
INSERT INTO `employees` VALUES (100,'Yovonnda','Magrannell','Executive Secretary',63996,'2003-03-17','AD PRES',24000,null,null,90);
INSERT INTO `employees` VALUES (101,'D''arcy','Nortunen','Account Executive',62871,'2005-09-21','AD VP',17000,null,100,90);
INSERT INTO `employees` VALUES (102,'Sayer','Matterson','Statistician III',98926,'2001-01-13','AD VP',17000,null,100,90);
INSERT INTO `employees` VALUES (103,'Mindy','Crissil','Staff Scientist',94860,'2006-01-03','SA REP',9000,null,102,60);
INSERT INTO `employees` VALUES (104,'Keriann','Alloisi','VP Marketing',110150,'2007-05-21','SA REP',6000,null,103,60);
INSERT INTO `employees` VALUES (105,'Alaster','Scutchin','Assistant Professor',32179,'2005-06-25','SA REP',4800,null,103,60);
INSERT INTO `employees` VALUES (106,'North','de Clerc','VP Product Management',114257,'2006-02-05','SA REP',4800,null,103,60);
INSERT INTO `employees` VALUES (107,'Elladine','Rising','Social Worker',96767,'2007-02-07','SA REP',4200,null,103,60);
INSERT INTO `employees` VALUES (108,'Nisse','Voysey','Financial Advisor',52832,'2002-08-17','FI MGR',12008,null,101,100);
INSERT INTO `employees` VALUES (109,'Guthrey','Iacopetti','Office Assistant I',117690,'2002-08-16','FI ACCOUNT',9000,null,108,100);
INSERT INTO `employees` VALUES (110,'Msfuthrey','UUIacopetti','OKjfOffice Assistant I',3117690,'2004-08-16','FI ACCOUNT',9000,null,108,null);



