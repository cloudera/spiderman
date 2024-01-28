CREATE DATABASE IF NOT EXISTS `inn_1`;

drop table if exists `inn_1`.`Rooms`;
CREATE TABLE IF NOT EXISTS `inn_1`.`Rooms` (
    `RoomId` STRING,
    `roomName` STRING,
    `beds` INT,
    `bedType` STRING,
    `maxOccupancy` INT,
    `basePrice` INT,
    `decor` STRING,
    PRIMARY KEY (`RoomId`) DISABLE NOVALIDATE
);

drop table if exists `inn_1`.`Reservations`;
CREATE TABLE IF NOT EXISTS `inn_1`.`Reservations` (
    `Code` INT,
    `Room` STRING,
    `CheckIn` STRING,
    `CheckOut` STRING,
    `Rate` DOUBLE,
    `LastName` STRING,
    `FirstName` STRING,
    `Adults` INT,
    `Kids` INT,
    PRIMARY KEY (`Code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Room`) REFERENCES `inn_1`.`Rooms` (`RoomId`) DISABLE NOVALIDATE
);
