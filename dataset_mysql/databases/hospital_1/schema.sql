-- Dialect: mysql | Database: hospital_1 | Table Count: 15

CREATE TABLE `hospital_1`.`Physician` (
    `EmployeeID` INTEGER NOT NULL,
    `Name` VARCHAR(30) NOT NULL,
    `Position` VARCHAR(30) NOT NULL,
    `SSN` INTEGER NOT NULL,
    PRIMARY KEY (`EmployeeID`)
);

CREATE TABLE `hospital_1`.`Department` (
    `DepartmentID` INTEGER NOT NULL,
    `Name` VARCHAR(30) NOT NULL,
    `Head` INTEGER NOT NULL,
    PRIMARY KEY (`DepartmentID`),
    FOREIGN KEY (`Head`) REFERENCES `hospital_1`.`Physician` (`EmployeeID`)
);

CREATE TABLE `hospital_1`.`Affiliated_With` (
    `Physician` INTEGER NOT NULL,
    `Department` INTEGER NOT NULL,
    `PrimaryAffiliation` BOOLEAN NOT NULL,
    PRIMARY KEY (`Physician`, `Department`),
    FOREIGN KEY (`Department`) REFERENCES `hospital_1`.`Department` (`DepartmentID`),
    FOREIGN KEY (`Physician`) REFERENCES `hospital_1`.`Physician` (`EmployeeID`)
);

CREATE TABLE `hospital_1`.`Procedures` (
    `Code` INTEGER NOT NULL,
    `Name` VARCHAR(30) NOT NULL,
    `Cost` REAL NOT NULL,
    PRIMARY KEY (`Code`)
);

CREATE TABLE `hospital_1`.`Trained_In` (
    `Physician` INTEGER NOT NULL,
    `Treatment` INTEGER NOT NULL,
    `CertificationDate` DATETIME NOT NULL,
    `CertificationExpires` DATETIME NOT NULL,
    PRIMARY KEY (`Physician`, `Treatment`),
    FOREIGN KEY (`Treatment`) REFERENCES `hospital_1`.`Procedures` (`Code`),
    FOREIGN KEY (`Physician`) REFERENCES `hospital_1`.`Physician` (`EmployeeID`)
);

CREATE TABLE `hospital_1`.`Patient` (
    `SSN` INTEGER NOT NULL,
    `Name` VARCHAR(30) NOT NULL,
    `Address` VARCHAR(30) NOT NULL,
    `Phone` VARCHAR(30) NOT NULL,
    `InsuranceID` INTEGER NOT NULL,
    `PCP` INTEGER NOT NULL,
    PRIMARY KEY (`SSN`),
    FOREIGN KEY (`PCP`) REFERENCES `hospital_1`.`Physician` (`EmployeeID`)
);

CREATE TABLE `hospital_1`.`Nurse` (
    `EmployeeID` INTEGER NOT NULL,
    `Name` VARCHAR(30) NOT NULL,
    `Position` VARCHAR(30) NOT NULL,
    `Registered` BOOLEAN NOT NULL,
    `SSN` INTEGER NOT NULL,
    PRIMARY KEY (`EmployeeID`)
);

CREATE TABLE `hospital_1`.`Appointment` (
    `AppointmentID` INTEGER NOT NULL,
    `Patient` INTEGER NOT NULL,
    `PrepNurse` INTEGER,
    `Physician` INTEGER NOT NULL,
    `Start` DATETIME NOT NULL,
    `End` DATETIME NOT NULL,
    `ExaminationRoom` TEXT NOT NULL,
    PRIMARY KEY (`AppointmentID`),
    FOREIGN KEY (`Physician`) REFERENCES `hospital_1`.`Physician` (`EmployeeID`),
    FOREIGN KEY (`PrepNurse`) REFERENCES `hospital_1`.`Nurse` (`EmployeeID`),
    FOREIGN KEY (`Patient`) REFERENCES `hospital_1`.`Patient` (`SSN`)
);

CREATE TABLE `hospital_1`.`Medication` (
    `Code` INTEGER NOT NULL,
    `Name` VARCHAR(30) NOT NULL,
    `Brand` VARCHAR(30) NOT NULL,
    `Description` VARCHAR(30) NOT NULL,
    PRIMARY KEY (`Code`)
);

