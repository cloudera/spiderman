drop table if exists `insurance_policies`.`Customers`;
CREATE TABLE IF NOT EXISTS `insurance_policies`.`Customers` (
    `Customer_ID` INT NOT NULL,
    `Customer_Details` STRING NOT NULL,
    PRIMARY KEY (`Customer_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/insurance_policies/data/Customers.csv' INTO TABLE `insurance_policies`.`Customers`;


drop table if exists `insurance_policies`.`Customer_Policies`;
CREATE TABLE IF NOT EXISTS `insurance_policies`.`Customer_Policies` (
    `Policy_ID` INT NOT NULL,
    `Customer_ID` INT NOT NULL,
    `Policy_Type_Code` CHAR(15) NOT NULL,
    `Start_Date` DATE,
    `End_Date` DATE,
    PRIMARY KEY (`Policy_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Customer_ID`) REFERENCES `insurance_policies`.`Customers` (`Customer_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/insurance_policies/data/Customer_Policies.csv' INTO TABLE `insurance_policies`.`Customer_Policies`;


drop table if exists `insurance_policies`.`Claims`;
CREATE TABLE IF NOT EXISTS `insurance_policies`.`Claims` (
    `Claim_ID` INT NOT NULL,
    `Policy_ID` INT NOT NULL,
    `Date_Claim_Made` DATE,
    `Date_Claim_Settled` DATE,
    `Amount_Claimed` INT,
    `Amount_Settled` INT,
    PRIMARY KEY (`Claim_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Policy_ID`) REFERENCES `insurance_policies`.`Customer_Policies` (`Policy_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/insurance_policies/data/Claims.csv' INTO TABLE `insurance_policies`.`Claims`;


drop table if exists `insurance_policies`.`Settlements`;
CREATE TABLE IF NOT EXISTS `insurance_policies`.`Settlements` (
    `Settlement_ID` INT NOT NULL,
    `Claim_ID` INT NOT NULL,
    `Date_Claim_Made` DATE,
    `Date_Claim_Settled` DATE,
    `Amount_Claimed` INT,
    `Amount_Settled` INT,
    `Customer_Policy_ID` INT NOT NULL,
    PRIMARY KEY (`Settlement_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Claim_ID`) REFERENCES `insurance_policies`.`Claims` (`Claim_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/insurance_policies/data/Settlements.csv' INTO TABLE `insurance_policies`.`Settlements`;


drop table if exists `insurance_policies`.`Payments`;
CREATE TABLE IF NOT EXISTS `insurance_policies`.`Payments` (
    `Payment_ID` INT NOT NULL,
    `Settlement_ID` INT NOT NULL,
    `Payment_Method_Code` STRING,
    `Date_Payment_Made` DATE,
    `Amount_Payment` INT,
    PRIMARY KEY (`Payment_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Settlement_ID`) REFERENCES `insurance_policies`.`Settlements` (`Settlement_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/insurance_policies/data/Payments.csv' INTO TABLE `insurance_policies`.`Payments`;

