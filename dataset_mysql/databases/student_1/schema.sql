-- Dialect: mysql | Database: student_1 | Table Count: 2

CREATE TABLE `student_1`.`list` (
    `LastName` VARCHAR(50),
    `FirstName` VARCHAR(50),
    `Grade` INTEGER,
    `Classroom` INTEGER,
    PRIMARY KEY (`LastName`, `FirstName`)
);

CREATE TABLE `student_1`.`teachers` (
    `LastName` VARCHAR(50),
    `FirstName` VARCHAR(50),
    `Classroom` INTEGER,
    PRIMARY KEY (`LastName`, `FirstName`)
);