CREATE TABLE `hospital_1`.`Prescribes` (
    `Physician` INTEGER NOT NULL,
    `Patient` INTEGER NOT NULL,
    `Medication` INTEGER NOT NULL,
    `Date` DATETIME NOT NULL,
    `Appointment` INTEGER,
    `Dose` VARCHAR(30) NOT NULL,
    PRIMARY KEY (`Physician`, `Patient`, `Medication`, `Date`),
    FOREIGN KEY (`Appointment`) REFERENCES `hospital_1`.`Appointment` (`AppointmentID`),
    FOREIGN KEY (`Medication`) REFERENCES `hospital_1`.`Medication` (`Code`),
    FOREIGN KEY (`Patient`) REFERENCES `hospital_1`.`Patient` (`SSN`),
    FOREIGN KEY (`Physician`) REFERENCES `hospital_1`.`Physician` (`EmployeeID`)
);

CREATE TABLE `hospital_1`.`Block` (
    `BlockFloor` INTEGER NOT NULL,
    `BlockCode` INTEGER NOT NULL,
    PRIMARY KEY (`BlockFloor`, `BlockCode`)
);

CREATE TABLE `hospital_1`.`Room` (
    `RoomNumber` INTEGER NOT NULL,
    `RoomType` VARCHAR(30) NOT NULL,
    `BlockFloor` INTEGER NOT NULL,
    `BlockCode` INTEGER NOT NULL,
    `Unavailable` BOOLEAN NOT NULL,
    PRIMARY KEY (`RoomNumber`),
    FOREIGN KEY (`BlockFloor`, `BlockCode`) REFERENCES `hospital_1`.`Block` (`BlockFloor`, `BlockCode`)
);

CREATE TABLE `hospital_1`.`On_Call` (
    `Nurse` INTEGER NOT NULL,
    `BlockFloor` INTEGER NOT NULL,
    `BlockCode` INTEGER NOT NULL,
    `OnCallStart` DATETIME NOT NULL,
    `OnCallEnd` DATETIME NOT NULL,
    PRIMARY KEY (`Nurse`, `BlockFloor`, `BlockCode`, `OnCallStart`, `OnCallEnd`),
    FOREIGN KEY (`BlockFloor`, `BlockCode`) REFERENCES `hospital_1`.`Block` (`BlockFloor`, `BlockCode`),
    FOREIGN KEY (`Nurse`) REFERENCES `hospital_1`.`Nurse` (`EmployeeID`)
);

CREATE TABLE `hospital_1`.`Stay` (
    `StayID` INTEGER NOT NULL,
    `Patient` INTEGER NOT NULL,
    `Room` INTEGER NOT NULL,
    `StayStart` DATETIME NOT NULL,
    `StayEnd` DATETIME NOT NULL,
    PRIMARY KEY (`StayID`),
    FOREIGN KEY (`Room`) REFERENCES `hospital_1`.`Room` (`RoomNumber`),
    FOREIGN KEY (`Patient`) REFERENCES `hospital_1`.`Patient` (`SSN`)
);

CREATE TABLE `hospital_1`.`Undergoes` (
    `Patient` INTEGER NOT NULL,
    `Procedures` INTEGER NOT NULL,
    `Stay` INTEGER NOT NULL,
    `DateUndergoes` DATETIME NOT NULL,
    `Physician` INTEGER NOT NULL,
    `AssistingNurse` INTEGER,
    PRIMARY KEY (`Patient`, `Procedures`, `Stay`, `DateUndergoes`),
    FOREIGN KEY (`AssistingNurse`) REFERENCES `hospital_1`.`Nurse` (`EmployeeID`),
    FOREIGN KEY (`Physician`) REFERENCES `hospital_1`.`Physician` (`EmployeeID`),
    FOREIGN KEY (`Stay`) REFERENCES `hospital_1`.`Stay` (`StayID`),
    FOREIGN KEY (`Procedures`) REFERENCES `hospital_1`.`Procedures` (`Code`),
    FOREIGN KEY (`Patient`) REFERENCES `hospital_1`.`Patient` (`SSN`)
);
