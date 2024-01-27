CREATE DATABASE IF NOT EXISTS `insurance_and_eClaims`;

drop table if exists `insurance_and_eClaims`.`Customers`;
CREATE TABLE IF NOT EXISTS `insurance_and_eClaims`.`Customers` (
    `Customer_ID` INT NOT NULL,
    `Customer_Details` STRING NOT NULL,
    PRIMARY KEY (`Customer_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/insurance_and_eClaims/data/Customers.csv' INTO TABLE `insurance_and_eClaims`.`Customers`;


drop table if exists `insurance_and_eClaims`.`Staff`;
CREATE TABLE IF NOT EXISTS `insurance_and_eClaims`.`Staff` (
    `Staff_ID` INT NOT NULL,
    `Staff_Details` STRING NOT NULL,
    PRIMARY KEY (`Staff_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/insurance_and_eClaims/data/Staff.csv' INTO TABLE `insurance_and_eClaims`.`Staff`;


drop table if exists `insurance_and_eClaims`.`Policies`;
CREATE TABLE IF NOT EXISTS `insurance_and_eClaims`.`Policies` (
    `Policy_ID` INT NOT NULL,
    `Customer_ID` INT NOT NULL,
    `Policy_Type_Code` CHAR(15) NOT NULL,
    `Start_Date` TIMESTAMP,
    `End_Date` TIMESTAMP,
    PRIMARY KEY (`Policy_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Customer_ID`) REFERENCES `insurance_and_eClaims`.`Customers` (`Customer_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/insurance_and_eClaims/data/Policies.csv' INTO TABLE `insurance_and_eClaims`.`Policies`;


drop table if exists `insurance_and_eClaims`.`Claim_Headers`;
CREATE TABLE IF NOT EXISTS `insurance_and_eClaims`.`Claim_Headers` (
    `Claim_Header_ID` INT NOT NULL,
    `Claim_Status_Code` CHAR(15) NOT NULL,
    `Claim_Type_Code` CHAR(15) NOT NULL,
    `Policy_ID` INT NOT NULL,
    `Date_of_Claim` TIMESTAMP,
    `Date_of_Settlement` TIMESTAMP,
    `Amount_Claimed` DECIMAL(20,4),
    `Amount_Piad` DECIMAL(20,4),
    PRIMARY KEY (`Claim_Header_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Policy_ID`) REFERENCES `insurance_and_eClaims`.`Policies` (`Policy_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/insurance_and_eClaims/data/Claim_Headers.csv' INTO TABLE `insurance_and_eClaims`.`Claim_Headers`;


drop table if exists `insurance_and_eClaims`.`Claims_Documents`;
CREATE TABLE IF NOT EXISTS `insurance_and_eClaims`.`Claims_Documents` (
    `Claim_ID` INT NOT NULL,
    `Document_Type_Code` CHAR(15) NOT NULL,
    `Created_by_Staff_ID` INT,
    `Created_Date` INT,
    PRIMARY KEY (`Claim_ID`, `Document_Type_Code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Created_by_Staff_ID`) REFERENCES `insurance_and_eClaims`.`Staff` (`Staff_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Claim_ID`) REFERENCES `insurance_and_eClaims`.`Claim_Headers` (`Claim_Header_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/insurance_and_eClaims/data/Claims_Documents.csv' INTO TABLE `insurance_and_eClaims`.`Claims_Documents`;


drop table if exists `insurance_and_eClaims`.`Claims_Processing_Stages`;
CREATE TABLE IF NOT EXISTS `insurance_and_eClaims`.`Claims_Processing_Stages` (
    `Claim_Stage_ID` INT NOT NULL,
    `Next_Claim_Stage_ID` INT,
    `Claim_Status_Name` STRING NOT NULL,
    `Claim_Status_Description` STRING NOT NULL,
    PRIMARY KEY (`Claim_Stage_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/insurance_and_eClaims/data/Claims_Processing_Stages.csv' INTO TABLE `insurance_and_eClaims`.`Claims_Processing_Stages`;


drop table if exists `insurance_and_eClaims`.`Claims_Processing`;
CREATE TABLE IF NOT EXISTS `insurance_and_eClaims`.`Claims_Processing` (
    `Claim_Processing_ID` INT NOT NULL,
    `Claim_ID` INT NOT NULL,
    `Claim_Outcome_Code` CHAR(15) NOT NULL,
    `Claim_Stage_ID` INT NOT NULL,
    `Staff_ID` INT,
    PRIMARY KEY (`Claim_Processing_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Staff_ID`) REFERENCES `insurance_and_eClaims`.`Staff` (`Staff_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Claim_ID`) REFERENCES `insurance_and_eClaims`.`Claim_Headers` (`Claim_Header_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/insurance_and_eClaims/data/Claims_Processing.csv' INTO TABLE `insurance_and_eClaims`.`Claims_Processing`;

