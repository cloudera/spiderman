-- Dialect: MySQL | Database: chinook_1 | Table Count: 11

CREATE DATABASE IF NOT EXISTS `chinook_1`;

DROP TABLE IF EXISTS `chinook_1`.`Artist`;
CREATE TABLE `chinook_1`.`Artist` (
    `ArtistId` INTEGER NOT NULL,
    `Name` VARCHAR(120) DEFAULT NULL,
    PRIMARY KEY (`ArtistId`)
);

DROP TABLE IF EXISTS `chinook_1`.`Album`;
CREATE TABLE `chinook_1`.`Album` (
    `AlbumId` INTEGER NOT NULL,
    `Title` VARCHAR(160) NOT NULL,
    `ArtistId` INTEGER NOT NULL,
    PRIMARY KEY (`AlbumId`),
    FOREIGN KEY (`ArtistId`) REFERENCES `chinook_1`.`Artist` (`ArtistId`),
    INDEX idx_ArtistId (`ArtistId`)
);

DROP TABLE IF EXISTS `chinook_1`.`Employee`;
CREATE TABLE `chinook_1`.`Employee` (
    `EmployeeId` INTEGER NOT NULL,
    `LastName` VARCHAR(20) NOT NULL,
    `FirstName` VARCHAR(20) NOT NULL,
    `Title` VARCHAR(30) DEFAULT NULL,
    `ReportsTo` INTEGER DEFAULT NULL,
    `BirthDate` DATETIME DEFAULT NULL,
    `HireDate` DATETIME DEFAULT NULL,
    `Address` VARCHAR(70) DEFAULT NULL,
    `City` VARCHAR(40) DEFAULT NULL,
    `State` VARCHAR(40) DEFAULT NULL,
    `Country` VARCHAR(40) DEFAULT NULL,
    `PostalCode` VARCHAR(10) DEFAULT NULL,
    `Phone` VARCHAR(24) DEFAULT NULL,
    `Fax` VARCHAR(24) DEFAULT NULL,
    `Email` VARCHAR(60) DEFAULT NULL,
    PRIMARY KEY (`EmployeeId`),
    FOREIGN KEY (`ReportsTo`) REFERENCES `chinook_1`.`Employee` (`EmployeeId`),
    INDEX idx_ReportsTo (`ReportsTo`)
);

DROP TABLE IF EXISTS `chinook_1`.`Customer`;
CREATE TABLE `chinook_1`.`Customer` (
    `CustomerId` INTEGER NOT NULL,
    `FirstName` VARCHAR(40) NOT NULL,
    `LastName` VARCHAR(20) NOT NULL,
    `Company` VARCHAR(80) DEFAULT NULL,
    `Address` VARCHAR(70) DEFAULT NULL,
    `City` VARCHAR(40) DEFAULT NULL,
    `State` VARCHAR(40) DEFAULT NULL,
    `Country` VARCHAR(40) DEFAULT NULL,
    `PostalCode` VARCHAR(10) DEFAULT NULL,
    `Phone` VARCHAR(24) DEFAULT NULL,
    `Fax` VARCHAR(24) DEFAULT NULL,
    `Email` VARCHAR(60) NOT NULL,
    `SupportRepId` INTEGER DEFAULT NULL,
    PRIMARY KEY (`CustomerId`),
    FOREIGN KEY (`SupportRepId`) REFERENCES `chinook_1`.`Employee` (`EmployeeId`),
    INDEX idx_SupportRepId (`SupportRepId`)
);

DROP TABLE IF EXISTS `chinook_1`.`Genre`;
CREATE TABLE `chinook_1`.`Genre` (
    `GenreId` INTEGER NOT NULL,
    `Name` VARCHAR(120) DEFAULT NULL,
    PRIMARY KEY (`GenreId`)
);

