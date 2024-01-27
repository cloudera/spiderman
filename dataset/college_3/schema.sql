CREATE DATABASE IF NOT EXISTS `college_3`;

drop table if exists `college_3`.`Student`;
CREATE TABLE IF NOT EXISTS `college_3`.`Student` (
    `StuID` INT,
    `LName` STRING,
    `Fname` STRING,
    `Age` INT,
    `Sex` STRING,
    `Major` INT,
    `Advisor` INT,
    `city_code` STRING,
    PRIMARY KEY (`StuID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_3/data/Student.csv' INTO TABLE `college_3`.`Student`;


drop table if exists `college_3`.`Faculty`;
CREATE TABLE IF NOT EXISTS `college_3`.`Faculty` (
    `FacID` INT,
    `Lname` STRING,
    `Fname` STRING,
    `Rank` STRING,
    `Sex` STRING,
    `Phone` INT,
    `Room` STRING,
    `Building` STRING,
    PRIMARY KEY (`FacID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_3/data/Faculty.csv' INTO TABLE `college_3`.`Faculty`;


drop table if exists `college_3`.`Department`;
CREATE TABLE IF NOT EXISTS `college_3`.`Department` (
    `DNO` INT,
    `Division` STRING,
    `DName` STRING,
    `Room` STRING,
    `Building` STRING,
    `DPhone` INT,
    PRIMARY KEY (`DNO`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_3/data/Department.csv' INTO TABLE `college_3`.`Department`;


drop table if exists `college_3`.`Member_of`;
CREATE TABLE IF NOT EXISTS `college_3`.`Member_of` (
    `FacID` INT,
    `DNO` INT,
    `Appt_Type` STRING,
    FOREIGN KEY (`DNO`) REFERENCES `college_3`.`Department` (`DNO`) DISABLE NOVALIDATE,
    FOREIGN KEY (`FacID`) REFERENCES `college_3`.`Faculty` (`FacID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_3/data/Member_of.csv' INTO TABLE `college_3`.`Member_of`;


drop table if exists `college_3`.`Course`;
CREATE TABLE IF NOT EXISTS `college_3`.`Course` (
    `CID` STRING,
    `CName` STRING,
    `Credits` INT,
    `Instructor` INT,
    `Days` STRING,
    `Hours` STRING,
    `DNO` INT,
    PRIMARY KEY (`CID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`DNO`) REFERENCES `college_3`.`Department` (`DNO`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Instructor`) REFERENCES `college_3`.`Faculty` (`FacID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_3/data/Course.csv' INTO TABLE `college_3`.`Course`;


drop table if exists `college_3`.`Minor_in`;
CREATE TABLE IF NOT EXISTS `college_3`.`Minor_in` (
    `StuID` INT,
    `DNO` INT,
    FOREIGN KEY (`DNO`) REFERENCES `college_3`.`Department` (`DNO`) DISABLE NOVALIDATE,
    FOREIGN KEY (`StuID`) REFERENCES `college_3`.`Student` (`StuID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_3/data/Minor_in.csv' INTO TABLE `college_3`.`Minor_in`;


drop table if exists `college_3`.`Gradeconversion`;
CREATE TABLE IF NOT EXISTS `college_3`.`Gradeconversion` (
    `lettergrade` STRING,
    `gradepoint` DECIMAL,
    PRIMARY KEY (`lettergrade`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_3/data/Gradeconversion.csv' INTO TABLE `college_3`.`Gradeconversion`;


drop table if exists `college_3`.`Enrolled_in`;
CREATE TABLE IF NOT EXISTS `college_3`.`Enrolled_in` (
    `StuID` INT,
    `CID` STRING,
    `Grade` STRING,
    FOREIGN KEY (`Grade`) REFERENCES `college_3`.`Gradeconversion` (`lettergrade`) DISABLE NOVALIDATE,
    FOREIGN KEY (`CID`) REFERENCES `college_3`.`Course` (`CID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`StuID`) REFERENCES `college_3`.`Student` (`StuID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_3/data/Enrolled_in.csv' INTO TABLE `college_3`.`Enrolled_in`;

