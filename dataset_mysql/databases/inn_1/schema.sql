-- Dialect: mysql | Database: inn_1 | Table Count: 2

CREATE TABLE `inn_1`.`Rooms` (
    `RoomId` VARCHAR(50),
    `roomName` TEXT,
    `beds` INTEGER,
    `bedType` TEXT,
    `maxOccupancy` INTEGER,
    `basePrice` INTEGER,
    `decor` TEXT,
    PRIMARY KEY (`RoomId`)
);

CREATE TABLE `inn_1`.`Reservations` (
    `Code` INTEGER,
    `Room` VARCHAR(50),
    `CheckIn` TEXT,
    `CheckOut` TEXT,
    `Rate` REAL,
    `LastName` TEXT,
    `FirstName` TEXT,
    `Adults` INTEGER,
    `Kids` INTEGER,
    PRIMARY KEY (`Code`),
    FOREIGN KEY (`Room`) REFERENCES `inn_1`.`Rooms` (`RoomId`)
);
