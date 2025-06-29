-- Dialect: mysql | Database: course_teach | Table Count: 3

CREATE TABLE `course_teach`.`course` (
    `Course_ID` INT,
    `Staring_Date` TEXT,
    `Course` TEXT,
    PRIMARY KEY (`Course_ID`)
);

CREATE TABLE `course_teach`.`teacher` (
    `Teacher_ID` INT,
    `Name` TEXT,
    `Age` TEXT,
    `Hometown` TEXT,
    PRIMARY KEY (`Teacher_ID`)
);

CREATE TABLE `course_teach`.`course_arrange` (
    `Course_ID` INT,
    `Teacher_ID` INT,
    `Grade` INT,
    PRIMARY KEY (`Course_ID`, `Teacher_ID`, `Grade`),
    FOREIGN KEY (`Teacher_ID`) REFERENCES `course_teach`.`teacher` (`Teacher_ID`),
    FOREIGN KEY (`Course_ID`) REFERENCES `course_teach`.`course` (`Course_ID`)
);
