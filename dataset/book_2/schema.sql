drop table if exists `book_2`.`book`;
CREATE TABLE IF NOT EXISTS `book_2`.`book` (
    `Book_ID` INT,
    `Title` STRING,
    `Issues` REAL,
    `Writer` STRING,
    PRIMARY KEY (`Book_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/book_2/data/book.csv' INTO TABLE `book_2`.`book`;


drop table if exists `book_2`.`publication`;
CREATE TABLE IF NOT EXISTS `book_2`.`publication` (
    `Publication_ID` INT,
    `Book_ID` INT,
    `Publisher` STRING,
    `Publication_Date` STRING,
    `Price` REAL,
    PRIMARY KEY (`Publication_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Book_ID`) REFERENCES `book_2`.`book` (`Book_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/book_2/data/publication.csv' INTO TABLE `book_2`.`publication`;

