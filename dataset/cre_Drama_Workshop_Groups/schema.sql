CREATE DATABASE IF NOT EXISTS `cre_Drama_Workshop_Groups`;

drop table if exists `cre_Drama_Workshop_Groups`.`Ref_Payment_Methods`;
CREATE TABLE IF NOT EXISTS `cre_Drama_Workshop_Groups`.`Ref_Payment_Methods` (
    `payment_method_code` CHAR (15) NOT NULL,
    `payment_method_description` STRING,
    PRIMARY KEY (`payment_method_code`) DISABLE NOVALIDATE
);

drop table if exists `cre_Drama_Workshop_Groups`.`Ref_Service_Types`;
CREATE TABLE IF NOT EXISTS `cre_Drama_Workshop_Groups`.`Ref_Service_Types` (
    `Service_Type_Code` CHAR(15) NOT NULL,
    `Parent_Service_Type_Code` CHAR(15),
    `Service_Type_Description` STRING,
    PRIMARY KEY (`Service_Type_Code`) DISABLE NOVALIDATE
);

drop table if exists `cre_Drama_Workshop_Groups`.`Addresses`;
CREATE TABLE IF NOT EXISTS `cre_Drama_Workshop_Groups`.`Addresses` (
    `Address_ID` INT NOT NULL,
    `Line_1` STRING,
    `Line_2` STRING,
    `City_Town` STRING,
    `State_County` STRING,
    `Other_Details` STRING,
    PRIMARY KEY (`Address_ID`) DISABLE NOVALIDATE
);

drop table if exists `cre_Drama_Workshop_Groups`.`Products`;
CREATE TABLE IF NOT EXISTS `cre_Drama_Workshop_Groups`.`Products` (
    `Product_ID` INT NOT NULL,
    `Product_Name` STRING,
    `Product_Price` DECIMAL(20,4),
    `Product_Description` STRING,
    `Other_Product_Service_Details` STRING,
    PRIMARY KEY (`Product_ID`) DISABLE NOVALIDATE
);

drop table if exists `cre_Drama_Workshop_Groups`.`Marketing_Regions`;
CREATE TABLE IF NOT EXISTS `cre_Drama_Workshop_Groups`.`Marketing_Regions` (
    `Marketing_Region_Code` CHAR(15) NOT NULL,
    `Marketing_Region_Name` STRING NOT NULL,
    `Marketing_Region_Descriptrion` STRING NOT NULL,
    `Other_Details` STRING,
    PRIMARY KEY (`Marketing_Region_Code`) DISABLE NOVALIDATE
);

drop table if exists `cre_Drama_Workshop_Groups`.`Clients`;
CREATE TABLE IF NOT EXISTS `cre_Drama_Workshop_Groups`.`Clients` (
    `Client_ID` INT NOT NULL,
    `Address_ID` INT NOT NULL,
    `Customer_Email_Address` STRING,
    `Customer_Name` STRING,
    `Customer_Phone` STRING,
    `Other_Details` STRING,
    PRIMARY KEY (`Client_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Address_ID`) REFERENCES `cre_Drama_Workshop_Groups`.`Addresses` (`Address_ID`) DISABLE NOVALIDATE,
    UNIQUE (`Client_ID`) DISABLE NOVALIDATE
);

drop table if exists `cre_Drama_Workshop_Groups`.`Drama_Workshop_Groups`;
CREATE TABLE IF NOT EXISTS `cre_Drama_Workshop_Groups`.`Drama_Workshop_Groups` (
    `Workshop_Group_ID` INT NOT NULL,
    `Address_ID` INT NOT NULL,
    `Currency_Code` CHAR(15) NOT NULL,
    `Marketing_Region_Code` CHAR(15) NOT NULL,
    `Store_Name` STRING,
    `Store_Phone` STRING,
    `Store_Email_Address` STRING,
    `Other_Details` STRING,
    PRIMARY KEY (`Workshop_Group_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Address_ID`) REFERENCES `cre_Drama_Workshop_Groups`.`Addresses` (`Address_ID`) DISABLE NOVALIDATE,
    UNIQUE (`Workshop_Group_ID`) DISABLE NOVALIDATE
);

