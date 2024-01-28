CREATE DATABASE IF NOT EXISTS `local_govt_in_alabama`;

drop table if exists `local_govt_in_alabama`.`Services`;
CREATE TABLE IF NOT EXISTS `local_govt_in_alabama`.`Services` (
    `Service_ID` INT NOT NULL,
    `Service_Type_Code` CHAR(15) NOT NULL,
    PRIMARY KEY (`Service_ID`) DISABLE NOVALIDATE
);

drop table if exists `local_govt_in_alabama`.`Participants`;
CREATE TABLE IF NOT EXISTS `local_govt_in_alabama`.`Participants` (
    `Participant_ID` INT NOT NULL,
    `Participant_Type_Code` CHAR(15) NOT NULL,
    `Participant_Details` STRING,
    PRIMARY KEY (`Participant_ID`) DISABLE NOVALIDATE
);

drop table if exists `local_govt_in_alabama`.`Events`;
CREATE TABLE IF NOT EXISTS `local_govt_in_alabama`.`Events` (
    `Event_ID` INT NOT NULL,
    `Service_ID` INT NOT NULL,
    `Event_Details` STRING,
    PRIMARY KEY (`Event_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Service_ID`) REFERENCES `local_govt_in_alabama`.`Services` (`Service_ID`) DISABLE NOVALIDATE
);

drop table if exists `local_govt_in_alabama`.`Participants_in_Events`;
CREATE TABLE IF NOT EXISTS `local_govt_in_alabama`.`Participants_in_Events` (
    `Event_ID` INT NOT NULL,
    `Participant_ID` INT NOT NULL,
    PRIMARY KEY (`Event_ID`, `Participant_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Event_ID`) REFERENCES `local_govt_in_alabama`.`Events` (`Event_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Participant_ID`) REFERENCES `local_govt_in_alabama`.`Participants` (`Participant_ID`) DISABLE NOVALIDATE
);