DROP TABLE IF EXISTS `chinook_1`.`Invoice`;
CREATE TABLE `chinook_1`.`Invoice` (
    `InvoiceId` INTEGER NOT NULL,
    `CustomerId` INTEGER NOT NULL,
    `InvoiceDate` DATETIME NOT NULL,
    `BillingAddress` VARCHAR(70) DEFAULT NULL,
    `BillingCity` VARCHAR(40) DEFAULT NULL,
    `BillingState` VARCHAR(40) DEFAULT NULL,
    `BillingCountry` VARCHAR(40) DEFAULT NULL,
    `BillingPostalCode` VARCHAR(10) DEFAULT NULL,
    `Total` DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (`InvoiceId`),
    FOREIGN KEY (`CustomerId`) REFERENCES `chinook_1`.`Customer` (`CustomerId`),
    INDEX idx_CustomerId (`CustomerId`)
);

DROP TABLE IF EXISTS `chinook_1`.`MediaType`;
CREATE TABLE `chinook_1`.`MediaType` (
    `MediaTypeId` INTEGER NOT NULL,
    `Name` VARCHAR(120) DEFAULT NULL,
    PRIMARY KEY (`MediaTypeId`)
);

DROP TABLE IF EXISTS `chinook_1`.`Track`;
CREATE TABLE `chinook_1`.`Track` (
    `TrackId` INTEGER NOT NULL,
    `Name` VARCHAR(200) NOT NULL,
    `AlbumId` INTEGER DEFAULT NULL,
    `MediaTypeId` INTEGER NOT NULL,
    `GenreId` INTEGER DEFAULT NULL,
    `Composer` VARCHAR(220) DEFAULT NULL,
    `Milliseconds` INTEGER NOT NULL,
    `Bytes` INTEGER DEFAULT NULL,
    `UnitPrice` DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (`TrackId`),
    FOREIGN KEY (`MediaTypeId`) REFERENCES `chinook_1`.`MediaType` (`MediaTypeId`),
    FOREIGN KEY (`GenreId`) REFERENCES `chinook_1`.`Genre` (`GenreId`),
    FOREIGN KEY (`AlbumId`) REFERENCES `chinook_1`.`Album` (`AlbumId`),
    INDEX idx_AlbumId (`AlbumId`),
    INDEX idx_MediaTypeId (`MediaTypeId`),
    INDEX idx_GenreId (`GenreId`)
);

DROP TABLE IF EXISTS `chinook_1`.`InvoiceLine`;
CREATE TABLE `chinook_1`.`InvoiceLine` (
    `InvoiceLineId` INTEGER NOT NULL,
    `InvoiceId` INTEGER NOT NULL,
    `TrackId` INTEGER NOT NULL,
    `UnitPrice` DECIMAL(10,2) NOT NULL,
    `Quantity` INTEGER NOT NULL,
    PRIMARY KEY (`InvoiceLineId`),
    FOREIGN KEY (`TrackId`) REFERENCES `chinook_1`.`Track` (`TrackId`),
    FOREIGN KEY (`InvoiceId`) REFERENCES `chinook_1`.`Invoice` (`InvoiceId`),
    INDEX idx_InvoiceId (`InvoiceId`),
    INDEX idx_TrackId (`TrackId`)
);

DROP TABLE IF EXISTS `chinook_1`.`Playlist`;
CREATE TABLE `chinook_1`.`Playlist` (
    `PlaylistId` INTEGER NOT NULL,
    `Name` VARCHAR(120) DEFAULT NULL,
    PRIMARY KEY (`PlaylistId`)
);

DROP TABLE IF EXISTS `chinook_1`.`PlaylistTrack`;
CREATE TABLE `chinook_1`.`PlaylistTrack` (
    `PlaylistId` INTEGER NOT NULL,
    `TrackId` INTEGER NOT NULL,
    PRIMARY KEY (`PlaylistId`, `TrackId`),
    FOREIGN KEY (`TrackId`) REFERENCES `chinook_1`.`Track` (`TrackId`),
    FOREIGN KEY (`PlaylistId`) REFERENCES `chinook_1`.`Playlist` (`PlaylistId`),
    INDEX idx_TrackId (`TrackId`)
);
