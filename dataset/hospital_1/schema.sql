CREATE DATABASE IF NOT EXISTS `hospital_1`;

drop table if exists `hospital_1`.`Physician`;
CREATE TABLE IF NOT EXISTS `hospital_1`.`Physician` (
    `EmployeeID` INT NOT NULL,
    `Name` STRING NOT NULL,
    `Position` STRING NOT NULL,
    `SSN` INT NOT NULL,
    PRIMARY KEY (`EmployeeID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/hospital_1/data/Physician.csv' INTO TABLE `hospital_1`.`Physician`;


drop table if exists `hospital_1`.`Department`;
CREATE TABLE IF NOT EXISTS `hospital_1`.`Department` (
    `DepartmentID` INT NOT NULL,
    `Name` STRING NOT NULL,
    `Head` INT NOT NULL,
    PRIMARY KEY (`DepartmentID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Head`) REFERENCES `hospital_1`.`Physician` (`EmployeeID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/hospital_1/data/Department.csv' INTO TABLE `hospital_1`.`Department`;


drop table if exists `hospital_1`.`Affiliated_With`;
CREATE TABLE IF NOT EXISTS `hospital_1`.`Affiliated_With` (
    `Physician` INT NOT NULL,
    `Department` INT NOT NULL,
    `PrimaryAffiliation` BOOLEAN NOT NULL,
    PRIMARY KEY (`Physician`, `Department`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Department`) REFERENCES `hospital_1`.`Department` (`DepartmentID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Physician`) REFERENCES `hospital_1`.`Physician` (`EmployeeID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/hospital_1/data/Affiliated_With.csv' INTO TABLE `hospital_1`.`Affiliated_With`;


drop table if exists `hospital_1`.`Procedures`;
CREATE TABLE IF NOT EXISTS `hospital_1`.`Procedures` (
    `Code` INT NOT NULL,
    `Name` STRING NOT NULL,
    `Cost` REAL NOT NULL,
    PRIMARY KEY (`Code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/hospital_1/data/Procedures.csv' INTO TABLE `hospital_1`.`Procedures`;


drop table if exists `hospital_1`.`Trained_In`;
CREATE TABLE IF NOT EXISTS `hospital_1`.`Trained_In` (
    `Physician` INT NOT NULL,
    `Treatment` INT NOT NULL,
    `CertificationDate` TIMESTAMP NOT NULL,
    `CertificationExpires` TIMESTAMP NOT NULL,
    PRIMARY KEY (`Physician`, `Treatment`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Treatment`) REFERENCES `hospital_1`.`Procedures` (`Code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Physician`) REFERENCES `hospital_1`.`Physician` (`EmployeeID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/hospital_1/data/Trained_In.csv' INTO TABLE `hospital_1`.`Trained_In`;


drop table if exists `hospital_1`.`Patient`;
CREATE TABLE IF NOT EXISTS `hospital_1`.`Patient` (
    `SSN` INT NOT NULL,
    `Name` STRING NOT NULL,
    `Address` STRING NOT NULL,
    `Phone` STRING NOT NULL,
    `InsuranceID` INT NOT NULL,
    `PCP` INT NOT NULL,
    PRIMARY KEY (`SSN`) DISABLE NOVALIDATE,
    FOREIGN KEY (`PCP`) REFERENCES `hospital_1`.`Physician` (`EmployeeID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/hospital_1/data/Patient.csv' INTO TABLE `hospital_1`.`Patient`;


drop table if exists `hospital_1`.`Nurse`;
CREATE TABLE IF NOT EXISTS `hospital_1`.`Nurse` (
    `EmployeeID` INT NOT NULL,
    `Name` STRING NOT NULL,
    `Position` STRING NOT NULL,
    `Registered` BOOLEAN NOT NULL,
    `SSN` INT NOT NULL,
    PRIMARY KEY (`EmployeeID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/hospital_1/data/Nurse.csv' INTO TABLE `hospital_1`.`Nurse`;


drop table if exists `hospital_1`.`Appointment`;
CREATE TABLE IF NOT EXISTS `hospital_1`.`Appointment` (
    `AppointmentID` INT NOT NULL,
    `Patient` INT NOT NULL,
    `PrepNurse` INT,
    `Physician` INT NOT NULL,
    `Start` TIMESTAMP NOT NULL,
    `End` TIMESTAMP NOT NULL,
    `ExaminationRoom` STRING NOT NULL,
    PRIMARY KEY (`AppointmentID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Physician`) REFERENCES `hospital_1`.`Physician` (`EmployeeID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`PrepNurse`) REFERENCES `hospital_1`.`Nurse` (`EmployeeID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Patient`) REFERENCES `hospital_1`.`Patient` (`SSN`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/hospital_1/data/Appointment.csv' INTO TABLE `hospital_1`.`Appointment`;


drop table if exists `hospital_1`.`Medication`;
CREATE TABLE IF NOT EXISTS `hospital_1`.`Medication` (
    `Code` INT NOT NULL,
    `Name` STRING NOT NULL,
    `Brand` STRING NOT NULL,
    `Description` STRING NOT NULL,
    PRIMARY KEY (`Code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/hospital_1/data/Medication.csv' INTO TABLE `hospital_1`.`Medication`;


drop table if exists `hospital_1`.`Prescribes`;
CREATE TABLE IF NOT EXISTS `hospital_1`.`Prescribes` (
    `Physician` INT NOT NULL,
    `Patient` INT NOT NULL,
    `Medication` INT NOT NULL,
    `Date` TIMESTAMP NOT NULL,
    `Appointment` INT,
    `Dose` STRING NOT NULL,
    PRIMARY KEY (`Physician`, `Patient`, `Medication`, `Date`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Appointment`) REFERENCES `hospital_1`.`Appointment` (`AppointmentID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Medication`) REFERENCES `hospital_1`.`Medication` (`Code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Patient`) REFERENCES `hospital_1`.`Patient` (`SSN`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Physician`) REFERENCES `hospital_1`.`Physician` (`EmployeeID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/hospital_1/data/Prescribes.csv' INTO TABLE `hospital_1`.`Prescribes`;


drop table if exists `hospital_1`.`Block`;
CREATE TABLE IF NOT EXISTS `hospital_1`.`Block` (
    `BlockFloor` INT NOT NULL,
    `BlockCode` INT NOT NULL,
    PRIMARY KEY (`BlockFloor`, `BlockCode`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/hospital_1/data/Block.csv' INTO TABLE `hospital_1`.`Block`;


drop table if exists `hospital_1`.`Room`;
CREATE TABLE IF NOT EXISTS `hospital_1`.`Room` (
    `RoomNumber` INT NOT NULL,
    `RoomType` STRING NOT NULL,
    `BlockFloor` INT NOT NULL,
    `BlockCode` INT NOT NULL,
    `Unavailable` BOOLEAN NOT NULL,
    PRIMARY KEY (`RoomNumber`) DISABLE NOVALIDATE,
    FOREIGN KEY (`BlockFloor`, `BlockCode`) REFERENCES `hospital_1`.`Block` (`BlockFloor`, `BlockCode`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/hospital_1/data/Room.csv' INTO TABLE `hospital_1`.`Room`;


drop table if exists `hospital_1`.`On_Call`;
CREATE TABLE IF NOT EXISTS `hospital_1`.`On_Call` (
    `Nurse` INT NOT NULL,
    `BlockFloor` INT NOT NULL,
    `BlockCode` INT NOT NULL,
    `OnCallStart` TIMESTAMP NOT NULL,
    `OnCallEnd` TIMESTAMP NOT NULL,
    PRIMARY KEY (`Nurse`, `BlockFloor`, `BlockCode`, `OnCallStart`, `OnCallEnd`) DISABLE NOVALIDATE,
    FOREIGN KEY (`BlockFloor`, `BlockCode`) REFERENCES `hospital_1`.`Block` (`BlockFloor`, `BlockCode`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Nurse`) REFERENCES `hospital_1`.`Nurse` (`EmployeeID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/hospital_1/data/On_Call.csv' INTO TABLE `hospital_1`.`On_Call`;


drop table if exists `hospital_1`.`Stay`;
CREATE TABLE IF NOT EXISTS `hospital_1`.`Stay` (
    `StayID` INT NOT NULL,
    `Patient` INT NOT NULL,
    `Room` INT NOT NULL,
    `StayStart` TIMESTAMP NOT NULL,
    `StayEnd` TIMESTAMP NOT NULL,
    PRIMARY KEY (`StayID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Room`) REFERENCES `hospital_1`.`Room` (`RoomNumber`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Patient`) REFERENCES `hospital_1`.`Patient` (`SSN`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/hospital_1/data/Stay.csv' INTO TABLE `hospital_1`.`Stay`;


drop table if exists `hospital_1`.`Undergoes`;
CREATE TABLE IF NOT EXISTS `hospital_1`.`Undergoes` (
    `Patient` INT NOT NULL,
    `Procedures` INT NOT NULL,
    `Stay` INT NOT NULL,
    `DateUndergoes` TIMESTAMP NOT NULL,
    `Physician` INT NOT NULL,
    `AssistingNurse` INT,
    PRIMARY KEY (`Patient`, `Procedures`, `Stay`, `DateUndergoes`) DISABLE NOVALIDATE,
    FOREIGN KEY (`AssistingNurse`) REFERENCES `hospital_1`.`Nurse` (`EmployeeID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Physician`) REFERENCES `hospital_1`.`Physician` (`EmployeeID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Stay`) REFERENCES `hospital_1`.`Stay` (`StayID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Procedures`) REFERENCES `hospital_1`.`Procedures` (`Code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Patient`) REFERENCES `hospital_1`.`Patient` (`SSN`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/hospital_1/data/Undergoes.csv' INTO TABLE `hospital_1`.`Undergoes`;