drop table if exists `cre_Drama_Workshop_Groups`.`Performers`;
CREATE TABLE IF NOT EXISTS `cre_Drama_Workshop_Groups`.`Performers` (
    `Performer_ID` INT NOT NULL,
    `Address_ID` INT NOT NULL,
    `Customer_Name` STRING,
    `Customer_Phone` STRING,
    `Customer_Email_Address` STRING,
    `Other_Details` STRING,
    PRIMARY KEY (`Performer_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Address_ID`) REFERENCES `cre_Drama_Workshop_Groups`.`Addresses` (`Address_ID`) DISABLE NOVALIDATE,
    UNIQUE (`Performer_ID`) DISABLE NOVALIDATE
);

drop table if exists `cre_Drama_Workshop_Groups`.`Customers`;
CREATE TABLE IF NOT EXISTS `cre_Drama_Workshop_Groups`.`Customers` (
    `Customer_ID` INT NOT NULL,
    `Address_ID` INT NOT NULL,
    `Customer_Name` STRING,
    `Customer_Phone` STRING,
    `Customer_Email_Address` STRING,
    `Other_Details` STRING,
    PRIMARY KEY (`Customer_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Address_ID`) REFERENCES `cre_Drama_Workshop_Groups`.`Addresses` (`Address_ID`) DISABLE NOVALIDATE
);

drop table if exists `cre_Drama_Workshop_Groups`.`Stores`;
CREATE TABLE IF NOT EXISTS `cre_Drama_Workshop_Groups`.`Stores` (
    `Store_ID` INT NOT NULL,
    `Address_ID` INT NOT NULL,
    `Marketing_Region_Code` CHAR(15) NOT NULL,
    `Store_Name` STRING,
    `Store_Phone` STRING,
    `Store_Email_Address` STRING,
    `Other_Details` STRING,
    PRIMARY KEY (`Store_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Marketing_Region_Code`) REFERENCES `cre_Drama_Workshop_Groups`.`Marketing_Regions` (`Marketing_Region_Code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Address_ID`) REFERENCES `cre_Drama_Workshop_Groups`.`Addresses` (`Address_ID`) DISABLE NOVALIDATE
);

drop table if exists `cre_Drama_Workshop_Groups`.`Bookings`;
CREATE TABLE IF NOT EXISTS `cre_Drama_Workshop_Groups`.`Bookings` (
    `Booking_ID` INT NOT NULL,
    `Customer_ID` INT NOT NULL,
    `Workshop_Group_ID` INT NOT NULL,
    `Status_Code` CHAR(15) NOT NULL,
    `Store_ID` INT NOT NULL,
    `Order_Date` TIMESTAMP NOT NULL,
    `Planned_Delivery_Date` TIMESTAMP NOT NULL,
    `Actual_Delivery_Date` TIMESTAMP NOT NULL,
    `Other_Order_Details` STRING,
    PRIMARY KEY (`Booking_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Workshop_Group_ID`) REFERENCES `cre_Drama_Workshop_Groups`.`Drama_Workshop_Groups` (`Workshop_Group_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Customer_ID`) REFERENCES `cre_Drama_Workshop_Groups`.`Clients` (`Client_ID`) DISABLE NOVALIDATE,
    UNIQUE (`Booking_ID`) DISABLE NOVALIDATE
);

drop table if exists `cre_Drama_Workshop_Groups`.`Performers_in_Bookings`;
CREATE TABLE IF NOT EXISTS `cre_Drama_Workshop_Groups`.`Performers_in_Bookings` (
    `Order_ID` INT NOT NULL,
    `Performer_ID` INT NOT NULL,
    PRIMARY KEY (`Order_ID`, `Performer_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Order_ID`) REFERENCES `cre_Drama_Workshop_Groups`.`Bookings` (`Booking_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Performer_ID`) REFERENCES `cre_Drama_Workshop_Groups`.`Performers` (`Performer_ID`) DISABLE NOVALIDATE
);

drop table if exists `cre_Drama_Workshop_Groups`.`Customer_Orders`;
CREATE TABLE IF NOT EXISTS `cre_Drama_Workshop_Groups`.`Customer_Orders` (
    `Order_ID` INT NOT NULL,
    `Customer_ID` INT NOT NULL,
    `Store_ID` INT NOT NULL,
    `Order_Date` TIMESTAMP NOT NULL,
    `Planned_Delivery_Date` TIMESTAMP NOT NULL,
    `Actual_Delivery_Date` TIMESTAMP NOT NULL,
    `Other_Order_Details` STRING,
    PRIMARY KEY (`Order_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Store_ID`) REFERENCES `cre_Drama_Workshop_Groups`.`Stores` (`Store_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Customer_ID`) REFERENCES `cre_Drama_Workshop_Groups`.`Customers` (`Customer_ID`) DISABLE NOVALIDATE,
    UNIQUE (`Order_ID`) DISABLE NOVALIDATE
);

