-- Dialect: mysql | Database: performance_attendance | Table Count: 3

CREATE TABLE `performance_attendance`.`member` (
    `Member_ID` INT,
    `Name` TEXT,
    `Nationality` TEXT,
    `Role` TEXT,
    PRIMARY KEY (`Member_ID`)
);

CREATE TABLE `performance_attendance`.`performance` (
    `Performance_ID` INT,
    `Date` TEXT,
    `Host` TEXT,
    `Location` TEXT,
    `Attendance` INT,
    PRIMARY KEY (`Performance_ID`)
);

CREATE TABLE `performance_attendance`.`member_attendance` (
    `Member_ID` INT,
    `Performance_ID` INT,
    `Num_of_Pieces` INT,
    PRIMARY KEY (`Member_ID`, `Performance_ID`),
    FOREIGN KEY (`Performance_ID`) REFERENCES `performance_attendance`.`performance` (`Performance_ID`),
    FOREIGN KEY (`Member_ID`) REFERENCES `performance_attendance`.`member` (`Member_ID`)
);
