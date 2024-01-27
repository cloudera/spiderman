CREATE DATABASE IF NOT EXISTS `chinook_1`;

drop table if exists `chinook_1`.`Artist`;
CREATE TABLE IF NOT EXISTS `chinook_1`.`Artist` (
    `ArtistId` INT NOT NULL,
    `Name` STRING,
    PRIMARY KEY (`ArtistId`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/chinook_1/data/Artist.csv' INTO TABLE `chinook_1`.`Artist`;


drop table if exists `chinook_1`.`Album`;
CREATE TABLE IF NOT EXISTS `chinook_1`.`Album` (
    `AlbumId` INT NOT NULL,
    `Title` STRING NOT NULL,
    `ArtistId` INT NOT NULL,
    PRIMARY KEY (`AlbumId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`ArtistId`) REFERENCES `chinook_1`.`Artist` (`ArtistId`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/chinook_1/data/Album.csv' INTO TABLE `chinook_1`.`Album`;


drop table if exists `chinook_1`.`Employee`;
CREATE TABLE IF NOT EXISTS `chinook_1`.`Employee` (
    `EmployeeId` INT NOT NULL,
    `LastName` STRING NOT NULL,
    `FirstName` STRING NOT NULL,
    `Title` STRING,
    `ReportsTo` INT,
    `BirthDate` TIMESTAMP,
    `HireDate` TIMESTAMP,
    `Address` STRING,
    `City` STRING,
    `State` STRING,
    `Country` STRING,
    `PostalCode` STRING,
    `Phone` STRING,
    `Fax` STRING,
    `Email` STRING,
    PRIMARY KEY (`EmployeeId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`ReportsTo`) REFERENCES `chinook_1`.`Employee` (`EmployeeId`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/chinook_1/data/Employee.csv' INTO TABLE `chinook_1`.`Employee`;


drop table if exists `chinook_1`.`Customer`;
CREATE TABLE IF NOT EXISTS `chinook_1`.`Customer` (
    `CustomerId` INT NOT NULL,
    `FirstName` STRING NOT NULL,
    `LastName` STRING NOT NULL,
    `Company` STRING,
    `Address` STRING,
    `City` STRING,
    `State` STRING,
    `Country` STRING,
    `PostalCode` STRING,
    `Phone` STRING,
    `Fax` STRING,
    `Email` STRING NOT NULL,
    `SupportRepId` INT,
    PRIMARY KEY (`CustomerId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`SupportRepId`) REFERENCES `chinook_1`.`Employee` (`EmployeeId`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/chinook_1/data/Customer.csv' INTO TABLE `chinook_1`.`Customer`;


drop table if exists `chinook_1`.`Genre`;
CREATE TABLE IF NOT EXISTS `chinook_1`.`Genre` (
    `GenreId` INT NOT NULL,
    `Name` STRING,
    PRIMARY KEY (`GenreId`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/chinook_1/data/Genre.csv' INTO TABLE `chinook_1`.`Genre`;


drop table if exists `chinook_1`.`Invoice`;
CREATE TABLE IF NOT EXISTS `chinook_1`.`Invoice` (
    `InvoiceId` INT NOT NULL,
    `CustomerId` INT NOT NULL,
    `InvoiceDate` TIMESTAMP NOT NULL,
    `BillingAddress` STRING,
    `BillingCity` STRING,
    `BillingState` STRING,
    `BillingCountry` STRING,
    `BillingPostalCode` STRING,
    `Total` DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (`InvoiceId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`CustomerId`) REFERENCES `chinook_1`.`Customer` (`CustomerId`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/chinook_1/data/Invoice.csv' INTO TABLE `chinook_1`.`Invoice`;


drop table if exists `chinook_1`.`MediaType`;
CREATE TABLE IF NOT EXISTS `chinook_1`.`MediaType` (
    `MediaTypeId` INT NOT NULL,
    `Name` STRING,
    PRIMARY KEY (`MediaTypeId`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/chinook_1/data/MediaType.csv' INTO TABLE `chinook_1`.`MediaType`;


drop table if exists `chinook_1`.`Track`;
CREATE TABLE IF NOT EXISTS `chinook_1`.`Track` (
    `TrackId` INT NOT NULL,
    `Name` STRING NOT NULL,
    `AlbumId` INT,
    `MediaTypeId` INT NOT NULL,
    `GenreId` INT,
    `Composer` STRING,
    `Milliseconds` INT NOT NULL,
    `Bytes` INT,
    `UnitPrice` DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (`TrackId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`MediaTypeId`) REFERENCES `chinook_1`.`MediaType` (`MediaTypeId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`GenreId`) REFERENCES `chinook_1`.`Genre` (`GenreId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`AlbumId`) REFERENCES `chinook_1`.`Album` (`AlbumId`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/chinook_1/data/Track.csv' INTO TABLE `chinook_1`.`Track`;


drop table if exists `chinook_1`.`InvoiceLine`;
CREATE TABLE IF NOT EXISTS `chinook_1`.`InvoiceLine` (
    `InvoiceLineId` INT NOT NULL,
    `InvoiceId` INT NOT NULL,
    `TrackId` INT NOT NULL,
    `UnitPrice` DECIMAL(10,2) NOT NULL,
    `Quantity` INT NOT NULL,
    PRIMARY KEY (`InvoiceLineId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`TrackId`) REFERENCES `chinook_1`.`Track` (`TrackId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`InvoiceId`) REFERENCES `chinook_1`.`Invoice` (`InvoiceId`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/chinook_1/data/InvoiceLine.csv' INTO TABLE `chinook_1`.`InvoiceLine`;


drop table if exists `chinook_1`.`Playlist`;
CREATE TABLE IF NOT EXISTS `chinook_1`.`Playlist` (
    `PlaylistId` INT NOT NULL,
    `Name` STRING,
    PRIMARY KEY (`PlaylistId`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/chinook_1/data/Playlist.csv' INTO TABLE `chinook_1`.`Playlist`;


drop table if exists `chinook_1`.`PlaylistTrack`;
CREATE TABLE IF NOT EXISTS `chinook_1`.`PlaylistTrack` (
    `PlaylistId` INT NOT NULL,
    `TrackId` INT NOT NULL,
    PRIMARY KEY (`PlaylistId`, `TrackId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`TrackId`) REFERENCES `chinook_1`.`Track` (`TrackId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`PlaylistId`) REFERENCES `chinook_1`.`Playlist` (`PlaylistId`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/chinook_1/data/PlaylistTrack.csv' INTO TABLE `chinook_1`.`PlaylistTrack`;

