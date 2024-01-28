CREATE DATABASE IF NOT EXISTS `local_govt_mdm`;

drop table if exists `local_govt_mdm`.`Customer_Master_Index`;
CREATE TABLE IF NOT EXISTS `local_govt_mdm`.`Customer_Master_Index` (
    `master_customer_id` INT NOT NULL,
    `cmi_details` STRING,
    PRIMARY KEY (`master_customer_id`) DISABLE NOVALIDATE
);

drop table if exists `local_govt_mdm`.`CMI_Cross_References`;
CREATE TABLE IF NOT EXISTS `local_govt_mdm`.`CMI_Cross_References` (
    `cmi_cross_ref_id` INT NOT NULL,
    `master_customer_id` INT NOT NULL,
    `source_system_code` CHAR(15) NOT NULL,
    PRIMARY KEY (`cmi_cross_ref_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`master_customer_id`) REFERENCES `local_govt_mdm`.`Customer_Master_Index` (`master_customer_id`) DISABLE NOVALIDATE
);

drop table if exists `local_govt_mdm`.`Council_Tax`;
CREATE TABLE IF NOT EXISTS `local_govt_mdm`.`Council_Tax` (
    `council_tax_id` INT NOT NULL,
    `cmi_cross_ref_id` INT NOT NULL,
    PRIMARY KEY (`council_tax_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`cmi_cross_ref_id`) REFERENCES `local_govt_mdm`.`CMI_Cross_References` (`cmi_cross_ref_id`) DISABLE NOVALIDATE
);

drop table if exists `local_govt_mdm`.`Business_Rates`;
CREATE TABLE IF NOT EXISTS `local_govt_mdm`.`Business_Rates` (
    `business_rates_id` INT NOT NULL,
    `cmi_cross_ref_id` INT NOT NULL,
    PRIMARY KEY (`business_rates_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`cmi_cross_ref_id`) REFERENCES `local_govt_mdm`.`CMI_Cross_References` (`cmi_cross_ref_id`) DISABLE NOVALIDATE
);

drop table if exists `local_govt_mdm`.`Benefits_Overpayments`;
CREATE TABLE IF NOT EXISTS `local_govt_mdm`.`Benefits_Overpayments` (
    `council_tax_id` INT NOT NULL,
    `cmi_cross_ref_id` INT NOT NULL,
    PRIMARY KEY (`council_tax_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`cmi_cross_ref_id`) REFERENCES `local_govt_mdm`.`CMI_Cross_References` (`cmi_cross_ref_id`) DISABLE NOVALIDATE
);

drop table if exists `local_govt_mdm`.`Parking_Fines`;
CREATE TABLE IF NOT EXISTS `local_govt_mdm`.`Parking_Fines` (
    `council_tax_id` INT NOT NULL,
    `cmi_cross_ref_id` INT NOT NULL,
    PRIMARY KEY (`council_tax_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`cmi_cross_ref_id`) REFERENCES `local_govt_mdm`.`CMI_Cross_References` (`cmi_cross_ref_id`) DISABLE NOVALIDATE
);

drop table if exists `local_govt_mdm`.`Rent_Arrears`;
CREATE TABLE IF NOT EXISTS `local_govt_mdm`.`Rent_Arrears` (
    `council_tax_id` INT NOT NULL,
    `cmi_cross_ref_id` INT NOT NULL,
    PRIMARY KEY (`council_tax_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`cmi_cross_ref_id`) REFERENCES `local_govt_mdm`.`CMI_Cross_References` (`cmi_cross_ref_id`) DISABLE NOVALIDATE
);

drop table if exists `local_govt_mdm`.`Electoral_Register`;
CREATE TABLE IF NOT EXISTS `local_govt_mdm`.`Electoral_Register` (
    `electoral_register_id` INT NOT NULL,
    `cmi_cross_ref_id` INT NOT NULL,
    PRIMARY KEY (`electoral_register_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`cmi_cross_ref_id`) REFERENCES `local_govt_mdm`.`CMI_Cross_References` (`cmi_cross_ref_id`) DISABLE NOVALIDATE
);
