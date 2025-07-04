-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema University
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `University` ;

-- -----------------------------------------------------
-- Schema University
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `University` ;
USE `University` ;

-- -----------------------------------------------------
-- Table `University`.`college`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `University`.`college` ;

CREATE TABLE IF NOT EXISTS `University`.`college` (
  `college_id` INT NOT NULL,
  `college_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`college_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `University`.`department` ;

CREATE TABLE IF NOT EXISTS `University`.`department` (
  `dept_id` VARCHAR(15) NOT NULL,
  `dept_name` VARCHAR(100) NOT NULL,
  `college_id` INT NOT NULL,
  PRIMARY KEY (`dept_id`),
  INDEX `fk_department_college1_idx` (`college_id` ASC) VISIBLE,
  CONSTRAINT `fk_department_college1`
    FOREIGN KEY (`college_id`)
    REFERENCES `University`.`college` (`college_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`course`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `University`.`course` ;

CREATE TABLE IF NOT EXISTS `University`.`course` (
  `course_num` INT NOT NULL,
  `course_title` VARCHAR(100) NOT NULL,
  `credits` INT NOT NULL,
  `dept_id` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`course_num`, `dept_id`),
  INDEX `fk_course_department1_idx` (`dept_id` ASC) VISIBLE,
  CONSTRAINT `fk_course_department1`
    FOREIGN KEY (`dept_id`)
    REFERENCES `University`.`department` (`dept_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`faculty`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `University`.`faculty` ;

CREATE TABLE IF NOT EXISTS `University`.`faculty` (
  `faculty_id` INT NOT NULL,
  `faculty_fname` VARCHAR(50) NOT NULL,
  `faculty_lname` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`faculty_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `University`.`student` ;

CREATE TABLE IF NOT EXISTS `University`.`student` (
  `student_id` INT NOT NULL,
  `fname` VARCHAR(50) NOT NULL,
  `lname` VARCHAR(50) NOT NULL,
  `gender` ENUM('M', 'F') NOT NULL,
  `city` VARCHAR(50) NOT NULL,
  `state` VARCHAR(10) NOT NULL,
  `birthdate` DATE NOT NULL,
  PRIMARY KEY (`student_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`section`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `University`.`section` ;

CREATE TABLE IF NOT EXISTS `University`.`section` (
  `section_id` INT NOT NULL,
  `capacity` INT NOT NULL,
  `year` YEAR NOT NULL,
  `term` ENUM('Fall', 'Spring', 'Summer', 'Winter') NOT NULL,
  `section_num` INT NULL,
  `course_num` INT NOT NULL,
  `course_dept_id` VARCHAR(15) NOT NULL,
  `faculty_id` INT NOT NULL,
  PRIMARY KEY (`section_id`),
  INDEX `fk_section_course1_idx` (`course_num` ASC, `course_dept_id` ASC) VISIBLE,
  INDEX `fk_section_faculty1_idx` (`faculty_id` ASC) VISIBLE,
  CONSTRAINT `fk_section_course1`
    FOREIGN KEY (`course_num` , `course_dept_id`)
    REFERENCES `University`.`course` (`course_num` , `dept_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_section_faculty1`
    FOREIGN KEY (`faculty_id`)
    REFERENCES `University`.`faculty` (`faculty_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `University`.`enrolled`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `University`.`enrolled` ;

CREATE TABLE IF NOT EXISTS `University`.`enrolled` (
  `student_student_id` INT NOT NULL,
  `section_section_id` INT NOT NULL,
  PRIMARY KEY (`student_student_id`, `section_section_id`),
  INDEX `fk_section_has_student_student1_idx` (`student_student_id` ASC) VISIBLE,
  INDEX `fk_enrolled_section1_idx` (`section_section_id` ASC) VISIBLE,
  CONSTRAINT `fk_section_has_student_student1`
    FOREIGN KEY (`student_student_id`)
    REFERENCES `University`.`student` (`student_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_enrolled_section1`
    FOREIGN KEY (`section_section_id`)
    REFERENCES `University`.`section` (`section_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `University`.`college`
-- -----------------------------------------------------
START TRANSACTION;
USE `University`;
INSERT INTO `University`.`college` (`college_id`, `college_name`) VALUES (1, 'College of Physical Science and Engineering');
INSERT INTO `University`.`college` (`college_id`, `college_name`) VALUES (2, 'College of Business and Communication');
INSERT INTO `University`.`college` (`college_id`, `college_name`) VALUES (3, 'College of Language and Letters');

COMMIT;


-- -----------------------------------------------------
-- Data for table `University`.`department`
-- -----------------------------------------------------
START TRANSACTION;
USE `University`;
INSERT INTO `University`.`department` (`dept_id`, `dept_name`, `college_id`) VALUES ('ITM', 'Computer Information Technology', 1);
INSERT INTO `University`.`department` (`dept_id`, `dept_name`, `college_id`) VALUES ('ECON', 'Economics', 2);
INSERT INTO `University`.`department` (`dept_id`, `dept_name`, `college_id`) VALUES ('HUM', 'Humanities and Philosophy', 3);

COMMIT;


-- -----------------------------------------------------
-- Data for table `University`.`course`
-- -----------------------------------------------------
START TRANSACTION;
USE `University`;
INSERT INTO `University`.`course` (`course_num`, `course_title`, `credits`, `dept_id`) VALUES (111, 'Intro to Databases', 3, 'ITM');
INSERT INTO `University`.`course` (`course_num`, `course_title`, `credits`, `dept_id`) VALUES (388, 'Econometrics', 4, 'ECON');
INSERT INTO `University`.`course` (`course_num`, `course_title`, `credits`, `dept_id`) VALUES (150, 'Micro Economics', 3, 'ECON');
INSERT INTO `University`.`course` (`course_num`, `course_title`, `credits`, `dept_id`) VALUES (376, 'Classical Heritage', 2, 'HUM');

COMMIT;


-- -----------------------------------------------------
-- Data for table `University`.`faculty`
-- -----------------------------------------------------
START TRANSACTION;
USE `University`;
INSERT INTO `University`.`faculty` (`faculty_id`, `faculty_fname`, `faculty_lname`) VALUES (1, 'Marty', 'Morring');
INSERT INTO `University`.`faculty` (`faculty_id`, `faculty_fname`, `faculty_lname`) VALUES (2, 'Nate', 'Norris');
INSERT INTO `University`.`faculty` (`faculty_id`, `faculty_fname`, `faculty_lname`) VALUES (3, 'Ben', 'Barium');
INSERT INTO `University`.`faculty` (`faculty_id`, `faculty_fname`, `faculty_lname`) VALUES (4, 'John', 'Jensen');
INSERT INTO `University`.`faculty` (`faculty_id`, `faculty_fname`, `faculty_lname`) VALUES (5, 'Bill', 'Barney');

COMMIT;


-- -----------------------------------------------------
-- Data for table `University`.`student`
-- -----------------------------------------------------
START TRANSACTION;
USE `University`;
INSERT INTO `University`.`student` (`student_id`, `fname`, `lname`, `gender`, `city`, `state`, `birthdate`) VALUES (1, 'Paul', 'Miller', 'M', 'Dallas', 'TX', '1996-02-22');
INSERT INTO `University`.`student` (`student_id`, `fname`, `lname`, `gender`, `city`, `state`, `birthdate`) VALUES (2, 'Katie', 'Smith', 'F', 'Provo', 'OUT', '1995-07-22');
INSERT INTO `University`.`student` (`student_id`, `fname`, `lname`, `gender`, `city`, `state`, `birthdate`) VALUES (3, 'Kelly', 'Jones', 'F', 'Provo', 'OUT', '1998-06-22');
INSERT INTO `University`.`student` (`student_id`, `fname`, `lname`, `gender`, `city`, `state`, `birthdate`) VALUES (4, 'Devon', 'Merrill', 'M', 'Mesa', 'THE', '2000-07-22');
INSERT INTO `University`.`student` (`student_id`, `fname`, `lname`, `gender`, `city`, `state`, `birthdate`) VALUES (5, 'Mandy', 'Murdock', 'F', 'Topeka', 'KS', '1996-11-22');
INSERT INTO `University`.`student` (`student_id`, `fname`, `lname`, `gender`, `city`, `state`, `birthdate`) VALUES (6, 'Alece', 'Adams', 'F', 'Rigby', 'ID', '1997-05-22');
INSERT INTO `University`.`student` (`student_id`, `fname`, `lname`, `gender`, `city`, `state`, `birthdate`) VALUES (7, 'Bryce', 'Carlson', 'M', 'Bozeman', 'MT', '1997-11-22');
INSERT INTO `University`.`student` (`student_id`, `fname`, `lname`, `gender`, `city`, `state`, `birthdate`) VALUES (8, 'Preston', 'Larsen', 'M', 'Decatur', 'TN', '1996-09-22');
INSERT INTO `University`.`student` (`student_id`, `fname`, `lname`, `gender`, `city`, `state`, `birthdate`) VALUES (9, 'Julia', 'Madsen', 'F', 'Rexburg', 'ID', '1998-09-22');
INSERT INTO `University`.`student` (`student_id`, `fname`, `lname`, `gender`, `city`, `state`, `birthdate`) VALUES (10, 'Susan', 'Sorensen', 'F', 'Mesa', 'THE', '1998-08-09');

COMMIT;


-- -----------------------------------------------------
-- Data for table `University`.`section`
-- -----------------------------------------------------
START TRANSACTION;
USE `University`;
INSERT INTO `University`.`section` (`section_id`, `capacity`, `year`, `term`, `section_num`, `course_num`, `course_dept_id`, `faculty_id`) VALUES (1, 30, 2019, 'Fall', 1, 111, 'ITM', 1);
INSERT INTO `University`.`section` (`section_id`, `capacity`, `year`, `term`, `section_num`, `course_num`, `course_dept_id`, `faculty_id`) VALUES (2, 50, 2019, 'Fall', 1, 150, 'ECON', 2);
INSERT INTO `University`.`section` (`section_id`, `capacity`, `year`, `term`, `section_num`, `course_num`, `course_dept_id`, `faculty_id`) VALUES (3, 50, 2019, 'Fall', 2, 150, 'ECON', 2);
INSERT INTO `University`.`section` (`section_id`, `capacity`, `year`, `term`, `section_num`, `course_num`, `course_dept_id`, `faculty_id`) VALUES (4, 35, 2019, 'Fall', 1, 388, 'ECON', 3);
INSERT INTO `University`.`section` (`section_id`, `capacity`, `year`, `term`, `section_num`, `course_num`, `course_dept_id`, `faculty_id`) VALUES (5, 30, 2019, 'Fall', 1, 376, 'HUM', 4);
INSERT INTO `University`.`section` (`section_id`, `capacity`, `year`, `term`, `section_num`, `course_num`, `course_dept_id`, `faculty_id`) VALUES (6, 30, 2018, 'Winter', 2, 111, 'ITM', 1);
INSERT INTO `University`.`section` (`section_id`, `capacity`, `year`, `term`, `section_num`, `course_num`, `course_dept_id`, `faculty_id`) VALUES (7, 35, 2018, 'Winter', 3, 111, 'ITM', 5);
INSERT INTO `University`.`section` (`section_id`, `capacity`, `year`, `term`, `section_num`, `course_num`, `course_dept_id`, `faculty_id`) VALUES (8, 50, 2018, 'Winter', 1, 150, 'ECON', 2);
INSERT INTO `University`.`section` (`section_id`, `capacity`, `year`, `term`, `section_num`, `course_num`, `course_dept_id`, `faculty_id`) VALUES (9, 50, 2018, 'Winter', 2, 150, 'ECON', 2);
INSERT INTO `University`.`section` (`section_id`, `capacity`, `year`, `term`, `section_num`, `course_num`, `course_dept_id`, `faculty_id`) VALUES (10, 30, 2018, 'Winter', 1, 376, 'HUM', 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `University`.`enrolled`
-- -----------------------------------------------------
START TRANSACTION;
USE `University`;
INSERT INTO `University`.`enrolled` (`student_student_id`, `section_section_id`) VALUES (6, 7);
INSERT INTO `University`.`enrolled` (`student_student_id`, `section_section_id`) VALUES (7, 6);
INSERT INTO `University`.`enrolled` (`student_student_id`, `section_section_id`) VALUES (7, 8);
INSERT INTO `University`.`enrolled` (`student_student_id`, `section_section_id`) VALUES (7, 10);
INSERT INTO `University`.`enrolled` (`student_student_id`, `section_section_id`) VALUES (4, 5);
INSERT INTO `University`.`enrolled` (`student_student_id`, `section_section_id`) VALUES (9, 9);
INSERT INTO `University`.`enrolled` (`student_student_id`, `section_section_id`) VALUES (2, 4);
INSERT INTO `University`.`enrolled` (`student_student_id`, `section_section_id`) VALUES (3, 4);
INSERT INTO `University`.`enrolled` (`student_student_id`, `section_section_id`) VALUES (5, 4);
INSERT INTO `University`.`enrolled` (`student_student_id`, `section_section_id`) VALUES (5, 5);
INSERT INTO `University`.`enrolled` (`student_student_id`, `section_section_id`) VALUES (1, 1);
INSERT INTO `University`.`enrolled` (`student_student_id`, `section_section_id`) VALUES (1, 3);
INSERT INTO `University`.`enrolled` (`student_student_id`, `section_section_id`) VALUES (8, 9);
INSERT INTO `University`.`enrolled` (`student_student_id`, `section_section_id`) VALUES (10, 6);

COMMIT;




use University;
-- Query 1: Students born in September (sorted by last name)
SELECT fname, lname , date_format(birthdate,'%M %e, %Y') as "Sept Birthdays"
FROM student
WHERE MONTH(birthdate)=9
ORDER BY lname;

-- Query 2: Student's age in years and days as of Jan 5, 2017
SELECT
  lname,
  fname,
  FLOOR(DATEDIFF('2017-01-05', birthdate) / 365) AS Years,
  MOD(DATEDIFF('2017-01-05', birthdate), 365) AS Days,
  CONCAT(
    FLOOR(DATEDIFF('2017-01-05', birthdate) / 365), ' - Yrs, ',
    MOD(DATEDIFF('2017-01-05', birthdate), 365), ' - Days'
  ) AS `Years and Days`
FROM student
ORDER BY
  Years DESC,
  Days DESC;
    
-- Query 3: Students taught by John Jensen (sort by student last name)
SELECT st.fname Firstname, st.lname Lastname
FROM student st
JOIN enrolled ed ON st.student_id = ed.student_student_id
JOIN section sn ON ed.section_section_id = sn.section_id
JOIN faculty fy ON sn.faculty_id = fy.faculty_id
WHERE fy.faculty_fname = 'John' AND fy.faculty_lname = 'Jensen'
ORDER BY st.lname;

-- Query 4: Instructors Bryce will have in Winter 2018
SELECT fy.faculty_fname Firstname, fy.faculty_lname Lastname
FROM student st
JOIN enrolled ed ON st.student_id = ed.student_student_id
JOIN section sn ON ed.section_section_id = sn.section_id
JOIN faculty fy ON sn.faculty_id = fy.faculty_id
WHERE st.fname = 'Bryce' AND sn.term = 'Winter' AND sn.year = 2018
ORDER BY fy.faculty_lname;

-- Query 5: Students that take Econometrics in Fall 2019
SELECT st.fname Firstname, st.lname Lastname
FROM student st
JOIN enrolled ed ON st.student_id = ed.student_student_id
JOIN section sn ON ed.section_section_id = sn.section_id
JOIN course ce ON ce.course_num = sn.course_num AND sn.course_dept_id = ce.dept_id 
WHERE ce.course_title = 'Econometrics' AND sn.term = 'Fall' AND sn.year = 2019
ORDER BY st.lname;


-- Query 6: All of Bryce Carlson's courses for Winter 2018

SELECT ce.dept_id, ce.course_num, ce.course_title
FROM student st
JOIN enrolled ed ON st.student_id = ed.student_student_id
JOIN section sn ON ed.section_section_id = sn.section_id
JOIN course ce ON ce.course_num = sn.course_num AND sn.course_dept_id = ce.dept_id 
WHERE st.fname = 'Bryce' AND sn.term = 'Winter' AND sn.year = 2018
ORDER BY ce.course_title;

-- Query 7: Number of students enrolled for Fall 2019
SELECT sn.term, sn.year, count(st.student_id) as Enrollment
FROM student st
JOIN enrolled ed ON st.student_id = ed.student_student_id
JOIN section sn ON ed.section_section_id = sn.section_id
JOIN course ce ON ce.course_num = sn.course_num AND sn.course_dept_id = ce.dept_id 
WHERE sn.term = 'Fall' AND sn.year = 2019
ORDER BY ce.course_title;

-- Query 8: Number of courses in each college (sorted by college name)
SELECT ce.college_name, COUNT(DISTINCT c.course_num) AS num_courses
FROM college ce
JOIN department dt ON ce.college_id = dt.college_id
JOIN course c ON dt.dept_id = c.dept_id
GROUP BY ce.college_id
ORDER BY ce.college_name;

-- Query 9: Total teaching capacity per professor for Winter 2018
SELECT fy.faculty_fname, fy.faculty_lname, sum(sn.capacity) AS capacity
FROM faculty fy
JOIN section sn ON fy.faculty_id = sn.faculty_id
WHERE sn.term = 'Winter' AND sn.year = 2018 AND sum(ce.credits)
GROUP BY fy.faculty_id
ORDER BY sn.capacity;

-- Query 10: Total credit load per student for Fall 2019 (only greater than 3)
SELECT st.lname, st.fname, sum(ce.credits) AS 'total_credits'
FROM student st
JOIN enrolled ed ON st.student_id = ed.student_student_id
JOIN section sn ON ed.section_section_id = sn.section_id
JOIN course ce ON ce.course_num = sn.course_num AND sn.course_dept_id = ce.dept_id 
WHERE sn.term = 'Fall' AND sn.year = 2019 
GROUP BY st.student_id
HAVING total_credits > 3
ORDER BY total_credits desc;
