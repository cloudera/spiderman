-- Dialect: mysql | Database: insurance_and_eClaims | Table Count: 7

CREATE TABLE `insurance_and_eClaims`.`Customers` (
    `Customer_ID` INTEGER NOT NULL,
    `Customer_Details` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`Customer_ID`)
);

CREATE TABLE `insurance_and_eClaims`.`Staff` (
    `Staff_ID` INTEGER NOT NULL,
    `Staff_Details` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`Staff_ID`)
);

CREATE TABLE `insurance_and_eClaims`.`Policies` (
    `Policy_ID` INTEGER NOT NULL,
    `Customer_ID` INTEGER NOT NULL,
    `Policy_Type_Code` CHAR(15) NOT NULL,
    `Start_Date` DATETIME,
    `End_Date` DATETIME,
    PRIMARY KEY (`Policy_ID`),
    FOREIGN KEY (`Customer_ID`) REFERENCES `insurance_and_eClaims`.`Customers` (`Customer_ID`)
);

CREATE TABLE `insurance_and_eClaims`.`Claim_Headers` (
    `Claim_Header_ID` INTEGER NOT NULL,
    `Claim_Status_Code` CHAR(15) NOT NULL,
    `Claim_Type_Code` VARCHAR(30) NOT NULL,
    `Policy_ID` INTEGER NOT NULL,
    `Date_of_Claim` DATETIME,
    `Date_of_Settlement` DATETIME,
    `Amount_Claimed` DECIMAL(20,4),
    `Amount_Piad` DECIMAL(20,4),
    PRIMARY KEY (`Claim_Header_ID`),
    FOREIGN KEY (`Policy_ID`) REFERENCES `insurance_and_eClaims`.`Policies` (`Policy_ID`)
);

CREATE TABLE `insurance_and_eClaims`.`Claims_Documents` (
    `Claim_ID` INTEGER NOT NULL,
    `Document_Type_Code` CHAR(15) NOT NULL,
    `Created_by_Staff_ID` INTEGER,
    `Created_Date` INTEGER,
    PRIMARY KEY (`Claim_ID`, `Document_Type_Code`),
    FOREIGN KEY (`Created_by_Staff_ID`) REFERENCES `insurance_and_eClaims`.`Staff` (`Staff_ID`),
    FOREIGN KEY (`Claim_ID`) REFERENCES `insurance_and_eClaims`.`Claim_Headers` (`Claim_Header_ID`)
);

CREATE TABLE `insurance_and_eClaims`.`Claims_Processing_Stages` (
    `Claim_Stage_ID` INTEGER NOT NULL,
    `Next_Claim_Stage_ID` INTEGER,
    `Claim_Status_Name` VARCHAR(255) NOT NULL,
    `Claim_Status_Description` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`Claim_Stage_ID`)
);

CREATE TABLE `insurance_and_eClaims`.`Claims_Processing` (
    `Claim_Processing_ID` INTEGER NOT NULL,
    `Claim_ID` INTEGER NOT NULL,
    `Claim_Outcome_Code` CHAR(15) NOT NULL,
    `Claim_Stage_ID` INTEGER NOT NULL,
    `Staff_ID` INTEGER,
    PRIMARY KEY (`Claim_Processing_ID`),
    FOREIGN KEY (`Staff_ID`) REFERENCES `insurance_and_eClaims`.`Staff` (`Staff_ID`),
    FOREIGN KEY (`Claim_ID`) REFERENCES `insurance_and_eClaims`.`Claim_Headers` (`Claim_Header_ID`)
);