drop table if exists `cre_Drama_Workshop_Groups`.`Order_Items`;
CREATE TABLE IF NOT EXISTS `cre_Drama_Workshop_Groups`.`Order_Items` (
    `Order_Item_ID` INT NOT NULL,
    `Order_ID` INT NOT NULL,
    `Product_ID` INT NOT NULL,
    `Order_Quantity` STRING,
    `Other_Item_Details` STRING,
    PRIMARY KEY (`Order_Item_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Product_ID`) REFERENCES `cre_Drama_Workshop_Groups`.`Products` (`Product_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Order_ID`) REFERENCES `cre_Drama_Workshop_Groups`.`Customer_Orders` (`Order_ID`) DISABLE NOVALIDATE
);

drop table if exists `cre_Drama_Workshop_Groups`.`Invoices`;
CREATE TABLE IF NOT EXISTS `cre_Drama_Workshop_Groups`.`Invoices` (
    `Invoice_ID` INT NOT NULL,
    `Order_ID` INT NOT NULL,
    `payment_method_code` CHAR(15),
    `Product_ID` INT NOT NULL,
    `Order_Quantity` STRING,
    `Other_Item_Details` STRING,
    `Order_Item_ID` INT NOT NULL,
    PRIMARY KEY (`Invoice_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`payment_method_code`) REFERENCES `cre_Drama_Workshop_Groups`.`Ref_Payment_Methods` (`payment_method_code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Order_ID`) REFERENCES `cre_Drama_Workshop_Groups`.`Bookings` (`Booking_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Order_ID`) REFERENCES `cre_Drama_Workshop_Groups`.`Customer_Orders` (`Order_ID`) DISABLE NOVALIDATE
);

drop table if exists `cre_Drama_Workshop_Groups`.`Services`;
CREATE TABLE IF NOT EXISTS `cre_Drama_Workshop_Groups`.`Services` (
    `Service_ID` INT NOT NULL,
    `Service_Type_Code` CHAR(15),
    `Workshop_Group_ID` INT NOT NULL,
    `Product_Description` STRING,
    `Product_Name` STRING,
    `Product_Price` DECIMAL(20,4),
    `Other_Product_Service_Details` STRING,
    PRIMARY KEY (`Service_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Service_Type_Code`) REFERENCES `cre_Drama_Workshop_Groups`.`Ref_Service_Types` (`Service_Type_Code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Workshop_Group_ID`) REFERENCES `cre_Drama_Workshop_Groups`.`Drama_Workshop_Groups` (`Workshop_Group_ID`) DISABLE NOVALIDATE,
    UNIQUE (`Service_ID`) DISABLE NOVALIDATE
);

drop table if exists `cre_Drama_Workshop_Groups`.`Bookings_Services`;
CREATE TABLE IF NOT EXISTS `cre_Drama_Workshop_Groups`.`Bookings_Services` (
    `Order_ID` INT NOT NULL,
    `Product_ID` INT NOT NULL,
    PRIMARY KEY (`Order_ID`, `Product_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Product_ID`) REFERENCES `cre_Drama_Workshop_Groups`.`Services` (`Service_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Order_ID`) REFERENCES `cre_Drama_Workshop_Groups`.`Bookings` (`Booking_ID`) DISABLE NOVALIDATE
);

drop table if exists `cre_Drama_Workshop_Groups`.`Invoice_Items`;
CREATE TABLE IF NOT EXISTS `cre_Drama_Workshop_Groups`.`Invoice_Items` (
    `Invoice_Item_ID` INT NOT NULL,
    `Invoice_ID` INT NOT NULL,
    `Order_ID` INT NOT NULL,
    `Order_Item_ID` INT NOT NULL,
    `Product_ID` INT NOT NULL,
    `Order_Quantity` INT,
    `Other_Item_Details` STRING,
    PRIMARY KEY (`Invoice_Item_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Order_ID`, `Product_ID`) REFERENCES `cre_Drama_Workshop_Groups`.`Bookings_Services` (`Order_ID`, `Product_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Invoice_ID`) REFERENCES `cre_Drama_Workshop_Groups`.`Invoices` (`Invoice_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Order_Item_ID`) REFERENCES `cre_Drama_Workshop_Groups`.`Order_Items` (`Order_Item_ID`) DISABLE NOVALIDATE
);
