--- Database: customer_deliveries ----------------------------------------

create database if not exists `customer_deliveries`;

drop table if exists `customer_deliveries`.`Products`;
CREATE TABLE IF NOT EXISTS `customer_deliveries`.`Products` (
    `product_id` INT,
    `product_name` STRING,
    `product_price` DECIMAL(19,4),
    `product_description` STRING,
    PRIMARY KEY (`product_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customer_deliveries/data/Products.csv' INTO TABLE `customer_deliveries`.`Products`;


drop table if exists `customer_deliveries`.`Addresses`;
CREATE TABLE IF NOT EXISTS `customer_deliveries`.`Addresses` (
    `address_id` INT,
    `address_details` STRING,
    `city` STRING,
    `zip_postcode` STRING,
    `state_province_county` STRING,
    `country` STRING,
    PRIMARY KEY (`address_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customer_deliveries/data/Addresses.csv' INTO TABLE `customer_deliveries`.`Addresses`;


drop table if exists `customer_deliveries`.`Customers`;
CREATE TABLE IF NOT EXISTS `customer_deliveries`.`Customers` (
    `customer_id` INT,
    `payment_method` STRING NOT NULL,
    `customer_name` STRING,
    `customer_phone` STRING,
    `customer_email` STRING,
    `date_became_customer` TIMESTAMP,
    PRIMARY KEY (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customer_deliveries/data/Customers.csv' INTO TABLE `customer_deliveries`.`Customers`;


drop table if exists `customer_deliveries`.`Regular_Orders`;
CREATE TABLE IF NOT EXISTS `customer_deliveries`.`Regular_Orders` (
    `regular_order_id` INT,
    `distributer_id` INT NOT NULL,
    PRIMARY KEY (`regular_order_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`distributer_id`) REFERENCES `customer_deliveries`.`Customers` (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customer_deliveries/data/Regular_Orders.csv' INTO TABLE `customer_deliveries`.`Regular_Orders`;


drop table if exists `customer_deliveries`.`Regular_Order_Products`;
CREATE TABLE IF NOT EXISTS `customer_deliveries`.`Regular_Order_Products` (
    `regular_order_id` INT NOT NULL,
    `product_id` INT NOT NULL,
    FOREIGN KEY (`regular_order_id`) REFERENCES `customer_deliveries`.`Regular_Orders` (`regular_order_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`product_id`) REFERENCES `customer_deliveries`.`Products` (`product_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customer_deliveries/data/Regular_Order_Products.csv' INTO TABLE `customer_deliveries`.`Regular_Order_Products`;


drop table if exists `customer_deliveries`.`Actual_Orders`;
CREATE TABLE IF NOT EXISTS `customer_deliveries`.`Actual_Orders` (
    `actual_order_id` INT,
    `order_status_code` STRING NOT NULL,
    `regular_order_id` INT NOT NULL,
    `actual_order_date` TIMESTAMP,
    PRIMARY KEY (`actual_order_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`regular_order_id`) REFERENCES `customer_deliveries`.`Regular_Orders` (`regular_order_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customer_deliveries/data/Actual_Orders.csv' INTO TABLE `customer_deliveries`.`Actual_Orders`;


drop table if exists `customer_deliveries`.`Actual_Order_Products`;
CREATE TABLE IF NOT EXISTS `customer_deliveries`.`Actual_Order_Products` (
    `actual_order_id` INT NOT NULL,
    `product_id` INT NOT NULL,
    FOREIGN KEY (`actual_order_id`) REFERENCES `customer_deliveries`.`Actual_Orders` (`actual_order_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`product_id`) REFERENCES `customer_deliveries`.`Products` (`product_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customer_deliveries/data/Actual_Order_Products.csv' INTO TABLE `customer_deliveries`.`Actual_Order_Products`;


drop table if exists `customer_deliveries`.`Customer_Addresses`;
CREATE TABLE IF NOT EXISTS `customer_deliveries`.`Customer_Addresses` (
    `customer_id` INT NOT NULL,
    `address_id` INT NOT NULL,
    `date_from` TIMESTAMP NOT NULL,
    `address_type` STRING NOT NULL,
    `date_to` TIMESTAMP,
    FOREIGN KEY (`address_id`) REFERENCES `customer_deliveries`.`Addresses` (`address_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`customer_id`) REFERENCES `customer_deliveries`.`Customers` (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customer_deliveries/data/Customer_Addresses.csv' INTO TABLE `customer_deliveries`.`Customer_Addresses`;


drop table if exists `customer_deliveries`.`Delivery_Routes`;
CREATE TABLE IF NOT EXISTS `customer_deliveries`.`Delivery_Routes` (
    `route_id` INT,
    `route_name` STRING,
    `other_route_details` STRING,
    PRIMARY KEY (`route_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customer_deliveries/data/Delivery_Routes.csv' INTO TABLE `customer_deliveries`.`Delivery_Routes`;


drop table if exists `customer_deliveries`.`Delivery_Route_Locations`;
CREATE TABLE IF NOT EXISTS `customer_deliveries`.`Delivery_Route_Locations` (
    `location_code` STRING,
    `route_id` INT NOT NULL,
    `location_address_id` INT NOT NULL,
    `location_name` STRING,
    PRIMARY KEY (`location_code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`route_id`) REFERENCES `customer_deliveries`.`Delivery_Routes` (`route_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`location_address_id`) REFERENCES `customer_deliveries`.`Addresses` (`address_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customer_deliveries/data/Delivery_Route_Locations.csv' INTO TABLE `customer_deliveries`.`Delivery_Route_Locations`;


drop table if exists `customer_deliveries`.`Trucks`;
CREATE TABLE IF NOT EXISTS `customer_deliveries`.`Trucks` (
    `truck_id` INT,
    `truck_licence_number` STRING,
    `truck_details` STRING,
    PRIMARY KEY (`truck_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customer_deliveries/data/Trucks.csv' INTO TABLE `customer_deliveries`.`Trucks`;


drop table if exists `customer_deliveries`.`Employees`;
CREATE TABLE IF NOT EXISTS `customer_deliveries`.`Employees` (
    `employee_id` INT,
    `employee_address_id` INT NOT NULL,
    `employee_name` STRING,
    `employee_phone` STRING,
    PRIMARY KEY (`employee_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`employee_address_id`) REFERENCES `customer_deliveries`.`Addresses` (`address_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customer_deliveries/data/Employees.csv' INTO TABLE `customer_deliveries`.`Employees`;


drop table if exists `customer_deliveries`.`Order_Deliveries`;
CREATE TABLE IF NOT EXISTS `customer_deliveries`.`Order_Deliveries` (
    `location_code` STRING NOT NULL,
    `actual_order_id` INT NOT NULL,
    `delivery_status_code` STRING NOT NULL,
    `driver_employee_id` INT NOT NULL,
    `truck_id` INT NOT NULL,
    `delivery_date` TIMESTAMP,
    FOREIGN KEY (`driver_employee_id`) REFERENCES `customer_deliveries`.`Employees` (`employee_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`location_code`) REFERENCES `customer_deliveries`.`Delivery_Route_Locations` (`location_code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`actual_order_id`) REFERENCES `customer_deliveries`.`Actual_Orders` (`actual_order_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`truck_id`) REFERENCES `customer_deliveries`.`Trucks` (`truck_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customer_deliveries/data/Order_Deliveries.csv' INTO TABLE `customer_deliveries`.`Order_Deliveries`;



--- Database: allergy_1 ----------------------------------------

create database if not exists `allergy_1`;

drop table if exists `allergy_1`.`Allergy_Type`;
CREATE TABLE IF NOT EXISTS `allergy_1`.`Allergy_Type` (
    `Allergy` STRING,
    `AllergyType` STRING,
    PRIMARY KEY (`Allergy`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/allergy_1/data/Allergy_Type.csv' INTO TABLE `allergy_1`.`Allergy_Type`;


drop table if exists `allergy_1`.`Student`;
CREATE TABLE IF NOT EXISTS `allergy_1`.`Student` (
    `StuID` INT,
    `LName` STRING,
    `Fname` STRING,
    `Age` INT,
    `Sex` STRING,
    `Major` INT,
    `Advisor` INT,
    `city_code` STRING,
    PRIMARY KEY (`StuID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/allergy_1/data/Student.csv' INTO TABLE `allergy_1`.`Student`;


drop table if exists `allergy_1`.`Has_Allergy`;
CREATE TABLE IF NOT EXISTS `allergy_1`.`Has_Allergy` (
    `StuID` INT,
    `Allergy` STRING,
    FOREIGN KEY (`Allergy`) REFERENCES `allergy_1`.`Allergy_Type` (`Allergy`) DISABLE NOVALIDATE,
    FOREIGN KEY (`StuID`) REFERENCES `allergy_1`.`Student` (`StuID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/allergy_1/data/Has_Allergy.csv' INTO TABLE `allergy_1`.`Has_Allergy`;



--- Database: company_office ----------------------------------------

create database if not exists `company_office`;

drop table if exists `company_office`.`buildings`;
CREATE TABLE IF NOT EXISTS `company_office`.`buildings` (
    `id` INT,
    `name` STRING,
    `City` STRING,
    `Height` INT,
    `Stories` INT,
    `Status` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/company_office/data/buildings.csv' INTO TABLE `company_office`.`buildings`;


drop table if exists `company_office`.`Companies`;
CREATE TABLE IF NOT EXISTS `company_office`.`Companies` (
    `id` INT,
    `name` STRING,
    `Headquarters` STRING,
    `Industry` STRING,
    `Sales_billion` REAL,
    `Profits_billion` REAL,
    `Assets_billion` REAL,
    `Market_Value_billion` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/company_office/data/Companies.csv' INTO TABLE `company_office`.`Companies`;


drop table if exists `company_office`.`Office_locations`;
CREATE TABLE IF NOT EXISTS `company_office`.`Office_locations` (
    `building_id` INT,
    `company_id` INT,
    `move_in_year` INT,
    PRIMARY KEY (`building_id`, `company_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`company_id`) REFERENCES `company_office`.`Companies` (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`building_id`) REFERENCES `company_office`.`buildings` (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/company_office/data/Office_locations.csv' INTO TABLE `company_office`.`Office_locations`;



--- Database: device ----------------------------------------

create database if not exists `device`;

drop table if exists `device`.`device`;
CREATE TABLE IF NOT EXISTS `device`.`device` (
    `Device_ID` INT,
    `Device` STRING,
    `Carrier` STRING,
    `Package_Version` STRING,
    `Applications` STRING,
    `Software_Platform` STRING,
    PRIMARY KEY (`Device_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/device/data/device.csv' INTO TABLE `device`.`device`;


drop table if exists `device`.`shop`;
CREATE TABLE IF NOT EXISTS `device`.`shop` (
    `Shop_ID` INT,
    `Shop_Name` STRING,
    `Location` STRING,
    `Open_Date` STRING,
    `Open_Year` INT,
    PRIMARY KEY (`Shop_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/device/data/shop.csv' INTO TABLE `device`.`shop`;


drop table if exists `device`.`stock`;
CREATE TABLE IF NOT EXISTS `device`.`stock` (
    `Shop_ID` INT,
    `Device_ID` INT,
    `Quantity` INT,
    PRIMARY KEY (`Shop_ID`, `Device_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Device_ID`) REFERENCES `device`.`device` (`Device_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Shop_ID`) REFERENCES `device`.`shop` (`Shop_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/device/data/stock.csv' INTO TABLE `device`.`stock`;



--- Database: phone_1 ----------------------------------------

create database if not exists `phone_1`;

drop table if exists `phone_1`.`chip_model`;
CREATE TABLE IF NOT EXISTS `phone_1`.`chip_model` (
    `Model_name` STRING,
    `Launch_year` REAL,
    `RAM_MiB` REAL,
    `ROM_MiB` REAL,
    `Slots` STRING,
    `WiFi` STRING,
    `Bluetooth` STRING,
    PRIMARY KEY (`Model_name`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/phone_1/data/chip_model.csv' INTO TABLE `phone_1`.`chip_model`;


drop table if exists `phone_1`.`screen_mode`;
CREATE TABLE IF NOT EXISTS `phone_1`.`screen_mode` (
    `Graphics_mode` REAL,
    `Char_cells` STRING,
    `Pixels` STRING,
    `Hardware_colours` REAL,
    `used_kb` REAL,
    `map` STRING,
    `Type` STRING,
    PRIMARY KEY (`Graphics_mode`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/phone_1/data/screen_mode.csv' INTO TABLE `phone_1`.`screen_mode`;


drop table if exists `phone_1`.`phone`;
CREATE TABLE IF NOT EXISTS `phone_1`.`phone` (
    `Company_name` STRING,
    `Hardware_Model_name` STRING,
    `Accreditation_type` STRING,
    `Accreditation_level` STRING,
    `Date` STRING,
    `chip_model` STRING,
    `screen_mode` REAL,
    PRIMARY KEY (`Hardware_Model_name`) DISABLE NOVALIDATE,
    FOREIGN KEY (`chip_model`) REFERENCES `phone_1`.`chip_model` (`Model_name`) DISABLE NOVALIDATE,
    FOREIGN KEY (`screen_mode`) REFERENCES `phone_1`.`screen_mode` (`Graphics_mode`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/phone_1/data/phone.csv' INTO TABLE `phone_1`.`phone`;



--- Database: cre_Doc_Control_Systems ----------------------------------------

create database if not exists `cre_Doc_Control_Systems`;

drop table if exists `cre_Doc_Control_Systems`.`Ref_Document_Types`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Control_Systems`.`Ref_Document_Types` (
    `document_type_code` CHAR(15) NOT NULL,
    `document_type_description` STRING NOT NULL,
    PRIMARY KEY (`document_type_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Doc_Control_Systems/data/Ref_Document_Types.csv' INTO TABLE `cre_Doc_Control_Systems`.`Ref_Document_Types`;


drop table if exists `cre_Doc_Control_Systems`.`Roles`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Control_Systems`.`Roles` (
    `role_code` CHAR(15) NOT NULL,
    `role_description` STRING,
    PRIMARY KEY (`role_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Doc_Control_Systems/data/Roles.csv' INTO TABLE `cre_Doc_Control_Systems`.`Roles`;


drop table if exists `cre_Doc_Control_Systems`.`Addresses`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Control_Systems`.`Addresses` (
    `address_id` INT NOT NULL,
    `address_details` STRING,
    PRIMARY KEY (`address_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Doc_Control_Systems/data/Addresses.csv' INTO TABLE `cre_Doc_Control_Systems`.`Addresses`;


drop table if exists `cre_Doc_Control_Systems`.`Ref_Document_Status`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Control_Systems`.`Ref_Document_Status` (
    `document_status_code` CHAR(15) NOT NULL,
    `document_status_description` STRING NOT NULL,
    PRIMARY KEY (`document_status_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Doc_Control_Systems/data/Ref_Document_Status.csv' INTO TABLE `cre_Doc_Control_Systems`.`Ref_Document_Status`;


drop table if exists `cre_Doc_Control_Systems`.`Ref_Shipping_Agents`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Control_Systems`.`Ref_Shipping_Agents` (
    `shipping_agent_code` CHAR(15) NOT NULL,
    `shipping_agent_name` STRING NOT NULL,
    `shipping_agent_description` STRING NOT NULL,
    PRIMARY KEY (`shipping_agent_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Doc_Control_Systems/data/Ref_Shipping_Agents.csv' INTO TABLE `cre_Doc_Control_Systems`.`Ref_Shipping_Agents`;


drop table if exists `cre_Doc_Control_Systems`.`Documents`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Control_Systems`.`Documents` (
    `document_id` INT NOT NULL,
    `document_status_code` CHAR(15) NOT NULL,
    `document_type_code` CHAR(15) NOT NULL,
    `shipping_agent_code` CHAR(15),
    `receipt_date` TIMESTAMP,
    `receipt_number` STRING,
    `other_details` STRING,
    PRIMARY KEY (`document_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`shipping_agent_code`) REFERENCES `cre_Doc_Control_Systems`.`Ref_Shipping_Agents` (`shipping_agent_code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`document_status_code`) REFERENCES `cre_Doc_Control_Systems`.`Ref_Document_Status` (`document_status_code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`document_type_code`) REFERENCES `cre_Doc_Control_Systems`.`Ref_Document_Types` (`document_type_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Doc_Control_Systems/data/Documents.csv' INTO TABLE `cre_Doc_Control_Systems`.`Documents`;


drop table if exists `cre_Doc_Control_Systems`.`Employees`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Control_Systems`.`Employees` (
    `employee_id` INT NOT NULL,
    `role_code` CHAR(15) NOT NULL,
    `employee_name` STRING,
    `other_details` STRING,
    PRIMARY KEY (`employee_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`role_code`) REFERENCES `cre_Doc_Control_Systems`.`Roles` (`role_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Doc_Control_Systems/data/Employees.csv' INTO TABLE `cre_Doc_Control_Systems`.`Employees`;


drop table if exists `cre_Doc_Control_Systems`.`Document_Drafts`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Control_Systems`.`Document_Drafts` (
    `document_id` INT NOT NULL,
    `draft_number` INT NOT NULL,
    `draft_details` STRING,
    PRIMARY KEY (`document_id`, `draft_number`) DISABLE NOVALIDATE,
    FOREIGN KEY (`document_id`) REFERENCES `cre_Doc_Control_Systems`.`Documents` (`document_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Doc_Control_Systems/data/Document_Drafts.csv' INTO TABLE `cre_Doc_Control_Systems`.`Document_Drafts`;


drop table if exists `cre_Doc_Control_Systems`.`Draft_Copies`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Control_Systems`.`Draft_Copies` (
    `document_id` INT NOT NULL,
    `draft_number` INT NOT NULL,
    `copy_number` INT NOT NULL,
    PRIMARY KEY (`document_id`, `draft_number`, `copy_number`) DISABLE NOVALIDATE,
    FOREIGN KEY (`document_id`, `draft_number`) REFERENCES `cre_Doc_Control_Systems`.`Document_Drafts` (`document_id`, `draft_number`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Doc_Control_Systems/data/Draft_Copies.csv' INTO TABLE `cre_Doc_Control_Systems`.`Draft_Copies`;


drop table if exists `cre_Doc_Control_Systems`.`Circulation_History`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Control_Systems`.`Circulation_History` (
    `document_id` INT NOT NULL,
    `draft_number` INT NOT NULL,
    `copy_number` INT NOT NULL,
    `employee_id` INT NOT NULL,
    PRIMARY KEY (`document_id`, `draft_number`, `copy_number`, `employee_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`employee_id`) REFERENCES `cre_Doc_Control_Systems`.`Employees` (`employee_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`document_id`, `draft_number`, `copy_number`) REFERENCES `cre_Doc_Control_Systems`.`Draft_Copies` (`document_id`, `draft_number`, `copy_number`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Doc_Control_Systems/data/Circulation_History.csv' INTO TABLE `cre_Doc_Control_Systems`.`Circulation_History`;


drop table if exists `cre_Doc_Control_Systems`.`Documents_Mailed`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Control_Systems`.`Documents_Mailed` (
    `document_id` INT NOT NULL,
    `mailed_to_address_id` INT NOT NULL,
    `mailing_date` TIMESTAMP,
    PRIMARY KEY (`document_id`, `mailed_to_address_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`mailed_to_address_id`) REFERENCES `cre_Doc_Control_Systems`.`Addresses` (`address_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`document_id`) REFERENCES `cre_Doc_Control_Systems`.`Documents` (`document_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Doc_Control_Systems/data/Documents_Mailed.csv' INTO TABLE `cre_Doc_Control_Systems`.`Documents_Mailed`;



--- Database: decoration_competition ----------------------------------------

create database if not exists `decoration_competition`;

drop table if exists `decoration_competition`.`college`;
CREATE TABLE IF NOT EXISTS `decoration_competition`.`college` (
    `College_ID` INT,
    `Name` STRING,
    `Leader_Name` STRING,
    `College_Location` STRING,
    PRIMARY KEY (`College_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/decoration_competition/data/college.csv' INTO TABLE `decoration_competition`.`college`;


drop table if exists `decoration_competition`.`member`;
CREATE TABLE IF NOT EXISTS `decoration_competition`.`member` (
    `Member_ID` INT,
    `Name` STRING,
    `Country` STRING,
    `College_ID` INT,
    PRIMARY KEY (`Member_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`College_ID`) REFERENCES `decoration_competition`.`college` (`College_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/decoration_competition/data/member.csv' INTO TABLE `decoration_competition`.`member`;


drop table if exists `decoration_competition`.`round`;
CREATE TABLE IF NOT EXISTS `decoration_competition`.`round` (
    `Round_ID` INT,
    `Member_ID` INT,
    `Decoration_Theme` STRING,
    `Rank_in_Round` INT,
    PRIMARY KEY (`Round_ID`, `Member_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Member_ID`) REFERENCES `decoration_competition`.`member` (`Member_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/decoration_competition/data/round.csv' INTO TABLE `decoration_competition`.`round`;



--- Database: customers_campaigns_ecommerce ----------------------------------------

create database if not exists `customers_campaigns_ecommerce`;

drop table if exists `customers_campaigns_ecommerce`.`Premises`;
CREATE TABLE IF NOT EXISTS `customers_campaigns_ecommerce`.`Premises` (
    `premise_id` INT,
    `premises_type` STRING NOT NULL,
    `premise_details` STRING,
    PRIMARY KEY (`premise_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_campaigns_ecommerce/data/Premises.csv' INTO TABLE `customers_campaigns_ecommerce`.`Premises`;


drop table if exists `customers_campaigns_ecommerce`.`Products`;
CREATE TABLE IF NOT EXISTS `customers_campaigns_ecommerce`.`Products` (
    `product_id` INT,
    `product_category` STRING NOT NULL,
    `product_name` STRING,
    PRIMARY KEY (`product_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_campaigns_ecommerce/data/Products.csv' INTO TABLE `customers_campaigns_ecommerce`.`Products`;


drop table if exists `customers_campaigns_ecommerce`.`Customers`;
CREATE TABLE IF NOT EXISTS `customers_campaigns_ecommerce`.`Customers` (
    `customer_id` INT,
    `payment_method` STRING NOT NULL,
    `customer_name` STRING,
    `customer_phone` STRING,
    `customer_email` STRING,
    `customer_address` STRING,
    `customer_login` STRING,
    `customer_password` STRING,
    PRIMARY KEY (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_campaigns_ecommerce/data/Customers.csv' INTO TABLE `customers_campaigns_ecommerce`.`Customers`;


drop table if exists `customers_campaigns_ecommerce`.`Mailshot_Campaigns`;
CREATE TABLE IF NOT EXISTS `customers_campaigns_ecommerce`.`Mailshot_Campaigns` (
    `mailshot_id` INT,
    `product_category` STRING,
    `mailshot_name` STRING,
    `mailshot_start_date` TIMESTAMP,
    `mailshot_end_date` TIMESTAMP,
    PRIMARY KEY (`mailshot_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_campaigns_ecommerce/data/Mailshot_Campaigns.csv' INTO TABLE `customers_campaigns_ecommerce`.`Mailshot_Campaigns`;


drop table if exists `customers_campaigns_ecommerce`.`Customer_Addresses`;
CREATE TABLE IF NOT EXISTS `customers_campaigns_ecommerce`.`Customer_Addresses` (
    `customer_id` INT NOT NULL,
    `premise_id` INT NOT NULL,
    `date_address_from` TIMESTAMP NOT NULL,
    `address_type_code` STRING NOT NULL,
    `date_address_to` TIMESTAMP,
    FOREIGN KEY (`customer_id`) REFERENCES `customers_campaigns_ecommerce`.`Customers` (`customer_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`premise_id`) REFERENCES `customers_campaigns_ecommerce`.`Premises` (`premise_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_campaigns_ecommerce/data/Customer_Addresses.csv' INTO TABLE `customers_campaigns_ecommerce`.`Customer_Addresses`;


drop table if exists `customers_campaigns_ecommerce`.`Customer_Orders`;
CREATE TABLE IF NOT EXISTS `customers_campaigns_ecommerce`.`Customer_Orders` (
    `order_id` INT,
    `customer_id` INT NOT NULL,
    `order_status_code` STRING NOT NULL,
    `shipping_method_code` STRING NOT NULL,
    `order_placed_datetime` TIMESTAMP NOT NULL,
    `order_delivered_datetime` TIMESTAMP,
    `order_shipping_charges` STRING,
    PRIMARY KEY (`order_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`customer_id`) REFERENCES `customers_campaigns_ecommerce`.`Customers` (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_campaigns_ecommerce/data/Customer_Orders.csv' INTO TABLE `customers_campaigns_ecommerce`.`Customer_Orders`;


drop table if exists `customers_campaigns_ecommerce`.`Mailshot_Customers`;
CREATE TABLE IF NOT EXISTS `customers_campaigns_ecommerce`.`Mailshot_Customers` (
    `mailshot_id` INT NOT NULL,
    `customer_id` INT NOT NULL,
    `outcome_code` STRING NOT NULL,
    `mailshot_customer_date` TIMESTAMP,
    FOREIGN KEY (`mailshot_id`) REFERENCES `customers_campaigns_ecommerce`.`Mailshot_Campaigns` (`mailshot_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`customer_id`) REFERENCES `customers_campaigns_ecommerce`.`Customers` (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_campaigns_ecommerce/data/Mailshot_Customers.csv' INTO TABLE `customers_campaigns_ecommerce`.`Mailshot_Customers`;


drop table if exists `customers_campaigns_ecommerce`.`Order_Items`;
CREATE TABLE IF NOT EXISTS `customers_campaigns_ecommerce`.`Order_Items` (
    `item_id` INT NOT NULL,
    `order_item_status_code` STRING NOT NULL,
    `order_id` INT NOT NULL,
    `product_id` INT NOT NULL,
    `item_status_code` STRING,
    `item_delivered_datetime` TIMESTAMP,
    `item_order_quantity` STRING,
    FOREIGN KEY (`order_id`) REFERENCES `customers_campaigns_ecommerce`.`Customer_Orders` (`order_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`product_id`) REFERENCES `customers_campaigns_ecommerce`.`Products` (`product_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_campaigns_ecommerce/data/Order_Items.csv' INTO TABLE `customers_campaigns_ecommerce`.`Order_Items`;



--- Database: car_1 ----------------------------------------

create database if not exists `car_1`;

drop table if exists `car_1`.`continents`;
CREATE TABLE IF NOT EXISTS `car_1`.`continents` (
    `ContId` INT,
    `Continent` STRING,
    PRIMARY KEY (`ContId`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/car_1/data/continents.csv' INTO TABLE `car_1`.`continents`;


drop table if exists `car_1`.`countries`;
CREATE TABLE IF NOT EXISTS `car_1`.`countries` (
    `CountryId` INT,
    `CountryName` STRING,
    `Continent` INT,
    PRIMARY KEY (`CountryId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Continent`) REFERENCES `car_1`.`continents` (`ContId`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/car_1/data/countries.csv' INTO TABLE `car_1`.`countries`;


drop table if exists `car_1`.`car_makers`;
CREATE TABLE IF NOT EXISTS `car_1`.`car_makers` (
    `Id` INT,
    `Maker` STRING,
    `FullName` STRING,
    `Country` INT,
    PRIMARY KEY (`Id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Country`) REFERENCES `car_1`.`countries` (`CountryId`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/car_1/data/car_makers.csv' INTO TABLE `car_1`.`car_makers`;


drop table if exists `car_1`.`model_list`;
CREATE TABLE IF NOT EXISTS `car_1`.`model_list` (
    `ModelId` INT,
    `Maker` INT,
    `Model` STRING,
    PRIMARY KEY (`ModelId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Maker`) REFERENCES `car_1`.`car_makers` (`Id`) DISABLE NOVALIDATE,
    UNIQUE (`Model`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/car_1/data/model_list.csv' INTO TABLE `car_1`.`model_list`;


drop table if exists `car_1`.`car_names`;
CREATE TABLE IF NOT EXISTS `car_1`.`car_names` (
    `MakeId` INT,
    `Model` STRING,
    `Make` STRING,
    PRIMARY KEY (`MakeId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Model`) REFERENCES `car_1`.`model_list` (`Model`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/car_1/data/car_names.csv' INTO TABLE `car_1`.`car_names`;


drop table if exists `car_1`.`cars_data`;
CREATE TABLE IF NOT EXISTS `car_1`.`cars_data` (
    `Id` INT,
    `MPG` STRING,
    `Cylinders` INT,
    `Edispl` REAL,
    `Horsepower` STRING,
    `Weight` INT,
    `Accelerate` REAL,
    `Year` INT,
    PRIMARY KEY (`Id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Id`) REFERENCES `car_1`.`car_names` (`MakeId`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/car_1/data/cars_data.csv' INTO TABLE `car_1`.`cars_data`;



--- Database: roller_coaster ----------------------------------------

create database if not exists `roller_coaster`;

drop table if exists `roller_coaster`.`country`;
CREATE TABLE IF NOT EXISTS `roller_coaster`.`country` (
    `Country_ID` INT,
    `Name` STRING,
    `Population` INT,
    `Area` INT,
    `Languages` STRING,
    PRIMARY KEY (`Country_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/roller_coaster/data/country.csv' INTO TABLE `roller_coaster`.`country`;


drop table if exists `roller_coaster`.`roller_coaster`;
CREATE TABLE IF NOT EXISTS `roller_coaster`.`roller_coaster` (
    `Roller_Coaster_ID` INT,
    `Name` STRING,
    `Park` STRING,
    `Country_ID` INT,
    `Length` REAL,
    `Height` REAL,
    `Speed` STRING,
    `Opened` STRING,
    `Status` STRING,
    PRIMARY KEY (`Roller_Coaster_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Country_ID`) REFERENCES `roller_coaster`.`country` (`Country_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/roller_coaster/data/roller_coaster.csv' INTO TABLE `roller_coaster`.`roller_coaster`;



--- Database: entrepreneur ----------------------------------------

create database if not exists `entrepreneur`;

drop table if exists `entrepreneur`.`people`;
CREATE TABLE IF NOT EXISTS `entrepreneur`.`people` (
    `People_ID` INT,
    `Name` STRING,
    `Height` REAL,
    `Weight` REAL,
    `Date_of_Birth` STRING,
    PRIMARY KEY (`People_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/entrepreneur/data/people.csv' INTO TABLE `entrepreneur`.`people`;


drop table if exists `entrepreneur`.`entrepreneur`;
CREATE TABLE IF NOT EXISTS `entrepreneur`.`entrepreneur` (
    `Entrepreneur_ID` INT,
    `People_ID` INT,
    `Company` STRING,
    `Money_Requested` REAL,
    `Investor` STRING,
    PRIMARY KEY (`Entrepreneur_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`People_ID`) REFERENCES `entrepreneur`.`people` (`People_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/entrepreneur/data/entrepreneur.csv' INTO TABLE `entrepreneur`.`entrepreneur`;



--- Database: insurance_policies ----------------------------------------

create database if not exists `insurance_policies`;

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



--- Database: cre_Drama_Workshop_Groups ----------------------------------------

create database if not exists `cre_Drama_Workshop_Groups`;

drop table if exists `cre_Drama_Workshop_Groups`.`Ref_Payment_Methods`;
CREATE TABLE IF NOT EXISTS `cre_Drama_Workshop_Groups`.`Ref_Payment_Methods` (
    `payment_method_code` CHAR (15) NOT NULL,
    `payment_method_description` STRING,
    PRIMARY KEY (`payment_method_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Drama_Workshop_Groups/data/Ref_Payment_Methods.csv' INTO TABLE `cre_Drama_Workshop_Groups`.`Ref_Payment_Methods`;


drop table if exists `cre_Drama_Workshop_Groups`.`Ref_Service_Types`;
CREATE TABLE IF NOT EXISTS `cre_Drama_Workshop_Groups`.`Ref_Service_Types` (
    `Service_Type_Code` CHAR(15) NOT NULL,
    `Parent_Service_Type_Code` CHAR(15),
    `Service_Type_Description` STRING,
    PRIMARY KEY (`Service_Type_Code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Drama_Workshop_Groups/data/Ref_Service_Types.csv' INTO TABLE `cre_Drama_Workshop_Groups`.`Ref_Service_Types`;


drop table if exists `cre_Drama_Workshop_Groups`.`Addresses`;
CREATE TABLE IF NOT EXISTS `cre_Drama_Workshop_Groups`.`Addresses` (
    `Address_ID` INT NOT NULL,
    `Line_1` STRING,
    `Line_2` STRING,
    `City_Town` STRING,
    `State_County` STRING,
    `Other_Details` STRING,
    PRIMARY KEY (`Address_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Drama_Workshop_Groups/data/Addresses.csv' INTO TABLE `cre_Drama_Workshop_Groups`.`Addresses`;


drop table if exists `cre_Drama_Workshop_Groups`.`Products`;
CREATE TABLE IF NOT EXISTS `cre_Drama_Workshop_Groups`.`Products` (
    `Product_ID` INT NOT NULL,
    `Product_Name` STRING,
    `Product_Price` DECIMAL(20,4),
    `Product_Description` STRING,
    `Other_Product_Service_Details` STRING,
    PRIMARY KEY (`Product_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Drama_Workshop_Groups/data/Products.csv' INTO TABLE `cre_Drama_Workshop_Groups`.`Products`;


drop table if exists `cre_Drama_Workshop_Groups`.`Marketing_Regions`;
CREATE TABLE IF NOT EXISTS `cre_Drama_Workshop_Groups`.`Marketing_Regions` (
    `Marketing_Region_Code` CHAR(15) NOT NULL,
    `Marketing_Region_Name` STRING NOT NULL,
    `Marketing_Region_Descriptrion` STRING NOT NULL,
    `Other_Details` STRING,
    PRIMARY KEY (`Marketing_Region_Code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Drama_Workshop_Groups/data/Marketing_Regions.csv' INTO TABLE `cre_Drama_Workshop_Groups`.`Marketing_Regions`;


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
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Drama_Workshop_Groups/data/Clients.csv' INTO TABLE `cre_Drama_Workshop_Groups`.`Clients`;


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
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Drama_Workshop_Groups/data/Drama_Workshop_Groups.csv' INTO TABLE `cre_Drama_Workshop_Groups`.`Drama_Workshop_Groups`;


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
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Drama_Workshop_Groups/data/Performers.csv' INTO TABLE `cre_Drama_Workshop_Groups`.`Performers`;


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
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Drama_Workshop_Groups/data/Customers.csv' INTO TABLE `cre_Drama_Workshop_Groups`.`Customers`;


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
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Drama_Workshop_Groups/data/Stores.csv' INTO TABLE `cre_Drama_Workshop_Groups`.`Stores`;


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
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Drama_Workshop_Groups/data/Bookings.csv' INTO TABLE `cre_Drama_Workshop_Groups`.`Bookings`;


drop table if exists `cre_Drama_Workshop_Groups`.`Performers_in_Bookings`;
CREATE TABLE IF NOT EXISTS `cre_Drama_Workshop_Groups`.`Performers_in_Bookings` (
    `Order_ID` INT NOT NULL,
    `Performer_ID` INT NOT NULL,
    PRIMARY KEY (`Order_ID`, `Performer_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Order_ID`) REFERENCES `cre_Drama_Workshop_Groups`.`Bookings` (`Booking_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Performer_ID`) REFERENCES `cre_Drama_Workshop_Groups`.`Performers` (`Performer_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Drama_Workshop_Groups/data/Performers_in_Bookings.csv' INTO TABLE `cre_Drama_Workshop_Groups`.`Performers_in_Bookings`;


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
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Drama_Workshop_Groups/data/Customer_Orders.csv' INTO TABLE `cre_Drama_Workshop_Groups`.`Customer_Orders`;


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
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Drama_Workshop_Groups/data/Order_Items.csv' INTO TABLE `cre_Drama_Workshop_Groups`.`Order_Items`;


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
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Drama_Workshop_Groups/data/Invoices.csv' INTO TABLE `cre_Drama_Workshop_Groups`.`Invoices`;


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
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Drama_Workshop_Groups/data/Services.csv' INTO TABLE `cre_Drama_Workshop_Groups`.`Services`;


drop table if exists `cre_Drama_Workshop_Groups`.`Bookings_Services`;
CREATE TABLE IF NOT EXISTS `cre_Drama_Workshop_Groups`.`Bookings_Services` (
    `Order_ID` INT NOT NULL,
    `Product_ID` INT NOT NULL,
    PRIMARY KEY (`Order_ID`, `Product_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Product_ID`) REFERENCES `cre_Drama_Workshop_Groups`.`Services` (`Service_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Order_ID`) REFERENCES `cre_Drama_Workshop_Groups`.`Bookings` (`Booking_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Drama_Workshop_Groups/data/Bookings_Services.csv' INTO TABLE `cre_Drama_Workshop_Groups`.`Bookings_Services`;


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
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Drama_Workshop_Groups/data/Invoice_Items.csv' INTO TABLE `cre_Drama_Workshop_Groups`.`Invoice_Items`;



--- Database: voter_1 ----------------------------------------

create database if not exists `voter_1`;

drop table if exists `voter_1`.`AREA_CODE_STATE`;
CREATE TABLE IF NOT EXISTS `voter_1`.`AREA_CODE_STATE` (
    `area_code` INT NOT NULL,
    `state` STRING NOT NULL,
    PRIMARY KEY (`area_code`) DISABLE NOVALIDATE,
    UNIQUE (`state`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/voter_1/data/AREA_CODE_STATE.csv' INTO TABLE `voter_1`.`AREA_CODE_STATE`;


drop table if exists `voter_1`.`CONTESTANTS`;
CREATE TABLE IF NOT EXISTS `voter_1`.`CONTESTANTS` (
    `contestant_number` INT,
    `contestant_name` STRING NOT NULL,
    PRIMARY KEY (`contestant_number`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/voter_1/data/CONTESTANTS.csv' INTO TABLE `voter_1`.`CONTESTANTS`;


drop table if exists `voter_1`.`VOTES`;
CREATE TABLE IF NOT EXISTS `voter_1`.`VOTES` (
    `vote_id` INT NOT NULL,
    `phone_number` INT NOT NULL,
    `state` STRING NOT NULL,
    `contestant_number` INT NOT NULL,
    `created` TIMESTAMP NOT NULL,
    PRIMARY KEY (`vote_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`contestant_number`) REFERENCES `voter_1`.`CONTESTANTS` (`contestant_number`) DISABLE NOVALIDATE,
    FOREIGN KEY (`state`) REFERENCES `voter_1`.`AREA_CODE_STATE` (`state`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/voter_1/data/VOTES.csv' INTO TABLE `voter_1`.`VOTES`;



--- Database: journal_committee ----------------------------------------

create database if not exists `journal_committee`;

drop table if exists `journal_committee`.`journal`;
CREATE TABLE IF NOT EXISTS `journal_committee`.`journal` (
    `Journal_ID` INT,
    `Date` STRING,
    `Theme` STRING,
    `Sales` INT,
    PRIMARY KEY (`Journal_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/journal_committee/data/journal.csv' INTO TABLE `journal_committee`.`journal`;


drop table if exists `journal_committee`.`editor`;
CREATE TABLE IF NOT EXISTS `journal_committee`.`editor` (
    `Editor_ID` INT,
    `Name` STRING,
    `Age` REAL,
    PRIMARY KEY (`Editor_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/journal_committee/data/editor.csv' INTO TABLE `journal_committee`.`editor`;


drop table if exists `journal_committee`.`journal_committee`;
CREATE TABLE IF NOT EXISTS `journal_committee`.`journal_committee` (
    `Editor_ID` INT,
    `Journal_ID` INT,
    `Work_Type` STRING,
    PRIMARY KEY (`Editor_ID`, `Journal_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Journal_ID`) REFERENCES `journal_committee`.`journal` (`Journal_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Editor_ID`) REFERENCES `journal_committee`.`editor` (`Editor_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/journal_committee/data/journal_committee.csv' INTO TABLE `journal_committee`.`journal_committee`;



--- Database: performance_attendance ----------------------------------------

create database if not exists `performance_attendance`;

drop table if exists `performance_attendance`.`member`;
CREATE TABLE IF NOT EXISTS `performance_attendance`.`member` (
    `Member_ID` INT,
    `Name` STRING,
    `Nationality` STRING,
    `Role` STRING,
    PRIMARY KEY (`Member_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/performance_attendance/data/member.csv' INTO TABLE `performance_attendance`.`member`;


drop table if exists `performance_attendance`.`performance`;
CREATE TABLE IF NOT EXISTS `performance_attendance`.`performance` (
    `Performance_ID` INT,
    `Date` STRING,
    `Host` STRING,
    `Location` STRING,
    `Attendance` INT,
    PRIMARY KEY (`Performance_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/performance_attendance/data/performance.csv' INTO TABLE `performance_attendance`.`performance`;


drop table if exists `performance_attendance`.`member_attendance`;
CREATE TABLE IF NOT EXISTS `performance_attendance`.`member_attendance` (
    `Member_ID` INT,
    `Performance_ID` INT,
    `Num_of_Pieces` INT,
    PRIMARY KEY (`Member_ID`, `Performance_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Performance_ID`) REFERENCES `performance_attendance`.`performance` (`Performance_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Member_ID`) REFERENCES `performance_attendance`.`member` (`Member_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/performance_attendance/data/member_attendance.csv' INTO TABLE `performance_attendance`.`member_attendance`;



--- Database: store_1 ----------------------------------------

create database if not exists `store_1`;

drop table if exists `store_1`.`artists`;
CREATE TABLE IF NOT EXISTS `store_1`.`artists` (
    `id` INT,
    `name` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/store_1/data/artists.csv' INTO TABLE `store_1`.`artists`;


drop table if exists `store_1`.`albums`;
CREATE TABLE IF NOT EXISTS `store_1`.`albums` (
    `id` INT,
    `title` STRING NOT NULL,
    `artist_id` INT NOT NULL,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`artist_id`) REFERENCES `store_1`.`artists` (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/store_1/data/albums.csv' INTO TABLE `store_1`.`albums`;


drop table if exists `store_1`.`employees`;
CREATE TABLE IF NOT EXISTS `store_1`.`employees` (
    `id` INT,
    `last_name` STRING NOT NULL,
    `first_name` STRING NOT NULL,
    `title` STRING,
    `reports_to` INT,
    `birth_date` TIMESTAMP,
    `hire_date` TIMESTAMP,
    `address` STRING,
    `city` STRING,
    `state` STRING,
    `country` STRING,
    `postal_code` STRING,
    `phone` STRING,
    `fax` STRING,
    `email` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`reports_to`) REFERENCES `store_1`.`employees` (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/store_1/data/employees.csv' INTO TABLE `store_1`.`employees`;


drop table if exists `store_1`.`customers`;
CREATE TABLE IF NOT EXISTS `store_1`.`customers` (
    `id` INT,
    `first_name` STRING NOT NULL,
    `last_name` STRING NOT NULL,
    `company` STRING,
    `address` STRING,
    `city` STRING,
    `state` STRING,
    `country` STRING,
    `postal_code` STRING,
    `phone` STRING,
    `fax` STRING,
    `email` STRING NOT NULL,
    `support_rep_id` INT,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`support_rep_id`) REFERENCES `store_1`.`employees` (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/store_1/data/customers.csv' INTO TABLE `store_1`.`customers`;


drop table if exists `store_1`.`genres`;
CREATE TABLE IF NOT EXISTS `store_1`.`genres` (
    `id` INT,
    `name` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/store_1/data/genres.csv' INTO TABLE `store_1`.`genres`;


drop table if exists `store_1`.`invoices`;
CREATE TABLE IF NOT EXISTS `store_1`.`invoices` (
    `id` INT,
    `customer_id` INT NOT NULL,
    `invoice_date` TIMESTAMP NOT NULL,
    `billing_address` STRING,
    `billing_city` STRING,
    `billing_state` STRING,
    `billing_country` STRING,
    `billing_postal_code` STRING,
    `total` NUMERIC(10,2) NOT NULL,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`customer_id`) REFERENCES `store_1`.`customers` (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/store_1/data/invoices.csv' INTO TABLE `store_1`.`invoices`;


drop table if exists `store_1`.`media_types`;
CREATE TABLE IF NOT EXISTS `store_1`.`media_types` (
    `id` INT,
    `name` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/store_1/data/media_types.csv' INTO TABLE `store_1`.`media_types`;


drop table if exists `store_1`.`tracks`;
CREATE TABLE IF NOT EXISTS `store_1`.`tracks` (
    `id` INT,
    `name` STRING NOT NULL,
    `album_id` INT,
    `media_type_id` INT NOT NULL,
    `genre_id` INT,
    `composer` STRING,
    `milliseconds` INT NOT NULL,
    `bytes` INT,
    `unit_price` NUMERIC(10,2) NOT NULL,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`media_type_id`) REFERENCES `store_1`.`media_types` (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`genre_id`) REFERENCES `store_1`.`genres` (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`album_id`) REFERENCES `store_1`.`albums` (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/store_1/data/tracks.csv' INTO TABLE `store_1`.`tracks`;


drop table if exists `store_1`.`invoice_lines`;
CREATE TABLE IF NOT EXISTS `store_1`.`invoice_lines` (
    `id` INT,
    `invoice_id` INT NOT NULL,
    `track_id` INT NOT NULL,
    `unit_price` NUMERIC(10,2) NOT NULL,
    `quantity` INT NOT NULL,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`track_id`) REFERENCES `store_1`.`tracks` (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`invoice_id`) REFERENCES `store_1`.`invoices` (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/store_1/data/invoice_lines.csv' INTO TABLE `store_1`.`invoice_lines`;


drop table if exists `store_1`.`playlists`;
CREATE TABLE IF NOT EXISTS `store_1`.`playlists` (
    `id` INT,
    `name` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/store_1/data/playlists.csv' INTO TABLE `store_1`.`playlists`;


drop table if exists `store_1`.`playlist_tracks`;
CREATE TABLE IF NOT EXISTS `store_1`.`playlist_tracks` (
    `playlist_id` INT NOT NULL,
    `track_id` INT NOT NULL,
    PRIMARY KEY (`playlist_id`, `track_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`track_id`) REFERENCES `store_1`.`tracks` (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`playlist_id`) REFERENCES `store_1`.`playlists` (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/store_1/data/playlist_tracks.csv' INTO TABLE `store_1`.`playlist_tracks`;



--- Database: school_player ----------------------------------------

create database if not exists `school_player`;

drop table if exists `school_player`.`school`;
CREATE TABLE IF NOT EXISTS `school_player`.`school` (
    `School_ID` INT,
    `School` STRING,
    `Location` STRING,
    `Enrollment` REAL,
    `Founded` REAL,
    `Denomination` STRING,
    `Boys_or_Girls` STRING,
    `Day_or_Boarding` STRING,
    `Year_Entered_Competition` REAL,
    `School_Colors` STRING,
    PRIMARY KEY (`School_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/school_player/data/school.csv' INTO TABLE `school_player`.`school`;


drop table if exists `school_player`.`school_details`;
CREATE TABLE IF NOT EXISTS `school_player`.`school_details` (
    `School_ID` INT,
    `Nickname` STRING,
    `Colors` STRING,
    `League` STRING,
    `Class` STRING,
    `Division` STRING,
    PRIMARY KEY (`School_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`School_ID`) REFERENCES `school_player`.`school` (`School_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/school_player/data/school_details.csv' INTO TABLE `school_player`.`school_details`;


drop table if exists `school_player`.`school_performance`;
CREATE TABLE IF NOT EXISTS `school_player`.`school_performance` (
    `School_Id` INT,
    `School_Year` STRING,
    `Class_A` STRING,
    `Class_AA` STRING,
    PRIMARY KEY (`School_Id`, `School_Year`) DISABLE NOVALIDATE,
    FOREIGN KEY (`School_Id`) REFERENCES `school_player`.`school` (`School_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/school_player/data/school_performance.csv' INTO TABLE `school_player`.`school_performance`;


drop table if exists `school_player`.`player`;
CREATE TABLE IF NOT EXISTS `school_player`.`player` (
    `Player_ID` INT,
    `Player` STRING,
    `Team` STRING,
    `Age` INT,
    `Position` STRING,
    `School_ID` INT,
    PRIMARY KEY (`Player_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`School_ID`) REFERENCES `school_player`.`school` (`School_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/school_player/data/player.csv' INTO TABLE `school_player`.`player`;



--- Database: scientist_1 ----------------------------------------

create database if not exists `scientist_1`;

drop table if exists `scientist_1`.`Scientists`;
CREATE TABLE IF NOT EXISTS `scientist_1`.`Scientists` (
    `SSN` INT,
    `Name` CHAR(30) NOT NULL,
    PRIMARY KEY (`SSN`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/scientist_1/data/Scientists.csv' INTO TABLE `scientist_1`.`Scientists`;


drop table if exists `scientist_1`.`Projects`;
CREATE TABLE IF NOT EXISTS `scientist_1`.`Projects` (
    `Code` CHAR(4),
    `Name` CHAR(50) NOT NULL,
    `Hours` INT,
    PRIMARY KEY (`Code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/scientist_1/data/Projects.csv' INTO TABLE `scientist_1`.`Projects`;


drop table if exists `scientist_1`.`AssignedTo`;
CREATE TABLE IF NOT EXISTS `scientist_1`.`AssignedTo` (
    `Scientist` INT NOT NULL,
    `Project` CHAR(4) NOT NULL,
    PRIMARY KEY (`Scientist`, `Project`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Project`) REFERENCES `scientist_1`.`Projects` (`Code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Scientist`) REFERENCES `scientist_1`.`Scientists` (`SSN`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/scientist_1/data/AssignedTo.csv' INTO TABLE `scientist_1`.`AssignedTo`;



--- Database: student_transcripts_tracking ----------------------------------------

create database if not exists `student_transcripts_tracking`;

drop table if exists `student_transcripts_tracking`.`Addresses`;
CREATE TABLE IF NOT EXISTS `student_transcripts_tracking`.`Addresses` (
    `address_id` INT,
    `line_1` STRING,
    `line_2` STRING,
    `line_3` STRING,
    `city` STRING,
    `zip_postcode` STRING,
    `state_province_county` STRING,
    `country` STRING,
    `other_address_details` STRING,
    PRIMARY KEY (`address_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_transcripts_tracking/data/Addresses.csv' INTO TABLE `student_transcripts_tracking`.`Addresses`;


drop table if exists `student_transcripts_tracking`.`Courses`;
CREATE TABLE IF NOT EXISTS `student_transcripts_tracking`.`Courses` (
    `course_id` INT,
    `course_name` STRING,
    `course_description` STRING,
    `other_details` STRING,
    PRIMARY KEY (`course_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_transcripts_tracking/data/Courses.csv' INTO TABLE `student_transcripts_tracking`.`Courses`;


drop table if exists `student_transcripts_tracking`.`Departments`;
CREATE TABLE IF NOT EXISTS `student_transcripts_tracking`.`Departments` (
    `department_id` INT,
    `department_name` STRING,
    `department_description` STRING,
    `other_details` STRING,
    PRIMARY KEY (`department_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_transcripts_tracking/data/Departments.csv' INTO TABLE `student_transcripts_tracking`.`Departments`;


drop table if exists `student_transcripts_tracking`.`Degree_Programs`;
CREATE TABLE IF NOT EXISTS `student_transcripts_tracking`.`Degree_Programs` (
    `degree_program_id` INT,
    `department_id` INT NOT NULL,
    `degree_summary_name` STRING,
    `degree_summary_description` STRING,
    `other_details` STRING,
    PRIMARY KEY (`degree_program_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`department_id`) REFERENCES `student_transcripts_tracking`.`Departments` (`department_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_transcripts_tracking/data/Degree_Programs.csv' INTO TABLE `student_transcripts_tracking`.`Degree_Programs`;


drop table if exists `student_transcripts_tracking`.`Sections`;
CREATE TABLE IF NOT EXISTS `student_transcripts_tracking`.`Sections` (
    `section_id` INT,
    `course_id` INT NOT NULL,
    `section_name` STRING,
    `section_description` STRING,
    `other_details` STRING,
    PRIMARY KEY (`section_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`course_id`) REFERENCES `student_transcripts_tracking`.`Courses` (`course_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_transcripts_tracking/data/Sections.csv' INTO TABLE `student_transcripts_tracking`.`Sections`;


drop table if exists `student_transcripts_tracking`.`Semesters`;
CREATE TABLE IF NOT EXISTS `student_transcripts_tracking`.`Semesters` (
    `semester_id` INT,
    `semester_name` STRING,
    `semester_description` STRING,
    `other_details` STRING,
    PRIMARY KEY (`semester_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_transcripts_tracking/data/Semesters.csv' INTO TABLE `student_transcripts_tracking`.`Semesters`;


drop table if exists `student_transcripts_tracking`.`Students`;
CREATE TABLE IF NOT EXISTS `student_transcripts_tracking`.`Students` (
    `student_id` INT,
    `current_address_id` INT NOT NULL,
    `permanent_address_id` INT NOT NULL,
    `first_name` STRING,
    `middle_name` STRING,
    `last_name` STRING,
    `cell_mobile_number` STRING,
    `email_address` STRING,
    `ssn` STRING,
    `date_first_registered` TIMESTAMP,
    `date_left` TIMESTAMP,
    `other_student_details` STRING,
    PRIMARY KEY (`student_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`permanent_address_id`) REFERENCES `student_transcripts_tracking`.`Addresses` (`address_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`current_address_id`) REFERENCES `student_transcripts_tracking`.`Addresses` (`address_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_transcripts_tracking/data/Students.csv' INTO TABLE `student_transcripts_tracking`.`Students`;


drop table if exists `student_transcripts_tracking`.`Student_Enrolment`;
CREATE TABLE IF NOT EXISTS `student_transcripts_tracking`.`Student_Enrolment` (
    `student_enrolment_id` INT,
    `degree_program_id` INT NOT NULL,
    `semester_id` INT NOT NULL,
    `student_id` INT NOT NULL,
    `other_details` STRING,
    PRIMARY KEY (`student_enrolment_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`student_id`) REFERENCES `student_transcripts_tracking`.`Students` (`student_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`semester_id`) REFERENCES `student_transcripts_tracking`.`Semesters` (`semester_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`degree_program_id`) REFERENCES `student_transcripts_tracking`.`Degree_Programs` (`degree_program_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_transcripts_tracking/data/Student_Enrolment.csv' INTO TABLE `student_transcripts_tracking`.`Student_Enrolment`;


drop table if exists `student_transcripts_tracking`.`Student_Enrolment_Courses`;
CREATE TABLE IF NOT EXISTS `student_transcripts_tracking`.`Student_Enrolment_Courses` (
    `student_course_id` INT,
    `course_id` INT NOT NULL,
    `student_enrolment_id` INT NOT NULL,
    PRIMARY KEY (`student_course_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`student_enrolment_id`) REFERENCES `student_transcripts_tracking`.`Student_Enrolment` (`student_enrolment_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`course_id`) REFERENCES `student_transcripts_tracking`.`Courses` (`course_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_transcripts_tracking/data/Student_Enrolment_Courses.csv' INTO TABLE `student_transcripts_tracking`.`Student_Enrolment_Courses`;


drop table if exists `student_transcripts_tracking`.`Transcripts`;
CREATE TABLE IF NOT EXISTS `student_transcripts_tracking`.`Transcripts` (
    `transcript_id` INT,
    `transcript_date` TIMESTAMP,
    `other_details` STRING,
    PRIMARY KEY (`transcript_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_transcripts_tracking/data/Transcripts.csv' INTO TABLE `student_transcripts_tracking`.`Transcripts`;


drop table if exists `student_transcripts_tracking`.`Transcript_Contents`;
CREATE TABLE IF NOT EXISTS `student_transcripts_tracking`.`Transcript_Contents` (
    `student_course_id` INT NOT NULL,
    `transcript_id` INT NOT NULL,
    FOREIGN KEY (`transcript_id`) REFERENCES `student_transcripts_tracking`.`Transcripts` (`transcript_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`student_course_id`) REFERENCES `student_transcripts_tracking`.`Student_Enrolment_Courses` (`student_course_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_transcripts_tracking/data/Transcript_Contents.csv' INTO TABLE `student_transcripts_tracking`.`Transcript_Contents`;



--- Database: department_store ----------------------------------------

create database if not exists `department_store`;

drop table if exists `department_store`.`Addresses`;
CREATE TABLE IF NOT EXISTS `department_store`.`Addresses` (
    `address_id` INT,
    `address_details` STRING,
    PRIMARY KEY (`address_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/department_store/data/Addresses.csv' INTO TABLE `department_store`.`Addresses`;


drop table if exists `department_store`.`Staff`;
CREATE TABLE IF NOT EXISTS `department_store`.`Staff` (
    `staff_id` INT,
    `staff_gender` STRING,
    `staff_name` STRING,
    PRIMARY KEY (`staff_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/department_store/data/Staff.csv' INTO TABLE `department_store`.`Staff`;


drop table if exists `department_store`.`Suppliers`;
CREATE TABLE IF NOT EXISTS `department_store`.`Suppliers` (
    `supplier_id` INT,
    `supplier_name` STRING,
    `supplier_phone` STRING,
    PRIMARY KEY (`supplier_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/department_store/data/Suppliers.csv' INTO TABLE `department_store`.`Suppliers`;


drop table if exists `department_store`.`Department_Store_Chain`;
CREATE TABLE IF NOT EXISTS `department_store`.`Department_Store_Chain` (
    `dept_store_chain_id` INT,
    `dept_store_chain_name` STRING,
    PRIMARY KEY (`dept_store_chain_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/department_store/data/Department_Store_Chain.csv' INTO TABLE `department_store`.`Department_Store_Chain`;


drop table if exists `department_store`.`Customers`;
CREATE TABLE IF NOT EXISTS `department_store`.`Customers` (
    `customer_id` INT,
    `payment_method_code` STRING NOT NULL,
    `customer_code` STRING,
    `customer_name` STRING,
    `customer_address` STRING,
    `customer_phone` STRING,
    `customer_email` STRING,
    PRIMARY KEY (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/department_store/data/Customers.csv' INTO TABLE `department_store`.`Customers`;


drop table if exists `department_store`.`Products`;
CREATE TABLE IF NOT EXISTS `department_store`.`Products` (
    `product_id` INT,
    `product_type_code` STRING NOT NULL,
    `product_name` STRING,
    `product_price` DECIMAL(19,4),
    PRIMARY KEY (`product_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/department_store/data/Products.csv' INTO TABLE `department_store`.`Products`;


drop table if exists `department_store`.`Supplier_Addresses`;
CREATE TABLE IF NOT EXISTS `department_store`.`Supplier_Addresses` (
    `supplier_id` INT NOT NULL,
    `address_id` INT NOT NULL,
    `date_from` TIMESTAMP NOT NULL,
    `date_to` TIMESTAMP,
    PRIMARY KEY (`supplier_id`, `address_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`supplier_id`) REFERENCES `department_store`.`Suppliers` (`supplier_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`address_id`) REFERENCES `department_store`.`Addresses` (`address_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/department_store/data/Supplier_Addresses.csv' INTO TABLE `department_store`.`Supplier_Addresses`;


drop table if exists `department_store`.`Customer_Addresses`;
CREATE TABLE IF NOT EXISTS `department_store`.`Customer_Addresses` (
    `customer_id` INT NOT NULL,
    `address_id` INT NOT NULL,
    `date_from` TIMESTAMP NOT NULL,
    `date_to` TIMESTAMP,
    PRIMARY KEY (`customer_id`, `address_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`customer_id`) REFERENCES `department_store`.`Customers` (`customer_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`address_id`) REFERENCES `department_store`.`Addresses` (`address_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/department_store/data/Customer_Addresses.csv' INTO TABLE `department_store`.`Customer_Addresses`;


drop table if exists `department_store`.`Customer_Orders`;
CREATE TABLE IF NOT EXISTS `department_store`.`Customer_Orders` (
    `order_id` INT,
    `customer_id` INT NOT NULL,
    `order_status_code` STRING NOT NULL,
    `order_date` TIMESTAMP NOT NULL,
    PRIMARY KEY (`order_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`customer_id`) REFERENCES `department_store`.`Customers` (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/department_store/data/Customer_Orders.csv' INTO TABLE `department_store`.`Customer_Orders`;


drop table if exists `department_store`.`Department_Stores`;
CREATE TABLE IF NOT EXISTS `department_store`.`Department_Stores` (
    `dept_store_id` INT,
    `dept_store_chain_id` INT,
    `store_name` STRING,
    `store_address` STRING,
    `store_phone` STRING,
    `store_email` STRING,
    PRIMARY KEY (`dept_store_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`dept_store_chain_id`) REFERENCES `department_store`.`Department_Store_Chain` (`dept_store_chain_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/department_store/data/Department_Stores.csv' INTO TABLE `department_store`.`Department_Stores`;


drop table if exists `department_store`.`Departments`;
CREATE TABLE IF NOT EXISTS `department_store`.`Departments` (
    `department_id` INT,
    `dept_store_id` INT NOT NULL,
    `department_name` STRING,
    PRIMARY KEY (`department_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`dept_store_id`) REFERENCES `department_store`.`Department_Stores` (`dept_store_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/department_store/data/Departments.csv' INTO TABLE `department_store`.`Departments`;


drop table if exists `department_store`.`Order_Items`;
CREATE TABLE IF NOT EXISTS `department_store`.`Order_Items` (
    `order_item_id` INT,
    `order_id` INT NOT NULL,
    `product_id` INT NOT NULL,
    PRIMARY KEY (`order_item_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`product_id`) REFERENCES `department_store`.`Products` (`product_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`order_id`) REFERENCES `department_store`.`Customer_Orders` (`order_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/department_store/data/Order_Items.csv' INTO TABLE `department_store`.`Order_Items`;


drop table if exists `department_store`.`Product_Suppliers`;
CREATE TABLE IF NOT EXISTS `department_store`.`Product_Suppliers` (
    `product_id` INT NOT NULL,
    `supplier_id` INT NOT NULL,
    `date_supplied_from` TIMESTAMP NOT NULL,
    `date_supplied_to` TIMESTAMP,
    `total_amount_purchased` STRING,
    `total_value_purchased` DECIMAL(19,4),
    PRIMARY KEY (`product_id`, `supplier_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`product_id`) REFERENCES `department_store`.`Products` (`product_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`supplier_id`) REFERENCES `department_store`.`Suppliers` (`supplier_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/department_store/data/Product_Suppliers.csv' INTO TABLE `department_store`.`Product_Suppliers`;


drop table if exists `department_store`.`Staff_Department_Assignments`;
CREATE TABLE IF NOT EXISTS `department_store`.`Staff_Department_Assignments` (
    `staff_id` INT NOT NULL,
    `department_id` INT NOT NULL,
    `date_assigned_from` TIMESTAMP NOT NULL,
    `job_title_code` STRING NOT NULL,
    `date_assigned_to` TIMESTAMP,
    PRIMARY KEY (`staff_id`, `department_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`staff_id`) REFERENCES `department_store`.`Staff` (`staff_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`department_id`) REFERENCES `department_store`.`Departments` (`department_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/department_store/data/Staff_Department_Assignments.csv' INTO TABLE `department_store`.`Staff_Department_Assignments`;



--- Database: cre_Doc_Template_Mgt ----------------------------------------

create database if not exists `cre_Doc_Template_Mgt`;

drop table if exists `cre_Doc_Template_Mgt`.`Ref_Template_Types`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Template_Mgt`.`Ref_Template_Types` (
    `Template_Type_Code` CHAR(15) NOT NULL,
    `Template_Type_Description` STRING NOT NULL,
    PRIMARY KEY (`Template_Type_Code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Doc_Template_Mgt/data/Ref_Template_Types.csv' INTO TABLE `cre_Doc_Template_Mgt`.`Ref_Template_Types`;


drop table if exists `cre_Doc_Template_Mgt`.`Templates`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Template_Mgt`.`Templates` (
    `Template_ID` INT NOT NULL,
    `Version_Number` INT NOT NULL,
    `Template_Type_Code` CHAR(15) NOT NULL,
    `Date_Effective_From` TIMESTAMP,
    `Date_Effective_To` TIMESTAMP,
    `Template_Details` STRING NOT NULL,
    PRIMARY KEY (`Template_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Template_Type_Code`) REFERENCES `cre_Doc_Template_Mgt`.`Ref_Template_Types` (`Template_Type_Code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Doc_Template_Mgt/data/Templates.csv' INTO TABLE `cre_Doc_Template_Mgt`.`Templates`;


drop table if exists `cre_Doc_Template_Mgt`.`Documents`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Template_Mgt`.`Documents` (
    `Document_ID` INT NOT NULL,
    `Template_ID` INT,
    `Document_Name` STRING,
    `Document_Description` STRING,
    `Other_Details` STRING,
    PRIMARY KEY (`Document_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Template_ID`) REFERENCES `cre_Doc_Template_Mgt`.`Templates` (`Template_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Doc_Template_Mgt/data/Documents.csv' INTO TABLE `cre_Doc_Template_Mgt`.`Documents`;


drop table if exists `cre_Doc_Template_Mgt`.`Paragraphs`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Template_Mgt`.`Paragraphs` (
    `Paragraph_ID` INT NOT NULL,
    `Document_ID` INT NOT NULL,
    `Paragraph_Text` STRING,
    `Other_Details` STRING,
    PRIMARY KEY (`Paragraph_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Document_ID`) REFERENCES `cre_Doc_Template_Mgt`.`Documents` (`Document_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Doc_Template_Mgt/data/Paragraphs.csv' INTO TABLE `cre_Doc_Template_Mgt`.`Paragraphs`;



--- Database: local_govt_in_alabama ----------------------------------------

create database if not exists `local_govt_in_alabama`;

drop table if exists `local_govt_in_alabama`.`Services`;
CREATE TABLE IF NOT EXISTS `local_govt_in_alabama`.`Services` (
    `Service_ID` INT NOT NULL,
    `Service_Type_Code` CHAR(15) NOT NULL,
    PRIMARY KEY (`Service_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/local_govt_in_alabama/data/Services.csv' INTO TABLE `local_govt_in_alabama`.`Services`;


drop table if exists `local_govt_in_alabama`.`Participants`;
CREATE TABLE IF NOT EXISTS `local_govt_in_alabama`.`Participants` (
    `Participant_ID` INT NOT NULL,
    `Participant_Type_Code` CHAR(15) NOT NULL,
    `Participant_Details` STRING,
    PRIMARY KEY (`Participant_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/local_govt_in_alabama/data/Participants.csv' INTO TABLE `local_govt_in_alabama`.`Participants`;


drop table if exists `local_govt_in_alabama`.`Events`;
CREATE TABLE IF NOT EXISTS `local_govt_in_alabama`.`Events` (
    `Event_ID` INT NOT NULL,
    `Service_ID` INT NOT NULL,
    `Event_Details` STRING,
    PRIMARY KEY (`Event_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Service_ID`) REFERENCES `local_govt_in_alabama`.`Services` (`Service_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/local_govt_in_alabama/data/Events.csv' INTO TABLE `local_govt_in_alabama`.`Events`;


drop table if exists `local_govt_in_alabama`.`Participants_in_Events`;
CREATE TABLE IF NOT EXISTS `local_govt_in_alabama`.`Participants_in_Events` (
    `Event_ID` INT NOT NULL,
    `Participant_ID` INT NOT NULL,
    PRIMARY KEY (`Event_ID`, `Participant_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Event_ID`) REFERENCES `local_govt_in_alabama`.`Events` (`Event_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Participant_ID`) REFERENCES `local_govt_in_alabama`.`Participants` (`Participant_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/local_govt_in_alabama/data/Participants_in_Events.csv' INTO TABLE `local_govt_in_alabama`.`Participants_in_Events`;



--- Database: browser_web ----------------------------------------

create database if not exists `browser_web`;

drop table if exists `browser_web`.`Web_client_accelerator`;
CREATE TABLE IF NOT EXISTS `browser_web`.`Web_client_accelerator` (
    `id` INT,
    `name` STRING,
    `Operating_system` STRING,
    `Client` STRING,
    `Connection` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/browser_web/data/Web_client_accelerator.csv' INTO TABLE `browser_web`.`Web_client_accelerator`;


drop table if exists `browser_web`.`browser`;
CREATE TABLE IF NOT EXISTS `browser_web`.`browser` (
    `id` INT,
    `name` STRING,
    `market_share` REAL,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/browser_web/data/browser.csv' INTO TABLE `browser_web`.`browser`;


drop table if exists `browser_web`.`accelerator_compatible_browser`;
CREATE TABLE IF NOT EXISTS `browser_web`.`accelerator_compatible_browser` (
    `accelerator_id` INT,
    `browser_id` INT,
    `compatible_since_year` INT,
    PRIMARY KEY (`accelerator_id`, `browser_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`browser_id`) REFERENCES `browser_web`.`browser` (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`accelerator_id`) REFERENCES `browser_web`.`Web_client_accelerator` (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/browser_web/data/accelerator_compatible_browser.csv' INTO TABLE `browser_web`.`accelerator_compatible_browser`;



--- Database: cre_Docs_and_Epenses ----------------------------------------

create database if not exists `cre_Docs_and_Epenses`;

drop table if exists `cre_Docs_and_Epenses`.`Ref_Document_Types`;
CREATE TABLE IF NOT EXISTS `cre_Docs_and_Epenses`.`Ref_Document_Types` (
    `Document_Type_Code` CHAR(15) NOT NULL,
    `Document_Type_Name` STRING NOT NULL,
    `Document_Type_Description` STRING NOT NULL,
    PRIMARY KEY (`Document_Type_Code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Docs_and_Epenses/data/Ref_Document_Types.csv' INTO TABLE `cre_Docs_and_Epenses`.`Ref_Document_Types`;


drop table if exists `cre_Docs_and_Epenses`.`Ref_Budget_Codes`;
CREATE TABLE IF NOT EXISTS `cre_Docs_and_Epenses`.`Ref_Budget_Codes` (
    `Budget_Type_Code` CHAR(15) NOT NULL,
    `Budget_Type_Description` STRING NOT NULL,
    PRIMARY KEY (`Budget_Type_Code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Docs_and_Epenses/data/Ref_Budget_Codes.csv' INTO TABLE `cre_Docs_and_Epenses`.`Ref_Budget_Codes`;


drop table if exists `cre_Docs_and_Epenses`.`Projects`;
CREATE TABLE IF NOT EXISTS `cre_Docs_and_Epenses`.`Projects` (
    `Project_ID` INT NOT NULL,
    `Project_Details` STRING,
    PRIMARY KEY (`Project_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Docs_and_Epenses/data/Projects.csv' INTO TABLE `cre_Docs_and_Epenses`.`Projects`;


drop table if exists `cre_Docs_and_Epenses`.`Documents`;
CREATE TABLE IF NOT EXISTS `cre_Docs_and_Epenses`.`Documents` (
    `Document_ID` INT NOT NULL,
    `Document_Type_Code` CHAR(15) NOT NULL,
    `Project_ID` INT NOT NULL,
    `Document_Date` TIMESTAMP,
    `Document_Name` STRING,
    `Document_Description` STRING,
    `Other_Details` STRING,
    PRIMARY KEY (`Document_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Project_ID`) REFERENCES `cre_Docs_and_Epenses`.`Projects` (`Project_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Document_Type_Code`) REFERENCES `cre_Docs_and_Epenses`.`Ref_Document_Types` (`Document_Type_Code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Docs_and_Epenses/data/Documents.csv' INTO TABLE `cre_Docs_and_Epenses`.`Documents`;


drop table if exists `cre_Docs_and_Epenses`.`Statements`;
CREATE TABLE IF NOT EXISTS `cre_Docs_and_Epenses`.`Statements` (
    `Statement_ID` INT NOT NULL,
    `Statement_Details` STRING,
    PRIMARY KEY (`Statement_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Statement_ID`) REFERENCES `cre_Docs_and_Epenses`.`Documents` (`Document_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Docs_and_Epenses/data/Statements.csv' INTO TABLE `cre_Docs_and_Epenses`.`Statements`;


drop table if exists `cre_Docs_and_Epenses`.`Documents_with_Expenses`;
CREATE TABLE IF NOT EXISTS `cre_Docs_and_Epenses`.`Documents_with_Expenses` (
    `Document_ID` INT NOT NULL,
    `Budget_Type_Code` CHAR(15) NOT NULL,
    `Document_Details` STRING,
    PRIMARY KEY (`Document_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Document_ID`) REFERENCES `cre_Docs_and_Epenses`.`Documents` (`Document_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Budget_Type_Code`) REFERENCES `cre_Docs_and_Epenses`.`Ref_Budget_Codes` (`Budget_Type_Code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Docs_and_Epenses/data/Documents_with_Expenses.csv' INTO TABLE `cre_Docs_and_Epenses`.`Documents_with_Expenses`;


drop table if exists `cre_Docs_and_Epenses`.`Accounts`;
CREATE TABLE IF NOT EXISTS `cre_Docs_and_Epenses`.`Accounts` (
    `Account_ID` INT NOT NULL,
    `Statement_ID` INT NOT NULL,
    `Account_Details` STRING,
    PRIMARY KEY (`Account_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Statement_ID`) REFERENCES `cre_Docs_and_Epenses`.`Statements` (`Statement_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Docs_and_Epenses/data/Accounts.csv' INTO TABLE `cre_Docs_and_Epenses`.`Accounts`;



--- Database: apartment_rentals ----------------------------------------

create database if not exists `apartment_rentals`;

drop table if exists `apartment_rentals`.`Apartment_Buildings`;
CREATE TABLE IF NOT EXISTS `apartment_rentals`.`Apartment_Buildings` (
    `building_id` INT NOT NULL,
    `building_short_name` CHAR(15),
    `building_full_name` STRING,
    `building_description` STRING,
    `building_address` STRING,
    `building_manager` STRING,
    `building_phone` STRING,
    PRIMARY KEY (`building_id`) DISABLE NOVALIDATE,
    UNIQUE (`building_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/apartment_rentals/data/Apartment_Buildings.csv' INTO TABLE `apartment_rentals`.`Apartment_Buildings`;


drop table if exists `apartment_rentals`.`Apartments`;
CREATE TABLE IF NOT EXISTS `apartment_rentals`.`Apartments` (
    `apt_id` INT NOT NULL,
    `building_id` INT NOT NULL,
    `apt_type_code` CHAR(15),
    `apt_number` CHAR(10),
    `bathroom_count` INT,
    `bedroom_count` INT,
    `room_count` CHAR(5),
    PRIMARY KEY (`apt_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`building_id`) REFERENCES `apartment_rentals`.`Apartment_Buildings` (`building_id`) DISABLE NOVALIDATE,
    UNIQUE (`apt_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/apartment_rentals/data/Apartments.csv' INTO TABLE `apartment_rentals`.`Apartments`;


drop table if exists `apartment_rentals`.`Apartment_Facilities`;
CREATE TABLE IF NOT EXISTS `apartment_rentals`.`Apartment_Facilities` (
    `apt_id` INT NOT NULL,
    `facility_code` CHAR(15) NOT NULL,
    PRIMARY KEY (`apt_id`, `facility_code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`apt_id`) REFERENCES `apartment_rentals`.`Apartments` (`apt_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/apartment_rentals/data/Apartment_Facilities.csv' INTO TABLE `apartment_rentals`.`Apartment_Facilities`;


drop table if exists `apartment_rentals`.`Guests`;
CREATE TABLE IF NOT EXISTS `apartment_rentals`.`Guests` (
    `guest_id` INT NOT NULL,
    `gender_code` CHAR(1),
    `guest_first_name` STRING,
    `guest_last_name` STRING,
    `date_of_birth` TIMESTAMP,
    PRIMARY KEY (`guest_id`) DISABLE NOVALIDATE,
    UNIQUE (`guest_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/apartment_rentals/data/Guests.csv' INTO TABLE `apartment_rentals`.`Guests`;


drop table if exists `apartment_rentals`.`Apartment_Bookings`;
CREATE TABLE IF NOT EXISTS `apartment_rentals`.`Apartment_Bookings` (
    `apt_booking_id` INT NOT NULL,
    `apt_id` INT,
    `guest_id` INT NOT NULL,
    `booking_status_code` CHAR(15) NOT NULL,
    `booking_start_date` TIMESTAMP,
    `booking_end_date` TIMESTAMP,
    PRIMARY KEY (`apt_booking_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`guest_id`) REFERENCES `apartment_rentals`.`Guests` (`guest_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`apt_id`) REFERENCES `apartment_rentals`.`Apartments` (`apt_id`) DISABLE NOVALIDATE,
    UNIQUE (`apt_booking_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/apartment_rentals/data/Apartment_Bookings.csv' INTO TABLE `apartment_rentals`.`Apartment_Bookings`;


drop table if exists `apartment_rentals`.`View_Unit_Status`;
CREATE TABLE IF NOT EXISTS `apartment_rentals`.`View_Unit_Status` (
    `apt_id` INT,
    `apt_booking_id` INT,
    `status_date` TIMESTAMP NOT NULL,
    `available_yn` BOOLEAN,
    PRIMARY KEY (`status_date`) DISABLE NOVALIDATE,
    FOREIGN KEY (`apt_booking_id`) REFERENCES `apartment_rentals`.`Apartment_Bookings` (`apt_booking_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`apt_id`) REFERENCES `apartment_rentals`.`Apartments` (`apt_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/apartment_rentals/data/View_Unit_Status.csv' INTO TABLE `apartment_rentals`.`View_Unit_Status`;



--- Database: flight_4 ----------------------------------------

create database if not exists `flight_4`;

drop table if exists `flight_4`.`airlines`;
CREATE TABLE IF NOT EXISTS `flight_4`.`airlines` (
    `alid` INT,
    `name` STRING,
    `iata` STRING,
    `icao` STRING,
    `callsign` STRING,
    `country` STRING,
    `active` STRING,
    PRIMARY KEY (`alid`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/flight_4/data/airlines.csv' INTO TABLE `flight_4`.`airlines`;


drop table if exists `flight_4`.`airports`;
CREATE TABLE IF NOT EXISTS `flight_4`.`airports` (
    `apid` INT,
    `name` STRING NOT NULL,
    `city` STRING,
    `country` STRING,
    `x` REAL,
    `y` REAL,
    `elevation` BIGINT,
    `iata` STRING,
    `icao` STRING,
    PRIMARY KEY (`apid`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/flight_4/data/airports.csv' INTO TABLE `flight_4`.`airports`;


drop table if exists `flight_4`.`routes`;
CREATE TABLE IF NOT EXISTS `flight_4`.`routes` (
    `rid` INT,
    `dst_apid` INT,
    `dst_ap` STRING,
    `src_apid` INT,
    `src_ap` STRING,
    `alid` INT,
    `airline` STRING,
    `codeshare` STRING,
    PRIMARY KEY (`rid`) DISABLE NOVALIDATE,
    FOREIGN KEY (`alid`) REFERENCES `flight_4`.`airlines` (`alid`) DISABLE NOVALIDATE,
    FOREIGN KEY (`src_apid`) REFERENCES `flight_4`.`airports` (`apid`) DISABLE NOVALIDATE,
    FOREIGN KEY (`dst_apid`) REFERENCES `flight_4`.`airports` (`apid`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/flight_4/data/routes.csv' INTO TABLE `flight_4`.`routes`;



--- Database: hospital_1 ----------------------------------------

create database if not exists `hospital_1`;

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



--- Database: soccer_1 ----------------------------------------

create database if not exists `soccer_1`;

drop table if exists `soccer_1`.`Player`;
CREATE TABLE IF NOT EXISTS `soccer_1`.`Player` (
    `id` INT,
    `player_api_id` INT,
    `player_name` STRING,
    `player_fifa_api_id` INT,
    `birthday` STRING,
    `height` INT,
    `weight` INT,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    UNIQUE (`player_fifa_api_id`) DISABLE NOVALIDATE,
    UNIQUE (`player_api_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/soccer_1/data/Player.csv' INTO TABLE `soccer_1`.`Player`;


drop table if exists `soccer_1`.`Player_Attributes`;
CREATE TABLE IF NOT EXISTS `soccer_1`.`Player_Attributes` (
    `id` INT,
    `player_fifa_api_id` INT,
    `player_api_id` INT,
    `date` STRING,
    `overall_rating` INT,
    `potential` INT,
    `preferred_foot` STRING,
    `attacking_work_rate` STRING,
    `defensive_work_rate` STRING,
    `crossing` INT,
    `finishing` INT,
    `heading_accuracy` INT,
    `short_passing` INT,
    `volleys` INT,
    `dribbling` INT,
    `curve` INT,
    `free_kick_accuracy` INT,
    `long_passing` INT,
    `ball_control` INT,
    `acceleration` INT,
    `sprint_speed` INT,
    `agility` INT,
    `reactions` INT,
    `balance` INT,
    `shot_power` INT,
    `jumping` INT,
    `stamina` INT,
    `strength` INT,
    `long_shots` INT,
    `aggression` INT,
    `interceptions` INT,
    `positioning` INT,
    `vision` INT,
    `penalties` INT,
    `marking` INT,
    `standing_tackle` INT,
    `sliding_tackle` INT,
    `gk_diving` INT,
    `gk_handling` INT,
    `gk_kicking` INT,
    `gk_positioning` INT,
    `gk_reflexes` INT,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`player_api_id`) REFERENCES `soccer_1`.`Player` (`player_api_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`player_fifa_api_id`) REFERENCES `soccer_1`.`Player` (`player_fifa_api_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/soccer_1/data/Player_Attributes.csv' INTO TABLE `soccer_1`.`Player_Attributes`;


drop table if exists `soccer_1`.`Country`;
CREATE TABLE IF NOT EXISTS `soccer_1`.`Country` (
    `id` INT,
    `name` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    UNIQUE (`name`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/soccer_1/data/Country.csv' INTO TABLE `soccer_1`.`Country`;


drop table if exists `soccer_1`.`League`;
CREATE TABLE IF NOT EXISTS `soccer_1`.`League` (
    `id` INT,
    `country_id` INT,
    `name` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`country_id`) REFERENCES `soccer_1`.`Country` (`id`) DISABLE NOVALIDATE,
    UNIQUE (`name`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/soccer_1/data/League.csv' INTO TABLE `soccer_1`.`League`;


drop table if exists `soccer_1`.`Team`;
CREATE TABLE IF NOT EXISTS `soccer_1`.`Team` (
    `id` INT,
    `team_api_id` INT,
    `team_fifa_api_id` INT,
    `team_long_name` STRING,
    `team_short_name` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    UNIQUE (`team_api_id`) DISABLE NOVALIDATE,
    UNIQUE (`team_fifa_api_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/soccer_1/data/Team.csv' INTO TABLE `soccer_1`.`Team`;


drop table if exists `soccer_1`.`Team_Attributes`;
CREATE TABLE IF NOT EXISTS `soccer_1`.`Team_Attributes` (
    `id` INT,
    `team_fifa_api_id` INT,
    `team_api_id` INT,
    `date` STRING,
    `buildUpPlaySpeed` INT,
    `buildUpPlaySpeedClass` STRING,
    `buildUpPlayDribbling` INT,
    `buildUpPlayDribblingClass` STRING,
    `buildUpPlayPassing` INT,
    `buildUpPlayPassingClass` STRING,
    `buildUpPlayPositioningClass` STRING,
    `chanceCreationPassing` INT,
    `chanceCreationPassingClass` STRING,
    `chanceCreationCrossing` INT,
    `chanceCreationCrossingClass` STRING,
    `chanceCreationShooting` INT,
    `chanceCreationShootingClass` STRING,
    `chanceCreationPositioningClass` STRING,
    `defencePressure` INT,
    `defencePressureClass` STRING,
    `defenceAggression` INT,
    `defenceAggressionClass` STRING,
    `defenceTeamWidth` INT,
    `defenceTeamWidthClass` STRING,
    `defenceDefenderLineClass` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`team_api_id`) REFERENCES `soccer_1`.`Team` (`team_api_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`team_fifa_api_id`) REFERENCES `soccer_1`.`Team` (`team_fifa_api_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/soccer_1/data/Team_Attributes.csv' INTO TABLE `soccer_1`.`Team_Attributes`;



--- Database: gymnast ----------------------------------------

create database if not exists `gymnast`;

drop table if exists `gymnast`.`people`;
CREATE TABLE IF NOT EXISTS `gymnast`.`people` (
    `People_ID` INT,
    `Name` STRING,
    `Age` REAL,
    `Height` REAL,
    `Hometown` STRING,
    PRIMARY KEY (`People_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/gymnast/data/people.csv' INTO TABLE `gymnast`.`people`;


drop table if exists `gymnast`.`gymnast`;
CREATE TABLE IF NOT EXISTS `gymnast`.`gymnast` (
    `Gymnast_ID` INT,
    `Floor_Exercise_Points` REAL,
    `Pommel_Horse_Points` REAL,
    `Rings_Points` REAL,
    `Vault_Points` REAL,
    `Parallel_Bars_Points` REAL,
    `Horizontal_Bar_Points` REAL,
    `Total_Points` REAL,
    PRIMARY KEY (`Gymnast_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Gymnast_ID`) REFERENCES `gymnast`.`people` (`People_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/gymnast/data/gymnast.csv' INTO TABLE `gymnast`.`gymnast`;



--- Database: soccer_2 ----------------------------------------

create database if not exists `soccer_2`;

drop table if exists `soccer_2`.`College`;
CREATE TABLE IF NOT EXISTS `soccer_2`.`College` (
    `cName` STRING NOT NULL,
    `state` STRING,
    `enr` NUMERIC(5,0),
    PRIMARY KEY (`cName`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/soccer_2/data/College.csv' INTO TABLE `soccer_2`.`College`;


drop table if exists `soccer_2`.`Player`;
CREATE TABLE IF NOT EXISTS `soccer_2`.`Player` (
    `pID` NUMERIC(5,0) NOT NULL,
    `pName` STRING,
    `yCard` STRING,
    `HS` NUMERIC(5,0),
    PRIMARY KEY (`pID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/soccer_2/data/Player.csv' INTO TABLE `soccer_2`.`Player`;


drop table if exists `soccer_2`.`Tryout`;
CREATE TABLE IF NOT EXISTS `soccer_2`.`Tryout` (
    `pID` NUMERIC(5,0),
    `cName` STRING,
    `pPos` STRING,
    `decision` STRING,
    PRIMARY KEY (`pID`, `cName`) DISABLE NOVALIDATE,
    FOREIGN KEY (`cName`) REFERENCES `soccer_2`.`College` (`cName`) DISABLE NOVALIDATE,
    FOREIGN KEY (`pID`) REFERENCES `soccer_2`.`Player` (`pID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/soccer_2/data/Tryout.csv' INTO TABLE `soccer_2`.`Tryout`;



--- Database: formula_1 ----------------------------------------

create database if not exists `formula_1`;

drop table if exists `formula_1`.`circuits`;
CREATE TABLE IF NOT EXISTS `formula_1`.`circuits` (
    `circuitId` INT,
    `circuitRef` STRING,
    `name` STRING,
    `location` STRING,
    `country` STRING,
    `lat` REAL,
    `lng` REAL,
    `alt` STRING,
    `url` STRING,
    PRIMARY KEY (`circuitId`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/formula_1/data/circuits.csv' INTO TABLE `formula_1`.`circuits`;


drop table if exists `formula_1`.`races`;
CREATE TABLE IF NOT EXISTS `formula_1`.`races` (
    `raceId` INT,
    `year` INT,
    `round` INT,
    `circuitId` INT,
    `name` STRING,
    `date` STRING,
    `time` STRING,
    `url` STRING,
    PRIMARY KEY (`raceId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`circuitId`) REFERENCES `formula_1`.`circuits` (`circuitId`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/formula_1/data/races.csv' INTO TABLE `formula_1`.`races`;


drop table if exists `formula_1`.`drivers`;
CREATE TABLE IF NOT EXISTS `formula_1`.`drivers` (
    `driverId` INT,
    `driverRef` STRING,
    `number` STRING,
    `code` STRING,
    `forename` STRING,
    `surname` STRING,
    `dob` STRING,
    `nationality` STRING,
    `url` STRING,
    PRIMARY KEY (`driverId`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/formula_1/data/drivers.csv' INTO TABLE `formula_1`.`drivers`;


drop table if exists `formula_1`.`status`;
CREATE TABLE IF NOT EXISTS `formula_1`.`status` (
    `statusId` INT,
    `status` STRING,
    PRIMARY KEY (`statusId`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/formula_1/data/status.csv' INTO TABLE `formula_1`.`status`;


drop table if exists `formula_1`.`seasons`;
CREATE TABLE IF NOT EXISTS `formula_1`.`seasons` (
    `year` INT,
    `url` STRING,
    PRIMARY KEY (`year`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/formula_1/data/seasons.csv' INTO TABLE `formula_1`.`seasons`;


drop table if exists `formula_1`.`constructors`;
CREATE TABLE IF NOT EXISTS `formula_1`.`constructors` (
    `constructorId` INT,
    `constructorRef` STRING,
    `name` STRING,
    `nationality` STRING,
    `url` STRING,
    PRIMARY KEY (`constructorId`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/formula_1/data/constructors.csv' INTO TABLE `formula_1`.`constructors`;


drop table if exists `formula_1`.`constructorStandings`;
CREATE TABLE IF NOT EXISTS `formula_1`.`constructorStandings` (
    `constructorStandingsId` INT,
    `raceId` INT,
    `constructorId` INT,
    `points` REAL,
    `position` INT,
    `positionText` STRING,
    `wins` INT,
    PRIMARY KEY (`constructorStandingsId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`raceId`) REFERENCES `formula_1`.`races` (`raceId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`constructorId`) REFERENCES `formula_1`.`constructors` (`constructorId`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/formula_1/data/constructorStandings.csv' INTO TABLE `formula_1`.`constructorStandings`;


drop table if exists `formula_1`.`results`;
CREATE TABLE IF NOT EXISTS `formula_1`.`results` (
    `resultId` INT,
    `raceId` INT,
    `driverId` INT,
    `constructorId` INT,
    `number` INT,
    `grid` INT,
    `position` STRING,
    `positionText` STRING,
    `positionOrder` INT,
    `points` REAL,
    `laps` STRING,
    `time` STRING,
    `milliseconds` STRING,
    `fastestLap` STRING,
    `rank` STRING,
    `fastestLapTime` STRING,
    `fastestLapSpeed` STRING,
    `statusId` INT,
    PRIMARY KEY (`resultId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`driverId`) REFERENCES `formula_1`.`drivers` (`driverId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`raceId`) REFERENCES `formula_1`.`races` (`raceId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`constructorId`) REFERENCES `formula_1`.`constructors` (`constructorId`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/formula_1/data/results.csv' INTO TABLE `formula_1`.`results`;


drop table if exists `formula_1`.`driverStandings`;
CREATE TABLE IF NOT EXISTS `formula_1`.`driverStandings` (
    `driverStandingsId` INT,
    `raceId` INT,
    `driverId` INT,
    `points` REAL,
    `position` INT,
    `positionText` STRING,
    `wins` INT,
    PRIMARY KEY (`driverStandingsId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`driverId`) REFERENCES `formula_1`.`drivers` (`driverId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`raceId`) REFERENCES `formula_1`.`races` (`raceId`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/formula_1/data/driverStandings.csv' INTO TABLE `formula_1`.`driverStandings`;


drop table if exists `formula_1`.`constructorResults`;
CREATE TABLE IF NOT EXISTS `formula_1`.`constructorResults` (
    `constructorResultsId` INT,
    `raceId` INT,
    `constructorId` INT,
    `points` REAL,
    `status` STRING,
    PRIMARY KEY (`constructorResultsId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`raceId`) REFERENCES `formula_1`.`races` (`raceId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`constructorId`) REFERENCES `formula_1`.`constructors` (`constructorId`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/formula_1/data/constructorResults.csv' INTO TABLE `formula_1`.`constructorResults`;


drop table if exists `formula_1`.`qualifying`;
CREATE TABLE IF NOT EXISTS `formula_1`.`qualifying` (
    `qualifyId` INT,
    `raceId` INT,
    `driverId` INT,
    `constructorId` INT,
    `number` INT,
    `position` INT,
    `q1` STRING,
    `q2` STRING,
    `q3` STRING,
    PRIMARY KEY (`qualifyId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`driverId`) REFERENCES `formula_1`.`drivers` (`driverId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`raceId`) REFERENCES `formula_1`.`races` (`raceId`) DISABLE NOVALIDATE,
    FOREIGN KEY (`constructorId`) REFERENCES `formula_1`.`constructors` (`constructorId`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/formula_1/data/qualifying.csv' INTO TABLE `formula_1`.`qualifying`;



--- Database: workshop_paper ----------------------------------------

create database if not exists `workshop_paper`;

drop table if exists `workshop_paper`.`workshop`;
CREATE TABLE IF NOT EXISTS `workshop_paper`.`workshop` (
    `Workshop_ID` INT,
    `Date` STRING,
    `Venue` STRING,
    `Name` STRING,
    PRIMARY KEY (`Workshop_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/workshop_paper/data/workshop.csv' INTO TABLE `workshop_paper`.`workshop`;


drop table if exists `workshop_paper`.`submission`;
CREATE TABLE IF NOT EXISTS `workshop_paper`.`submission` (
    `Submission_ID` INT,
    `Scores` REAL,
    `Author` STRING,
    `College` STRING,
    PRIMARY KEY (`Submission_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/workshop_paper/data/submission.csv' INTO TABLE `workshop_paper`.`submission`;


drop table if exists `workshop_paper`.`Acceptance`;
CREATE TABLE IF NOT EXISTS `workshop_paper`.`Acceptance` (
    `Submission_ID` INT,
    `Workshop_ID` INT,
    `Result` STRING,
    PRIMARY KEY (`Submission_ID`, `Workshop_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Workshop_ID`) REFERENCES `workshop_paper`.`workshop` (`Workshop_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Submission_ID`) REFERENCES `workshop_paper`.`submission` (`Submission_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/workshop_paper/data/Acceptance.csv' INTO TABLE `workshop_paper`.`Acceptance`;



--- Database: shop_membership ----------------------------------------

create database if not exists `shop_membership`;

drop table if exists `shop_membership`.`member`;
CREATE TABLE IF NOT EXISTS `shop_membership`.`member` (
    `Member_ID` INT,
    `Card_Number` STRING,
    `Name` STRING,
    `Hometown` STRING,
    `Level` INT,
    PRIMARY KEY (`Member_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/shop_membership/data/member.csv' INTO TABLE `shop_membership`.`member`;


drop table if exists `shop_membership`.`branch`;
CREATE TABLE IF NOT EXISTS `shop_membership`.`branch` (
    `Branch_ID` INT,
    `Name` STRING,
    `Open_year` STRING,
    `Address_road` STRING,
    `City` STRING,
    `membership_amount` STRING,
    PRIMARY KEY (`Branch_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/shop_membership/data/branch.csv' INTO TABLE `shop_membership`.`branch`;


drop table if exists `shop_membership`.`membership_register_branch`;
CREATE TABLE IF NOT EXISTS `shop_membership`.`membership_register_branch` (
    `Member_ID` INT,
    `Branch_ID` INT,
    `Register_Year` STRING,
    PRIMARY KEY (`Member_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Branch_ID`) REFERENCES `shop_membership`.`branch` (`Branch_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Member_ID`) REFERENCES `shop_membership`.`member` (`Member_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/shop_membership/data/membership_register_branch.csv' INTO TABLE `shop_membership`.`membership_register_branch`;


drop table if exists `shop_membership`.`purchase`;
CREATE TABLE IF NOT EXISTS `shop_membership`.`purchase` (
    `Member_ID` INT,
    `Branch_ID` INT,
    `Year` STRING,
    `Total_pounds` REAL,
    PRIMARY KEY (`Member_ID`, `Branch_ID`, `Year`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Branch_ID`) REFERENCES `shop_membership`.`branch` (`Branch_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Member_ID`) REFERENCES `shop_membership`.`member` (`Member_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/shop_membership/data/purchase.csv' INTO TABLE `shop_membership`.`purchase`;



--- Database: candidate_poll ----------------------------------------

create database if not exists `candidate_poll`;

drop table if exists `candidate_poll`.`people`;
CREATE TABLE IF NOT EXISTS `candidate_poll`.`people` (
    `People_ID` INT,
    `Sex` STRING,
    `Name` STRING,
    `Date_of_Birth` STRING,
    `Height` REAL,
    `Weight` REAL,
    PRIMARY KEY (`People_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/candidate_poll/data/people.csv' INTO TABLE `candidate_poll`.`people`;


drop table if exists `candidate_poll`.`candidate`;
CREATE TABLE IF NOT EXISTS `candidate_poll`.`candidate` (
    `Candidate_ID` INT,
    `People_ID` INT,
    `Poll_Source` STRING,
    `Date` STRING,
    `Support_rate` REAL,
    `Consider_rate` REAL,
    `Oppose_rate` REAL,
    `Unsure_rate` REAL,
    PRIMARY KEY (`Candidate_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`People_ID`) REFERENCES `candidate_poll`.`people` (`People_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/candidate_poll/data/candidate.csv' INTO TABLE `candidate_poll`.`candidate`;



--- Database: hr_1 ----------------------------------------

create database if not exists `hr_1`;

drop table if exists `hr_1`.`regions`;
CREATE TABLE IF NOT EXISTS `hr_1`.`regions` (
    `REGION_ID` INT NOT NULL,
    `REGION_NAME` STRING,
    PRIMARY KEY (`REGION_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/hr_1/data/regions.csv' INTO TABLE `hr_1`.`regions`;


drop table if exists `hr_1`.`countries`;
CREATE TABLE IF NOT EXISTS `hr_1`.`countries` (
    `COUNTRY_ID` STRING NOT NULL,
    `COUNTRY_NAME` STRING,
    `REGION_ID` INT,
    PRIMARY KEY (`COUNTRY_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`REGION_ID`) REFERENCES `hr_1`.`regions` (`REGION_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/hr_1/data/countries.csv' INTO TABLE `hr_1`.`countries`;


drop table if exists `hr_1`.`departments`;
CREATE TABLE IF NOT EXISTS `hr_1`.`departments` (
    `DEPARTMENT_ID` DECIMAL(4,0) NOT NULL,
    `DEPARTMENT_NAME` STRING NOT NULL,
    `MANAGER_ID` DECIMAL(6,0),
    `LOCATION_ID` DECIMAL(4,0),
    PRIMARY KEY (`DEPARTMENT_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/hr_1/data/departments.csv' INTO TABLE `hr_1`.`departments`;


drop table if exists `hr_1`.`jobs`;
CREATE TABLE IF NOT EXISTS `hr_1`.`jobs` (
    `JOB_ID` STRING NOT NULL,
    `JOB_TITLE` STRING NOT NULL,
    `MIN_SALARY` DECIMAL(6,0),
    `MAX_SALARY` DECIMAL(6,0),
    PRIMARY KEY (`JOB_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/hr_1/data/jobs.csv' INTO TABLE `hr_1`.`jobs`;


drop table if exists `hr_1`.`employees`;
CREATE TABLE IF NOT EXISTS `hr_1`.`employees` (
    `EMPLOYEE_ID` DECIMAL(6,0) NOT NULL,
    `FIRST_NAME` STRING,
    `LAST_NAME` STRING NOT NULL,
    `EMAIL` STRING NOT NULL,
    `PHONE_NUMBER` STRING,
    `HIRE_DATE` DATE NOT NULL,
    `JOB_ID` STRING NOT NULL,
    `SALARY` DECIMAL(8,2),
    `COMMISSION_PCT` DECIMAL(2,2),
    `MANAGER_ID` DECIMAL(6,0),
    `DEPARTMENT_ID` DECIMAL(4,0),
    PRIMARY KEY (`EMPLOYEE_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`JOB_ID`) REFERENCES `hr_1`.`jobs` (`JOB_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`DEPARTMENT_ID`) REFERENCES `hr_1`.`departments` (`DEPARTMENT_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/hr_1/data/employees.csv' INTO TABLE `hr_1`.`employees`;


drop table if exists `hr_1`.`job_history`;
CREATE TABLE IF NOT EXISTS `hr_1`.`job_history` (
    `EMPLOYEE_ID` DECIMAL(6,0) NOT NULL,
    `START_DATE` DATE NOT NULL,
    `END_DATE` DATE NOT NULL,
    `JOB_ID` STRING NOT NULL,
    `DEPARTMENT_ID` DECIMAL(4,0),
    PRIMARY KEY (`EMPLOYEE_ID`, `START_DATE`) DISABLE NOVALIDATE,
    FOREIGN KEY (`JOB_ID`) REFERENCES `hr_1`.`jobs` (`JOB_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`DEPARTMENT_ID`) REFERENCES `hr_1`.`departments` (`DEPARTMENT_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`EMPLOYEE_ID`) REFERENCES `hr_1`.`employees` (`EMPLOYEE_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/hr_1/data/job_history.csv' INTO TABLE `hr_1`.`job_history`;


drop table if exists `hr_1`.`locations`;
CREATE TABLE IF NOT EXISTS `hr_1`.`locations` (
    `LOCATION_ID` DECIMAL(4,0) NOT NULL,
    `STREET_ADDRESS` STRING,
    `POSTAL_CODE` STRING,
    `CITY` STRING NOT NULL,
    `STATE_PROVINCE` STRING,
    `COUNTRY_ID` STRING,
    PRIMARY KEY (`LOCATION_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`COUNTRY_ID`) REFERENCES `hr_1`.`countries` (`COUNTRY_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/hr_1/data/locations.csv' INTO TABLE `hr_1`.`locations`;



--- Database: storm_record ----------------------------------------

create database if not exists `storm_record`;

drop table if exists `storm_record`.`storm`;
CREATE TABLE IF NOT EXISTS `storm_record`.`storm` (
    `Storm_ID` INT,
    `Name` STRING,
    `Dates_active` STRING,
    `Max_speed` INT,
    `Damage_millions_USD` REAL,
    `Number_Deaths` INT,
    PRIMARY KEY (`Storm_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/storm_record/data/storm.csv' INTO TABLE `storm_record`.`storm`;


drop table if exists `storm_record`.`region`;
CREATE TABLE IF NOT EXISTS `storm_record`.`region` (
    `Region_id` INT,
    `Region_code` STRING,
    `Region_name` STRING,
    PRIMARY KEY (`Region_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/storm_record/data/region.csv' INTO TABLE `storm_record`.`region`;


drop table if exists `storm_record`.`affected_region`;
CREATE TABLE IF NOT EXISTS `storm_record`.`affected_region` (
    `Region_id` INT,
    `Storm_ID` INT,
    `Number_city_affected` REAL,
    PRIMARY KEY (`Region_id`, `Storm_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Storm_ID`) REFERENCES `storm_record`.`storm` (`Storm_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Region_id`) REFERENCES `storm_record`.`region` (`Region_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/storm_record/data/affected_region.csv' INTO TABLE `storm_record`.`affected_region`;



--- Database: ship_mission ----------------------------------------

create database if not exists `ship_mission`;

drop table if exists `ship_mission`.`ship`;
CREATE TABLE IF NOT EXISTS `ship_mission`.`ship` (
    `Ship_ID` INT,
    `Name` STRING,
    `Type` STRING,
    `Nationality` STRING,
    `Tonnage` INT,
    PRIMARY KEY (`Ship_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/ship_mission/data/ship.csv' INTO TABLE `ship_mission`.`ship`;


drop table if exists `ship_mission`.`mission`;
CREATE TABLE IF NOT EXISTS `ship_mission`.`mission` (
    `Mission_ID` INT,
    `Ship_ID` INT,
    `Code` STRING,
    `Launched_Year` INT,
    `Location` STRING,
    `Speed_knots` INT,
    `Fate` STRING,
    PRIMARY KEY (`Mission_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Ship_ID`) REFERENCES `ship_mission`.`ship` (`Ship_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/ship_mission/data/mission.csv' INTO TABLE `ship_mission`.`mission`;



--- Database: coffee_shop ----------------------------------------

create database if not exists `coffee_shop`;

drop table if exists `coffee_shop`.`shop`;
CREATE TABLE IF NOT EXISTS `coffee_shop`.`shop` (
    `Shop_ID` INT,
    `Address` STRING,
    `Num_of_staff` STRING,
    `Score` REAL,
    `Open_Year` STRING,
    PRIMARY KEY (`Shop_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/coffee_shop/data/shop.csv' INTO TABLE `coffee_shop`.`shop`;


drop table if exists `coffee_shop`.`member`;
CREATE TABLE IF NOT EXISTS `coffee_shop`.`member` (
    `Member_ID` INT,
    `Name` STRING,
    `Membership_card` STRING,
    `Age` INT,
    `Time_of_purchase` INT,
    `Level_of_membership` INT,
    `Address` STRING,
    PRIMARY KEY (`Member_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/coffee_shop/data/member.csv' INTO TABLE `coffee_shop`.`member`;


drop table if exists `coffee_shop`.`happy_hour`;
CREATE TABLE IF NOT EXISTS `coffee_shop`.`happy_hour` (
    `HH_ID` INT,
    `Shop_ID` INT,
    `Month` STRING,
    `Num_of_shaff_in_charge` INT,
    PRIMARY KEY (`HH_ID`, `Shop_ID`, `Month`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Shop_ID`) REFERENCES `coffee_shop`.`shop` (`Shop_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/coffee_shop/data/happy_hour.csv' INTO TABLE `coffee_shop`.`happy_hour`;


drop table if exists `coffee_shop`.`happy_hour_member`;
CREATE TABLE IF NOT EXISTS `coffee_shop`.`happy_hour_member` (
    `HH_ID` INT,
    `Member_ID` INT,
    `Total_amount` REAL,
    PRIMARY KEY (`HH_ID`, `Member_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Member_ID`) REFERENCES `coffee_shop`.`member` (`Member_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/coffee_shop/data/happy_hour_member.csv' INTO TABLE `coffee_shop`.`happy_hour_member`;



--- Database: bike_1 ----------------------------------------

create database if not exists `bike_1`;

drop table if exists `bike_1`.`station`;
CREATE TABLE IF NOT EXISTS `bike_1`.`station` (
    `id` INT,
    `name` STRING,
    `lat` NUMERIC,
    `long` NUMERIC,
    `dock_count` INT,
    `city` STRING,
    `installation_date` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/bike_1/data/station.csv' INTO TABLE `bike_1`.`station`;


drop table if exists `bike_1`.`status`;
CREATE TABLE IF NOT EXISTS `bike_1`.`status` (
    `station_id` INT,
    `bikes_available` INT,
    `docks_available` INT,
    `time` STRING,
    FOREIGN KEY (`station_id`) REFERENCES `bike_1`.`station` (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/bike_1/data/status.csv' INTO TABLE `bike_1`.`status`;


drop table if exists `bike_1`.`trip`;
CREATE TABLE IF NOT EXISTS `bike_1`.`trip` (
    `id` INT,
    `duration` INT,
    `start_date` STRING,
    `start_station_name` STRING,
    `start_station_id` INT,
    `end_date` STRING,
    `end_station_name` STRING,
    `end_station_id` INT,
    `bike_id` INT,
    `subscription_type` STRING,
    `zip_code` INT,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/bike_1/data/trip.csv' INTO TABLE `bike_1`.`trip`;


drop table if exists `bike_1`.`weather`;
CREATE TABLE IF NOT EXISTS `bike_1`.`weather` (
    `date` STRING,
    `max_temperature_f` INT,
    `mean_temperature_f` INT,
    `min_temperature_f` INT,
    `max_dew_point_f` INT,
    `mean_dew_point_f` INT,
    `min_dew_point_f` INT,
    `max_humidity` INT,
    `mean_humidity` INT,
    `min_humidity` INT,
    `max_sea_level_pressure_inches` NUMERIC,
    `mean_sea_level_pressure_inches` NUMERIC,
    `min_sea_level_pressure_inches` NUMERIC,
    `max_visibility_miles` INT,
    `mean_visibility_miles` INT,
    `min_visibility_miles` INT,
    `max_wind_Speed_mph` INT,
    `mean_wind_speed_mph` INT,
    `max_gust_speed_mph` INT,
    `precipitation_inches` INT,
    `cloud_cover` INT,
    `events` STRING,
    `wind_dir_degrees` INT,
    `zip_code` INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/bike_1/data/weather.csv' INTO TABLE `bike_1`.`weather`;



--- Database: activity_1 ----------------------------------------

create database if not exists `activity_1`;

drop table if exists `activity_1`.`Activity`;
CREATE TABLE IF NOT EXISTS `activity_1`.`Activity` (
    `actid` INT,
    `activity_name` STRING,
    PRIMARY KEY (`actid`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/activity_1/data/Activity.csv' INTO TABLE `activity_1`.`Activity`;


drop table if exists `activity_1`.`Student`;
CREATE TABLE IF NOT EXISTS `activity_1`.`Student` (
    `StuID` INT,
    `LName` STRING,
    `Fname` STRING,
    `Age` INT,
    `Sex` STRING,
    `Major` INT,
    `Advisor` INT,
    `city_code` STRING,
    PRIMARY KEY (`StuID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/activity_1/data/Student.csv' INTO TABLE `activity_1`.`Student`;


drop table if exists `activity_1`.`Participates_in`;
CREATE TABLE IF NOT EXISTS `activity_1`.`Participates_in` (
    `stuid` INT,
    `actid` INT,
    FOREIGN KEY (`actid`) REFERENCES `activity_1`.`Activity` (`actid`) DISABLE NOVALIDATE,
    FOREIGN KEY (`stuid`) REFERENCES `activity_1`.`Student` (`StuID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/activity_1/data/Participates_in.csv' INTO TABLE `activity_1`.`Participates_in`;


drop table if exists `activity_1`.`Faculty`;
CREATE TABLE IF NOT EXISTS `activity_1`.`Faculty` (
    `FacID` INT,
    `Lname` STRING,
    `Fname` STRING,
    `Rank` STRING,
    `Sex` STRING,
    `Phone` INT,
    `Room` STRING,
    `Building` STRING,
    PRIMARY KEY (`FacID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/activity_1/data/Faculty.csv' INTO TABLE `activity_1`.`Faculty`;


drop table if exists `activity_1`.`Faculty_Participates_in`;
CREATE TABLE IF NOT EXISTS `activity_1`.`Faculty_Participates_in` (
    `FacID` INT,
    `actid` INT,
    FOREIGN KEY (`actid`) REFERENCES `activity_1`.`Activity` (`actid`) DISABLE NOVALIDATE,
    FOREIGN KEY (`FacID`) REFERENCES `activity_1`.`Faculty` (`FacID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/activity_1/data/Faculty_Participates_in.csv' INTO TABLE `activity_1`.`Faculty_Participates_in`;



--- Database: film_rank ----------------------------------------

create database if not exists `film_rank`;

drop table if exists `film_rank`.`film`;
CREATE TABLE IF NOT EXISTS `film_rank`.`film` (
    `Film_ID` INT,
    `Title` STRING,
    `Studio` STRING,
    `Director` STRING,
    `Gross_in_dollar` INT,
    PRIMARY KEY (`Film_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/film_rank/data/film.csv' INTO TABLE `film_rank`.`film`;


drop table if exists `film_rank`.`market`;
CREATE TABLE IF NOT EXISTS `film_rank`.`market` (
    `Market_ID` INT,
    `Country` STRING,
    `Number_cities` INT,
    PRIMARY KEY (`Market_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/film_rank/data/market.csv' INTO TABLE `film_rank`.`market`;


drop table if exists `film_rank`.`film_market_estimation`;
CREATE TABLE IF NOT EXISTS `film_rank`.`film_market_estimation` (
    `Estimation_ID` INT,
    `Low_Estimate` REAL,
    `High_Estimate` REAL,
    `Film_ID` INT,
    `Type` STRING,
    `Market_ID` INT,
    `Year` INT,
    PRIMARY KEY (`Estimation_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Market_ID`) REFERENCES `film_rank`.`market` (`Market_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Film_ID`) REFERENCES `film_rank`.`film` (`Film_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/film_rank/data/film_market_estimation.csv' INTO TABLE `film_rank`.`film_market_estimation`;



--- Database: program_share ----------------------------------------

create database if not exists `program_share`;

drop table if exists `program_share`.`program`;
CREATE TABLE IF NOT EXISTS `program_share`.`program` (
    `Program_ID` INT,
    `Name` STRING,
    `Origin` STRING,
    `Launch` REAL,
    `Owner` STRING,
    PRIMARY KEY (`Program_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/program_share/data/program.csv' INTO TABLE `program_share`.`program`;


drop table if exists `program_share`.`channel`;
CREATE TABLE IF NOT EXISTS `program_share`.`channel` (
    `Channel_ID` INT,
    `Name` STRING,
    `Owner` STRING,
    `Share_in_percent` REAL,
    `Rating_in_percent` REAL,
    PRIMARY KEY (`Channel_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/program_share/data/channel.csv' INTO TABLE `program_share`.`channel`;


drop table if exists `program_share`.`broadcast`;
CREATE TABLE IF NOT EXISTS `program_share`.`broadcast` (
    `Channel_ID` INT,
    `Program_ID` INT,
    `Time_of_day` STRING,
    PRIMARY KEY (`Channel_ID`, `Program_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Program_ID`) REFERENCES `program_share`.`program` (`Program_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Channel_ID`) REFERENCES `program_share`.`channel` (`Channel_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/program_share/data/broadcast.csv' INTO TABLE `program_share`.`broadcast`;


drop table if exists `program_share`.`broadcast_share`;
CREATE TABLE IF NOT EXISTS `program_share`.`broadcast_share` (
    `Channel_ID` INT,
    `Program_ID` INT,
    `Date` STRING,
    `Share_in_percent` REAL,
    PRIMARY KEY (`Channel_ID`, `Program_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Program_ID`) REFERENCES `program_share`.`program` (`Program_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Channel_ID`) REFERENCES `program_share`.`channel` (`Channel_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/program_share/data/broadcast_share.csv' INTO TABLE `program_share`.`broadcast_share`;



--- Database: company_1 ----------------------------------------

create database if not exists `company_1`;

drop table if exists `company_1`.`works_on`;
CREATE TABLE IF NOT EXISTS `company_1`.`works_on` (
    `Essn` INT,
    `Pno` INT,
    `Hours` REAL,
    PRIMARY KEY (`Essn`, `Pno`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/company_1/data/works_on.csv' INTO TABLE `company_1`.`works_on`;


drop table if exists `company_1`.`employee`;
CREATE TABLE IF NOT EXISTS `company_1`.`employee` (
    `Fname` STRING,
    `Minit` STRING,
    `Lname` STRING,
    `Ssn` INT,
    `Bdate` STRING,
    `Address` STRING,
    `Sex` STRING,
    `Salary` INT,
    `Super_ssn` INT,
    `Dno` INT,
    PRIMARY KEY (`Ssn`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/company_1/data/employee.csv' INTO TABLE `company_1`.`employee`;


drop table if exists `company_1`.`department`;
CREATE TABLE IF NOT EXISTS `company_1`.`department` (
    `Dname` STRING,
    `Dnumber` INT,
    `Mgr_ssn` INT,
    `Mgr_start_date` STRING,
    PRIMARY KEY (`Dnumber`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/company_1/data/department.csv' INTO TABLE `company_1`.`department`;


drop table if exists `company_1`.`project`;
CREATE TABLE IF NOT EXISTS `company_1`.`project` (
    `Pname` STRING,
    `Pnumber` INT,
    `Plocation` STRING,
    `Dnum` INT,
    PRIMARY KEY (`Pnumber`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/company_1/data/project.csv' INTO TABLE `company_1`.`project`;


drop table if exists `company_1`.`dependent`;
CREATE TABLE IF NOT EXISTS `company_1`.`dependent` (
    `Essn` INT,
    `Dependent_name` STRING,
    `Sex` STRING,
    `Bdate` STRING,
    `Relationship` STRING,
    PRIMARY KEY (`Essn`, `Dependent_name`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/company_1/data/dependent.csv' INTO TABLE `company_1`.`dependent`;


drop table if exists `company_1`.`dept_locations`;
CREATE TABLE IF NOT EXISTS `company_1`.`dept_locations` (
    `Dnumber` INT,
    `Dlocation` STRING,
    PRIMARY KEY (`Dnumber`, `Dlocation`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/company_1/data/dept_locations.csv' INTO TABLE `company_1`.`dept_locations`;



--- Database: college_2 ----------------------------------------

create database if not exists `college_2`;

drop table if exists `college_2`.`classroom`;
CREATE TABLE IF NOT EXISTS `college_2`.`classroom` (
    `building` STRING,
    `room_number` STRING,
    `capacity` NUMERIC(4,0),
    PRIMARY KEY (`building`, `room_number`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_2/data/classroom.csv' INTO TABLE `college_2`.`classroom`;


drop table if exists `college_2`.`department`;
CREATE TABLE IF NOT EXISTS `college_2`.`department` (
    `dept_name` STRING,
    `building` STRING,
    `budget` NUMERIC(12,2),
    PRIMARY KEY (`dept_name`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_2/data/department.csv' INTO TABLE `college_2`.`department`;


drop table if exists `college_2`.`course`;
CREATE TABLE IF NOT EXISTS `college_2`.`course` (
    `course_id` STRING,
    `title` STRING,
    `dept_name` STRING,
    `credits` NUMERIC(2,0),
    PRIMARY KEY (`course_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`dept_name`) REFERENCES `college_2`.`department` (`dept_name`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_2/data/course.csv' INTO TABLE `college_2`.`course`;


drop table if exists `college_2`.`instructor`;
CREATE TABLE IF NOT EXISTS `college_2`.`instructor` (
    `ID` STRING,
    `name` STRING NOT NULL,
    `dept_name` STRING,
    `salary` NUMERIC(8,2),
    PRIMARY KEY (`ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`dept_name`) REFERENCES `college_2`.`department` (`dept_name`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_2/data/instructor.csv' INTO TABLE `college_2`.`instructor`;


drop table if exists `college_2`.`section`;
CREATE TABLE IF NOT EXISTS `college_2`.`section` (
    `course_id` STRING,
    `sec_id` STRING,
    `semester` STRING,
    `year` NUMERIC(4,0),
    `building` STRING,
    `room_number` STRING,
    `time_slot_id` STRING,
    PRIMARY KEY (`course_id`, `sec_id`, `semester`, `year`) DISABLE NOVALIDATE,
    FOREIGN KEY (`building`, `room_number`) REFERENCES `college_2`.`classroom` (`building`, `room_number`) DISABLE NOVALIDATE,
    FOREIGN KEY (`course_id`) REFERENCES `college_2`.`course` (`course_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_2/data/section.csv' INTO TABLE `college_2`.`section`;


drop table if exists `college_2`.`teaches`;
CREATE TABLE IF NOT EXISTS `college_2`.`teaches` (
    `ID` STRING,
    `course_id` STRING,
    `sec_id` STRING,
    `semester` STRING,
    `year` NUMERIC(4,0),
    PRIMARY KEY (`ID`, `course_id`, `sec_id`, `semester`, `year`) DISABLE NOVALIDATE,
    FOREIGN KEY (`ID`) REFERENCES `college_2`.`instructor` (`ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`course_id`, `sec_id`, `semester`, `year`) REFERENCES `college_2`.`section` (`course_id`, `sec_id`, `semester`, `year`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_2/data/teaches.csv' INTO TABLE `college_2`.`teaches`;


drop table if exists `college_2`.`student`;
CREATE TABLE IF NOT EXISTS `college_2`.`student` (
    `ID` STRING,
    `name` STRING NOT NULL,
    `dept_name` STRING,
    `tot_cred` NUMERIC(3,0),
    PRIMARY KEY (`ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`dept_name`) REFERENCES `college_2`.`department` (`dept_name`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_2/data/student.csv' INTO TABLE `college_2`.`student`;


drop table if exists `college_2`.`takes`;
CREATE TABLE IF NOT EXISTS `college_2`.`takes` (
    `ID` STRING,
    `course_id` STRING,
    `sec_id` STRING,
    `semester` STRING,
    `year` NUMERIC(4,0),
    `grade` STRING,
    PRIMARY KEY (`ID`, `course_id`, `sec_id`, `semester`, `year`) DISABLE NOVALIDATE,
    FOREIGN KEY (`ID`) REFERENCES `college_2`.`student` (`ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`course_id`, `sec_id`, `semester`, `year`) REFERENCES `college_2`.`section` (`course_id`, `sec_id`, `semester`, `year`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_2/data/takes.csv' INTO TABLE `college_2`.`takes`;


drop table if exists `college_2`.`advisor`;
CREATE TABLE IF NOT EXISTS `college_2`.`advisor` (
    `s_ID` STRING,
    `i_ID` STRING,
    PRIMARY KEY (`s_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`s_ID`) REFERENCES `college_2`.`student` (`ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`i_ID`) REFERENCES `college_2`.`instructor` (`ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_2/data/advisor.csv' INTO TABLE `college_2`.`advisor`;


drop table if exists `college_2`.`time_slot`;
CREATE TABLE IF NOT EXISTS `college_2`.`time_slot` (
    `time_slot_id` STRING,
    `day` STRING,
    `start_hr` NUMERIC(2),
    `start_min` NUMERIC(2),
    `end_hr` NUMERIC(2),
    `end_min` NUMERIC(2),
    PRIMARY KEY (`time_slot_id`, `day`, `start_hr`, `start_min`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_2/data/time_slot.csv' INTO TABLE `college_2`.`time_slot`;


drop table if exists `college_2`.`prereq`;
CREATE TABLE IF NOT EXISTS `college_2`.`prereq` (
    `course_id` STRING,
    `prereq_id` STRING,
    PRIMARY KEY (`course_id`, `prereq_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`prereq_id`) REFERENCES `college_2`.`course` (`course_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`course_id`) REFERENCES `college_2`.`course` (`course_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_2/data/prereq.csv' INTO TABLE `college_2`.`prereq`;



--- Database: voter_2 ----------------------------------------

create database if not exists `voter_2`;

drop table if exists `voter_2`.`Student`;
CREATE TABLE IF NOT EXISTS `voter_2`.`Student` (
    `StuID` INT,
    `LName` STRING,
    `Fname` STRING,
    `Age` INT,
    `Sex` STRING,
    `Major` INT,
    `Advisor` INT,
    `city_code` STRING,
    PRIMARY KEY (`StuID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/voter_2/data/Student.csv' INTO TABLE `voter_2`.`Student`;


drop table if exists `voter_2`.`Voting_record`;
CREATE TABLE IF NOT EXISTS `voter_2`.`Voting_record` (
    `StuID` INT,
    `Registration_Date` STRING,
    `Election_Cycle` STRING,
    `President_Vote` INT,
    `Vice_President_Vote` INT,
    `Secretary_Vote` INT,
    `Treasurer_Vote` INT,
    `Class_President_Vote` INT,
    `Class_Senator_Vote` INT,
    FOREIGN KEY (`Class_Senator_Vote`) REFERENCES `voter_2`.`Student` (`StuID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Class_President_Vote`) REFERENCES `voter_2`.`Student` (`StuID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Treasurer_Vote`) REFERENCES `voter_2`.`Student` (`StuID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Secretary_Vote`) REFERENCES `voter_2`.`Student` (`StuID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Vice_President_Vote`) REFERENCES `voter_2`.`Student` (`StuID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`President_Vote`) REFERENCES `voter_2`.`Student` (`StuID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`StuID`) REFERENCES `voter_2`.`Student` (`StuID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/voter_2/data/Voting_record.csv' INTO TABLE `voter_2`.`Voting_record`;



--- Database: student_assessment ----------------------------------------

create database if not exists `student_assessment`;

drop table if exists `student_assessment`.`Addresses`;
CREATE TABLE IF NOT EXISTS `student_assessment`.`Addresses` (
    `address_id` INT NOT NULL,
    `line_1` STRING,
    `line_2` STRING,
    `city` STRING,
    `zip_postcode` CHAR(20),
    `state_province_county` STRING,
    `country` STRING,
    PRIMARY KEY (`address_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_assessment/data/Addresses.csv' INTO TABLE `student_assessment`.`Addresses`;


drop table if exists `student_assessment`.`People`;
CREATE TABLE IF NOT EXISTS `student_assessment`.`People` (
    `person_id` INT NOT NULL,
    `first_name` STRING,
    `middle_name` STRING,
    `last_name` STRING,
    `cell_mobile_number` STRING,
    `email_address` STRING,
    `login_name` STRING,
    `password` STRING,
    PRIMARY KEY (`person_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_assessment/data/People.csv' INTO TABLE `student_assessment`.`People`;


drop table if exists `student_assessment`.`Students`;
CREATE TABLE IF NOT EXISTS `student_assessment`.`Students` (
    `student_id` INT NOT NULL,
    `student_details` STRING,
    PRIMARY KEY (`student_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`student_id`) REFERENCES `student_assessment`.`People` (`person_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_assessment/data/Students.csv' INTO TABLE `student_assessment`.`Students`;


drop table if exists `student_assessment`.`Courses`;
CREATE TABLE IF NOT EXISTS `student_assessment`.`Courses` (
    `course_id` INT NOT NULL,
    `course_name` STRING,
    `course_description` STRING,
    `other_details` STRING,
    PRIMARY KEY (`course_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_assessment/data/Courses.csv' INTO TABLE `student_assessment`.`Courses`;


drop table if exists `student_assessment`.`People_Addresses`;
CREATE TABLE IF NOT EXISTS `student_assessment`.`People_Addresses` (
    `person_address_id` INT NOT NULL,
    `person_id` INT NOT NULL,
    `address_id` INT NOT NULL,
    `date_from` TIMESTAMP,
    `date_to` TIMESTAMP,
    PRIMARY KEY (`person_address_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`address_id`) REFERENCES `student_assessment`.`Addresses` (`address_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`person_id`) REFERENCES `student_assessment`.`People` (`person_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_assessment/data/People_Addresses.csv' INTO TABLE `student_assessment`.`People_Addresses`;


drop table if exists `student_assessment`.`Student_Course_Registrations`;
CREATE TABLE IF NOT EXISTS `student_assessment`.`Student_Course_Registrations` (
    `student_id` INT NOT NULL,
    `course_id` INT NOT NULL,
    `registration_date` TIMESTAMP NOT NULL,
    PRIMARY KEY (`student_id`, `course_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`course_id`) REFERENCES `student_assessment`.`Courses` (`course_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`student_id`) REFERENCES `student_assessment`.`Students` (`student_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_assessment/data/Student_Course_Registrations.csv' INTO TABLE `student_assessment`.`Student_Course_Registrations`;


drop table if exists `student_assessment`.`Student_Course_Attendance`;
CREATE TABLE IF NOT EXISTS `student_assessment`.`Student_Course_Attendance` (
    `student_id` INT NOT NULL,
    `course_id` INT NOT NULL,
    `date_of_attendance` TIMESTAMP NOT NULL,
    PRIMARY KEY (`student_id`, `course_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`student_id`, `course_id`) REFERENCES `student_assessment`.`Student_Course_Registrations` (`student_id`, `course_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_assessment/data/Student_Course_Attendance.csv' INTO TABLE `student_assessment`.`Student_Course_Attendance`;


drop table if exists `student_assessment`.`Candidates`;
CREATE TABLE IF NOT EXISTS `student_assessment`.`Candidates` (
    `candidate_id` INT NOT NULL,
    `candidate_details` STRING,
    PRIMARY KEY (`candidate_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`candidate_id`) REFERENCES `student_assessment`.`People` (`person_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_assessment/data/Candidates.csv' INTO TABLE `student_assessment`.`Candidates`;


drop table if exists `student_assessment`.`Candidate_Assessments`;
CREATE TABLE IF NOT EXISTS `student_assessment`.`Candidate_Assessments` (
    `candidate_id` INT NOT NULL,
    `qualification` CHAR(15) NOT NULL,
    `assessment_date` TIMESTAMP NOT NULL,
    `asessment_outcome_code` CHAR(15) NOT NULL,
    PRIMARY KEY (`candidate_id`, `qualification`) DISABLE NOVALIDATE,
    FOREIGN KEY (`candidate_id`) REFERENCES `student_assessment`.`Candidates` (`candidate_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_assessment/data/Candidate_Assessments.csv' INTO TABLE `student_assessment`.`Candidate_Assessments`;



--- Database: mountain_photos ----------------------------------------

create database if not exists `mountain_photos`;

drop table if exists `mountain_photos`.`mountain`;
CREATE TABLE IF NOT EXISTS `mountain_photos`.`mountain` (
    `id` INT,
    `name` STRING,
    `Height` REAL,
    `Prominence` REAL,
    `Range` STRING,
    `Country` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/mountain_photos/data/mountain.csv' INTO TABLE `mountain_photos`.`mountain`;


drop table if exists `mountain_photos`.`camera_lens`;
CREATE TABLE IF NOT EXISTS `mountain_photos`.`camera_lens` (
    `id` INT,
    `brand` STRING,
    `name` STRING,
    `focal_length_mm` REAL,
    `max_aperture` REAL,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/mountain_photos/data/camera_lens.csv' INTO TABLE `mountain_photos`.`camera_lens`;


drop table if exists `mountain_photos`.`photos`;
CREATE TABLE IF NOT EXISTS `mountain_photos`.`photos` (
    `id` INT,
    `camera_lens_id` INT,
    `mountain_id` INT,
    `color` STRING,
    `name` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`mountain_id`) REFERENCES `mountain_photos`.`mountain` (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`camera_lens_id`) REFERENCES `mountain_photos`.`camera_lens` (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/mountain_photos/data/photos.csv' INTO TABLE `mountain_photos`.`photos`;



--- Database: insurance_fnol ----------------------------------------

create database if not exists `insurance_fnol`;

drop table if exists `insurance_fnol`.`Customers`;
CREATE TABLE IF NOT EXISTS `insurance_fnol`.`Customers` (
    `Customer_ID` INT NOT NULL,
    `Customer_name` STRING,
    PRIMARY KEY (`Customer_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/insurance_fnol/data/Customers.csv' INTO TABLE `insurance_fnol`.`Customers`;


drop table if exists `insurance_fnol`.`Services`;
CREATE TABLE IF NOT EXISTS `insurance_fnol`.`Services` (
    `Service_ID` INT NOT NULL,
    `Service_name` STRING,
    PRIMARY KEY (`Service_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/insurance_fnol/data/Services.csv' INTO TABLE `insurance_fnol`.`Services`;


drop table if exists `insurance_fnol`.`Available_Policies`;
CREATE TABLE IF NOT EXISTS `insurance_fnol`.`Available_Policies` (
    `Policy_ID` INT NOT NULL,
    `policy_type_code` CHAR(15),
    `Customer_Phone` STRING,
    PRIMARY KEY (`Policy_ID`) DISABLE NOVALIDATE,
    UNIQUE (`Policy_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/insurance_fnol/data/Available_Policies.csv' INTO TABLE `insurance_fnol`.`Available_Policies`;


drop table if exists `insurance_fnol`.`Customers_Policies`;
CREATE TABLE IF NOT EXISTS `insurance_fnol`.`Customers_Policies` (
    `Customer_ID` INT NOT NULL,
    `Policy_ID` INT NOT NULL,
    `Date_Opened` DATE,
    `Date_Closed` DATE,
    PRIMARY KEY (`Customer_ID`, `Policy_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Policy_ID`) REFERENCES `insurance_fnol`.`Available_Policies` (`Policy_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Customer_ID`) REFERENCES `insurance_fnol`.`Customers` (`Customer_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/insurance_fnol/data/Customers_Policies.csv' INTO TABLE `insurance_fnol`.`Customers_Policies`;


drop table if exists `insurance_fnol`.`First_Notification_of_Loss`;
CREATE TABLE IF NOT EXISTS `insurance_fnol`.`First_Notification_of_Loss` (
    `FNOL_ID` INT NOT NULL,
    `Customer_ID` INT NOT NULL,
    `Policy_ID` INT NOT NULL,
    `Service_ID` INT NOT NULL,
    PRIMARY KEY (`FNOL_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Customer_ID`, `Policy_ID`) REFERENCES `insurance_fnol`.`Customers_Policies` (`Customer_ID`, `Policy_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Service_ID`) REFERENCES `insurance_fnol`.`Services` (`Service_ID`) DISABLE NOVALIDATE,
    UNIQUE (`FNOL_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/insurance_fnol/data/First_Notification_of_Loss.csv' INTO TABLE `insurance_fnol`.`First_Notification_of_Loss`;


drop table if exists `insurance_fnol`.`Claims`;
CREATE TABLE IF NOT EXISTS `insurance_fnol`.`Claims` (
    `Claim_ID` INT NOT NULL,
    `FNOL_ID` INT NOT NULL,
    `Effective_Date` DATE,
    PRIMARY KEY (`Claim_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`FNOL_ID`) REFERENCES `insurance_fnol`.`First_Notification_of_Loss` (`FNOL_ID`) DISABLE NOVALIDATE,
    UNIQUE (`Claim_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/insurance_fnol/data/Claims.csv' INTO TABLE `insurance_fnol`.`Claims`;


drop table if exists `insurance_fnol`.`Settlements`;
CREATE TABLE IF NOT EXISTS `insurance_fnol`.`Settlements` (
    `Settlement_ID` INT NOT NULL,
    `Claim_ID` INT,
    `Effective_Date` DATE,
    `Settlement_Amount` REAL,
    PRIMARY KEY (`Settlement_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Claim_ID`) REFERENCES `insurance_fnol`.`Claims` (`Claim_ID`) DISABLE NOVALIDATE,
    UNIQUE (`Settlement_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/insurance_fnol/data/Settlements.csv' INTO TABLE `insurance_fnol`.`Settlements`;



--- Database: race_track ----------------------------------------

create database if not exists `race_track`;

drop table if exists `race_track`.`track`;
CREATE TABLE IF NOT EXISTS `race_track`.`track` (
    `Track_ID` INT,
    `Name` STRING,
    `Location` STRING,
    `Seating` REAL,
    `Year_Opened` REAL,
    PRIMARY KEY (`Track_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/race_track/data/track.csv' INTO TABLE `race_track`.`track`;


drop table if exists `race_track`.`race`;
CREATE TABLE IF NOT EXISTS `race_track`.`race` (
    `Race_ID` INT,
    `Name` STRING,
    `Class` STRING,
    `Date` STRING,
    `Track_ID` INT,
    PRIMARY KEY (`Race_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Track_ID`) REFERENCES `race_track`.`track` (`Track_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/race_track/data/race.csv' INTO TABLE `race_track`.`race`;



--- Database: body_builder ----------------------------------------

create database if not exists `body_builder`;

drop table if exists `body_builder`.`people`;
CREATE TABLE IF NOT EXISTS `body_builder`.`people` (
    `People_ID` INT,
    `Name` STRING,
    `Height` REAL,
    `Weight` REAL,
    `Birth_Date` STRING,
    `Birth_Place` STRING,
    PRIMARY KEY (`People_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/body_builder/data/people.csv' INTO TABLE `body_builder`.`people`;


drop table if exists `body_builder`.`body_builder`;
CREATE TABLE IF NOT EXISTS `body_builder`.`body_builder` (
    `Body_Builder_ID` INT,
    `People_ID` INT,
    `Snatch` REAL,
    `Clean_Jerk` REAL,
    `Total` REAL,
    PRIMARY KEY (`Body_Builder_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`People_ID`) REFERENCES `body_builder`.`people` (`People_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/body_builder/data/body_builder.csv' INTO TABLE `body_builder`.`body_builder`;



--- Database: tracking_orders ----------------------------------------

create database if not exists `tracking_orders`;

drop table if exists `tracking_orders`.`Customers`;
CREATE TABLE IF NOT EXISTS `tracking_orders`.`Customers` (
    `customer_id` INT,
    `customer_name` STRING,
    `customer_details` STRING,
    PRIMARY KEY (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_orders/data/Customers.csv' INTO TABLE `tracking_orders`.`Customers`;


drop table if exists `tracking_orders`.`Invoices`;
CREATE TABLE IF NOT EXISTS `tracking_orders`.`Invoices` (
    `invoice_number` INT,
    `invoice_date` TIMESTAMP,
    `invoice_details` STRING,
    PRIMARY KEY (`invoice_number`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_orders/data/Invoices.csv' INTO TABLE `tracking_orders`.`Invoices`;


drop table if exists `tracking_orders`.`Orders`;
CREATE TABLE IF NOT EXISTS `tracking_orders`.`Orders` (
    `order_id` INT,
    `customer_id` INT NOT NULL,
    `order_status` STRING NOT NULL,
    `date_order_placed` TIMESTAMP NOT NULL,
    `order_details` STRING,
    PRIMARY KEY (`order_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`customer_id`) REFERENCES `tracking_orders`.`Customers` (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_orders/data/Orders.csv' INTO TABLE `tracking_orders`.`Orders`;


drop table if exists `tracking_orders`.`Products`;
CREATE TABLE IF NOT EXISTS `tracking_orders`.`Products` (
    `product_id` INT,
    `product_name` STRING,
    `product_details` STRING,
    PRIMARY KEY (`product_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_orders/data/Products.csv' INTO TABLE `tracking_orders`.`Products`;


drop table if exists `tracking_orders`.`Order_Items`;
CREATE TABLE IF NOT EXISTS `tracking_orders`.`Order_Items` (
    `order_item_id` INT,
    `product_id` INT NOT NULL,
    `order_id` INT NOT NULL,
    `order_item_status` STRING NOT NULL,
    `order_item_details` STRING,
    PRIMARY KEY (`order_item_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`product_id`) REFERENCES `tracking_orders`.`Products` (`product_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`order_id`) REFERENCES `tracking_orders`.`Orders` (`order_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_orders/data/Order_Items.csv' INTO TABLE `tracking_orders`.`Order_Items`;


drop table if exists `tracking_orders`.`Shipments`;
CREATE TABLE IF NOT EXISTS `tracking_orders`.`Shipments` (
    `shipment_id` INT,
    `order_id` INT NOT NULL,
    `invoice_number` INT NOT NULL,
    `shipment_tracking_number` STRING,
    `shipment_date` TIMESTAMP,
    `other_shipment_details` STRING,
    PRIMARY KEY (`shipment_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`invoice_number`) REFERENCES `tracking_orders`.`Invoices` (`invoice_number`) DISABLE NOVALIDATE,
    FOREIGN KEY (`order_id`) REFERENCES `tracking_orders`.`Orders` (`order_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_orders/data/Shipments.csv' INTO TABLE `tracking_orders`.`Shipments`;


drop table if exists `tracking_orders`.`Shipment_Items`;
CREATE TABLE IF NOT EXISTS `tracking_orders`.`Shipment_Items` (
    `shipment_id` INT NOT NULL,
    `order_item_id` INT NOT NULL,
    FOREIGN KEY (`shipment_id`) REFERENCES `tracking_orders`.`Shipments` (`shipment_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`order_item_id`) REFERENCES `tracking_orders`.`Order_Items` (`order_item_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_orders/data/Shipment_Items.csv' INTO TABLE `tracking_orders`.`Shipment_Items`;



--- Database: employee_hire_evaluation ----------------------------------------

create database if not exists `employee_hire_evaluation`;

drop table if exists `employee_hire_evaluation`.`employee`;
CREATE TABLE IF NOT EXISTS `employee_hire_evaluation`.`employee` (
    `Employee_ID` INT,
    `Name` STRING,
    `Age` INT,
    `City` STRING,
    PRIMARY KEY (`Employee_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/employee_hire_evaluation/data/employee.csv' INTO TABLE `employee_hire_evaluation`.`employee`;


drop table if exists `employee_hire_evaluation`.`shop`;
CREATE TABLE IF NOT EXISTS `employee_hire_evaluation`.`shop` (
    `Shop_ID` INT,
    `Name` STRING,
    `Location` STRING,
    `District` STRING,
    `Number_products` INT,
    `Manager_name` STRING,
    PRIMARY KEY (`Shop_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/employee_hire_evaluation/data/shop.csv' INTO TABLE `employee_hire_evaluation`.`shop`;


drop table if exists `employee_hire_evaluation`.`hiring`;
CREATE TABLE IF NOT EXISTS `employee_hire_evaluation`.`hiring` (
    `Shop_ID` INT,
    `Employee_ID` INT,
    `Start_from` STRING,
    `Is_full_time` BOOLEAN,
    PRIMARY KEY (`Employee_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Employee_ID`) REFERENCES `employee_hire_evaluation`.`employee` (`Employee_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Shop_ID`) REFERENCES `employee_hire_evaluation`.`shop` (`Shop_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/employee_hire_evaluation/data/hiring.csv' INTO TABLE `employee_hire_evaluation`.`hiring`;


drop table if exists `employee_hire_evaluation`.`evaluation`;
CREATE TABLE IF NOT EXISTS `employee_hire_evaluation`.`evaluation` (
    `Employee_ID` INT,
    `Year_awarded` STRING,
    `Bonus` REAL,
    PRIMARY KEY (`Employee_ID`, `Year_awarded`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Employee_ID`) REFERENCES `employee_hire_evaluation`.`employee` (`Employee_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/employee_hire_evaluation/data/evaluation.csv' INTO TABLE `employee_hire_evaluation`.`evaluation`;



--- Database: tracking_share_transactions ----------------------------------------

create database if not exists `tracking_share_transactions`;

drop table if exists `tracking_share_transactions`.`Investors`;
CREATE TABLE IF NOT EXISTS `tracking_share_transactions`.`Investors` (
    `investor_id` INT,
    `Investor_details` STRING,
    PRIMARY KEY (`investor_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_share_transactions/data/Investors.csv' INTO TABLE `tracking_share_transactions`.`Investors`;


drop table if exists `tracking_share_transactions`.`Lots`;
CREATE TABLE IF NOT EXISTS `tracking_share_transactions`.`Lots` (
    `lot_id` INT,
    `investor_id` INT NOT NULL,
    `lot_details` STRING,
    PRIMARY KEY (`lot_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`investor_id`) REFERENCES `tracking_share_transactions`.`Investors` (`investor_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_share_transactions/data/Lots.csv' INTO TABLE `tracking_share_transactions`.`Lots`;


drop table if exists `tracking_share_transactions`.`Ref_Transaction_Types`;
CREATE TABLE IF NOT EXISTS `tracking_share_transactions`.`Ref_Transaction_Types` (
    `transaction_type_code` STRING,
    `transaction_type_description` STRING NOT NULL,
    PRIMARY KEY (`transaction_type_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_share_transactions/data/Ref_Transaction_Types.csv' INTO TABLE `tracking_share_transactions`.`Ref_Transaction_Types`;


drop table if exists `tracking_share_transactions`.`Transactions`;
CREATE TABLE IF NOT EXISTS `tracking_share_transactions`.`Transactions` (
    `transaction_id` INT,
    `investor_id` INT NOT NULL,
    `transaction_type_code` STRING NOT NULL,
    `date_of_transaction` TIMESTAMP,
    `amount_of_transaction` DECIMAL(19,4),
    `share_count` STRING,
    `other_details` STRING,
    PRIMARY KEY (`transaction_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`transaction_type_code`) REFERENCES `tracking_share_transactions`.`Ref_Transaction_Types` (`transaction_type_code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`investor_id`) REFERENCES `tracking_share_transactions`.`Investors` (`investor_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_share_transactions/data/Transactions.csv' INTO TABLE `tracking_share_transactions`.`Transactions`;


drop table if exists `tracking_share_transactions`.`Sales`;
CREATE TABLE IF NOT EXISTS `tracking_share_transactions`.`Sales` (
    `sales_transaction_id` INT,
    `sales_details` STRING,
    PRIMARY KEY (`sales_transaction_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`sales_transaction_id`) REFERENCES `tracking_share_transactions`.`Transactions` (`transaction_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_share_transactions/data/Sales.csv' INTO TABLE `tracking_share_transactions`.`Sales`;


drop table if exists `tracking_share_transactions`.`Purchases`;
CREATE TABLE IF NOT EXISTS `tracking_share_transactions`.`Purchases` (
    `purchase_transaction_id` INT NOT NULL,
    `purchase_details` STRING NOT NULL,
    FOREIGN KEY (`purchase_transaction_id`) REFERENCES `tracking_share_transactions`.`Transactions` (`transaction_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_share_transactions/data/Purchases.csv' INTO TABLE `tracking_share_transactions`.`Purchases`;


drop table if exists `tracking_share_transactions`.`Transactions_Lots`;
CREATE TABLE IF NOT EXISTS `tracking_share_transactions`.`Transactions_Lots` (
    `transaction_id` INT NOT NULL,
    `lot_id` INT NOT NULL,
    FOREIGN KEY (`transaction_id`) REFERENCES `tracking_share_transactions`.`Transactions` (`transaction_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`lot_id`) REFERENCES `tracking_share_transactions`.`Lots` (`lot_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_share_transactions/data/Transactions_Lots.csv' INTO TABLE `tracking_share_transactions`.`Transactions_Lots`;



--- Database: cre_Theme_park ----------------------------------------

create database if not exists `cre_Theme_park`;

drop table if exists `cre_Theme_park`.`Ref_Hotel_Star_Ratings`;
CREATE TABLE IF NOT EXISTS `cre_Theme_park`.`Ref_Hotel_Star_Ratings` (
    `star_rating_code` CHAR(15) NOT NULL,
    `star_rating_description` STRING,
    PRIMARY KEY (`star_rating_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Theme_park/data/Ref_Hotel_Star_Ratings.csv' INTO TABLE `cre_Theme_park`.`Ref_Hotel_Star_Ratings`;


drop table if exists `cre_Theme_park`.`Locations`;
CREATE TABLE IF NOT EXISTS `cre_Theme_park`.`Locations` (
    `Location_ID` INT NOT NULL,
    `Location_Name` STRING,
    `Address` STRING,
    `Other_Details` STRING,
    PRIMARY KEY (`Location_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Theme_park/data/Locations.csv' INTO TABLE `cre_Theme_park`.`Locations`;


drop table if exists `cre_Theme_park`.`Ref_Attraction_Types`;
CREATE TABLE IF NOT EXISTS `cre_Theme_park`.`Ref_Attraction_Types` (
    `Attraction_Type_Code` CHAR(15) NOT NULL,
    `Attraction_Type_Description` STRING,
    PRIMARY KEY (`Attraction_Type_Code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Theme_park/data/Ref_Attraction_Types.csv' INTO TABLE `cre_Theme_park`.`Ref_Attraction_Types`;


drop table if exists `cre_Theme_park`.`Visitors`;
CREATE TABLE IF NOT EXISTS `cre_Theme_park`.`Visitors` (
    `Tourist_ID` INT NOT NULL,
    `Tourist_Details` STRING,
    PRIMARY KEY (`Tourist_ID`) DISABLE NOVALIDATE,
    UNIQUE (`Tourist_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Theme_park/data/Visitors.csv' INTO TABLE `cre_Theme_park`.`Visitors`;


drop table if exists `cre_Theme_park`.`Features`;
CREATE TABLE IF NOT EXISTS `cre_Theme_park`.`Features` (
    `Feature_ID` INT NOT NULL,
    `Feature_Details` STRING,
    PRIMARY KEY (`Feature_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Theme_park/data/Features.csv' INTO TABLE `cre_Theme_park`.`Features`;


drop table if exists `cre_Theme_park`.`Hotels`;
CREATE TABLE IF NOT EXISTS `cre_Theme_park`.`Hotels` (
    `hotel_id` INT NOT NULL,
    `star_rating_code` CHAR(15) NOT NULL,
    `pets_allowed_yn` CHAR(1),
    `price_range` REAL,
    `other_hotel_details` STRING,
    PRIMARY KEY (`hotel_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`star_rating_code`) REFERENCES `cre_Theme_park`.`Ref_Hotel_Star_Ratings` (`star_rating_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Theme_park/data/Hotels.csv' INTO TABLE `cre_Theme_park`.`Hotels`;


drop table if exists `cre_Theme_park`.`Tourist_Attractions`;
CREATE TABLE IF NOT EXISTS `cre_Theme_park`.`Tourist_Attractions` (
    `Tourist_Attraction_ID` INT NOT NULL,
    `Attraction_Type_Code` CHAR(15) NOT NULL,
    `Location_ID` INT NOT NULL,
    `How_to_Get_There` STRING,
    `Name` STRING,
    `Description` STRING,
    `Opening_Hours` STRING,
    `Other_Details` STRING,
    PRIMARY KEY (`Tourist_Attraction_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Attraction_Type_Code`) REFERENCES `cre_Theme_park`.`Ref_Attraction_Types` (`Attraction_Type_Code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Location_ID`) REFERENCES `cre_Theme_park`.`Locations` (`Location_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Theme_park/data/Tourist_Attractions.csv' INTO TABLE `cre_Theme_park`.`Tourist_Attractions`;


drop table if exists `cre_Theme_park`.`Street_Markets`;
CREATE TABLE IF NOT EXISTS `cre_Theme_park`.`Street_Markets` (
    `Market_ID` INT NOT NULL,
    `Market_Details` STRING,
    PRIMARY KEY (`Market_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Market_ID`) REFERENCES `cre_Theme_park`.`Tourist_Attractions` (`Tourist_Attraction_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Theme_park/data/Street_Markets.csv' INTO TABLE `cre_Theme_park`.`Street_Markets`;


drop table if exists `cre_Theme_park`.`Shops`;
CREATE TABLE IF NOT EXISTS `cre_Theme_park`.`Shops` (
    `Shop_ID` INT NOT NULL,
    `Shop_Details` STRING,
    PRIMARY KEY (`Shop_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Shop_ID`) REFERENCES `cre_Theme_park`.`Tourist_Attractions` (`Tourist_Attraction_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Theme_park/data/Shops.csv' INTO TABLE `cre_Theme_park`.`Shops`;


drop table if exists `cre_Theme_park`.`Museums`;
CREATE TABLE IF NOT EXISTS `cre_Theme_park`.`Museums` (
    `Museum_ID` INT NOT NULL,
    `Museum_Details` STRING,
    PRIMARY KEY (`Museum_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Museum_ID`) REFERENCES `cre_Theme_park`.`Tourist_Attractions` (`Tourist_Attraction_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Theme_park/data/Museums.csv' INTO TABLE `cre_Theme_park`.`Museums`;


drop table if exists `cre_Theme_park`.`Royal_Family`;
CREATE TABLE IF NOT EXISTS `cre_Theme_park`.`Royal_Family` (
    `Royal_Family_ID` INT NOT NULL,
    `Royal_Family_Details` STRING,
    PRIMARY KEY (`Royal_Family_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Royal_Family_ID`) REFERENCES `cre_Theme_park`.`Tourist_Attractions` (`Tourist_Attraction_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Theme_park/data/Royal_Family.csv' INTO TABLE `cre_Theme_park`.`Royal_Family`;


drop table if exists `cre_Theme_park`.`Theme_Parks`;
CREATE TABLE IF NOT EXISTS `cre_Theme_park`.`Theme_Parks` (
    `Theme_Park_ID` INT NOT NULL,
    `Theme_Park_Details` STRING,
    PRIMARY KEY (`Theme_Park_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Theme_Park_ID`) REFERENCES `cre_Theme_park`.`Tourist_Attractions` (`Tourist_Attraction_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Theme_park/data/Theme_Parks.csv' INTO TABLE `cre_Theme_park`.`Theme_Parks`;


drop table if exists `cre_Theme_park`.`Visits`;
CREATE TABLE IF NOT EXISTS `cre_Theme_park`.`Visits` (
    `Visit_ID` INT NOT NULL,
    `Tourist_Attraction_ID` INT NOT NULL,
    `Tourist_ID` INT NOT NULL,
    `Visit_Date` TIMESTAMP NOT NULL,
    `Visit_Details` STRING NOT NULL,
    PRIMARY KEY (`Visit_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Tourist_ID`) REFERENCES `cre_Theme_park`.`Visitors` (`Tourist_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Tourist_Attraction_ID`) REFERENCES `cre_Theme_park`.`Tourist_Attractions` (`Tourist_Attraction_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Theme_park/data/Visits.csv' INTO TABLE `cre_Theme_park`.`Visits`;


drop table if exists `cre_Theme_park`.`Photos`;
CREATE TABLE IF NOT EXISTS `cre_Theme_park`.`Photos` (
    `Photo_ID` INT NOT NULL,
    `Tourist_Attraction_ID` INT NOT NULL,
    `Name` STRING,
    `Description` STRING,
    `Filename` STRING,
    `Other_Details` STRING,
    PRIMARY KEY (`Photo_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Tourist_Attraction_ID`) REFERENCES `cre_Theme_park`.`Tourist_Attractions` (`Tourist_Attraction_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Theme_park/data/Photos.csv' INTO TABLE `cre_Theme_park`.`Photos`;


drop table if exists `cre_Theme_park`.`Staff`;
CREATE TABLE IF NOT EXISTS `cre_Theme_park`.`Staff` (
    `Staff_ID` INT NOT NULL,
    `Tourist_Attraction_ID` INT NOT NULL,
    `Name` STRING,
    `Other_Details` STRING,
    PRIMARY KEY (`Staff_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Tourist_Attraction_ID`) REFERENCES `cre_Theme_park`.`Tourist_Attractions` (`Tourist_Attraction_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Theme_park/data/Staff.csv' INTO TABLE `cre_Theme_park`.`Staff`;


drop table if exists `cre_Theme_park`.`Tourist_Attraction_Features`;
CREATE TABLE IF NOT EXISTS `cre_Theme_park`.`Tourist_Attraction_Features` (
    `Tourist_Attraction_ID` INT NOT NULL,
    `Feature_ID` INT NOT NULL,
    PRIMARY KEY (`Tourist_Attraction_ID`, `Feature_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Feature_ID`) REFERENCES `cre_Theme_park`.`Features` (`Feature_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Tourist_Attraction_ID`) REFERENCES `cre_Theme_park`.`Tourist_Attractions` (`Tourist_Attraction_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Theme_park/data/Tourist_Attraction_Features.csv' INTO TABLE `cre_Theme_park`.`Tourist_Attraction_Features`;



--- Database: customers_and_products_contacts ----------------------------------------

create database if not exists `customers_and_products_contacts`;

drop table if exists `customers_and_products_contacts`.`Addresses`;
CREATE TABLE IF NOT EXISTS `customers_and_products_contacts`.`Addresses` (
    `address_id` INT,
    `line_1_number_building` STRING,
    `city` STRING,
    `zip_postcode` STRING,
    `state_province_county` STRING,
    `country` STRING,
    PRIMARY KEY (`address_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_and_products_contacts/data/Addresses.csv' INTO TABLE `customers_and_products_contacts`.`Addresses`;


drop table if exists `customers_and_products_contacts`.`Products`;
CREATE TABLE IF NOT EXISTS `customers_and_products_contacts`.`Products` (
    `product_id` INT,
    `product_type_code` STRING,
    `product_name` STRING,
    `product_price` REAL,
    PRIMARY KEY (`product_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_and_products_contacts/data/Products.csv' INTO TABLE `customers_and_products_contacts`.`Products`;


drop table if exists `customers_and_products_contacts`.`Customers`;
CREATE TABLE IF NOT EXISTS `customers_and_products_contacts`.`Customers` (
    `customer_id` INT,
    `payment_method_code` STRING,
    `customer_number` STRING,
    `customer_name` STRING,
    `customer_address` STRING,
    `customer_phone` STRING,
    `customer_email` STRING,
    PRIMARY KEY (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_and_products_contacts/data/Customers.csv' INTO TABLE `customers_and_products_contacts`.`Customers`;


drop table if exists `customers_and_products_contacts`.`Contacts`;
CREATE TABLE IF NOT EXISTS `customers_and_products_contacts`.`Contacts` (
    `contact_id` INT,
    `customer_id` INT NOT NULL,
    `gender` STRING,
    `first_name` STRING,
    `last_name` STRING,
    `contact_phone` STRING,
    PRIMARY KEY (`contact_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_and_products_contacts/data/Contacts.csv' INTO TABLE `customers_and_products_contacts`.`Contacts`;


drop table if exists `customers_and_products_contacts`.`Customer_Address_History`;
CREATE TABLE IF NOT EXISTS `customers_and_products_contacts`.`Customer_Address_History` (
    `customer_id` INT NOT NULL,
    `address_id` INT NOT NULL,
    `date_from` TIMESTAMP NOT NULL,
    `date_to` TIMESTAMP,
    FOREIGN KEY (`address_id`) REFERENCES `customers_and_products_contacts`.`Addresses` (`address_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`customer_id`) REFERENCES `customers_and_products_contacts`.`Customers` (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_and_products_contacts/data/Customer_Address_History.csv' INTO TABLE `customers_and_products_contacts`.`Customer_Address_History`;


drop table if exists `customers_and_products_contacts`.`Customer_Orders`;
CREATE TABLE IF NOT EXISTS `customers_and_products_contacts`.`Customer_Orders` (
    `order_id` INT,
    `customer_id` INT NOT NULL,
    `order_date` TIMESTAMP NOT NULL,
    `order_status_code` STRING,
    PRIMARY KEY (`order_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`customer_id`) REFERENCES `customers_and_products_contacts`.`Customers` (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_and_products_contacts/data/Customer_Orders.csv' INTO TABLE `customers_and_products_contacts`.`Customer_Orders`;


drop table if exists `customers_and_products_contacts`.`Order_Items`;
CREATE TABLE IF NOT EXISTS `customers_and_products_contacts`.`Order_Items` (
    `order_item_id` INT NOT NULL,
    `order_id` INT NOT NULL,
    `product_id` INT NOT NULL,
    `order_quantity` STRING,
    FOREIGN KEY (`order_id`) REFERENCES `customers_and_products_contacts`.`Customer_Orders` (`order_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`product_id`) REFERENCES `customers_and_products_contacts`.`Products` (`product_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_and_products_contacts/data/Order_Items.csv' INTO TABLE `customers_and_products_contacts`.`Order_Items`;



--- Database: tracking_grants_for_research ----------------------------------------

create database if not exists `tracking_grants_for_research`;

drop table if exists `tracking_grants_for_research`.`Document_Types`;
CREATE TABLE IF NOT EXISTS `tracking_grants_for_research`.`Document_Types` (
    `document_type_code` STRING,
    `document_description` STRING NOT NULL,
    PRIMARY KEY (`document_type_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_grants_for_research/data/Document_Types.csv' INTO TABLE `tracking_grants_for_research`.`Document_Types`;


drop table if exists `tracking_grants_for_research`.`Organisation_Types`;
CREATE TABLE IF NOT EXISTS `tracking_grants_for_research`.`Organisation_Types` (
    `organisation_type` STRING,
    `organisation_type_description` STRING NOT NULL,
    PRIMARY KEY (`organisation_type`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_grants_for_research/data/Organisation_Types.csv' INTO TABLE `tracking_grants_for_research`.`Organisation_Types`;


drop table if exists `tracking_grants_for_research`.`Organisations`;
CREATE TABLE IF NOT EXISTS `tracking_grants_for_research`.`Organisations` (
    `organisation_id` INT,
    `organisation_type` STRING NOT NULL,
    `organisation_details` STRING NOT NULL,
    PRIMARY KEY (`organisation_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`organisation_type`) REFERENCES `tracking_grants_for_research`.`Organisation_Types` (`organisation_type`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_grants_for_research/data/Organisations.csv' INTO TABLE `tracking_grants_for_research`.`Organisations`;


drop table if exists `tracking_grants_for_research`.`Grants`;
CREATE TABLE IF NOT EXISTS `tracking_grants_for_research`.`Grants` (
    `grant_id` INT,
    `organisation_id` INT NOT NULL,
    `grant_amount` DECIMAL(19,4) NOT NULL,
    `grant_start_date` TIMESTAMP NOT NULL,
    `grant_end_date` TIMESTAMP NOT NULL,
    `other_details` STRING NOT NULL,
    PRIMARY KEY (`grant_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`organisation_id`) REFERENCES `tracking_grants_for_research`.`Organisations` (`organisation_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_grants_for_research/data/Grants.csv' INTO TABLE `tracking_grants_for_research`.`Grants`;


drop table if exists `tracking_grants_for_research`.`Documents`;
CREATE TABLE IF NOT EXISTS `tracking_grants_for_research`.`Documents` (
    `document_id` INT,
    `document_type_code` STRING,
    `grant_id` INT NOT NULL,
    `sent_date` TIMESTAMP NOT NULL,
    `response_received_date` TIMESTAMP NOT NULL,
    `other_details` STRING NOT NULL,
    PRIMARY KEY (`document_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`grant_id`) REFERENCES `tracking_grants_for_research`.`Grants` (`grant_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`document_type_code`) REFERENCES `tracking_grants_for_research`.`Document_Types` (`document_type_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_grants_for_research/data/Documents.csv' INTO TABLE `tracking_grants_for_research`.`Documents`;


drop table if exists `tracking_grants_for_research`.`Research_Outcomes`;
CREATE TABLE IF NOT EXISTS `tracking_grants_for_research`.`Research_Outcomes` (
    `outcome_code` STRING,
    `outcome_description` STRING NOT NULL,
    PRIMARY KEY (`outcome_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_grants_for_research/data/Research_Outcomes.csv' INTO TABLE `tracking_grants_for_research`.`Research_Outcomes`;


drop table if exists `tracking_grants_for_research`.`Research_Staff`;
CREATE TABLE IF NOT EXISTS `tracking_grants_for_research`.`Research_Staff` (
    `staff_id` INT,
    `employer_organisation_id` INT NOT NULL,
    `staff_details` STRING NOT NULL,
    PRIMARY KEY (`staff_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`employer_organisation_id`) REFERENCES `tracking_grants_for_research`.`Organisations` (`organisation_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_grants_for_research/data/Research_Staff.csv' INTO TABLE `tracking_grants_for_research`.`Research_Staff`;


drop table if exists `tracking_grants_for_research`.`Staff_Roles`;
CREATE TABLE IF NOT EXISTS `tracking_grants_for_research`.`Staff_Roles` (
    `role_code` STRING,
    `role_description` STRING NOT NULL,
    PRIMARY KEY (`role_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_grants_for_research/data/Staff_Roles.csv' INTO TABLE `tracking_grants_for_research`.`Staff_Roles`;


drop table if exists `tracking_grants_for_research`.`Projects`;
CREATE TABLE IF NOT EXISTS `tracking_grants_for_research`.`Projects` (
    `project_id` INT,
    `organisation_id` INT NOT NULL,
    `project_details` STRING NOT NULL,
    PRIMARY KEY (`project_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`organisation_id`) REFERENCES `tracking_grants_for_research`.`Organisations` (`organisation_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_grants_for_research/data/Projects.csv' INTO TABLE `tracking_grants_for_research`.`Projects`;


drop table if exists `tracking_grants_for_research`.`Project_Outcomes`;
CREATE TABLE IF NOT EXISTS `tracking_grants_for_research`.`Project_Outcomes` (
    `project_id` INT NOT NULL,
    `outcome_code` STRING NOT NULL,
    `outcome_details` STRING,
    FOREIGN KEY (`outcome_code`) REFERENCES `tracking_grants_for_research`.`Research_Outcomes` (`outcome_code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`project_id`) REFERENCES `tracking_grants_for_research`.`Projects` (`project_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_grants_for_research/data/Project_Outcomes.csv' INTO TABLE `tracking_grants_for_research`.`Project_Outcomes`;


drop table if exists `tracking_grants_for_research`.`Project_Staff`;
CREATE TABLE IF NOT EXISTS `tracking_grants_for_research`.`Project_Staff` (
    `staff_id` REAL,
    `project_id` INT NOT NULL,
    `role_code` STRING NOT NULL,
    `date_from` TIMESTAMP,
    `date_to` TIMESTAMP,
    `other_details` STRING,
    PRIMARY KEY (`staff_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`role_code`) REFERENCES `tracking_grants_for_research`.`Staff_Roles` (`role_code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`project_id`) REFERENCES `tracking_grants_for_research`.`Projects` (`project_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_grants_for_research/data/Project_Staff.csv' INTO TABLE `tracking_grants_for_research`.`Project_Staff`;


drop table if exists `tracking_grants_for_research`.`Tasks`;
CREATE TABLE IF NOT EXISTS `tracking_grants_for_research`.`Tasks` (
    `task_id` INT,
    `project_id` INT NOT NULL,
    `task_details` STRING NOT NULL,
    `eg Agree Objectives` STRING,
    PRIMARY KEY (`task_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`project_id`) REFERENCES `tracking_grants_for_research`.`Projects` (`project_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_grants_for_research/data/Tasks.csv' INTO TABLE `tracking_grants_for_research`.`Tasks`;



--- Database: city_record ----------------------------------------

create database if not exists `city_record`;

drop table if exists `city_record`.`city`;
CREATE TABLE IF NOT EXISTS `city_record`.`city` (
    `City_ID` INT,
    `City` STRING,
    `Hanzi` STRING,
    `Hanyu_Pinyin` STRING,
    `Regional_Population` INT,
    `GDP` REAL,
    PRIMARY KEY (`City_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/city_record/data/city.csv' INTO TABLE `city_record`.`city`;


drop table if exists `city_record`.`match`;
CREATE TABLE IF NOT EXISTS `city_record`.`match` (
    `Match_ID` INT,
    `Date` STRING,
    `Venue` STRING,
    `Score` STRING,
    `Result` STRING,
    `Competition` STRING,
    PRIMARY KEY (`Match_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/city_record/data/match.csv' INTO TABLE `city_record`.`match`;


drop table if exists `city_record`.`temperature`;
CREATE TABLE IF NOT EXISTS `city_record`.`temperature` (
    `City_ID` INT,
    `Jan` REAL,
    `Feb` REAL,
    `Mar` REAL,
    `Apr` REAL,
    `Jun` REAL,
    `Jul` REAL,
    `Aug` REAL,
    `Sep` REAL,
    `Oct` REAL,
    `Nov` REAL,
    `Dec` REAL,
    PRIMARY KEY (`City_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`City_ID`) REFERENCES `city_record`.`city` (`City_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/city_record/data/temperature.csv' INTO TABLE `city_record`.`temperature`;


drop table if exists `city_record`.`hosting_city`;
CREATE TABLE IF NOT EXISTS `city_record`.`hosting_city` (
    `Year` INT,
    `Match_ID` INT,
    `Host_City` INT,
    PRIMARY KEY (`Year`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Match_ID`) REFERENCES `city_record`.`match` (`Match_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Host_City`) REFERENCES `city_record`.`city` (`City_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/city_record/data/hosting_city.csv' INTO TABLE `city_record`.`hosting_city`;



--- Database: assets_maintenance ----------------------------------------

create database if not exists `assets_maintenance`;

drop table if exists `assets_maintenance`.`Third_Party_Companies`;
CREATE TABLE IF NOT EXISTS `assets_maintenance`.`Third_Party_Companies` (
    `company_id` INT,
    `company_type` STRING NOT NULL,
    `company_name` STRING,
    `company_address` STRING,
    `other_company_details` STRING,
    PRIMARY KEY (`company_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/assets_maintenance/data/Third_Party_Companies.csv' INTO TABLE `assets_maintenance`.`Third_Party_Companies`;


drop table if exists `assets_maintenance`.`Maintenance_Contracts`;
CREATE TABLE IF NOT EXISTS `assets_maintenance`.`Maintenance_Contracts` (
    `maintenance_contract_id` INT,
    `maintenance_contract_company_id` INT NOT NULL,
    `contract_start_date` TIMESTAMP,
    `contract_end_date` TIMESTAMP,
    `other_contract_details` STRING,
    PRIMARY KEY (`maintenance_contract_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`maintenance_contract_company_id`) REFERENCES `assets_maintenance`.`Third_Party_Companies` (`company_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/assets_maintenance/data/Maintenance_Contracts.csv' INTO TABLE `assets_maintenance`.`Maintenance_Contracts`;


drop table if exists `assets_maintenance`.`Parts`;
CREATE TABLE IF NOT EXISTS `assets_maintenance`.`Parts` (
    `part_id` INT,
    `part_name` STRING,
    `chargeable_yn` STRING,
    `chargeable_amount` STRING,
    `other_part_details` STRING,
    PRIMARY KEY (`part_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/assets_maintenance/data/Parts.csv' INTO TABLE `assets_maintenance`.`Parts`;


drop table if exists `assets_maintenance`.`Skills`;
CREATE TABLE IF NOT EXISTS `assets_maintenance`.`Skills` (
    `skill_id` INT,
    `skill_code` STRING,
    `skill_description` STRING,
    PRIMARY KEY (`skill_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/assets_maintenance/data/Skills.csv' INTO TABLE `assets_maintenance`.`Skills`;


drop table if exists `assets_maintenance`.`Staff`;
CREATE TABLE IF NOT EXISTS `assets_maintenance`.`Staff` (
    `staff_id` INT,
    `staff_name` STRING,
    `gender` STRING,
    `other_staff_details` STRING,
    PRIMARY KEY (`staff_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/assets_maintenance/data/Staff.csv' INTO TABLE `assets_maintenance`.`Staff`;


drop table if exists `assets_maintenance`.`Assets`;
CREATE TABLE IF NOT EXISTS `assets_maintenance`.`Assets` (
    `asset_id` INT,
    `maintenance_contract_id` INT NOT NULL,
    `supplier_company_id` INT NOT NULL,
    `asset_details` STRING,
    `asset_make` STRING,
    `asset_model` STRING,
    `asset_acquired_date` TIMESTAMP,
    `asset_disposed_date` TIMESTAMP,
    `other_asset_details` STRING,
    PRIMARY KEY (`asset_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`supplier_company_id`) REFERENCES `assets_maintenance`.`Third_Party_Companies` (`company_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`maintenance_contract_id`) REFERENCES `assets_maintenance`.`Maintenance_Contracts` (`maintenance_contract_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/assets_maintenance/data/Assets.csv' INTO TABLE `assets_maintenance`.`Assets`;


drop table if exists `assets_maintenance`.`Asset_Parts`;
CREATE TABLE IF NOT EXISTS `assets_maintenance`.`Asset_Parts` (
    `asset_id` INT NOT NULL,
    `part_id` INT NOT NULL,
    FOREIGN KEY (`asset_id`) REFERENCES `assets_maintenance`.`Assets` (`asset_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`part_id`) REFERENCES `assets_maintenance`.`Parts` (`part_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/assets_maintenance/data/Asset_Parts.csv' INTO TABLE `assets_maintenance`.`Asset_Parts`;


drop table if exists `assets_maintenance`.`Maintenance_Engineers`;
CREATE TABLE IF NOT EXISTS `assets_maintenance`.`Maintenance_Engineers` (
    `engineer_id` INT,
    `company_id` INT NOT NULL,
    `first_name` STRING,
    `last_name` STRING,
    `other_details` STRING,
    PRIMARY KEY (`engineer_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`company_id`) REFERENCES `assets_maintenance`.`Third_Party_Companies` (`company_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/assets_maintenance/data/Maintenance_Engineers.csv' INTO TABLE `assets_maintenance`.`Maintenance_Engineers`;


drop table if exists `assets_maintenance`.`Engineer_Skills`;
CREATE TABLE IF NOT EXISTS `assets_maintenance`.`Engineer_Skills` (
    `engineer_id` INT NOT NULL,
    `skill_id` INT NOT NULL,
    FOREIGN KEY (`skill_id`) REFERENCES `assets_maintenance`.`Skills` (`skill_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`engineer_id`) REFERENCES `assets_maintenance`.`Maintenance_Engineers` (`engineer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/assets_maintenance/data/Engineer_Skills.csv' INTO TABLE `assets_maintenance`.`Engineer_Skills`;


drop table if exists `assets_maintenance`.`Fault_Log`;
CREATE TABLE IF NOT EXISTS `assets_maintenance`.`Fault_Log` (
    `fault_log_entry_id` INT,
    `asset_id` INT NOT NULL,
    `recorded_by_staff_id` INT NOT NULL,
    `fault_log_entry_datetime` TIMESTAMP,
    `fault_description` STRING,
    `other_fault_details` STRING,
    PRIMARY KEY (`fault_log_entry_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`recorded_by_staff_id`) REFERENCES `assets_maintenance`.`Staff` (`staff_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`asset_id`) REFERENCES `assets_maintenance`.`Assets` (`asset_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/assets_maintenance/data/Fault_Log.csv' INTO TABLE `assets_maintenance`.`Fault_Log`;


drop table if exists `assets_maintenance`.`Engineer_Visits`;
CREATE TABLE IF NOT EXISTS `assets_maintenance`.`Engineer_Visits` (
    `engineer_visit_id` INT,
    `contact_staff_id` INT,
    `engineer_id` INT NOT NULL,
    `fault_log_entry_id` INT NOT NULL,
    `fault_status` STRING NOT NULL,
    `visit_start_datetime` TIMESTAMP,
    `visit_end_datetime` TIMESTAMP,
    `other_visit_details` STRING,
    PRIMARY KEY (`engineer_visit_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`contact_staff_id`) REFERENCES `assets_maintenance`.`Staff` (`staff_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`engineer_id`) REFERENCES `assets_maintenance`.`Maintenance_Engineers` (`engineer_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`fault_log_entry_id`) REFERENCES `assets_maintenance`.`Fault_Log` (`fault_log_entry_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/assets_maintenance/data/Engineer_Visits.csv' INTO TABLE `assets_maintenance`.`Engineer_Visits`;


drop table if exists `assets_maintenance`.`Part_Faults`;
CREATE TABLE IF NOT EXISTS `assets_maintenance`.`Part_Faults` (
    `part_fault_id` INT,
    `part_id` INT NOT NULL,
    `fault_short_name` STRING,
    `fault_description` STRING,
    `other_fault_details` STRING,
    PRIMARY KEY (`part_fault_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`part_id`) REFERENCES `assets_maintenance`.`Parts` (`part_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/assets_maintenance/data/Part_Faults.csv' INTO TABLE `assets_maintenance`.`Part_Faults`;


drop table if exists `assets_maintenance`.`Fault_Log_Parts`;
CREATE TABLE IF NOT EXISTS `assets_maintenance`.`Fault_Log_Parts` (
    `fault_log_entry_id` INT NOT NULL,
    `part_fault_id` INT NOT NULL,
    `fault_status` STRING NOT NULL,
    FOREIGN KEY (`fault_log_entry_id`) REFERENCES `assets_maintenance`.`Fault_Log` (`fault_log_entry_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`part_fault_id`) REFERENCES `assets_maintenance`.`Part_Faults` (`part_fault_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/assets_maintenance/data/Fault_Log_Parts.csv' INTO TABLE `assets_maintenance`.`Fault_Log_Parts`;


drop table if exists `assets_maintenance`.`Skills_Required_To_Fix`;
CREATE TABLE IF NOT EXISTS `assets_maintenance`.`Skills_Required_To_Fix` (
    `part_fault_id` INT NOT NULL,
    `skill_id` INT NOT NULL,
    FOREIGN KEY (`skill_id`) REFERENCES `assets_maintenance`.`Skills` (`skill_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`part_fault_id`) REFERENCES `assets_maintenance`.`Part_Faults` (`part_fault_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/assets_maintenance/data/Skills_Required_To_Fix.csv' INTO TABLE `assets_maintenance`.`Skills_Required_To_Fix`;



--- Database: music_4 ----------------------------------------

create database if not exists `music_4`;

drop table if exists `music_4`.`artist`;
CREATE TABLE IF NOT EXISTS `music_4`.`artist` (
    `Artist_ID` INT,
    `Artist` STRING,
    `Age` INT,
    `Famous_Title` STRING,
    `Famous_Release_date` STRING,
    PRIMARY KEY (`Artist_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/music_4/data/artist.csv' INTO TABLE `music_4`.`artist`;


drop table if exists `music_4`.`volume`;
CREATE TABLE IF NOT EXISTS `music_4`.`volume` (
    `Volume_ID` INT,
    `Volume_Issue` STRING,
    `Issue_Date` STRING,
    `Weeks_on_Top` REAL,
    `Song` STRING,
    `Artist_ID` INT,
    PRIMARY KEY (`Volume_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Artist_ID`) REFERENCES `music_4`.`artist` (`Artist_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/music_4/data/volume.csv' INTO TABLE `music_4`.`volume`;


drop table if exists `music_4`.`music_festival`;
CREATE TABLE IF NOT EXISTS `music_4`.`music_festival` (
    `ID` INT,
    `Music_Festival` STRING,
    `Date_of_ceremony` STRING,
    `Category` STRING,
    `Volume` INT,
    `Result` STRING,
    PRIMARY KEY (`ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Volume`) REFERENCES `music_4`.`volume` (`Volume_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/music_4/data/music_festival.csv' INTO TABLE `music_4`.`music_festival`;



--- Database: wrestler ----------------------------------------

create database if not exists `wrestler`;

drop table if exists `wrestler`.`wrestler`;
CREATE TABLE IF NOT EXISTS `wrestler`.`wrestler` (
    `Wrestler_ID` INT,
    `Name` STRING,
    `Reign` STRING,
    `Days_held` STRING,
    `Location` STRING,
    `Event` STRING,
    PRIMARY KEY (`Wrestler_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/wrestler/data/wrestler.csv' INTO TABLE `wrestler`.`wrestler`;


drop table if exists `wrestler`.`Elimination`;
CREATE TABLE IF NOT EXISTS `wrestler`.`Elimination` (
    `Elimination_ID` STRING,
    `Wrestler_ID` INT,
    `Team` STRING,
    `Eliminated_By` STRING,
    `Elimination_Move` STRING,
    `Time` STRING,
    PRIMARY KEY (`Elimination_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Wrestler_ID`) REFERENCES `wrestler`.`wrestler` (`Wrestler_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/wrestler/data/Elimination.csv' INTO TABLE `wrestler`.`Elimination`;



--- Database: customer_complaints ----------------------------------------

create database if not exists `customer_complaints`;

drop table if exists `customer_complaints`.`Staff`;
CREATE TABLE IF NOT EXISTS `customer_complaints`.`Staff` (
    `staff_id` INT,
    `gender` STRING,
    `first_name` STRING,
    `last_name` STRING,
    `email_address` STRING,
    `phone_number` STRING,
    PRIMARY KEY (`staff_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customer_complaints/data/Staff.csv' INTO TABLE `customer_complaints`.`Staff`;


drop table if exists `customer_complaints`.`Customers`;
CREATE TABLE IF NOT EXISTS `customer_complaints`.`Customers` (
    `customer_id` INT,
    `customer_type_code` STRING NOT NULL,
    `address_line_1` STRING,
    `address_line_2` STRING,
    `town_city` STRING,
    `state` STRING,
    `email_address` STRING,
    `phone_number` STRING,
    PRIMARY KEY (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customer_complaints/data/Customers.csv' INTO TABLE `customer_complaints`.`Customers`;


drop table if exists `customer_complaints`.`Products`;
CREATE TABLE IF NOT EXISTS `customer_complaints`.`Products` (
    `product_id` INT,
    `parent_product_id` INT,
    `product_category_code` STRING NOT NULL,
    `date_product_first_available` TIMESTAMP,
    `date_product_discontinued` TIMESTAMP,
    `product_name` STRING,
    `product_description` STRING,
    `product_price` DECIMAL(19,4),
    PRIMARY KEY (`product_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customer_complaints/data/Products.csv' INTO TABLE `customer_complaints`.`Products`;


drop table if exists `customer_complaints`.`Complaints`;
CREATE TABLE IF NOT EXISTS `customer_complaints`.`Complaints` (
    `complaint_id` INT NOT NULL,
    `product_id` INT NOT NULL,
    `customer_id` INT NOT NULL,
    `complaint_outcome_code` STRING NOT NULL,
    `complaint_status_code` STRING NOT NULL,
    `complaint_type_code` STRING NOT NULL,
    `date_complaint_raised` TIMESTAMP,
    `date_complaint_closed` TIMESTAMP,
    `staff_id` INT NOT NULL,
    FOREIGN KEY (`customer_id`) REFERENCES `customer_complaints`.`Customers` (`customer_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`product_id`) REFERENCES `customer_complaints`.`Products` (`product_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`staff_id`) REFERENCES `customer_complaints`.`Staff` (`staff_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customer_complaints/data/Complaints.csv' INTO TABLE `customer_complaints`.`Complaints`;



--- Database: store_product ----------------------------------------

create database if not exists `store_product`;

drop table if exists `store_product`.`product`;
CREATE TABLE IF NOT EXISTS `store_product`.`product` (
    `product_id` INT,
    `product` STRING,
    `dimensions` STRING,
    `dpi` REAL,
    `pages_per_minute_color` REAL,
    `max_page_size` STRING,
    `interface` STRING,
    PRIMARY KEY (`product_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/store_product/data/product.csv' INTO TABLE `store_product`.`product`;


drop table if exists `store_product`.`store`;
CREATE TABLE IF NOT EXISTS `store_product`.`store` (
    `Store_ID` INT,
    `Store_Name` STRING,
    `Type` STRING,
    `Area_size` REAL,
    `Number_of_product_category` REAL,
    `Ranking` INT,
    PRIMARY KEY (`Store_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/store_product/data/store.csv' INTO TABLE `store_product`.`store`;


drop table if exists `store_product`.`district`;
CREATE TABLE IF NOT EXISTS `store_product`.`district` (
    `District_ID` INT,
    `District_name` STRING,
    `Headquartered_City` STRING,
    `City_Population` REAL,
    `City_Area` REAL,
    PRIMARY KEY (`District_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/store_product/data/district.csv' INTO TABLE `store_product`.`district`;


drop table if exists `store_product`.`store_product`;
CREATE TABLE IF NOT EXISTS `store_product`.`store_product` (
    `Store_ID` INT,
    `Product_ID` INT,
    PRIMARY KEY (`Store_ID`, `Product_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Product_ID`) REFERENCES `store_product`.`product` (`Product_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Store_ID`) REFERENCES `store_product`.`store` (`Store_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/store_product/data/store_product.csv' INTO TABLE `store_product`.`store_product`;


drop table if exists `store_product`.`store_district`;
CREATE TABLE IF NOT EXISTS `store_product`.`store_district` (
    `Store_ID` INT,
    `District_ID` INT,
    PRIMARY KEY (`Store_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`District_ID`) REFERENCES `store_product`.`district` (`District_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Store_ID`) REFERENCES `store_product`.`store` (`Store_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/store_product/data/store_district.csv' INTO TABLE `store_product`.`store_district`;



--- Database: local_govt_mdm ----------------------------------------

create database if not exists `local_govt_mdm`;

drop table if exists `local_govt_mdm`.`Customer_Master_Index`;
CREATE TABLE IF NOT EXISTS `local_govt_mdm`.`Customer_Master_Index` (
    `master_customer_id` INT NOT NULL,
    `cmi_details` STRING,
    PRIMARY KEY (`master_customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/local_govt_mdm/data/Customer_Master_Index.csv' INTO TABLE `local_govt_mdm`.`Customer_Master_Index`;


drop table if exists `local_govt_mdm`.`CMI_Cross_References`;
CREATE TABLE IF NOT EXISTS `local_govt_mdm`.`CMI_Cross_References` (
    `cmi_cross_ref_id` INT NOT NULL,
    `master_customer_id` INT NOT NULL,
    `source_system_code` CHAR(15) NOT NULL,
    PRIMARY KEY (`cmi_cross_ref_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`master_customer_id`) REFERENCES `local_govt_mdm`.`Customer_Master_Index` (`master_customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/local_govt_mdm/data/CMI_Cross_References.csv' INTO TABLE `local_govt_mdm`.`CMI_Cross_References`;


drop table if exists `local_govt_mdm`.`Council_Tax`;
CREATE TABLE IF NOT EXISTS `local_govt_mdm`.`Council_Tax` (
    `council_tax_id` INT NOT NULL,
    `cmi_cross_ref_id` INT NOT NULL,
    PRIMARY KEY (`council_tax_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`cmi_cross_ref_id`) REFERENCES `local_govt_mdm`.`CMI_Cross_References` (`cmi_cross_ref_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/local_govt_mdm/data/Council_Tax.csv' INTO TABLE `local_govt_mdm`.`Council_Tax`;


drop table if exists `local_govt_mdm`.`Business_Rates`;
CREATE TABLE IF NOT EXISTS `local_govt_mdm`.`Business_Rates` (
    `business_rates_id` INT NOT NULL,
    `cmi_cross_ref_id` INT NOT NULL,
    PRIMARY KEY (`business_rates_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`cmi_cross_ref_id`) REFERENCES `local_govt_mdm`.`CMI_Cross_References` (`cmi_cross_ref_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/local_govt_mdm/data/Business_Rates.csv' INTO TABLE `local_govt_mdm`.`Business_Rates`;


drop table if exists `local_govt_mdm`.`Benefits_Overpayments`;
CREATE TABLE IF NOT EXISTS `local_govt_mdm`.`Benefits_Overpayments` (
    `council_tax_id` INT NOT NULL,
    `cmi_cross_ref_id` INT NOT NULL,
    PRIMARY KEY (`council_tax_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`cmi_cross_ref_id`) REFERENCES `local_govt_mdm`.`CMI_Cross_References` (`cmi_cross_ref_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/local_govt_mdm/data/Benefits_Overpayments.csv' INTO TABLE `local_govt_mdm`.`Benefits_Overpayments`;


drop table if exists `local_govt_mdm`.`Parking_Fines`;
CREATE TABLE IF NOT EXISTS `local_govt_mdm`.`Parking_Fines` (
    `council_tax_id` INT NOT NULL,
    `cmi_cross_ref_id` INT NOT NULL,
    PRIMARY KEY (`council_tax_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`cmi_cross_ref_id`) REFERENCES `local_govt_mdm`.`CMI_Cross_References` (`cmi_cross_ref_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/local_govt_mdm/data/Parking_Fines.csv' INTO TABLE `local_govt_mdm`.`Parking_Fines`;


drop table if exists `local_govt_mdm`.`Rent_Arrears`;
CREATE TABLE IF NOT EXISTS `local_govt_mdm`.`Rent_Arrears` (
    `council_tax_id` INT NOT NULL,
    `cmi_cross_ref_id` INT NOT NULL,
    PRIMARY KEY (`council_tax_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`cmi_cross_ref_id`) REFERENCES `local_govt_mdm`.`CMI_Cross_References` (`cmi_cross_ref_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/local_govt_mdm/data/Rent_Arrears.csv' INTO TABLE `local_govt_mdm`.`Rent_Arrears`;


drop table if exists `local_govt_mdm`.`Electoral_Register`;
CREATE TABLE IF NOT EXISTS `local_govt_mdm`.`Electoral_Register` (
    `electoral_register_id` INT NOT NULL,
    `cmi_cross_ref_id` INT NOT NULL,
    PRIMARY KEY (`electoral_register_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`cmi_cross_ref_id`) REFERENCES `local_govt_mdm`.`CMI_Cross_References` (`cmi_cross_ref_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/local_govt_mdm/data/Electoral_Register.csv' INTO TABLE `local_govt_mdm`.`Electoral_Register`;



--- Database: world_1 ----------------------------------------

create database if not exists `world_1`;

drop table if exists `world_1`.`country`;
CREATE TABLE IF NOT EXISTS `world_1`.`country` (
    `Code` CHAR(3) NOT NULL,
    `Name` CHAR(52) NOT NULL,
    `Continent` STRING NOT NULL,
    `Region` CHAR(26) NOT NULL,
    `SurfaceArea` DECIMAL(10,2) NOT NULL,
    `IndepYear` INT,
    `Population` INT NOT NULL,
    `LifeExpectancy` DECIMAL(3,1),
    `GNP` DECIMAL(10,2),
    `GNPOld` DECIMAL(10,2),
    `LocalName` CHAR(45) NOT NULL,
    `GovernmentForm` CHAR(45) NOT NULL,
    `HeadOfState` CHAR(60),
    `Capital` INT,
    `Code2` CHAR(2) NOT NULL,
    PRIMARY KEY (`Code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/world_1/data/country.csv' INTO TABLE `world_1`.`country`;


drop table if exists `world_1`.`city`;
CREATE TABLE IF NOT EXISTS `world_1`.`city` (
    `ID` INT NOT NULL,
    `Name` CHAR(35) NOT NULL,
    `CountryCode` CHAR(3) NOT NULL,
    `District` CHAR(20) NOT NULL,
    `Population` INT NOT NULL,
    PRIMARY KEY (`ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`CountryCode`) REFERENCES `world_1`.`country` (`Code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/world_1/data/city.csv' INTO TABLE `world_1`.`city`;


drop table if exists `world_1`.`countrylanguage`;
CREATE TABLE IF NOT EXISTS `world_1`.`countrylanguage` (
    `CountryCode` CHAR(3) NOT NULL,
    `Language` CHAR(30) NOT NULL,
    `IsOfficial` STRING NOT NULL,
    `Percentage` DECIMAL(4,1) NOT NULL,
    PRIMARY KEY (`CountryCode`, `Language`) DISABLE NOVALIDATE,
    FOREIGN KEY (`CountryCode`) REFERENCES `world_1`.`country` (`Code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/world_1/data/countrylanguage.csv' INTO TABLE `world_1`.`countrylanguage`;



--- Database: flight_1 ----------------------------------------

create database if not exists `flight_1`;

drop table if exists `flight_1`.`aircraft`;
CREATE TABLE IF NOT EXISTS `flight_1`.`aircraft` (
    `aid` NUMERIC(9,0),
    `name` STRING,
    `distance` NUMERIC(6,0),
    PRIMARY KEY (`aid`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/flight_1/data/aircraft.csv' INTO TABLE `flight_1`.`aircraft`;


drop table if exists `flight_1`.`flight`;
CREATE TABLE IF NOT EXISTS `flight_1`.`flight` (
    `flno` NUMERIC(4,0),
    `origin` STRING,
    `destination` STRING,
    `distance` NUMERIC(6,0),
    `departure_date` DATE,
    `arrival_date` DATE,
    `price` NUMERIC(7,2),
    `aid` NUMERIC(9,0),
    PRIMARY KEY (`flno`) DISABLE NOVALIDATE,
    FOREIGN KEY (`aid`) REFERENCES `flight_1`.`aircraft` (`aid`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/flight_1/data/flight.csv' INTO TABLE `flight_1`.`flight`;


drop table if exists `flight_1`.`employee`;
CREATE TABLE IF NOT EXISTS `flight_1`.`employee` (
    `eid` NUMERIC(9,0),
    `name` STRING,
    `salary` NUMERIC(10,2),
    PRIMARY KEY (`eid`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/flight_1/data/employee.csv' INTO TABLE `flight_1`.`employee`;


drop table if exists `flight_1`.`certificate`;
CREATE TABLE IF NOT EXISTS `flight_1`.`certificate` (
    `eid` NUMERIC(9,0),
    `aid` NUMERIC(9,0),
    PRIMARY KEY (`eid`, `aid`) DISABLE NOVALIDATE,
    FOREIGN KEY (`aid`) REFERENCES `flight_1`.`aircraft` (`aid`) DISABLE NOVALIDATE,
    FOREIGN KEY (`eid`) REFERENCES `flight_1`.`employee` (`eid`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/flight_1/data/certificate.csv' INTO TABLE `flight_1`.`certificate`;



--- Database: ship_1 ----------------------------------------

create database if not exists `ship_1`;

drop table if exists `ship_1`.`Ship`;
CREATE TABLE IF NOT EXISTS `ship_1`.`Ship` (
    `Ship_ID` INT,
    `Name` STRING,
    `Type` STRING,
    `Built_Year` REAL,
    `Class` STRING,
    `Flag` STRING,
    PRIMARY KEY (`Ship_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/ship_1/data/Ship.csv' INTO TABLE `ship_1`.`Ship`;


drop table if exists `ship_1`.`captain`;
CREATE TABLE IF NOT EXISTS `ship_1`.`captain` (
    `Captain_ID` INT,
    `Name` STRING,
    `Ship_ID` INT,
    `age` STRING,
    `Class` STRING,
    `Rank` STRING,
    PRIMARY KEY (`Captain_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Ship_ID`) REFERENCES `ship_1`.`Ship` (`Ship_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/ship_1/data/captain.csv' INTO TABLE `ship_1`.`captain`;



--- Database: climbing ----------------------------------------

create database if not exists `climbing`;

drop table if exists `climbing`.`mountain`;
CREATE TABLE IF NOT EXISTS `climbing`.`mountain` (
    `Mountain_ID` INT,
    `Name` STRING,
    `Height` REAL,
    `Prominence` REAL,
    `Range` STRING,
    `Country` STRING,
    PRIMARY KEY (`Mountain_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/climbing/data/mountain.csv' INTO TABLE `climbing`.`mountain`;


drop table if exists `climbing`.`climber`;
CREATE TABLE IF NOT EXISTS `climbing`.`climber` (
    `Climber_ID` INT,
    `Name` STRING,
    `Country` STRING,
    `Time` STRING,
    `Points` REAL,
    `Mountain_ID` INT,
    PRIMARY KEY (`Climber_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Mountain_ID`) REFERENCES `climbing`.`mountain` (`Mountain_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/climbing/data/climber.csv' INTO TABLE `climbing`.`climber`;



--- Database: game_injury ----------------------------------------

create database if not exists `game_injury`;

drop table if exists `game_injury`.`stadium`;
CREATE TABLE IF NOT EXISTS `game_injury`.`stadium` (
    `id` INT,
    `name` STRING,
    `Home_Games` INT,
    `Average_Attendance` REAL,
    `Total_Attendance` REAL,
    `Capacity_Percentage` REAL,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/game_injury/data/stadium.csv' INTO TABLE `game_injury`.`stadium`;


drop table if exists `game_injury`.`game`;
CREATE TABLE IF NOT EXISTS `game_injury`.`game` (
    `stadium_id` INT,
    `id` INT,
    `Season` INT,
    `Date` STRING,
    `Home_team` STRING,
    `Away_team` STRING,
    `Score` STRING,
    `Competition` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`stadium_id`) REFERENCES `game_injury`.`stadium` (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/game_injury/data/game.csv' INTO TABLE `game_injury`.`game`;


drop table if exists `game_injury`.`injury_accident`;
CREATE TABLE IF NOT EXISTS `game_injury`.`injury_accident` (
    `game_id` INT,
    `id` INT,
    `Player` STRING,
    `Injury` STRING,
    `Number_of_matches` STRING,
    `Source` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`game_id`) REFERENCES `game_injury`.`game` (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/game_injury/data/injury_accident.csv' INTO TABLE `game_injury`.`injury_accident`;



--- Database: school_finance ----------------------------------------

create database if not exists `school_finance`;

drop table if exists `school_finance`.`School`;
CREATE TABLE IF NOT EXISTS `school_finance`.`School` (
    `School_id` INT,
    `School_name` STRING,
    `Location` STRING,
    `Mascot` STRING,
    `Enrollment` INT,
    `IHSAA_Class` STRING,
    `IHSAA_Football_Class` STRING,
    `County` STRING,
    PRIMARY KEY (`School_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/school_finance/data/School.csv' INTO TABLE `school_finance`.`School`;


drop table if exists `school_finance`.`budget`;
CREATE TABLE IF NOT EXISTS `school_finance`.`budget` (
    `School_id` INT,
    `Year` INT,
    `Budgeted` INT,
    `total_budget_percent_budgeted` REAL,
    `Invested` INT,
    `total_budget_percent_invested` REAL,
    `Budget_invested_percent` STRING,
    PRIMARY KEY (`School_id`, `Year`) DISABLE NOVALIDATE,
    FOREIGN KEY (`School_id`) REFERENCES `school_finance`.`School` (`School_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/school_finance/data/budget.csv' INTO TABLE `school_finance`.`budget`;


drop table if exists `school_finance`.`endowment`;
CREATE TABLE IF NOT EXISTS `school_finance`.`endowment` (
    `endowment_id` INT,
    `School_id` INT,
    `donator_name` STRING,
    `amount` REAL,
    PRIMARY KEY (`endowment_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`School_id`) REFERENCES `school_finance`.`School` (`School_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/school_finance/data/endowment.csv' INTO TABLE `school_finance`.`endowment`;



--- Database: game_1 ----------------------------------------

create database if not exists `game_1`;

drop table if exists `game_1`.`Student`;
CREATE TABLE IF NOT EXISTS `game_1`.`Student` (
    `StuID` INT,
    `LName` STRING,
    `Fname` STRING,
    `Age` INT,
    `Sex` STRING,
    `Major` INT,
    `Advisor` INT,
    `city_code` STRING,
    PRIMARY KEY (`StuID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/game_1/data/Student.csv' INTO TABLE `game_1`.`Student`;


drop table if exists `game_1`.`Video_Games`;
CREATE TABLE IF NOT EXISTS `game_1`.`Video_Games` (
    `GameID` INT,
    `GName` STRING,
    `GType` STRING,
    PRIMARY KEY (`GameID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/game_1/data/Video_Games.csv' INTO TABLE `game_1`.`Video_Games`;


drop table if exists `game_1`.`Plays_Games`;
CREATE TABLE IF NOT EXISTS `game_1`.`Plays_Games` (
    `StuID` INT,
    `GameID` INT,
    `Hours_Played` INT,
    FOREIGN KEY (`StuID`) REFERENCES `game_1`.`Student` (`StuID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`GameID`) REFERENCES `game_1`.`Video_Games` (`GameID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/game_1/data/Plays_Games.csv' INTO TABLE `game_1`.`Plays_Games`;


drop table if exists `game_1`.`SportsInfo`;
CREATE TABLE IF NOT EXISTS `game_1`.`SportsInfo` (
    `StuID` INT,
    `SportName` STRING,
    `HoursPerWeek` INT,
    `GamesPlayed` INT,
    `OnScholarship` STRING,
    FOREIGN KEY (`StuID`) REFERENCES `game_1`.`Student` (`StuID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/game_1/data/SportsInfo.csv' INTO TABLE `game_1`.`SportsInfo`;



--- Database: architecture ----------------------------------------

create database if not exists `architecture`;

drop table if exists `architecture`.`architect`;
CREATE TABLE IF NOT EXISTS `architecture`.`architect` (
    `id` INT,
    `name` STRING,
    `nationality` STRING,
    `gender` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/architecture/data/architect.csv' INTO TABLE `architecture`.`architect`;


drop table if exists `architecture`.`bridge`;
CREATE TABLE IF NOT EXISTS `architecture`.`bridge` (
    `architect_id` INT,
    `id` INT,
    `name` STRING,
    `location` STRING,
    `length_meters` REAL,
    `length_feet` REAL,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`architect_id`) REFERENCES `architecture`.`architect` (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/architecture/data/bridge.csv' INTO TABLE `architecture`.`bridge`;


drop table if exists `architecture`.`mill`;
CREATE TABLE IF NOT EXISTS `architecture`.`mill` (
    `architect_id` INT,
    `id` INT,
    `location` STRING,
    `name` STRING,
    `type` STRING,
    `built_year` INT,
    `notes` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`architect_id`) REFERENCES `architecture`.`architect` (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/architecture/data/mill.csv' INTO TABLE `architecture`.`mill`;



--- Database: e_government ----------------------------------------

create database if not exists `e_government`;

drop table if exists `e_government`.`Addresses`;
CREATE TABLE IF NOT EXISTS `e_government`.`Addresses` (
    `address_id` INT,
    `line_1_number_building` STRING,
    `town_city` STRING,
    `zip_postcode` STRING,
    `state_province_county` STRING,
    `country` STRING,
    PRIMARY KEY (`address_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/e_government/data/Addresses.csv' INTO TABLE `e_government`.`Addresses`;


drop table if exists `e_government`.`Services`;
CREATE TABLE IF NOT EXISTS `e_government`.`Services` (
    `service_id` INT,
    `service_type_code` STRING NOT NULL,
    `service_name` STRING,
    `service_descriptio` STRING,
    PRIMARY KEY (`service_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/e_government/data/Services.csv' INTO TABLE `e_government`.`Services`;


drop table if exists `e_government`.`Forms`;
CREATE TABLE IF NOT EXISTS `e_government`.`Forms` (
    `form_id` INT,
    `form_type_code` STRING NOT NULL,
    `service_id` INT,
    `form_number` STRING,
    `form_name` STRING,
    `form_description` STRING,
    PRIMARY KEY (`form_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`service_id`) REFERENCES `e_government`.`Services` (`service_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/e_government/data/Forms.csv' INTO TABLE `e_government`.`Forms`;


drop table if exists `e_government`.`Individuals`;
CREATE TABLE IF NOT EXISTS `e_government`.`Individuals` (
    `individual_id` INT,
    `individual_first_name` STRING,
    `individual_middle_name` STRING,
    `inidividual_phone` STRING,
    `individual_email` STRING,
    `individual_address` STRING,
    `individual_last_name` STRING,
    PRIMARY KEY (`individual_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/e_government/data/Individuals.csv' INTO TABLE `e_government`.`Individuals`;


drop table if exists `e_government`.`Organizations`;
CREATE TABLE IF NOT EXISTS `e_government`.`Organizations` (
    `organization_id` INT,
    `date_formed` TIMESTAMP,
    `organization_name` STRING,
    `uk_vat_number` STRING,
    PRIMARY KEY (`organization_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/e_government/data/Organizations.csv' INTO TABLE `e_government`.`Organizations`;


drop table if exists `e_government`.`Parties`;
CREATE TABLE IF NOT EXISTS `e_government`.`Parties` (
    `party_id` INT,
    `payment_method_code` STRING NOT NULL,
    `party_phone` STRING,
    `party_email` STRING,
    PRIMARY KEY (`party_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/e_government/data/Parties.csv' INTO TABLE `e_government`.`Parties`;


drop table if exists `e_government`.`Organization_Contact_Individuals`;
CREATE TABLE IF NOT EXISTS `e_government`.`Organization_Contact_Individuals` (
    `individual_id` INT NOT NULL,
    `organization_id` INT NOT NULL,
    `date_contact_from` TIMESTAMP NOT NULL,
    `date_contact_to` TIMESTAMP,
    PRIMARY KEY (`individual_id`, `organization_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`individual_id`) REFERENCES `e_government`.`Individuals` (`individual_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`organization_id`) REFERENCES `e_government`.`Organizations` (`organization_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/e_government/data/Organization_Contact_Individuals.csv' INTO TABLE `e_government`.`Organization_Contact_Individuals`;


drop table if exists `e_government`.`Party_Addresses`;
CREATE TABLE IF NOT EXISTS `e_government`.`Party_Addresses` (
    `party_id` INT NOT NULL,
    `address_id` INT NOT NULL,
    `date_address_from` TIMESTAMP NOT NULL,
    `address_type_code` STRING NOT NULL,
    `date_address_to` TIMESTAMP,
    PRIMARY KEY (`party_id`, `address_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`party_id`) REFERENCES `e_government`.`Parties` (`party_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`address_id`) REFERENCES `e_government`.`Addresses` (`address_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/e_government/data/Party_Addresses.csv' INTO TABLE `e_government`.`Party_Addresses`;


drop table if exists `e_government`.`Party_Forms`;
CREATE TABLE IF NOT EXISTS `e_government`.`Party_Forms` (
    `party_id` INT NOT NULL,
    `form_id` INT NOT NULL,
    `date_completion_started` TIMESTAMP NOT NULL,
    `form_status_code` STRING NOT NULL,
    `date_fully_completed` TIMESTAMP,
    PRIMARY KEY (`party_id`, `form_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`form_id`) REFERENCES `e_government`.`Forms` (`form_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`party_id`) REFERENCES `e_government`.`Parties` (`party_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/e_government/data/Party_Forms.csv' INTO TABLE `e_government`.`Party_Forms`;


drop table if exists `e_government`.`Party_Services`;
CREATE TABLE IF NOT EXISTS `e_government`.`Party_Services` (
    `booking_id` INT NOT NULL,
    `customer_id` INT NOT NULL,
    `service_id` INT NOT NULL,
    `service_datetime` TIMESTAMP NOT NULL,
    `booking_made_date` TIMESTAMP,
    FOREIGN KEY (`customer_id`) REFERENCES `e_government`.`Parties` (`party_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`service_id`) REFERENCES `e_government`.`Services` (`service_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/e_government/data/Party_Services.csv' INTO TABLE `e_government`.`Party_Services`;



--- Database: college_1 ----------------------------------------

create database if not exists `college_1`;

drop table if exists `college_1`.`EMPLOYEE`;
CREATE TABLE IF NOT EXISTS `college_1`.`EMPLOYEE` (
    `EMP_NUM` INT,
    `EMP_LNAME` STRING,
    `EMP_FNAME` STRING,
    `EMP_INITIAL` STRING,
    `EMP_JOBCODE` STRING,
    `EMP_HIREDATE` TIMESTAMP,
    `EMP_DOB` TIMESTAMP,
    PRIMARY KEY (`EMP_NUM`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_1/data/EMPLOYEE.csv' INTO TABLE `college_1`.`EMPLOYEE`;


drop table if exists `college_1`.`DEPARTMENT`;
CREATE TABLE IF NOT EXISTS `college_1`.`DEPARTMENT` (
    `DEPT_CODE` STRING,
    `DEPT_NAME` STRING,
    `SCHOOL_CODE` STRING,
    `EMP_NUM` INT,
    `DEPT_ADDRESS` STRING,
    `DEPT_EXTENSION` STRING,
    PRIMARY KEY (`DEPT_CODE`) DISABLE NOVALIDATE,
    FOREIGN KEY (`EMP_NUM`) REFERENCES `college_1`.`EMPLOYEE` (`EMP_NUM`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_1/data/DEPARTMENT.csv' INTO TABLE `college_1`.`DEPARTMENT`;


drop table if exists `college_1`.`COURSE`;
CREATE TABLE IF NOT EXISTS `college_1`.`COURSE` (
    `CRS_CODE` STRING,
    `DEPT_CODE` STRING,
    `CRS_DESCRIPTION` STRING,
    `CRS_CREDIT` DECIMAL(8),
    PRIMARY KEY (`CRS_CODE`) DISABLE NOVALIDATE,
    FOREIGN KEY (`DEPT_CODE`) REFERENCES `college_1`.`DEPARTMENT` (`DEPT_CODE`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_1/data/COURSE.csv' INTO TABLE `college_1`.`COURSE`;


drop table if exists `college_1`.`CLASS`;
CREATE TABLE IF NOT EXISTS `college_1`.`CLASS` (
    `CLASS_CODE` STRING,
    `CRS_CODE` STRING,
    `CLASS_SECTION` STRING,
    `CLASS_TIME` STRING,
    `CLASS_ROOM` STRING,
    `PROF_NUM` INT,
    PRIMARY KEY (`CLASS_CODE`) DISABLE NOVALIDATE,
    FOREIGN KEY (`PROF_NUM`) REFERENCES `college_1`.`EMPLOYEE` (`EMP_NUM`) DISABLE NOVALIDATE,
    FOREIGN KEY (`CRS_CODE`) REFERENCES `college_1`.`COURSE` (`CRS_CODE`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_1/data/CLASS.csv' INTO TABLE `college_1`.`CLASS`;


drop table if exists `college_1`.`STUDENT`;
CREATE TABLE IF NOT EXISTS `college_1`.`STUDENT` (
    `STU_NUM` INT,
    `STU_LNAME` STRING,
    `STU_FNAME` STRING,
    `STU_INIT` STRING,
    `STU_DOB` TIMESTAMP,
    `STU_HRS` INT,
    `STU_CLASS` STRING,
    `STU_GPA` DECIMAL(8),
    `STU_TRANSFER` NUMERIC,
    `DEPT_CODE` STRING,
    `STU_PHONE` STRING,
    `PROF_NUM` INT,
    PRIMARY KEY (`STU_NUM`) DISABLE NOVALIDATE,
    FOREIGN KEY (`DEPT_CODE`) REFERENCES `college_1`.`DEPARTMENT` (`DEPT_CODE`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_1/data/STUDENT.csv' INTO TABLE `college_1`.`STUDENT`;


drop table if exists `college_1`.`ENROLL`;
CREATE TABLE IF NOT EXISTS `college_1`.`ENROLL` (
    `CLASS_CODE` STRING,
    `STU_NUM` INT,
    `ENROLL_GRADE` STRING,
    FOREIGN KEY (`STU_NUM`) REFERENCES `college_1`.`STUDENT` (`STU_NUM`) DISABLE NOVALIDATE,
    FOREIGN KEY (`CLASS_CODE`) REFERENCES `college_1`.`CLASS` (`CLASS_CODE`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_1/data/ENROLL.csv' INTO TABLE `college_1`.`ENROLL`;


drop table if exists `college_1`.`PROFESSOR`;
CREATE TABLE IF NOT EXISTS `college_1`.`PROFESSOR` (
    `EMP_NUM` INT,
    `DEPT_CODE` STRING,
    `PROF_OFFICE` STRING,
    `PROF_EXTENSION` STRING,
    `PROF_HIGH_DEGREE` STRING,
    FOREIGN KEY (`DEPT_CODE`) REFERENCES `college_1`.`DEPARTMENT` (`DEPT_CODE`) DISABLE NOVALIDATE,
    FOREIGN KEY (`EMP_NUM`) REFERENCES `college_1`.`EMPLOYEE` (`EMP_NUM`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_1/data/PROFESSOR.csv' INTO TABLE `college_1`.`PROFESSOR`;



--- Database: tracking_software_problems ----------------------------------------

create database if not exists `tracking_software_problems`;

drop table if exists `tracking_software_problems`.`Problem_Category_Codes`;
CREATE TABLE IF NOT EXISTS `tracking_software_problems`.`Problem_Category_Codes` (
    `problem_category_code` STRING,
    `problem_category_description` STRING,
    PRIMARY KEY (`problem_category_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_software_problems/data/Problem_Category_Codes.csv' INTO TABLE `tracking_software_problems`.`Problem_Category_Codes`;


drop table if exists `tracking_software_problems`.`Problem_Status_Codes`;
CREATE TABLE IF NOT EXISTS `tracking_software_problems`.`Problem_Status_Codes` (
    `problem_status_code` STRING,
    `problem_status_description` STRING,
    PRIMARY KEY (`problem_status_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_software_problems/data/Problem_Status_Codes.csv' INTO TABLE `tracking_software_problems`.`Problem_Status_Codes`;


drop table if exists `tracking_software_problems`.`Staff`;
CREATE TABLE IF NOT EXISTS `tracking_software_problems`.`Staff` (
    `staff_id` INT,
    `staff_first_name` STRING,
    `staff_last_name` STRING,
    `other_staff_details` STRING,
    PRIMARY KEY (`staff_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_software_problems/data/Staff.csv' INTO TABLE `tracking_software_problems`.`Staff`;


drop table if exists `tracking_software_problems`.`Product`;
CREATE TABLE IF NOT EXISTS `tracking_software_problems`.`Product` (
    `product_id` INT,
    `product_name` STRING,
    `product_details` STRING,
    PRIMARY KEY (`product_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_software_problems/data/Product.csv' INTO TABLE `tracking_software_problems`.`Product`;


drop table if exists `tracking_software_problems`.`Problems`;
CREATE TABLE IF NOT EXISTS `tracking_software_problems`.`Problems` (
    `problem_id` INT,
    `product_id` INT NOT NULL,
    `closure_authorised_by_staff_id` INT NOT NULL,
    `reported_by_staff_id` INT NOT NULL,
    `date_problem_reported` TIMESTAMP NOT NULL,
    `date_problem_closed` TIMESTAMP,
    `problem_description` STRING,
    `other_problem_details` STRING,
    PRIMARY KEY (`problem_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`reported_by_staff_id`) REFERENCES `tracking_software_problems`.`Staff` (`staff_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`product_id`) REFERENCES `tracking_software_problems`.`Product` (`product_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`closure_authorised_by_staff_id`) REFERENCES `tracking_software_problems`.`Staff` (`staff_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_software_problems/data/Problems.csv' INTO TABLE `tracking_software_problems`.`Problems`;


drop table if exists `tracking_software_problems`.`Problem_Log`;
CREATE TABLE IF NOT EXISTS `tracking_software_problems`.`Problem_Log` (
    `problem_log_id` INT,
    `assigned_to_staff_id` INT NOT NULL,
    `problem_id` INT NOT NULL,
    `problem_category_code` STRING NOT NULL,
    `problem_status_code` STRING NOT NULL,
    `log_entry_date` TIMESTAMP,
    `log_entry_description` STRING,
    `log_entry_fix` STRING,
    `other_log_details` STRING,
    PRIMARY KEY (`problem_log_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`problem_status_code`) REFERENCES `tracking_software_problems`.`Problem_Status_Codes` (`problem_status_code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`problem_id`) REFERENCES `tracking_software_problems`.`Problems` (`problem_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`assigned_to_staff_id`) REFERENCES `tracking_software_problems`.`Staff` (`staff_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`problem_category_code`) REFERENCES `tracking_software_problems`.`Problem_Category_Codes` (`problem_category_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tracking_software_problems/data/Problem_Log.csv' INTO TABLE `tracking_software_problems`.`Problem_Log`;



--- Database: farm ----------------------------------------

create database if not exists `farm`;

drop table if exists `farm`.`city`;
CREATE TABLE IF NOT EXISTS `farm`.`city` (
    `City_ID` INT,
    `Official_Name` STRING,
    `Status` STRING,
    `Area_km_2` REAL,
    `Population` REAL,
    `Census_Ranking` STRING,
    PRIMARY KEY (`City_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/farm/data/city.csv' INTO TABLE `farm`.`city`;


drop table if exists `farm`.`farm`;
CREATE TABLE IF NOT EXISTS `farm`.`farm` (
    `Farm_ID` INT,
    `Year` INT,
    `Total_Horses` REAL,
    `Working_Horses` REAL,
    `Total_Cattle` REAL,
    `Oxen` REAL,
    `Bulls` REAL,
    `Cows` REAL,
    `Pigs` REAL,
    `Sheep_and_Goats` REAL,
    PRIMARY KEY (`Farm_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/farm/data/farm.csv' INTO TABLE `farm`.`farm`;


drop table if exists `farm`.`farm_competition`;
CREATE TABLE IF NOT EXISTS `farm`.`farm_competition` (
    `Competition_ID` INT,
    `Year` INT,
    `Theme` STRING,
    `Host_city_ID` INT,
    `Hosts` STRING,
    PRIMARY KEY (`Competition_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Host_city_ID`) REFERENCES `farm`.`city` (`City_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/farm/data/farm_competition.csv' INTO TABLE `farm`.`farm_competition`;


drop table if exists `farm`.`competition_record`;
CREATE TABLE IF NOT EXISTS `farm`.`competition_record` (
    `Competition_ID` INT,
    `Farm_ID` INT,
    `Rank` INT,
    PRIMARY KEY (`Competition_ID`, `Farm_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Farm_ID`) REFERENCES `farm`.`farm` (`Farm_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Competition_ID`) REFERENCES `farm`.`farm_competition` (`Competition_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/farm/data/competition_record.csv' INTO TABLE `farm`.`competition_record`;



--- Database: culture_company ----------------------------------------

create database if not exists `culture_company`;

drop table if exists `culture_company`.`book_club`;
CREATE TABLE IF NOT EXISTS `culture_company`.`book_club` (
    `book_club_id` INT,
    `Year` INT,
    `Author_or_Editor` STRING,
    `Book_Title` STRING,
    `Publisher` STRING,
    `Category` STRING,
    `Result` STRING,
    PRIMARY KEY (`book_club_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/culture_company/data/book_club.csv' INTO TABLE `culture_company`.`book_club`;


drop table if exists `culture_company`.`movie`;
CREATE TABLE IF NOT EXISTS `culture_company`.`movie` (
    `movie_id` INT,
    `Title` STRING,
    `Year` INT,
    `Director` STRING,
    `Budget_million` REAL,
    `Gross_worldwide` INT,
    PRIMARY KEY (`movie_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/culture_company/data/movie.csv' INTO TABLE `culture_company`.`movie`;


drop table if exists `culture_company`.`culture_company`;
CREATE TABLE IF NOT EXISTS `culture_company`.`culture_company` (
    `Company_name` STRING,
    `Type` STRING,
    `Incorporated_in` STRING,
    `Group_Equity_Shareholding` REAL,
    `book_club_id` INT,
    `movie_id` INT,
    PRIMARY KEY (`Company_name`) DISABLE NOVALIDATE,
    FOREIGN KEY (`movie_id`) REFERENCES `culture_company`.`movie` (`movie_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`book_club_id`) REFERENCES `culture_company`.`book_club` (`book_club_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/culture_company/data/culture_company.csv' INTO TABLE `culture_company`.`culture_company`;



--- Database: pilot_record ----------------------------------------

create database if not exists `pilot_record`;

drop table if exists `pilot_record`.`aircraft`;
CREATE TABLE IF NOT EXISTS `pilot_record`.`aircraft` (
    `Aircraft_ID` INT,
    `Order_Year` INT,
    `Manufacturer` STRING,
    `Model` STRING,
    `Fleet_Series` STRING,
    `Powertrain` STRING,
    `Fuel_Propulsion` STRING,
    PRIMARY KEY (`Aircraft_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/pilot_record/data/aircraft.csv' INTO TABLE `pilot_record`.`aircraft`;


drop table if exists `pilot_record`.`pilot`;
CREATE TABLE IF NOT EXISTS `pilot_record`.`pilot` (
    `Pilot_ID` INT,
    `Pilot_name` STRING,
    `Rank` INT,
    `Age` INT,
    `Nationality` STRING,
    `Position` STRING,
    `Join_Year` INT,
    `Team` STRING,
    PRIMARY KEY (`Pilot_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/pilot_record/data/pilot.csv' INTO TABLE `pilot_record`.`pilot`;


drop table if exists `pilot_record`.`pilot_record`;
CREATE TABLE IF NOT EXISTS `pilot_record`.`pilot_record` (
    `Record_ID` INT,
    `Pilot_ID` INT,
    `Aircraft_ID` INT,
    `Date` STRING,
    PRIMARY KEY (`Pilot_ID`, `Aircraft_ID`, `Date`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Aircraft_ID`) REFERENCES `pilot_record`.`aircraft` (`Aircraft_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Pilot_ID`) REFERENCES `pilot_record`.`pilot` (`Pilot_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/pilot_record/data/pilot_record.csv' INTO TABLE `pilot_record`.`pilot_record`;



--- Database: school_bus ----------------------------------------

create database if not exists `school_bus`;

drop table if exists `school_bus`.`driver`;
CREATE TABLE IF NOT EXISTS `school_bus`.`driver` (
    `Driver_ID` INT,
    `Name` STRING,
    `Party` STRING,
    `Home_city` STRING,
    `Age` INT,
    PRIMARY KEY (`Driver_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/school_bus/data/driver.csv' INTO TABLE `school_bus`.`driver`;


drop table if exists `school_bus`.`school`;
CREATE TABLE IF NOT EXISTS `school_bus`.`school` (
    `School_ID` INT,
    `Grade` STRING,
    `School` STRING,
    `Location` STRING,
    `Type` STRING,
    PRIMARY KEY (`School_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/school_bus/data/school.csv' INTO TABLE `school_bus`.`school`;


drop table if exists `school_bus`.`school_bus`;
CREATE TABLE IF NOT EXISTS `school_bus`.`school_bus` (
    `School_ID` INT,
    `Driver_ID` INT,
    `Years_Working` INT,
    `If_full_time` BOOLEAN,
    PRIMARY KEY (`School_ID`, `Driver_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Driver_ID`) REFERENCES `school_bus`.`driver` (`Driver_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`School_ID`) REFERENCES `school_bus`.`school` (`School_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/school_bus/data/school_bus.csv' INTO TABLE `school_bus`.`school_bus`;



--- Database: inn_1 ----------------------------------------

create database if not exists `inn_1`;

drop table if exists `inn_1`.`Rooms`;
CREATE TABLE IF NOT EXISTS `inn_1`.`Rooms` (
    `RoomId` STRING,
    `roomName` STRING,
    `beds` INT,
    `bedType` STRING,
    `maxOccupancy` INT,
    `basePrice` INT,
    `decor` STRING,
    PRIMARY KEY (`RoomId`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/inn_1/data/Rooms.csv' INTO TABLE `inn_1`.`Rooms`;


drop table if exists `inn_1`.`Reservations`;
CREATE TABLE IF NOT EXISTS `inn_1`.`Reservations` (
    `Code` INT,
    `Room` STRING,
    `CheckIn` STRING,
    `CheckOut` STRING,
    `Rate` REAL,
    `LastName` STRING,
    `FirstName` STRING,
    `Adults` INT,
    `Kids` INT,
    PRIMARY KEY (`Code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Room`) REFERENCES `inn_1`.`Rooms` (`RoomId`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/inn_1/data/Reservations.csv' INTO TABLE `inn_1`.`Reservations`;



--- Database: local_govt_and_lot ----------------------------------------

create database if not exists `local_govt_and_lot`;

drop table if exists `local_govt_and_lot`.`Customers`;
CREATE TABLE IF NOT EXISTS `local_govt_and_lot`.`Customers` (
    `customer_id` INT NOT NULL,
    `customer_details` STRING,
    PRIMARY KEY (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/local_govt_and_lot/data/Customers.csv' INTO TABLE `local_govt_and_lot`.`Customers`;


drop table if exists `local_govt_and_lot`.`Properties`;
CREATE TABLE IF NOT EXISTS `local_govt_and_lot`.`Properties` (
    `property_id` INT NOT NULL,
    `property_type_code` CHAR(15) NOT NULL,
    `property_address` STRING,
    `other_details` STRING,
    PRIMARY KEY (`property_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/local_govt_and_lot/data/Properties.csv' INTO TABLE `local_govt_and_lot`.`Properties`;


drop table if exists `local_govt_and_lot`.`Residents`;
CREATE TABLE IF NOT EXISTS `local_govt_and_lot`.`Residents` (
    `resident_id` INT NOT NULL,
    `property_id` INT NOT NULL,
    `date_moved_in` TIMESTAMP NOT NULL,
    `date_moved_out` TIMESTAMP NOT NULL,
    `other_details` STRING,
    PRIMARY KEY (`resident_id`, `property_id`, `date_moved_in`) DISABLE NOVALIDATE,
    FOREIGN KEY (`property_id`) REFERENCES `local_govt_and_lot`.`Properties` (`property_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/local_govt_and_lot/data/Residents.csv' INTO TABLE `local_govt_and_lot`.`Residents`;


drop table if exists `local_govt_and_lot`.`Organizations`;
CREATE TABLE IF NOT EXISTS `local_govt_and_lot`.`Organizations` (
    `organization_id` INT NOT NULL,
    `parent_organization_id` INT,
    `organization_details` STRING,
    PRIMARY KEY (`organization_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/local_govt_and_lot/data/Organizations.csv' INTO TABLE `local_govt_and_lot`.`Organizations`;


drop table if exists `local_govt_and_lot`.`Services`;
CREATE TABLE IF NOT EXISTS `local_govt_and_lot`.`Services` (
    `service_id` INT NOT NULL,
    `organization_id` INT NOT NULL,
    `service_type_code` CHAR(15) NOT NULL,
    `service_details` STRING,
    PRIMARY KEY (`service_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`organization_id`) REFERENCES `local_govt_and_lot`.`Organizations` (`organization_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/local_govt_and_lot/data/Services.csv' INTO TABLE `local_govt_and_lot`.`Services`;


drop table if exists `local_govt_and_lot`.`Residents_Services`;
CREATE TABLE IF NOT EXISTS `local_govt_and_lot`.`Residents_Services` (
    `resident_id` INT NOT NULL,
    `service_id` INT NOT NULL,
    `date_moved_in` TIMESTAMP,
    `property_id` INT,
    `date_requested` TIMESTAMP,
    `date_provided` TIMESTAMP,
    `other_details` STRING,
    PRIMARY KEY (`resident_id`, `service_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`resident_id`, `property_id`, `date_moved_in`) REFERENCES `local_govt_and_lot`.`Residents` (`resident_id`, `property_id`, `date_moved_in`) DISABLE NOVALIDATE,
    FOREIGN KEY (`service_id`) REFERENCES `local_govt_and_lot`.`Services` (`service_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/local_govt_and_lot/data/Residents_Services.csv' INTO TABLE `local_govt_and_lot`.`Residents_Services`;


drop table if exists `local_govt_and_lot`.`Things`;
CREATE TABLE IF NOT EXISTS `local_govt_and_lot`.`Things` (
    `thing_id` INT NOT NULL,
    `organization_id` INT NOT NULL,
    `Type_of_Thing_Code` CHAR(15) NOT NULL,
    `service_type_code` CHAR(10) NOT NULL,
    `service_details` STRING,
    PRIMARY KEY (`thing_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`organization_id`) REFERENCES `local_govt_and_lot`.`Organizations` (`organization_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/local_govt_and_lot/data/Things.csv' INTO TABLE `local_govt_and_lot`.`Things`;


drop table if exists `local_govt_and_lot`.`Customer_Events`;
CREATE TABLE IF NOT EXISTS `local_govt_and_lot`.`Customer_Events` (
    `Customer_Event_ID` INT NOT NULL,
    `customer_id` INT,
    `date_moved_in` TIMESTAMP,
    `property_id` INT,
    `resident_id` INT,
    `thing_id` INT NOT NULL,
    PRIMARY KEY (`Customer_Event_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`resident_id`, `property_id`, `date_moved_in`) REFERENCES `local_govt_and_lot`.`Residents` (`resident_id`, `property_id`, `date_moved_in`) DISABLE NOVALIDATE,
    FOREIGN KEY (`customer_id`) REFERENCES `local_govt_and_lot`.`Customers` (`customer_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`thing_id`) REFERENCES `local_govt_and_lot`.`Things` (`thing_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/local_govt_and_lot/data/Customer_Events.csv' INTO TABLE `local_govt_and_lot`.`Customer_Events`;


drop table if exists `local_govt_and_lot`.`Customer_Event_Notes`;
CREATE TABLE IF NOT EXISTS `local_govt_and_lot`.`Customer_Event_Notes` (
    `Customer_Event_Note_ID` INT NOT NULL,
    `Customer_Event_ID` INT NOT NULL,
    `service_type_code` CHAR(15) NOT NULL,
    `resident_id` INT NOT NULL,
    `property_id` INT NOT NULL,
    `date_moved_in` TIMESTAMP NOT NULL,
    PRIMARY KEY (`Customer_Event_Note_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Customer_Event_ID`) REFERENCES `local_govt_and_lot`.`Customer_Events` (`Customer_Event_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/local_govt_and_lot/data/Customer_Event_Notes.csv' INTO TABLE `local_govt_and_lot`.`Customer_Event_Notes`;


drop table if exists `local_govt_and_lot`.`Timed_Status_of_Things`;
CREATE TABLE IF NOT EXISTS `local_govt_and_lot`.`Timed_Status_of_Things` (
    `thing_id` INT NOT NULL,
    `Date_and_Date` TIMESTAMP NOT NULL,
    `Status_of_Thing_Code` CHAR(15) NOT NULL,
    PRIMARY KEY (`thing_id`, `Date_and_Date`, `Status_of_Thing_Code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`thing_id`) REFERENCES `local_govt_and_lot`.`Things` (`thing_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/local_govt_and_lot/data/Timed_Status_of_Things.csv' INTO TABLE `local_govt_and_lot`.`Timed_Status_of_Things`;


drop table if exists `local_govt_and_lot`.`Timed_Locations_of_Things`;
CREATE TABLE IF NOT EXISTS `local_govt_and_lot`.`Timed_Locations_of_Things` (
    `thing_id` INT NOT NULL,
    `Date_and_Time` TIMESTAMP NOT NULL,
    `Location_Code` CHAR(15) NOT NULL,
    PRIMARY KEY (`thing_id`, `Date_and_Time`, `Location_Code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`thing_id`) REFERENCES `local_govt_and_lot`.`Things` (`thing_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/local_govt_and_lot/data/Timed_Locations_of_Things.csv' INTO TABLE `local_govt_and_lot`.`Timed_Locations_of_Things`;



--- Database: aircraft ----------------------------------------

create database if not exists `aircraft`;

drop table if exists `aircraft`.`pilot`;
CREATE TABLE IF NOT EXISTS `aircraft`.`pilot` (
    `Pilot_Id` INT NOT NULL,
    `Name` STRING NOT NULL,
    `Age` INT NOT NULL,
    PRIMARY KEY (`Pilot_Id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/aircraft/data/pilot.csv' INTO TABLE `aircraft`.`pilot`;


drop table if exists `aircraft`.`aircraft`;
CREATE TABLE IF NOT EXISTS `aircraft`.`aircraft` (
    `Aircraft_ID` INT NOT NULL,
    `Aircraft` STRING NOT NULL,
    `Description` STRING NOT NULL,
    `Max_Gross_Weight` STRING NOT NULL,
    `Total_disk_area` STRING NOT NULL,
    `Max_disk_Loading` STRING NOT NULL,
    PRIMARY KEY (`Aircraft_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/aircraft/data/aircraft.csv' INTO TABLE `aircraft`.`aircraft`;


drop table if exists `aircraft`.`match`;
CREATE TABLE IF NOT EXISTS `aircraft`.`match` (
    `Round` REAL,
    `Location` STRING,
    `Country` STRING,
    `Date` STRING,
    `Fastest_Qualifying` STRING,
    `Winning_Pilot` INT,
    `Winning_Aircraft` INT,
    PRIMARY KEY (`Round`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Winning_Pilot`) REFERENCES `aircraft`.`pilot` (`Pilot_Id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Winning_Aircraft`) REFERENCES `aircraft`.`aircraft` (`Aircraft_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/aircraft/data/match.csv' INTO TABLE `aircraft`.`match`;


drop table if exists `aircraft`.`airport`;
CREATE TABLE IF NOT EXISTS `aircraft`.`airport` (
    `Airport_ID` INT,
    `Airport_Name` STRING,
    `Total_Passengers` REAL,
    `%_Change_2007` STRING,
    `International_Passengers` REAL,
    `Domestic_Passengers` REAL,
    `Transit_Passengers` REAL,
    `Aircraft_Movements` REAL,
    `Freight_Metric_Tonnes` REAL,
    PRIMARY KEY (`Airport_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/aircraft/data/airport.csv' INTO TABLE `aircraft`.`airport`;


drop table if exists `aircraft`.`airport_aircraft`;
CREATE TABLE IF NOT EXISTS `aircraft`.`airport_aircraft` (
    `ID` INT,
    `Airport_ID` INT,
    `Aircraft_ID` INT,
    PRIMARY KEY (`Airport_ID`, `Aircraft_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Aircraft_ID`) REFERENCES `aircraft`.`aircraft` (`Aircraft_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Airport_ID`) REFERENCES `aircraft`.`airport` (`Airport_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/aircraft/data/airport_aircraft.csv' INTO TABLE `aircraft`.`airport_aircraft`;



--- Database: real_estate_properties ----------------------------------------

create database if not exists `real_estate_properties`;

drop table if exists `real_estate_properties`.`Ref_Feature_Types`;
CREATE TABLE IF NOT EXISTS `real_estate_properties`.`Ref_Feature_Types` (
    `feature_type_code` STRING,
    `feature_type_name` STRING,
    PRIMARY KEY (`feature_type_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/real_estate_properties/data/Ref_Feature_Types.csv' INTO TABLE `real_estate_properties`.`Ref_Feature_Types`;


drop table if exists `real_estate_properties`.`Ref_Property_Types`;
CREATE TABLE IF NOT EXISTS `real_estate_properties`.`Ref_Property_Types` (
    `property_type_code` STRING,
    `property_type_description` STRING,
    PRIMARY KEY (`property_type_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/real_estate_properties/data/Ref_Property_Types.csv' INTO TABLE `real_estate_properties`.`Ref_Property_Types`;


drop table if exists `real_estate_properties`.`Other_Available_Features`;
CREATE TABLE IF NOT EXISTS `real_estate_properties`.`Other_Available_Features` (
    `feature_id` INT,
    `feature_type_code` STRING NOT NULL,
    `feature_name` STRING,
    `feature_description` STRING,
    PRIMARY KEY (`feature_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`feature_type_code`) REFERENCES `real_estate_properties`.`Ref_Feature_Types` (`feature_type_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/real_estate_properties/data/Other_Available_Features.csv' INTO TABLE `real_estate_properties`.`Other_Available_Features`;


drop table if exists `real_estate_properties`.`Properties`;
CREATE TABLE IF NOT EXISTS `real_estate_properties`.`Properties` (
    `property_id` INT,
    `property_type_code` STRING NOT NULL,
    `date_on_market` TIMESTAMP,
    `date_sold` TIMESTAMP,
    `property_name` STRING,
    `property_address` STRING,
    `room_count` INT,
    `vendor_requested_price` DECIMAL(19,4),
    `buyer_offered_price` DECIMAL(19,4),
    `agreed_selling_price` DECIMAL(19,4),
    `apt_feature_1` STRING,
    `apt_feature_2` STRING,
    `apt_feature_3` STRING,
    `fld_feature_1` STRING,
    `fld_feature_2` STRING,
    `fld_feature_3` STRING,
    `hse_feature_1` STRING,
    `hse_feature_2` STRING,
    `hse_feature_3` STRING,
    `oth_feature_1` STRING,
    `oth_feature_2` STRING,
    `oth_feature_3` STRING,
    `shp_feature_1` STRING,
    `shp_feature_2` STRING,
    `shp_feature_3` STRING,
    `other_property_details` STRING,
    PRIMARY KEY (`property_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`property_type_code`) REFERENCES `real_estate_properties`.`Ref_Property_Types` (`property_type_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/real_estate_properties/data/Properties.csv' INTO TABLE `real_estate_properties`.`Properties`;


drop table if exists `real_estate_properties`.`Other_Property_Features`;
CREATE TABLE IF NOT EXISTS `real_estate_properties`.`Other_Property_Features` (
    `property_id` INT NOT NULL,
    `feature_id` INT NOT NULL,
    `property_feature_description` STRING,
    FOREIGN KEY (`property_id`) REFERENCES `real_estate_properties`.`Properties` (`property_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`feature_id`) REFERENCES `real_estate_properties`.`Other_Available_Features` (`feature_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/real_estate_properties/data/Other_Property_Features.csv' INTO TABLE `real_estate_properties`.`Other_Property_Features`;



--- Database: match_season ----------------------------------------

create database if not exists `match_season`;

drop table if exists `match_season`.`country`;
CREATE TABLE IF NOT EXISTS `match_season`.`country` (
    `Country_id` INT,
    `Country_name` STRING,
    `Capital` STRING,
    `Official_native_language` STRING,
    PRIMARY KEY (`Country_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/match_season/data/country.csv' INTO TABLE `match_season`.`country`;


drop table if exists `match_season`.`team`;
CREATE TABLE IF NOT EXISTS `match_season`.`team` (
    `Team_id` INT,
    `Name` STRING,
    PRIMARY KEY (`Team_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/match_season/data/team.csv' INTO TABLE `match_season`.`team`;


drop table if exists `match_season`.`match_season`;
CREATE TABLE IF NOT EXISTS `match_season`.`match_season` (
    `Season` REAL,
    `Player` STRING,
    `Position` STRING,
    `Country` INT,
    `Team` INT,
    `Draft_Pick_Number` INT,
    `Draft_Class` STRING,
    `College` STRING,
    PRIMARY KEY (`Season`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Team`) REFERENCES `match_season`.`team` (`Team_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Country`) REFERENCES `match_season`.`country` (`Country_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/match_season/data/match_season.csv' INTO TABLE `match_season`.`match_season`;


drop table if exists `match_season`.`player`;
CREATE TABLE IF NOT EXISTS `match_season`.`player` (
    `Player_ID` INT,
    `Player` STRING,
    `Years_Played` STRING,
    `Total_WL` STRING,
    `Singles_WL` STRING,
    `Doubles_WL` STRING,
    `Team` INT,
    PRIMARY KEY (`Player_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Team`) REFERENCES `match_season`.`team` (`Team_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/match_season/data/player.csv' INTO TABLE `match_season`.`player`;



--- Database: county_public_safety ----------------------------------------

create database if not exists `county_public_safety`;

drop table if exists `county_public_safety`.`county_public_safety`;
CREATE TABLE IF NOT EXISTS `county_public_safety`.`county_public_safety` (
    `County_ID` INT,
    `Name` STRING,
    `Population` INT,
    `Police_officers` INT,
    `Residents_per_officer` INT,
    `Case_burden` INT,
    `Crime_rate` REAL,
    `Police_force` STRING,
    `Location` STRING,
    PRIMARY KEY (`County_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/county_public_safety/data/county_public_safety.csv' INTO TABLE `county_public_safety`.`county_public_safety`;


drop table if exists `county_public_safety`.`city`;
CREATE TABLE IF NOT EXISTS `county_public_safety`.`city` (
    `City_ID` INT,
    `County_ID` INT,
    `Name` STRING,
    `White` REAL,
    `Black` REAL,
    `Amerindian` REAL,
    `Asian` REAL,
    `Multiracial` REAL,
    `Hispanic` REAL,
    PRIMARY KEY (`City_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`County_ID`) REFERENCES `county_public_safety`.`county_public_safety` (`County_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/county_public_safety/data/city.csv' INTO TABLE `county_public_safety`.`city`;



--- Database: network_1 ----------------------------------------

create database if not exists `network_1`;

drop table if exists `network_1`.`Highschooler`;
CREATE TABLE IF NOT EXISTS `network_1`.`Highschooler` (
    `ID` INT,
    `name` STRING,
    `grade` INT,
    PRIMARY KEY (`ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/network_1/data/Highschooler.csv' INTO TABLE `network_1`.`Highschooler`;


drop table if exists `network_1`.`Friend`;
CREATE TABLE IF NOT EXISTS `network_1`.`Friend` (
    `student_id` INT,
    `friend_id` INT,
    PRIMARY KEY (`student_id`, `friend_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`friend_id`) REFERENCES `network_1`.`Highschooler` (`ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`student_id`) REFERENCES `network_1`.`Highschooler` (`ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/network_1/data/Friend.csv' INTO TABLE `network_1`.`Friend`;


drop table if exists `network_1`.`Likes`;
CREATE TABLE IF NOT EXISTS `network_1`.`Likes` (
    `student_id` INT,
    `liked_id` INT,
    PRIMARY KEY (`student_id`, `liked_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`student_id`) REFERENCES `network_1`.`Highschooler` (`ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`liked_id`) REFERENCES `network_1`.`Highschooler` (`ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/network_1/data/Likes.csv' INTO TABLE `network_1`.`Likes`;



--- Database: solvency_ii ----------------------------------------

create database if not exists `solvency_ii`;

drop table if exists `solvency_ii`.`Addresses`;
CREATE TABLE IF NOT EXISTS `solvency_ii`.`Addresses` (
    `Address_ID` INT NOT NULL,
    `address_details` STRING,
    PRIMARY KEY (`Address_ID`) DISABLE NOVALIDATE,
    UNIQUE (`Address_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/solvency_ii/data/Addresses.csv' INTO TABLE `solvency_ii`.`Addresses`;


drop table if exists `solvency_ii`.`Locations`;
CREATE TABLE IF NOT EXISTS `solvency_ii`.`Locations` (
    `Location_ID` INT NOT NULL,
    `Other_Details` STRING,
    PRIMARY KEY (`Location_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/solvency_ii/data/Locations.csv' INTO TABLE `solvency_ii`.`Locations`;


drop table if exists `solvency_ii`.`Products`;
CREATE TABLE IF NOT EXISTS `solvency_ii`.`Products` (
    `Product_ID` INT NOT NULL,
    `Product_Type_Code` CHAR(15),
    `Product_Name` STRING,
    `Product_Price` DECIMAL(20,4),
    PRIMARY KEY (`Product_ID`) DISABLE NOVALIDATE,
    UNIQUE (`Product_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/solvency_ii/data/Products.csv' INTO TABLE `solvency_ii`.`Products`;


drop table if exists `solvency_ii`.`Parties`;
CREATE TABLE IF NOT EXISTS `solvency_ii`.`Parties` (
    `Party_ID` INT NOT NULL,
    `Party_Details` STRING,
    PRIMARY KEY (`Party_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/solvency_ii/data/Parties.csv' INTO TABLE `solvency_ii`.`Parties`;


drop table if exists `solvency_ii`.`Assets`;
CREATE TABLE IF NOT EXISTS `solvency_ii`.`Assets` (
    `Asset_ID` INT NOT NULL,
    `Other_Details` STRING,
    PRIMARY KEY (`Asset_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/solvency_ii/data/Assets.csv' INTO TABLE `solvency_ii`.`Assets`;


drop table if exists `solvency_ii`.`Channels`;
CREATE TABLE IF NOT EXISTS `solvency_ii`.`Channels` (
    `Channel_ID` INT NOT NULL,
    `Other_Details` STRING,
    PRIMARY KEY (`Channel_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/solvency_ii/data/Channels.csv' INTO TABLE `solvency_ii`.`Channels`;


drop table if exists `solvency_ii`.`Finances`;
CREATE TABLE IF NOT EXISTS `solvency_ii`.`Finances` (
    `Finance_ID` INT NOT NULL,
    `Other_Details` STRING,
    PRIMARY KEY (`Finance_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/solvency_ii/data/Finances.csv' INTO TABLE `solvency_ii`.`Finances`;


drop table if exists `solvency_ii`.`Events`;
CREATE TABLE IF NOT EXISTS `solvency_ii`.`Events` (
    `Event_ID` INT NOT NULL,
    `Address_ID` INT,
    `Channel_ID` INT NOT NULL,
    `Event_Type_Code` CHAR(15),
    `Finance_ID` INT NOT NULL,
    `Location_ID` INT NOT NULL,
    PRIMARY KEY (`Event_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Finance_ID`) REFERENCES `solvency_ii`.`Finances` (`Finance_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Address_ID`) REFERENCES `solvency_ii`.`Addresses` (`Address_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Location_ID`) REFERENCES `solvency_ii`.`Locations` (`Location_ID`) DISABLE NOVALIDATE,
    UNIQUE (`Event_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/solvency_ii/data/Events.csv' INTO TABLE `solvency_ii`.`Events`;


drop table if exists `solvency_ii`.`Products_in_Events`;
CREATE TABLE IF NOT EXISTS `solvency_ii`.`Products_in_Events` (
    `Product_in_Event_ID` INT NOT NULL,
    `Event_ID` INT NOT NULL,
    `Product_ID` INT NOT NULL,
    PRIMARY KEY (`Product_in_Event_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Product_ID`) REFERENCES `solvency_ii`.`Products` (`Product_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Event_ID`) REFERENCES `solvency_ii`.`Events` (`Event_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/solvency_ii/data/Products_in_Events.csv' INTO TABLE `solvency_ii`.`Products_in_Events`;


drop table if exists `solvency_ii`.`Parties_in_Events`;
CREATE TABLE IF NOT EXISTS `solvency_ii`.`Parties_in_Events` (
    `Party_ID` INT NOT NULL,
    `Event_ID` INT NOT NULL,
    `Role_Code` CHAR(15),
    PRIMARY KEY (`Party_ID`, `Event_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Event_ID`) REFERENCES `solvency_ii`.`Events` (`Event_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Party_ID`) REFERENCES `solvency_ii`.`Parties` (`Party_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/solvency_ii/data/Parties_in_Events.csv' INTO TABLE `solvency_ii`.`Parties_in_Events`;


drop table if exists `solvency_ii`.`Agreements`;
CREATE TABLE IF NOT EXISTS `solvency_ii`.`Agreements` (
    `Document_ID` INT NOT NULL,
    `Event_ID` INT NOT NULL,
    PRIMARY KEY (`Document_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Event_ID`) REFERENCES `solvency_ii`.`Events` (`Event_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/solvency_ii/data/Agreements.csv' INTO TABLE `solvency_ii`.`Agreements`;


drop table if exists `solvency_ii`.`Assets_in_Events`;
CREATE TABLE IF NOT EXISTS `solvency_ii`.`Assets_in_Events` (
    `Asset_ID` INT NOT NULL,
    `Event_ID` INT NOT NULL,
    PRIMARY KEY (`Asset_ID`, `Event_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Event_ID`) REFERENCES `solvency_ii`.`Events` (`Event_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Event_ID`) REFERENCES `solvency_ii`.`Events` (`Event_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/solvency_ii/data/Assets_in_Events.csv' INTO TABLE `solvency_ii`.`Assets_in_Events`;



--- Database: singer ----------------------------------------

create database if not exists `singer`;

drop table if exists `singer`.`singer`;
CREATE TABLE IF NOT EXISTS `singer`.`singer` (
    `Singer_ID` INT,
    `Name` STRING,
    `Birth_Year` REAL,
    `Net_Worth_Millions` REAL,
    `Citizenship` STRING,
    PRIMARY KEY (`Singer_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/singer/data/singer.csv' INTO TABLE `singer`.`singer`;


drop table if exists `singer`.`song`;
CREATE TABLE IF NOT EXISTS `singer`.`song` (
    `Song_ID` INT,
    `Title` STRING,
    `Singer_ID` INT,
    `Sales` REAL,
    `Highest_Position` REAL,
    PRIMARY KEY (`Song_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Singer_ID`) REFERENCES `singer`.`singer` (`Singer_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/singer/data/song.csv' INTO TABLE `singer`.`song`;



--- Database: college_3 ----------------------------------------

create database if not exists `college_3`;

drop table if exists `college_3`.`Student`;
CREATE TABLE IF NOT EXISTS `college_3`.`Student` (
    `StuID` INT,
    `LName` STRING,
    `Fname` STRING,
    `Age` INT,
    `Sex` STRING,
    `Major` INT,
    `Advisor` INT,
    `city_code` STRING,
    PRIMARY KEY (`StuID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_3/data/Student.csv' INTO TABLE `college_3`.`Student`;


drop table if exists `college_3`.`Faculty`;
CREATE TABLE IF NOT EXISTS `college_3`.`Faculty` (
    `FacID` INT,
    `Lname` STRING,
    `Fname` STRING,
    `Rank` STRING,
    `Sex` STRING,
    `Phone` INT,
    `Room` STRING,
    `Building` STRING,
    PRIMARY KEY (`FacID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_3/data/Faculty.csv' INTO TABLE `college_3`.`Faculty`;


drop table if exists `college_3`.`Department`;
CREATE TABLE IF NOT EXISTS `college_3`.`Department` (
    `DNO` INT,
    `Division` STRING,
    `DName` STRING,
    `Room` STRING,
    `Building` STRING,
    `DPhone` INT,
    PRIMARY KEY (`DNO`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_3/data/Department.csv' INTO TABLE `college_3`.`Department`;


drop table if exists `college_3`.`Member_of`;
CREATE TABLE IF NOT EXISTS `college_3`.`Member_of` (
    `FacID` INT,
    `DNO` INT,
    `Appt_Type` STRING,
    FOREIGN KEY (`DNO`) REFERENCES `college_3`.`Department` (`DNO`) DISABLE NOVALIDATE,
    FOREIGN KEY (`FacID`) REFERENCES `college_3`.`Faculty` (`FacID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_3/data/Member_of.csv' INTO TABLE `college_3`.`Member_of`;


drop table if exists `college_3`.`Course`;
CREATE TABLE IF NOT EXISTS `college_3`.`Course` (
    `CID` STRING,
    `CName` STRING,
    `Credits` INT,
    `Instructor` INT,
    `Days` STRING,
    `Hours` STRING,
    `DNO` INT,
    PRIMARY KEY (`CID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`DNO`) REFERENCES `college_3`.`Department` (`DNO`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Instructor`) REFERENCES `college_3`.`Faculty` (`FacID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_3/data/Course.csv' INTO TABLE `college_3`.`Course`;


drop table if exists `college_3`.`Minor_in`;
CREATE TABLE IF NOT EXISTS `college_3`.`Minor_in` (
    `StuID` INT,
    `DNO` INT,
    FOREIGN KEY (`DNO`) REFERENCES `college_3`.`Department` (`DNO`) DISABLE NOVALIDATE,
    FOREIGN KEY (`StuID`) REFERENCES `college_3`.`Student` (`StuID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_3/data/Minor_in.csv' INTO TABLE `college_3`.`Minor_in`;


drop table if exists `college_3`.`Gradeconversion`;
CREATE TABLE IF NOT EXISTS `college_3`.`Gradeconversion` (
    `lettergrade` STRING,
    `gradepoint` DECIMAL,
    PRIMARY KEY (`lettergrade`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_3/data/Gradeconversion.csv' INTO TABLE `college_3`.`Gradeconversion`;


drop table if exists `college_3`.`Enrolled_in`;
CREATE TABLE IF NOT EXISTS `college_3`.`Enrolled_in` (
    `StuID` INT,
    `CID` STRING,
    `Grade` STRING,
    FOREIGN KEY (`Grade`) REFERENCES `college_3`.`Gradeconversion` (`lettergrade`) DISABLE NOVALIDATE,
    FOREIGN KEY (`CID`) REFERENCES `college_3`.`Course` (`CID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`StuID`) REFERENCES `college_3`.`Student` (`StuID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/college_3/data/Enrolled_in.csv' INTO TABLE `college_3`.`Enrolled_in`;



--- Database: movie_1 ----------------------------------------

create database if not exists `movie_1`;

drop table if exists `movie_1`.`Movie`;
CREATE TABLE IF NOT EXISTS `movie_1`.`Movie` (
    `mID` INT,
    `title` STRING,
    `year` INT,
    `director` STRING,
    PRIMARY KEY (`mID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/movie_1/data/Movie.csv' INTO TABLE `movie_1`.`Movie`;


drop table if exists `movie_1`.`Reviewer`;
CREATE TABLE IF NOT EXISTS `movie_1`.`Reviewer` (
    `rID` INT,
    `name` STRING,
    PRIMARY KEY (`rID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/movie_1/data/Reviewer.csv' INTO TABLE `movie_1`.`Reviewer`;


drop table if exists `movie_1`.`Rating`;
CREATE TABLE IF NOT EXISTS `movie_1`.`Rating` (
    `rID` INT,
    `mID` INT,
    `stars` INT,
    `ratingDate` DATE,
    FOREIGN KEY (`rID`) REFERENCES `movie_1`.`Reviewer` (`rID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`mID`) REFERENCES `movie_1`.`Movie` (`mID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/movie_1/data/Rating.csv' INTO TABLE `movie_1`.`Rating`;



--- Database: twitter_1 ----------------------------------------

create database if not exists `twitter_1`;

drop table if exists `twitter_1`.`user_profiles`;
CREATE TABLE IF NOT EXISTS `twitter_1`.`user_profiles` (
    `uid` INT NOT NULL,
    `name` STRING,
    `email` STRING,
    `partitionid` INT,
    `followers` INT,
    PRIMARY KEY (`uid`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/twitter_1/data/user_profiles.csv' INTO TABLE `twitter_1`.`user_profiles`;


drop table if exists `twitter_1`.`follows`;
CREATE TABLE IF NOT EXISTS `twitter_1`.`follows` (
    `f1` INT NOT NULL,
    `f2` INT NOT NULL,
    PRIMARY KEY (`f1`, `f2`) DISABLE NOVALIDATE,
    FOREIGN KEY (`f2`) REFERENCES `twitter_1`.`user_profiles` (`uid`) DISABLE NOVALIDATE,
    FOREIGN KEY (`f1`) REFERENCES `twitter_1`.`user_profiles` (`uid`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/twitter_1/data/follows.csv' INTO TABLE `twitter_1`.`follows`;


drop table if exists `twitter_1`.`tweets`;
CREATE TABLE IF NOT EXISTS `twitter_1`.`tweets` (
    `id` BIGINT NOT NULL,
    `uid` INT NOT NULL,
    `text` CHAR(140) NOT NULL,
    `createdate` TIMESTAMP,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`uid`) REFERENCES `twitter_1`.`user_profiles` (`uid`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/twitter_1/data/tweets.csv' INTO TABLE `twitter_1`.`tweets`;



--- Database: music_1 ----------------------------------------

create database if not exists `music_1`;

drop table if exists `music_1`.`genre`;
CREATE TABLE IF NOT EXISTS `music_1`.`genre` (
    `g_name` STRING NOT NULL,
    `rating` STRING,
    `most_popular_in` STRING,
    PRIMARY KEY (`g_name`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/music_1/data/genre.csv' INTO TABLE `music_1`.`genre`;


drop table if exists `music_1`.`artist`;
CREATE TABLE IF NOT EXISTS `music_1`.`artist` (
    `artist_name` STRING NOT NULL,
    `country` STRING,
    `gender` STRING,
    `preferred_genre` STRING,
    PRIMARY KEY (`artist_name`) DISABLE NOVALIDATE,
    FOREIGN KEY (`preferred_genre`) REFERENCES `music_1`.`genre` (`g_name`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/music_1/data/artist.csv' INTO TABLE `music_1`.`artist`;


drop table if exists `music_1`.`files`;
CREATE TABLE IF NOT EXISTS `music_1`.`files` (
    `f_id` NUMERIC(10) NOT NULL,
    `artist_name` STRING,
    `file_size` STRING,
    `duration` STRING,
    `formats` STRING,
    PRIMARY KEY (`f_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`artist_name`) REFERENCES `music_1`.`artist` (`artist_name`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/music_1/data/files.csv' INTO TABLE `music_1`.`files`;


drop table if exists `music_1`.`song`;
CREATE TABLE IF NOT EXISTS `music_1`.`song` (
    `song_name` STRING,
    `artist_name` STRING,
    `country` STRING,
    `f_id` NUMERIC(10),
    `genre_is` STRING,
    `rating` NUMERIC(10),
    `languages` STRING,
    `releasedate` DATE,
    `resolution` NUMERIC(10) NOT NULL,
    PRIMARY KEY (`song_name`) DISABLE NOVALIDATE,
    FOREIGN KEY (`genre_is`) REFERENCES `music_1`.`genre` (`g_name`) DISABLE NOVALIDATE,
    FOREIGN KEY (`f_id`) REFERENCES `music_1`.`files` (`f_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`artist_name`) REFERENCES `music_1`.`artist` (`artist_name`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/music_1/data/song.csv' INTO TABLE `music_1`.`song`;



--- Database: company_employee ----------------------------------------

create database if not exists `company_employee`;

drop table if exists `company_employee`.`people`;
CREATE TABLE IF NOT EXISTS `company_employee`.`people` (
    `People_ID` INT,
    `Age` INT,
    `Name` STRING,
    `Nationality` STRING,
    `Graduation_College` STRING,
    PRIMARY KEY (`People_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/company_employee/data/people.csv' INTO TABLE `company_employee`.`people`;


drop table if exists `company_employee`.`company`;
CREATE TABLE IF NOT EXISTS `company_employee`.`company` (
    `Company_ID` INT,
    `Name` STRING,
    `Headquarters` STRING,
    `Industry` STRING,
    `Sales_in_Billion` REAL,
    `Profits_in_Billion` REAL,
    `Assets_in_Billion` REAL,
    `Market_Value_in_Billion` REAL,
    PRIMARY KEY (`Company_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/company_employee/data/company.csv' INTO TABLE `company_employee`.`company`;


drop table if exists `company_employee`.`employment`;
CREATE TABLE IF NOT EXISTS `company_employee`.`employment` (
    `Company_ID` INT,
    `People_ID` INT,
    `Year_working` INT,
    PRIMARY KEY (`Company_ID`, `People_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`People_ID`) REFERENCES `company_employee`.`people` (`People_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Company_ID`) REFERENCES `company_employee`.`company` (`Company_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/company_employee/data/employment.csv' INTO TABLE `company_employee`.`employment`;



--- Database: pets_1 ----------------------------------------

create database if not exists `pets_1`;

drop table if exists `pets_1`.`Student`;
CREATE TABLE IF NOT EXISTS `pets_1`.`Student` (
    `StuID` INT,
    `LName` STRING,
    `Fname` STRING,
    `Age` INT,
    `Sex` STRING,
    `Major` INT,
    `Advisor` INT,
    `city_code` STRING,
    PRIMARY KEY (`StuID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/pets_1/data/Student.csv' INTO TABLE `pets_1`.`Student`;


drop table if exists `pets_1`.`Pets`;
CREATE TABLE IF NOT EXISTS `pets_1`.`Pets` (
    `PetID` INT,
    `PetType` STRING,
    `pet_age` INT,
    `weight` REAL,
    PRIMARY KEY (`PetID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/pets_1/data/Pets.csv' INTO TABLE `pets_1`.`Pets`;


drop table if exists `pets_1`.`Has_Pet`;
CREATE TABLE IF NOT EXISTS `pets_1`.`Has_Pet` (
    `StuID` INT,
    `PetID` INT,
    FOREIGN KEY (`StuID`) REFERENCES `pets_1`.`Student` (`StuID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`PetID`) REFERENCES `pets_1`.`Pets` (`PetID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/pets_1/data/Has_Pet.csv' INTO TABLE `pets_1`.`Has_Pet`;



--- Database: gas_company ----------------------------------------

create database if not exists `gas_company`;

drop table if exists `gas_company`.`company`;
CREATE TABLE IF NOT EXISTS `gas_company`.`company` (
    `Company_ID` INT,
    `Rank` INT,
    `Company` STRING,
    `Headquarters` STRING,
    `Main_Industry` STRING,
    `Sales_billion` REAL,
    `Profits_billion` REAL,
    `Assets_billion` REAL,
    `Market_Value` REAL,
    PRIMARY KEY (`Company_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/gas_company/data/company.csv' INTO TABLE `gas_company`.`company`;


drop table if exists `gas_company`.`gas_station`;
CREATE TABLE IF NOT EXISTS `gas_company`.`gas_station` (
    `Station_ID` INT,
    `Open_Year` INT,
    `Location` STRING,
    `Manager_Name` STRING,
    `Vice_Manager_Name` STRING,
    `Representative_Name` STRING,
    PRIMARY KEY (`Station_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/gas_company/data/gas_station.csv' INTO TABLE `gas_company`.`gas_station`;


drop table if exists `gas_company`.`station_company`;
CREATE TABLE IF NOT EXISTS `gas_company`.`station_company` (
    `Station_ID` INT,
    `Company_ID` INT,
    `Rank_of_the_Year` INT,
    PRIMARY KEY (`Station_ID`, `Company_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Company_ID`) REFERENCES `gas_company`.`company` (`Company_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Station_ID`) REFERENCES `gas_company`.`gas_station` (`Station_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/gas_company/data/station_company.csv' INTO TABLE `gas_company`.`station_company`;



--- Database: battle_death ----------------------------------------

create database if not exists `battle_death`;

drop table if exists `battle_death`.`battle`;
CREATE TABLE IF NOT EXISTS `battle_death`.`battle` (
    `id` INT,
    `name` STRING,
    `date` STRING,
    `bulgarian_commander` STRING,
    `latin_commander` STRING,
    `result` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/battle_death/data/battle.csv' INTO TABLE `battle_death`.`battle`;


drop table if exists `battle_death`.`ship`;
CREATE TABLE IF NOT EXISTS `battle_death`.`ship` (
    `lost_in_battle` INT,
    `id` INT,
    `name` STRING,
    `tonnage` STRING,
    `ship_type` STRING,
    `location` STRING,
    `disposition_of_ship` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`lost_in_battle`) REFERENCES `battle_death`.`battle` (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/battle_death/data/ship.csv' INTO TABLE `battle_death`.`ship`;


drop table if exists `battle_death`.`death`;
CREATE TABLE IF NOT EXISTS `battle_death`.`death` (
    `caused_by_ship_id` INT,
    `id` INT,
    `note` STRING,
    `killed` INT,
    `injured` INT,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`caused_by_ship_id`) REFERENCES `battle_death`.`ship` (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/battle_death/data/death.csv' INTO TABLE `battle_death`.`death`;



--- Database: election_representative ----------------------------------------

create database if not exists `election_representative`;

drop table if exists `election_representative`.`representative`;
CREATE TABLE IF NOT EXISTS `election_representative`.`representative` (
    `Representative_ID` INT,
    `Name` STRING,
    `State` STRING,
    `Party` STRING,
    `Lifespan` STRING,
    PRIMARY KEY (`Representative_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/election_representative/data/representative.csv' INTO TABLE `election_representative`.`representative`;


drop table if exists `election_representative`.`election`;
CREATE TABLE IF NOT EXISTS `election_representative`.`election` (
    `Election_ID` INT,
    `Representative_ID` INT,
    `Date` STRING,
    `Votes` REAL,
    `Vote_Percent` REAL,
    `Seats` REAL,
    `Place` REAL,
    PRIMARY KEY (`Election_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Representative_ID`) REFERENCES `election_representative`.`representative` (`Representative_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/election_representative/data/election.csv' INTO TABLE `election_representative`.`election`;



--- Database: dog_kennels ----------------------------------------

create database if not exists `dog_kennels`;

drop table if exists `dog_kennels`.`Breeds`;
CREATE TABLE IF NOT EXISTS `dog_kennels`.`Breeds` (
    `breed_code` STRING,
    `breed_name` STRING,
    PRIMARY KEY (`breed_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/dog_kennels/data/Breeds.csv' INTO TABLE `dog_kennels`.`Breeds`;


drop table if exists `dog_kennels`.`Charges`;
CREATE TABLE IF NOT EXISTS `dog_kennels`.`Charges` (
    `charge_id` INT,
    `charge_type` STRING,
    `charge_amount` DECIMAL(19,4),
    PRIMARY KEY (`charge_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/dog_kennels/data/Charges.csv' INTO TABLE `dog_kennels`.`Charges`;


drop table if exists `dog_kennels`.`Sizes`;
CREATE TABLE IF NOT EXISTS `dog_kennels`.`Sizes` (
    `size_code` STRING,
    `size_description` STRING,
    PRIMARY KEY (`size_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/dog_kennels/data/Sizes.csv' INTO TABLE `dog_kennels`.`Sizes`;


drop table if exists `dog_kennels`.`Treatment_Types`;
CREATE TABLE IF NOT EXISTS `dog_kennels`.`Treatment_Types` (
    `treatment_type_code` STRING,
    `treatment_type_description` STRING,
    PRIMARY KEY (`treatment_type_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/dog_kennels/data/Treatment_Types.csv' INTO TABLE `dog_kennels`.`Treatment_Types`;


drop table if exists `dog_kennels`.`Owners`;
CREATE TABLE IF NOT EXISTS `dog_kennels`.`Owners` (
    `owner_id` INT,
    `first_name` STRING,
    `last_name` STRING,
    `street` STRING,
    `city` STRING,
    `state` STRING,
    `zip_code` STRING,
    `email_address` STRING,
    `home_phone` STRING,
    `cell_number` STRING,
    PRIMARY KEY (`owner_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/dog_kennels/data/Owners.csv' INTO TABLE `dog_kennels`.`Owners`;


drop table if exists `dog_kennels`.`Dogs`;
CREATE TABLE IF NOT EXISTS `dog_kennels`.`Dogs` (
    `dog_id` INT,
    `owner_id` INT NOT NULL,
    `abandoned_yn` STRING,
    `breed_code` STRING NOT NULL,
    `size_code` STRING NOT NULL,
    `name` STRING,
    `age` STRING,
    `date_of_birth` TIMESTAMP,
    `gender` STRING,
    `weight` STRING,
    `date_arrived` TIMESTAMP,
    `date_adopted` TIMESTAMP,
    `date_departed` TIMESTAMP,
    PRIMARY KEY (`dog_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`owner_id`) REFERENCES `dog_kennels`.`Owners` (`owner_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`owner_id`) REFERENCES `dog_kennels`.`Owners` (`owner_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`size_code`) REFERENCES `dog_kennels`.`Sizes` (`size_code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`breed_code`) REFERENCES `dog_kennels`.`Breeds` (`breed_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/dog_kennels/data/Dogs.csv' INTO TABLE `dog_kennels`.`Dogs`;


drop table if exists `dog_kennels`.`Professionals`;
CREATE TABLE IF NOT EXISTS `dog_kennels`.`Professionals` (
    `professional_id` INT,
    `role_code` STRING NOT NULL,
    `first_name` STRING,
    `street` STRING,
    `city` STRING,
    `state` STRING,
    `zip_code` STRING,
    `last_name` STRING,
    `email_address` STRING,
    `home_phone` STRING,
    `cell_number` STRING,
    PRIMARY KEY (`professional_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/dog_kennels/data/Professionals.csv' INTO TABLE `dog_kennels`.`Professionals`;


drop table if exists `dog_kennels`.`Treatments`;
CREATE TABLE IF NOT EXISTS `dog_kennels`.`Treatments` (
    `treatment_id` INT,
    `dog_id` INT NOT NULL,
    `professional_id` INT NOT NULL,
    `treatment_type_code` STRING NOT NULL,
    `date_of_treatment` TIMESTAMP,
    `cost_of_treatment` DECIMAL(19,4),
    PRIMARY KEY (`treatment_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`dog_id`) REFERENCES `dog_kennels`.`Dogs` (`dog_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`professional_id`) REFERENCES `dog_kennels`.`Professionals` (`professional_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`treatment_type_code`) REFERENCES `dog_kennels`.`Treatment_Types` (`treatment_type_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/dog_kennels/data/Treatments.csv' INTO TABLE `dog_kennels`.`Treatments`;



--- Database: products_for_hire ----------------------------------------

create database if not exists `products_for_hire`;

drop table if exists `products_for_hire`.`Discount_Coupons`;
CREATE TABLE IF NOT EXISTS `products_for_hire`.`Discount_Coupons` (
    `coupon_id` INT,
    `date_issued` TIMESTAMP,
    `coupon_amount` DECIMAL(19,4),
    PRIMARY KEY (`coupon_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/products_for_hire/data/Discount_Coupons.csv' INTO TABLE `products_for_hire`.`Discount_Coupons`;


drop table if exists `products_for_hire`.`Customers`;
CREATE TABLE IF NOT EXISTS `products_for_hire`.`Customers` (
    `customer_id` INT,
    `coupon_id` INT NOT NULL,
    `good_or_bad_customer` STRING,
    `first_name` STRING,
    `last_name` STRING,
    `gender_mf` STRING,
    `date_became_customer` TIMESTAMP,
    `date_last_hire` TIMESTAMP,
    PRIMARY KEY (`customer_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`coupon_id`) REFERENCES `products_for_hire`.`Discount_Coupons` (`coupon_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/products_for_hire/data/Customers.csv' INTO TABLE `products_for_hire`.`Customers`;


drop table if exists `products_for_hire`.`Bookings`;
CREATE TABLE IF NOT EXISTS `products_for_hire`.`Bookings` (
    `booking_id` INT,
    `customer_id` INT NOT NULL,
    `booking_status_code` STRING NOT NULL,
    `returned_damaged_yn` STRING,
    `booking_start_date` TIMESTAMP,
    `booking_end_date` TIMESTAMP,
    `count_hired` STRING,
    `amount_payable` DECIMAL(19,4),
    `amount_of_discount` DECIMAL(19,4),
    `amount_outstanding` DECIMAL(19,4),
    `amount_of_refund` DECIMAL(19,4),
    PRIMARY KEY (`booking_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`customer_id`) REFERENCES `products_for_hire`.`Customers` (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/products_for_hire/data/Bookings.csv' INTO TABLE `products_for_hire`.`Bookings`;


drop table if exists `products_for_hire`.`Products_for_Hire`;
CREATE TABLE IF NOT EXISTS `products_for_hire`.`Products_for_Hire` (
    `product_id` INT,
    `product_type_code` STRING NOT NULL,
    `daily_hire_cost` DECIMAL(19,4),
    `product_name` STRING,
    `product_description` STRING,
    PRIMARY KEY (`product_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/products_for_hire/data/Products_for_Hire.csv' INTO TABLE `products_for_hire`.`Products_for_Hire`;


drop table if exists `products_for_hire`.`Payments`;
CREATE TABLE IF NOT EXISTS `products_for_hire`.`Payments` (
    `payment_id` INT,
    `booking_id` INT,
    `customer_id` INT NOT NULL,
    `payment_type_code` STRING NOT NULL,
    `amount_paid_in_full_yn` STRING,
    `payment_date` TIMESTAMP,
    `amount_due` DECIMAL(19,4),
    `amount_paid` DECIMAL(19,4),
    PRIMARY KEY (`payment_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`customer_id`) REFERENCES `products_for_hire`.`Customers` (`customer_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`booking_id`) REFERENCES `products_for_hire`.`Bookings` (`booking_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/products_for_hire/data/Payments.csv' INTO TABLE `products_for_hire`.`Payments`;


drop table if exists `products_for_hire`.`Products_Booked`;
CREATE TABLE IF NOT EXISTS `products_for_hire`.`Products_Booked` (
    `booking_id` INT NOT NULL,
    `product_id` INT NOT NULL,
    `returned_yn` STRING,
    `returned_late_yn` STRING,
    `booked_count` INT,
    `booked_amount` DECIMAL,
    PRIMARY KEY (`booking_id`, `product_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`product_id`) REFERENCES `products_for_hire`.`Products_for_Hire` (`product_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`booking_id`) REFERENCES `products_for_hire`.`Bookings` (`booking_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/products_for_hire/data/Products_Booked.csv' INTO TABLE `products_for_hire`.`Products_Booked`;


drop table if exists `products_for_hire`.`View_Product_Availability`;
CREATE TABLE IF NOT EXISTS `products_for_hire`.`View_Product_Availability` (
    `product_id` INT NOT NULL,
    `booking_id` INT NOT NULL,
    `status_date` TIMESTAMP,
    `available_yn` STRING,
    PRIMARY KEY (`status_date`) DISABLE NOVALIDATE,
    FOREIGN KEY (`product_id`) REFERENCES `products_for_hire`.`Products_for_Hire` (`product_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`booking_id`) REFERENCES `products_for_hire`.`Bookings` (`booking_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/products_for_hire/data/View_Product_Availability.csv' INTO TABLE `products_for_hire`.`View_Product_Availability`;



--- Database: e_learning ----------------------------------------

create database if not exists `e_learning`;

drop table if exists `e_learning`.`Course_Authors_and_Tutors`;
CREATE TABLE IF NOT EXISTS `e_learning`.`Course_Authors_and_Tutors` (
    `author_id` INT,
    `author_tutor_ATB` STRING,
    `login_name` STRING,
    `password` STRING,
    `personal_name` STRING,
    `middle_name` STRING,
    `family_name` STRING,
    `gender_mf` STRING,
    `address_line_1` STRING,
    PRIMARY KEY (`author_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/e_learning/data/Course_Authors_and_Tutors.csv' INTO TABLE `e_learning`.`Course_Authors_and_Tutors`;


drop table if exists `e_learning`.`Students`;
CREATE TABLE IF NOT EXISTS `e_learning`.`Students` (
    `student_id` INT,
    `date_of_registration` TIMESTAMP,
    `date_of_latest_logon` TIMESTAMP,
    `login_name` STRING,
    `password` STRING,
    `personal_name` STRING,
    `middle_name` STRING,
    `family_name` STRING,
    PRIMARY KEY (`student_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/e_learning/data/Students.csv' INTO TABLE `e_learning`.`Students`;


drop table if exists `e_learning`.`Subjects`;
CREATE TABLE IF NOT EXISTS `e_learning`.`Subjects` (
    `subject_id` INT,
    `subject_name` STRING,
    PRIMARY KEY (`subject_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/e_learning/data/Subjects.csv' INTO TABLE `e_learning`.`Subjects`;


drop table if exists `e_learning`.`Courses`;
CREATE TABLE IF NOT EXISTS `e_learning`.`Courses` (
    `course_id` INT,
    `author_id` INT NOT NULL,
    `subject_id` INT NOT NULL,
    `course_name` STRING,
    `course_description` STRING,
    PRIMARY KEY (`course_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`subject_id`) REFERENCES `e_learning`.`Subjects` (`subject_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`author_id`) REFERENCES `e_learning`.`Course_Authors_and_Tutors` (`author_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/e_learning/data/Courses.csv' INTO TABLE `e_learning`.`Courses`;


drop table if exists `e_learning`.`Student_Course_Enrolment`;
CREATE TABLE IF NOT EXISTS `e_learning`.`Student_Course_Enrolment` (
    `registration_id` INT,
    `student_id` INT NOT NULL,
    `course_id` INT NOT NULL,
    `date_of_enrolment` TIMESTAMP NOT NULL,
    `date_of_completion` TIMESTAMP NOT NULL,
    PRIMARY KEY (`registration_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`student_id`) REFERENCES `e_learning`.`Students` (`student_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`course_id`) REFERENCES `e_learning`.`Courses` (`course_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/e_learning/data/Student_Course_Enrolment.csv' INTO TABLE `e_learning`.`Student_Course_Enrolment`;


drop table if exists `e_learning`.`Student_Tests_Taken`;
CREATE TABLE IF NOT EXISTS `e_learning`.`Student_Tests_Taken` (
    `registration_id` INT NOT NULL,
    `date_test_taken` TIMESTAMP NOT NULL,
    `test_result` STRING,
    FOREIGN KEY (`registration_id`) REFERENCES `e_learning`.`Student_Course_Enrolment` (`registration_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/e_learning/data/Student_Tests_Taken.csv' INTO TABLE `e_learning`.`Student_Tests_Taken`;



--- Database: entertainment_awards ----------------------------------------

create database if not exists `entertainment_awards`;

drop table if exists `entertainment_awards`.`festival_detail`;
CREATE TABLE IF NOT EXISTS `entertainment_awards`.`festival_detail` (
    `Festival_ID` INT,
    `Festival_Name` STRING,
    `Chair_Name` STRING,
    `Location` STRING,
    `Year` INT,
    `Num_of_Audience` INT,
    PRIMARY KEY (`Festival_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/entertainment_awards/data/festival_detail.csv' INTO TABLE `entertainment_awards`.`festival_detail`;


drop table if exists `entertainment_awards`.`artwork`;
CREATE TABLE IF NOT EXISTS `entertainment_awards`.`artwork` (
    `Artwork_ID` INT,
    `Type` STRING,
    `Name` STRING,
    PRIMARY KEY (`Artwork_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/entertainment_awards/data/artwork.csv' INTO TABLE `entertainment_awards`.`artwork`;


drop table if exists `entertainment_awards`.`nomination`;
CREATE TABLE IF NOT EXISTS `entertainment_awards`.`nomination` (
    `Artwork_ID` INT,
    `Festival_ID` INT,
    `Result` STRING,
    PRIMARY KEY (`Artwork_ID`, `Festival_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Festival_ID`) REFERENCES `entertainment_awards`.`festival_detail` (`Festival_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Artwork_ID`) REFERENCES `entertainment_awards`.`artwork` (`Artwork_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/entertainment_awards/data/nomination.csv' INTO TABLE `entertainment_awards`.`nomination`;



--- Database: tvshow ----------------------------------------

create database if not exists `tvshow`;

drop table if exists `tvshow`.`TV_Channel`;
CREATE TABLE IF NOT EXISTS `tvshow`.`TV_Channel` (
    `id` STRING,
    `series_name` STRING,
    `Country` STRING,
    `Language` STRING,
    `Content` STRING,
    `Pixel_aspect_ratio_PAR` STRING,
    `Hight_definition_TV` STRING,
    `Pay_per_view_PPV` STRING,
    `Package_Option` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tvshow/data/TV_Channel.csv' INTO TABLE `tvshow`.`TV_Channel`;


drop table if exists `tvshow`.`TV_series`;
CREATE TABLE IF NOT EXISTS `tvshow`.`TV_series` (
    `id` REAL,
    `Episode` STRING,
    `Air_Date` STRING,
    `Rating` STRING,
    `Share` REAL,
    `18_49_Rating_Share` STRING,
    `Viewers_m` STRING,
    `Weekly_Rank` REAL,
    `Channel` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Channel`) REFERENCES `tvshow`.`TV_Channel` (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tvshow/data/TV_series.csv' INTO TABLE `tvshow`.`TV_series`;


drop table if exists `tvshow`.`Cartoon`;
CREATE TABLE IF NOT EXISTS `tvshow`.`Cartoon` (
    `id` REAL,
    `Title` STRING,
    `Directed_by` STRING,
    `Written_by` STRING,
    `Original_air_date` STRING,
    `Production_code` REAL,
    `Channel` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Channel`) REFERENCES `tvshow`.`TV_Channel` (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/tvshow/data/Cartoon.csv' INTO TABLE `tvshow`.`Cartoon`;



--- Database: theme_gallery ----------------------------------------

create database if not exists `theme_gallery`;

drop table if exists `theme_gallery`.`artist`;
CREATE TABLE IF NOT EXISTS `theme_gallery`.`artist` (
    `Artist_ID` INT,
    `Name` STRING,
    `Country` STRING,
    `Year_Join` INT,
    `Age` INT,
    PRIMARY KEY (`Artist_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/theme_gallery/data/artist.csv' INTO TABLE `theme_gallery`.`artist`;


drop table if exists `theme_gallery`.`exhibition`;
CREATE TABLE IF NOT EXISTS `theme_gallery`.`exhibition` (
    `Exhibition_ID` INT,
    `Year` INT,
    `Theme` STRING,
    `Artist_ID` INT,
    `Ticket_Price` REAL,
    PRIMARY KEY (`Exhibition_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Artist_ID`) REFERENCES `theme_gallery`.`artist` (`Artist_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/theme_gallery/data/exhibition.csv' INTO TABLE `theme_gallery`.`exhibition`;


drop table if exists `theme_gallery`.`exhibition_record`;
CREATE TABLE IF NOT EXISTS `theme_gallery`.`exhibition_record` (
    `Exhibition_ID` INT,
    `Date` STRING,
    `Attendance` INT,
    PRIMARY KEY (`Exhibition_ID`, `Date`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Exhibition_ID`) REFERENCES `theme_gallery`.`exhibition` (`Exhibition_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/theme_gallery/data/exhibition_record.csv' INTO TABLE `theme_gallery`.`exhibition_record`;



--- Database: document_management ----------------------------------------

create database if not exists `document_management`;

drop table if exists `document_management`.`Roles`;
CREATE TABLE IF NOT EXISTS `document_management`.`Roles` (
    `role_code` STRING,
    `role_description` STRING,
    PRIMARY KEY (`role_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/document_management/data/Roles.csv' INTO TABLE `document_management`.`Roles`;


drop table if exists `document_management`.`Users`;
CREATE TABLE IF NOT EXISTS `document_management`.`Users` (
    `user_id` INT,
    `role_code` STRING NOT NULL,
    `user_name` STRING,
    `user_login` STRING,
    `password` STRING,
    PRIMARY KEY (`user_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`role_code`) REFERENCES `document_management`.`Roles` (`role_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/document_management/data/Users.csv' INTO TABLE `document_management`.`Users`;


drop table if exists `document_management`.`Document_Structures`;
CREATE TABLE IF NOT EXISTS `document_management`.`Document_Structures` (
    `document_structure_code` STRING,
    `parent_document_structure_code` STRING,
    `document_structure_description` STRING,
    PRIMARY KEY (`document_structure_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/document_management/data/Document_Structures.csv' INTO TABLE `document_management`.`Document_Structures`;


drop table if exists `document_management`.`Functional_Areas`;
CREATE TABLE IF NOT EXISTS `document_management`.`Functional_Areas` (
    `functional_area_code` STRING,
    `parent_functional_area_code` STRING,
    `functional_area_description` STRING NOT NULL,
    PRIMARY KEY (`functional_area_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/document_management/data/Functional_Areas.csv' INTO TABLE `document_management`.`Functional_Areas`;


drop table if exists `document_management`.`Images`;
CREATE TABLE IF NOT EXISTS `document_management`.`Images` (
    `image_id` INT,
    `image_alt_text` STRING,
    `image_name` STRING,
    `image_url` STRING,
    PRIMARY KEY (`image_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/document_management/data/Images.csv' INTO TABLE `document_management`.`Images`;


drop table if exists `document_management`.`Documents`;
CREATE TABLE IF NOT EXISTS `document_management`.`Documents` (
    `document_code` STRING,
    `document_structure_code` STRING NOT NULL,
    `document_type_code` STRING NOT NULL,
    `access_count` INT,
    `document_name` STRING,
    PRIMARY KEY (`document_code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`document_structure_code`) REFERENCES `document_management`.`Document_Structures` (`document_structure_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/document_management/data/Documents.csv' INTO TABLE `document_management`.`Documents`;


drop table if exists `document_management`.`Document_Functional_Areas`;
CREATE TABLE IF NOT EXISTS `document_management`.`Document_Functional_Areas` (
    `document_code` STRING NOT NULL,
    `functional_area_code` STRING NOT NULL,
    FOREIGN KEY (`functional_area_code`) REFERENCES `document_management`.`Functional_Areas` (`functional_area_code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`document_code`) REFERENCES `document_management`.`Documents` (`document_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/document_management/data/Document_Functional_Areas.csv' INTO TABLE `document_management`.`Document_Functional_Areas`;


drop table if exists `document_management`.`Document_Sections`;
CREATE TABLE IF NOT EXISTS `document_management`.`Document_Sections` (
    `section_id` INT,
    `document_code` STRING NOT NULL,
    `section_sequence` INT,
    `section_code` STRING,
    `section_title` STRING,
    PRIMARY KEY (`section_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`document_code`) REFERENCES `document_management`.`Documents` (`document_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/document_management/data/Document_Sections.csv' INTO TABLE `document_management`.`Document_Sections`;


drop table if exists `document_management`.`Document_Sections_Images`;
CREATE TABLE IF NOT EXISTS `document_management`.`Document_Sections_Images` (
    `section_id` INT NOT NULL,
    `image_id` INT NOT NULL,
    PRIMARY KEY (`section_id`, `image_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`image_id`) REFERENCES `document_management`.`Images` (`image_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`section_id`) REFERENCES `document_management`.`Document_Sections` (`section_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/document_management/data/Document_Sections_Images.csv' INTO TABLE `document_management`.`Document_Sections_Images`;



--- Database: university_basketball ----------------------------------------

create database if not exists `university_basketball`;

drop table if exists `university_basketball`.`university`;
CREATE TABLE IF NOT EXISTS `university_basketball`.`university` (
    `School_ID` INT,
    `School` STRING,
    `Location` STRING,
    `Founded` REAL,
    `Affiliation` STRING,
    `Enrollment` REAL,
    `Nickname` STRING,
    `Primary_conference` STRING,
    PRIMARY KEY (`School_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/university_basketball/data/university.csv' INTO TABLE `university_basketball`.`university`;


drop table if exists `university_basketball`.`basketball_match`;
CREATE TABLE IF NOT EXISTS `university_basketball`.`basketball_match` (
    `Team_ID` INT,
    `School_ID` INT,
    `Team_Name` STRING,
    `ACC_Regular_Season` STRING,
    `ACC_Percent` STRING,
    `ACC_Home` STRING,
    `ACC_Road` STRING,
    `All_Games` STRING,
    `All_Games_Percent` INT,
    `All_Home` STRING,
    `All_Road` STRING,
    `All_Neutral` STRING,
    PRIMARY KEY (`Team_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`School_ID`) REFERENCES `university_basketball`.`university` (`School_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/university_basketball/data/basketball_match.csv' INTO TABLE `university_basketball`.`basketball_match`;



--- Database: orchestra ----------------------------------------

create database if not exists `orchestra`;

drop table if exists `orchestra`.`conductor`;
CREATE TABLE IF NOT EXISTS `orchestra`.`conductor` (
    `Conductor_ID` INT,
    `Name` STRING,
    `Age` INT,
    `Nationality` STRING,
    `Year_of_Work` INT,
    PRIMARY KEY (`Conductor_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/orchestra/data/conductor.csv' INTO TABLE `orchestra`.`conductor`;


drop table if exists `orchestra`.`orchestra`;
CREATE TABLE IF NOT EXISTS `orchestra`.`orchestra` (
    `Orchestra_ID` INT,
    `Orchestra` STRING,
    `Conductor_ID` INT,
    `Record_Company` STRING,
    `Year_of_Founded` REAL,
    `Major_Record_Format` STRING,
    PRIMARY KEY (`Orchestra_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Conductor_ID`) REFERENCES `orchestra`.`conductor` (`Conductor_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/orchestra/data/orchestra.csv' INTO TABLE `orchestra`.`orchestra`;


drop table if exists `orchestra`.`performance`;
CREATE TABLE IF NOT EXISTS `orchestra`.`performance` (
    `Performance_ID` INT,
    `Orchestra_ID` INT,
    `Type` STRING,
    `Date` STRING,
    `Official_ratings_(millions)` REAL,
    `Weekly_rank` STRING,
    `Share` STRING,
    PRIMARY KEY (`Performance_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Orchestra_ID`) REFERENCES `orchestra`.`orchestra` (`Orchestra_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/orchestra/data/performance.csv' INTO TABLE `orchestra`.`performance`;


drop table if exists `orchestra`.`show`;
CREATE TABLE IF NOT EXISTS `orchestra`.`show` (
    `Show_ID` INT,
    `Performance_ID` INT,
    `If_first_show` BOOLEAN,
    `Result` STRING,
    `Attendance` REAL,
    FOREIGN KEY (`Performance_ID`) REFERENCES `orchestra`.`performance` (`Performance_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/orchestra/data/show.csv' INTO TABLE `orchestra`.`show`;



--- Database: flight_2 ----------------------------------------

create database if not exists `flight_2`;

drop table if exists `flight_2`.`airlines`;
CREATE TABLE IF NOT EXISTS `flight_2`.`airlines` (
    `uid` INT,
    `Airline` STRING,
    `Abbreviation` STRING,
    `Country` STRING,
    PRIMARY KEY (`uid`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/flight_2/data/airlines.csv' INTO TABLE `flight_2`.`airlines`;


drop table if exists `flight_2`.`airports`;
CREATE TABLE IF NOT EXISTS `flight_2`.`airports` (
    `City` STRING,
    `AirportCode` STRING,
    `AirportName` STRING,
    `Country` STRING,
    `CountryAbbrev` STRING,
    PRIMARY KEY (`AirportCode`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/flight_2/data/airports.csv' INTO TABLE `flight_2`.`airports`;


drop table if exists `flight_2`.`flights`;
CREATE TABLE IF NOT EXISTS `flight_2`.`flights` (
    `Airline` INT,
    `FlightNo` INT,
    `SourceAirport` STRING,
    `DestAirport` STRING,
    PRIMARY KEY (`Airline`, `FlightNo`) DISABLE NOVALIDATE,
    FOREIGN KEY (`DestAirport`) REFERENCES `flight_2`.`airports` (`AirportCode`) DISABLE NOVALIDATE,
    FOREIGN KEY (`SourceAirport`) REFERENCES `flight_2`.`airports` (`AirportCode`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/flight_2/data/flights.csv' INTO TABLE `flight_2`.`flights`;



--- Database: student_1 ----------------------------------------

create database if not exists `student_1`;

drop table if exists `student_1`.`list`;
CREATE TABLE IF NOT EXISTS `student_1`.`list` (
    `LastName` STRING,
    `FirstName` STRING,
    `Grade` INT,
    `Classroom` INT,
    PRIMARY KEY (`LastName`, `FirstName`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_1/data/list.csv' INTO TABLE `student_1`.`list`;


drop table if exists `student_1`.`teachers`;
CREATE TABLE IF NOT EXISTS `student_1`.`teachers` (
    `LastName` STRING,
    `FirstName` STRING,
    `Classroom` INT,
    PRIMARY KEY (`LastName`, `FirstName`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/student_1/data/teachers.csv' INTO TABLE `student_1`.`teachers`;



--- Database: party_host ----------------------------------------

create database if not exists `party_host`;

drop table if exists `party_host`.`party`;
CREATE TABLE IF NOT EXISTS `party_host`.`party` (
    `Party_ID` INT,
    `Party_Theme` STRING,
    `Location` STRING,
    `First_year` STRING,
    `Last_year` STRING,
    `Number_of_hosts` INT,
    PRIMARY KEY (`Party_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/party_host/data/party.csv' INTO TABLE `party_host`.`party`;


drop table if exists `party_host`.`host`;
CREATE TABLE IF NOT EXISTS `party_host`.`host` (
    `Host_ID` INT,
    `Name` STRING,
    `Nationality` STRING,
    `Age` STRING,
    PRIMARY KEY (`Host_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/party_host/data/host.csv' INTO TABLE `party_host`.`host`;


drop table if exists `party_host`.`party_host`;
CREATE TABLE IF NOT EXISTS `party_host`.`party_host` (
    `Party_ID` INT,
    `Host_ID` INT,
    `Is_Main_in_Charge` BOOLEAN,
    PRIMARY KEY (`Party_ID`, `Host_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Party_ID`) REFERENCES `party_host`.`party` (`Party_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Host_ID`) REFERENCES `party_host`.`host` (`Host_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/party_host/data/party_host.csv' INTO TABLE `party_host`.`party_host`;



--- Database: epinions_1 ----------------------------------------

create database if not exists `epinions_1`;

drop table if exists `epinions_1`.`item`;
CREATE TABLE IF NOT EXISTS `epinions_1`.`item` (
    `i_id` INT NOT NULL,
    `title` STRING,
    PRIMARY KEY (`i_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/epinions_1/data/item.csv' INTO TABLE `epinions_1`.`item`;


drop table if exists `epinions_1`.`useracct`;
CREATE TABLE IF NOT EXISTS `epinions_1`.`useracct` (
    `u_id` INT NOT NULL,
    `name` STRING,
    PRIMARY KEY (`u_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/epinions_1/data/useracct.csv' INTO TABLE `epinions_1`.`useracct`;


drop table if exists `epinions_1`.`review`;
CREATE TABLE IF NOT EXISTS `epinions_1`.`review` (
    `a_id` INT NOT NULL,
    `u_id` INT NOT NULL,
    `i_id` INT NOT NULL,
    `rating` INT,
    `rank` INT,
    PRIMARY KEY (`a_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`i_id`) REFERENCES `epinions_1`.`item` (`i_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`u_id`) REFERENCES `epinions_1`.`useracct` (`u_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/epinions_1/data/review.csv' INTO TABLE `epinions_1`.`review`;


drop table if exists `epinions_1`.`trust`;
CREATE TABLE IF NOT EXISTS `epinions_1`.`trust` (
    `source_u_id` INT NOT NULL,
    `target_u_id` INT NOT NULL,
    `trust` INT NOT NULL,
    FOREIGN KEY (`target_u_id`) REFERENCES `epinions_1`.`useracct` (`u_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`source_u_id`) REFERENCES `epinions_1`.`useracct` (`u_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/epinions_1/data/trust.csv' INTO TABLE `epinions_1`.`trust`;



--- Database: wedding ----------------------------------------

create database if not exists `wedding`;

drop table if exists `wedding`.`people`;
CREATE TABLE IF NOT EXISTS `wedding`.`people` (
    `People_ID` INT,
    `Name` STRING,
    `Country` STRING,
    `Is_Male` STRING,
    `Age` INT,
    PRIMARY KEY (`People_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/wedding/data/people.csv' INTO TABLE `wedding`.`people`;


drop table if exists `wedding`.`church`;
CREATE TABLE IF NOT EXISTS `wedding`.`church` (
    `Church_ID` INT,
    `Name` STRING,
    `Organized_by` STRING,
    `Open_Date` INT,
    `Continuation_of` STRING,
    PRIMARY KEY (`Church_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/wedding/data/church.csv' INTO TABLE `wedding`.`church`;


drop table if exists `wedding`.`wedding`;
CREATE TABLE IF NOT EXISTS `wedding`.`wedding` (
    `Church_ID` INT,
    `Male_ID` INT,
    `Female_ID` INT,
    `Year` INT,
    PRIMARY KEY (`Church_ID`, `Male_ID`, `Female_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Female_ID`) REFERENCES `wedding`.`people` (`People_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Male_ID`) REFERENCES `wedding`.`people` (`People_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Church_ID`) REFERENCES `wedding`.`church` (`Church_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/wedding/data/wedding.csv' INTO TABLE `wedding`.`wedding`;



--- Database: department_management ----------------------------------------

create database if not exists `department_management`;

drop table if exists `department_management`.`department`;
CREATE TABLE IF NOT EXISTS `department_management`.`department` (
    `Department_ID` INT,
    `Name` STRING,
    `Creation` STRING,
    `Ranking` INT,
    `Budget_in_Billions` REAL,
    `Num_Employees` REAL,
    PRIMARY KEY (`Department_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/department_management/data/department.csv' INTO TABLE `department_management`.`department`;


drop table if exists `department_management`.`head`;
CREATE TABLE IF NOT EXISTS `department_management`.`head` (
    `head_ID` INT,
    `name` STRING,
    `born_state` STRING,
    `age` REAL,
    PRIMARY KEY (`head_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/department_management/data/head.csv' INTO TABLE `department_management`.`head`;


drop table if exists `department_management`.`management`;
CREATE TABLE IF NOT EXISTS `department_management`.`management` (
    `department_ID` INT,
    `head_ID` INT,
    `temporary_acting` STRING,
    PRIMARY KEY (`department_ID`, `head_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`head_ID`) REFERENCES `department_management`.`head` (`head_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`department_ID`) REFERENCES `department_management`.`department` (`Department_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/department_management/data/management.csv' INTO TABLE `department_management`.`management`;



--- Database: products_gen_characteristics ----------------------------------------

create database if not exists `products_gen_characteristics`;

drop table if exists `products_gen_characteristics`.`Ref_Characteristic_Types`;
CREATE TABLE IF NOT EXISTS `products_gen_characteristics`.`Ref_Characteristic_Types` (
    `characteristic_type_code` STRING,
    `characteristic_type_description` STRING,
    PRIMARY KEY (`characteristic_type_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/products_gen_characteristics/data/Ref_Characteristic_Types.csv' INTO TABLE `products_gen_characteristics`.`Ref_Characteristic_Types`;


drop table if exists `products_gen_characteristics`.`Ref_Colors`;
CREATE TABLE IF NOT EXISTS `products_gen_characteristics`.`Ref_Colors` (
    `color_code` STRING,
    `color_description` STRING,
    PRIMARY KEY (`color_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/products_gen_characteristics/data/Ref_Colors.csv' INTO TABLE `products_gen_characteristics`.`Ref_Colors`;


drop table if exists `products_gen_characteristics`.`Ref_Product_Categories`;
CREATE TABLE IF NOT EXISTS `products_gen_characteristics`.`Ref_Product_Categories` (
    `product_category_code` STRING,
    `product_category_description` STRING,
    `unit_of_measure` STRING,
    PRIMARY KEY (`product_category_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/products_gen_characteristics/data/Ref_Product_Categories.csv' INTO TABLE `products_gen_characteristics`.`Ref_Product_Categories`;


drop table if exists `products_gen_characteristics`.`Characteristics`;
CREATE TABLE IF NOT EXISTS `products_gen_characteristics`.`Characteristics` (
    `characteristic_id` INT,
    `characteristic_type_code` STRING NOT NULL,
    `characteristic_data_type` STRING,
    `characteristic_name` STRING,
    `other_characteristic_details` STRING,
    PRIMARY KEY (`characteristic_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`characteristic_type_code`) REFERENCES `products_gen_characteristics`.`Ref_Characteristic_Types` (`characteristic_type_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/products_gen_characteristics/data/Characteristics.csv' INTO TABLE `products_gen_characteristics`.`Characteristics`;


drop table if exists `products_gen_characteristics`.`Products`;
CREATE TABLE IF NOT EXISTS `products_gen_characteristics`.`Products` (
    `product_id` INT,
    `color_code` STRING NOT NULL,
    `product_category_code` STRING NOT NULL,
    `product_name` STRING,
    `typical_buying_price` STRING,
    `typical_selling_price` STRING,
    `product_description` STRING,
    `other_product_details` STRING,
    PRIMARY KEY (`product_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`color_code`) REFERENCES `products_gen_characteristics`.`Ref_Colors` (`color_code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`product_category_code`) REFERENCES `products_gen_characteristics`.`Ref_Product_Categories` (`product_category_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/products_gen_characteristics/data/Products.csv' INTO TABLE `products_gen_characteristics`.`Products`;


drop table if exists `products_gen_characteristics`.`Product_Characteristics`;
CREATE TABLE IF NOT EXISTS `products_gen_characteristics`.`Product_Characteristics` (
    `product_id` INT NOT NULL,
    `characteristic_id` INT NOT NULL,
    `product_characteristic_value` STRING,
    FOREIGN KEY (`product_id`) REFERENCES `products_gen_characteristics`.`Products` (`product_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`characteristic_id`) REFERENCES `products_gen_characteristics`.`Characteristics` (`characteristic_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/products_gen_characteristics/data/Product_Characteristics.csv' INTO TABLE `products_gen_characteristics`.`Product_Characteristics`;



--- Database: riding_club ----------------------------------------

create database if not exists `riding_club`;

drop table if exists `riding_club`.`player`;
CREATE TABLE IF NOT EXISTS `riding_club`.`player` (
    `Player_ID` INT,
    `Sponsor_name` STRING,
    `Player_name` STRING,
    `Gender` STRING,
    `Residence` STRING,
    `Occupation` STRING,
    `Votes` INT,
    `Rank` STRING,
    PRIMARY KEY (`Player_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/riding_club/data/player.csv' INTO TABLE `riding_club`.`player`;


drop table if exists `riding_club`.`club`;
CREATE TABLE IF NOT EXISTS `riding_club`.`club` (
    `Club_ID` INT,
    `Club_name` STRING,
    `Region` STRING,
    `Start_year` INT,
    PRIMARY KEY (`Club_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/riding_club/data/club.csv' INTO TABLE `riding_club`.`club`;


drop table if exists `riding_club`.`coach`;
CREATE TABLE IF NOT EXISTS `riding_club`.`coach` (
    `Coach_ID` INT,
    `Coach_name` STRING,
    `Gender` STRING,
    `Club_ID` INT,
    `Rank` INT,
    PRIMARY KEY (`Coach_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Club_ID`) REFERENCES `riding_club`.`club` (`Club_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/riding_club/data/coach.csv' INTO TABLE `riding_club`.`coach`;


drop table if exists `riding_club`.`player_coach`;
CREATE TABLE IF NOT EXISTS `riding_club`.`player_coach` (
    `Player_ID` INT,
    `Coach_ID` INT,
    `Starting_year` INT,
    PRIMARY KEY (`Player_ID`, `Coach_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Coach_ID`) REFERENCES `riding_club`.`coach` (`Coach_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Player_ID`) REFERENCES `riding_club`.`player` (`Player_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/riding_club/data/player_coach.csv' INTO TABLE `riding_club`.`player_coach`;


drop table if exists `riding_club`.`match_result`;
CREATE TABLE IF NOT EXISTS `riding_club`.`match_result` (
    `Rank` INT,
    `Club_ID` INT,
    `Gold` INT,
    `Big_Silver` INT,
    `Small_Silver` INT,
    `Bronze` INT,
    `Points` INT,
    PRIMARY KEY (`Rank`, `Club_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Club_ID`) REFERENCES `riding_club`.`club` (`Club_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/riding_club/data/match_result.csv' INTO TABLE `riding_club`.`match_result`;



--- Database: loan_1 ----------------------------------------

create database if not exists `loan_1`;

drop table if exists `loan_1`.`bank`;
CREATE TABLE IF NOT EXISTS `loan_1`.`bank` (
    `branch_ID` INT,
    `bname` STRING,
    `no_of_customers` INT,
    `city` STRING,
    `state` STRING,
    PRIMARY KEY (`branch_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/loan_1/data/bank.csv' INTO TABLE `loan_1`.`bank`;


drop table if exists `loan_1`.`customer`;
CREATE TABLE IF NOT EXISTS `loan_1`.`customer` (
    `cust_ID` INT,
    `cust_name` STRING,
    `acc_type` CHAR(1),
    `acc_bal` INT,
    `no_of_loans` INT,
    `credit_score` INT,
    `branch_ID` INT,
    `state` STRING,
    PRIMARY KEY (`cust_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`branch_ID`) REFERENCES `loan_1`.`bank` (`branch_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/loan_1/data/customer.csv' INTO TABLE `loan_1`.`customer`;


drop table if exists `loan_1`.`loan`;
CREATE TABLE IF NOT EXISTS `loan_1`.`loan` (
    `loan_ID` INT,
    `loan_type` STRING,
    `cust_ID` INT,
    `branch_ID` INT,
    `amount` INT,
    PRIMARY KEY (`loan_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`cust_ID`) REFERENCES `loan_1`.`customer` (`Cust_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`branch_ID`) REFERENCES `loan_1`.`bank` (`branch_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/loan_1/data/loan.csv' INTO TABLE `loan_1`.`loan`;



--- Database: small_bank_1 ----------------------------------------

create database if not exists `small_bank_1`;

drop table if exists `small_bank_1`.`ACCOUNTS`;
CREATE TABLE IF NOT EXISTS `small_bank_1`.`ACCOUNTS` (
    `custid` BIGINT NOT NULL,
    `name` STRING NOT NULL,
    PRIMARY KEY (`custid`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/small_bank_1/data/ACCOUNTS.csv' INTO TABLE `small_bank_1`.`ACCOUNTS`;


drop table if exists `small_bank_1`.`SAVINGS`;
CREATE TABLE IF NOT EXISTS `small_bank_1`.`SAVINGS` (
    `custid` BIGINT NOT NULL,
    `balance` DECIMAL NOT NULL,
    PRIMARY KEY (`custid`) DISABLE NOVALIDATE,
    FOREIGN KEY (`custid`) REFERENCES `small_bank_1`.`ACCOUNTS` (`custid`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/small_bank_1/data/SAVINGS.csv' INTO TABLE `small_bank_1`.`SAVINGS`;


drop table if exists `small_bank_1`.`CHECKING`;
CREATE TABLE IF NOT EXISTS `small_bank_1`.`CHECKING` (
    `custid` BIGINT NOT NULL,
    `balance` DECIMAL NOT NULL,
    PRIMARY KEY (`custid`) DISABLE NOVALIDATE,
    FOREIGN KEY (`custid`) REFERENCES `small_bank_1`.`ACCOUNTS` (`custid`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/small_bank_1/data/CHECKING.csv' INTO TABLE `small_bank_1`.`CHECKING`;



--- Database: flight_company ----------------------------------------

create database if not exists `flight_company`;

drop table if exists `flight_company`.`airport`;
CREATE TABLE IF NOT EXISTS `flight_company`.`airport` (
    `id` INT,
    `City` STRING,
    `Country` STRING,
    `IATA` STRING,
    `ICAO` STRING,
    `name` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/flight_company/data/airport.csv' INTO TABLE `flight_company`.`airport`;


drop table if exists `flight_company`.`operate_company`;
CREATE TABLE IF NOT EXISTS `flight_company`.`operate_company` (
    `id` INT,
    `name` STRING,
    `Type` STRING,
    `Principal_activities` STRING,
    `Incorporated_in` STRING,
    `Group_Equity_Shareholding` REAL,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/flight_company/data/operate_company.csv' INTO TABLE `flight_company`.`operate_company`;


drop table if exists `flight_company`.`flight`;
CREATE TABLE IF NOT EXISTS `flight_company`.`flight` (
    `id` INT,
    `Vehicle_Flight_number` STRING,
    `Date` STRING,
    `Pilot` STRING,
    `Velocity` REAL,
    `Altitude` REAL,
    `airport_id` INT,
    `company_id` INT,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`company_id`) REFERENCES `flight_company`.`operate_company` (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`airport_id`) REFERENCES `flight_company`.`airport` (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/flight_company/data/flight.csv' INTO TABLE `flight_company`.`flight`;



--- Database: manufactory_1 ----------------------------------------

create database if not exists `manufactory_1`;

drop table if exists `manufactory_1`.`Manufacturers`;
CREATE TABLE IF NOT EXISTS `manufactory_1`.`Manufacturers` (
    `Code` INT,
    `Name` STRING NOT NULL,
    `Headquarter` STRING NOT NULL,
    `Founder` STRING NOT NULL,
    `Revenue` REAL,
    PRIMARY KEY (`Code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/manufactory_1/data/Manufacturers.csv' INTO TABLE `manufactory_1`.`Manufacturers`;


drop table if exists `manufactory_1`.`Products`;
CREATE TABLE IF NOT EXISTS `manufactory_1`.`Products` (
    `Code` INT,
    `Name` STRING NOT NULL,
    `Price` DECIMAL NOT NULL,
    `Manufacturer` INT NOT NULL,
    PRIMARY KEY (`Code`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Manufacturer`) REFERENCES `manufactory_1`.`Manufacturers` (`Code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/manufactory_1/data/Products.csv' INTO TABLE `manufactory_1`.`Products`;



--- Database: customers_and_addresses ----------------------------------------

create database if not exists `customers_and_addresses`;

drop table if exists `customers_and_addresses`.`Addresses`;
CREATE TABLE IF NOT EXISTS `customers_and_addresses`.`Addresses` (
    `address_id` INT,
    `address_content` STRING,
    `city` STRING,
    `zip_postcode` STRING,
    `state_province_county` STRING,
    `country` STRING,
    `other_address_details` STRING,
    PRIMARY KEY (`address_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_and_addresses/data/Addresses.csv' INTO TABLE `customers_and_addresses`.`Addresses`;


drop table if exists `customers_and_addresses`.`Products`;
CREATE TABLE IF NOT EXISTS `customers_and_addresses`.`Products` (
    `product_id` INT,
    `product_details` STRING,
    PRIMARY KEY (`product_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_and_addresses/data/Products.csv' INTO TABLE `customers_and_addresses`.`Products`;


drop table if exists `customers_and_addresses`.`Customers`;
CREATE TABLE IF NOT EXISTS `customers_and_addresses`.`Customers` (
    `customer_id` INT,
    `payment_method` STRING NOT NULL,
    `customer_name` STRING,
    `date_became_customer` TIMESTAMP,
    `other_customer_details` STRING,
    PRIMARY KEY (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_and_addresses/data/Customers.csv' INTO TABLE `customers_and_addresses`.`Customers`;


drop table if exists `customers_and_addresses`.`Customer_Addresses`;
CREATE TABLE IF NOT EXISTS `customers_and_addresses`.`Customer_Addresses` (
    `customer_id` INT NOT NULL,
    `address_id` INT NOT NULL,
    `date_address_from` TIMESTAMP NOT NULL,
    `address_type` STRING NOT NULL,
    `date_address_to` TIMESTAMP,
    FOREIGN KEY (`customer_id`) REFERENCES `customers_and_addresses`.`Customers` (`customer_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`address_id`) REFERENCES `customers_and_addresses`.`Addresses` (`address_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_and_addresses/data/Customer_Addresses.csv' INTO TABLE `customers_and_addresses`.`Customer_Addresses`;


drop table if exists `customers_and_addresses`.`Customer_Contact_Channels`;
CREATE TABLE IF NOT EXISTS `customers_and_addresses`.`Customer_Contact_Channels` (
    `customer_id` INT NOT NULL,
    `channel_code` STRING NOT NULL,
    `active_from_date` TIMESTAMP NOT NULL,
    `active_to_date` TIMESTAMP,
    `contact_number` STRING NOT NULL,
    FOREIGN KEY (`customer_id`) REFERENCES `customers_and_addresses`.`Customers` (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_and_addresses/data/Customer_Contact_Channels.csv' INTO TABLE `customers_and_addresses`.`Customer_Contact_Channels`;


drop table if exists `customers_and_addresses`.`Customer_Orders`;
CREATE TABLE IF NOT EXISTS `customers_and_addresses`.`Customer_Orders` (
    `order_id` INT,
    `customer_id` INT NOT NULL,
    `order_status` STRING NOT NULL,
    `order_date` TIMESTAMP,
    `order_details` STRING,
    PRIMARY KEY (`order_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`customer_id`) REFERENCES `customers_and_addresses`.`Customers` (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_and_addresses/data/Customer_Orders.csv' INTO TABLE `customers_and_addresses`.`Customer_Orders`;


drop table if exists `customers_and_addresses`.`Order_Items`;
CREATE TABLE IF NOT EXISTS `customers_and_addresses`.`Order_Items` (
    `order_id` INT NOT NULL,
    `product_id` INT NOT NULL,
    `order_quantity` STRING,
    FOREIGN KEY (`order_id`) REFERENCES `customers_and_addresses`.`Customer_Orders` (`order_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`product_id`) REFERENCES `customers_and_addresses`.`Products` (`product_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_and_addresses/data/Order_Items.csv' INTO TABLE `customers_and_addresses`.`Order_Items`;



--- Database: station_weather ----------------------------------------

create database if not exists `station_weather`;

drop table if exists `station_weather`.`train`;
CREATE TABLE IF NOT EXISTS `station_weather`.`train` (
    `id` INT,
    `train_number` INT,
    `name` STRING,
    `origin` STRING,
    `destination` STRING,
    `time` STRING,
    `interval` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/station_weather/data/train.csv' INTO TABLE `station_weather`.`train`;


drop table if exists `station_weather`.`station`;
CREATE TABLE IF NOT EXISTS `station_weather`.`station` (
    `id` INT,
    `network_name` STRING,
    `services` STRING,
    `local_authority` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/station_weather/data/station.csv' INTO TABLE `station_weather`.`station`;


drop table if exists `station_weather`.`route`;
CREATE TABLE IF NOT EXISTS `station_weather`.`route` (
    `train_id` INT,
    `station_id` INT,
    PRIMARY KEY (`train_id`, `station_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`station_id`) REFERENCES `station_weather`.`station` (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`train_id`) REFERENCES `station_weather`.`train` (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/station_weather/data/route.csv' INTO TABLE `station_weather`.`route`;


drop table if exists `station_weather`.`weekly_weather`;
CREATE TABLE IF NOT EXISTS `station_weather`.`weekly_weather` (
    `station_id` INT,
    `day_of_week` STRING,
    `high_temperature` INT,
    `low_temperature` INT,
    `precipitation` REAL,
    `wind_speed_mph` INT,
    PRIMARY KEY (`station_id`, `day_of_week`) DISABLE NOVALIDATE,
    FOREIGN KEY (`station_id`) REFERENCES `station_weather`.`station` (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/station_weather/data/weekly_weather.csv' INTO TABLE `station_weather`.`weekly_weather`;



--- Database: manufacturer ----------------------------------------

create database if not exists `manufacturer`;

drop table if exists `manufacturer`.`manufacturer`;
CREATE TABLE IF NOT EXISTS `manufacturer`.`manufacturer` (
    `Manufacturer_ID` INT,
    `Open_Year` REAL,
    `Name` STRING,
    `Num_of_Factories` INT,
    `Num_of_Shops` INT,
    PRIMARY KEY (`Manufacturer_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/manufacturer/data/manufacturer.csv' INTO TABLE `manufacturer`.`manufacturer`;


drop table if exists `manufacturer`.`furniture`;
CREATE TABLE IF NOT EXISTS `manufacturer`.`furniture` (
    `Furniture_ID` INT,
    `Name` STRING,
    `Num_of_Component` INT,
    `Market_Rate` REAL,
    PRIMARY KEY (`Furniture_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/manufacturer/data/furniture.csv' INTO TABLE `manufacturer`.`furniture`;


drop table if exists `manufacturer`.`furniture_manufacte`;
CREATE TABLE IF NOT EXISTS `manufacturer`.`furniture_manufacte` (
    `Manufacturer_ID` INT,
    `Furniture_ID` INT,
    `Price_in_Dollar` REAL,
    PRIMARY KEY (`Manufacturer_ID`, `Furniture_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Furniture_ID`) REFERENCES `manufacturer`.`furniture` (`Furniture_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Manufacturer_ID`) REFERENCES `manufacturer`.`manufacturer` (`Manufacturer_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/manufacturer/data/furniture_manufacte.csv' INTO TABLE `manufacturer`.`furniture_manufacte`;



--- Database: phone_market ----------------------------------------

create database if not exists `phone_market`;

drop table if exists `phone_market`.`phone`;
CREATE TABLE IF NOT EXISTS `phone_market`.`phone` (
    `Name` STRING,
    `Phone_ID` INT,
    `Memory_in_G` INT,
    `Carrier` STRING,
    `Price` REAL,
    PRIMARY KEY (`Phone_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/phone_market/data/phone.csv' INTO TABLE `phone_market`.`phone`;


drop table if exists `phone_market`.`market`;
CREATE TABLE IF NOT EXISTS `phone_market`.`market` (
    `Market_ID` INT,
    `District` STRING,
    `Num_of_employees` INT,
    `Num_of_shops` REAL,
    `Ranking` INT,
    PRIMARY KEY (`Market_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/phone_market/data/market.csv' INTO TABLE `phone_market`.`market`;


drop table if exists `phone_market`.`phone_market`;
CREATE TABLE IF NOT EXISTS `phone_market`.`phone_market` (
    `Market_ID` INT,
    `Phone_ID` INT,
    `Num_of_stock` INT,
    PRIMARY KEY (`Market_ID`, `Phone_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Phone_ID`) REFERENCES `phone_market`.`phone` (`Phone_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Market_ID`) REFERENCES `phone_market`.`market` (`Market_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/phone_market/data/phone_market.csv' INTO TABLE `phone_market`.`phone_market`;



--- Database: wta_1 ----------------------------------------

create database if not exists `wta_1`;

drop table if exists `wta_1`.`players`;
CREATE TABLE IF NOT EXISTS `wta_1`.`players` (
    `player_id` INT,
    `first_name` STRING,
    `last_name` STRING,
    `hand` STRING,
    `birth_date` DATE,
    `country_code` STRING,
    PRIMARY KEY (`player_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/wta_1/data/players.csv' INTO TABLE `wta_1`.`players`;


drop table if exists `wta_1`.`matches`;
CREATE TABLE IF NOT EXISTS `wta_1`.`matches` (
    `best_of` INT,
    `draw_size` INT,
    `loser_age` DECIMAL,
    `loser_entry` STRING,
    `loser_hand` STRING,
    `loser_ht` INT,
    `loser_id` INT,
    `loser_ioc` STRING,
    `loser_name` STRING,
    `loser_rank` INT,
    `loser_rank_points` INT,
    `loser_seed` INT,
    `match_num` INT,
    `minutes` INT,
    `round` STRING,
    `score` STRING,
    `surface` STRING,
    `tourney_date` DATE,
    `tourney_id` STRING,
    `tourney_level` STRING,
    `tourney_name` STRING,
    `winner_age` DECIMAL,
    `winner_entry` STRING,
    `winner_hand` STRING,
    `winner_ht` INT,
    `winner_id` INT,
    `winner_ioc` STRING,
    `winner_name` STRING,
    `winner_rank` INT,
    `winner_rank_points` INT,
    `winner_seed` INT,
    `year` INT,
    FOREIGN KEY (`winner_id`) REFERENCES `wta_1`.`players` (`player_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`loser_id`) REFERENCES `wta_1`.`players` (`player_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/wta_1/data/matches.csv' INTO TABLE `wta_1`.`matches`;


drop table if exists `wta_1`.`rankings`;
CREATE TABLE IF NOT EXISTS `wta_1`.`rankings` (
    `ranking_date` DATE,
    `ranking` INT,
    `player_id` INT,
    `ranking_points` INT,
    `tours` INT,
    FOREIGN KEY (`player_id`) REFERENCES `wta_1`.`players` (`player_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/wta_1/data/rankings.csv' INTO TABLE `wta_1`.`rankings`;



--- Database: perpetrator ----------------------------------------

create database if not exists `perpetrator`;

drop table if exists `perpetrator`.`people`;
CREATE TABLE IF NOT EXISTS `perpetrator`.`people` (
    `People_ID` INT,
    `Name` STRING,
    `Height` REAL,
    `Weight` REAL,
    `Home Town` STRING,
    PRIMARY KEY (`People_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/perpetrator/data/people.csv' INTO TABLE `perpetrator`.`people`;


drop table if exists `perpetrator`.`perpetrator`;
CREATE TABLE IF NOT EXISTS `perpetrator`.`perpetrator` (
    `Perpetrator_ID` INT,
    `People_ID` INT,
    `Date` STRING,
    `Year` REAL,
    `Location` STRING,
    `Country` STRING,
    `Killed` INT,
    `Injured` INT,
    PRIMARY KEY (`Perpetrator_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`People_ID`) REFERENCES `perpetrator`.`people` (`People_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/perpetrator/data/perpetrator.csv' INTO TABLE `perpetrator`.`perpetrator`;



--- Database: train_station ----------------------------------------

create database if not exists `train_station`;

drop table if exists `train_station`.`station`;
CREATE TABLE IF NOT EXISTS `train_station`.`station` (
    `Station_ID` INT,
    `Name` STRING,
    `Annual_entry_exit` REAL,
    `Annual_interchanges` REAL,
    `Total_Passengers` REAL,
    `Location` STRING,
    `Main_Services` STRING,
    `Number_of_Platforms` INT,
    PRIMARY KEY (`Station_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/train_station/data/station.csv' INTO TABLE `train_station`.`station`;


drop table if exists `train_station`.`train`;
CREATE TABLE IF NOT EXISTS `train_station`.`train` (
    `Train_ID` INT,
    `Name` STRING,
    `Time` STRING,
    `Service` STRING,
    PRIMARY KEY (`Train_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/train_station/data/train.csv' INTO TABLE `train_station`.`train`;


drop table if exists `train_station`.`train_station`;
CREATE TABLE IF NOT EXISTS `train_station`.`train_station` (
    `Train_ID` INT,
    `Station_ID` INT,
    PRIMARY KEY (`Train_ID`, `Station_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Station_ID`) REFERENCES `train_station`.`station` (`Station_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Train_ID`) REFERENCES `train_station`.`train` (`Train_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/train_station/data/train_station.csv' INTO TABLE `train_station`.`train_station`;



--- Database: medicine_enzyme_interaction ----------------------------------------

create database if not exists `medicine_enzyme_interaction`;

drop table if exists `medicine_enzyme_interaction`.`medicine`;
CREATE TABLE IF NOT EXISTS `medicine_enzyme_interaction`.`medicine` (
    `id` INT,
    `name` STRING,
    `Trade_Name` STRING,
    `FDA_approved` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/medicine_enzyme_interaction/data/medicine.csv' INTO TABLE `medicine_enzyme_interaction`.`medicine`;


drop table if exists `medicine_enzyme_interaction`.`enzyme`;
CREATE TABLE IF NOT EXISTS `medicine_enzyme_interaction`.`enzyme` (
    `id` INT,
    `name` STRING,
    `Location` STRING,
    `Product` STRING,
    `Chromosome` STRING,
    `OMIM` INT,
    `Porphyria` STRING,
    PRIMARY KEY (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/medicine_enzyme_interaction/data/enzyme.csv' INTO TABLE `medicine_enzyme_interaction`.`enzyme`;


drop table if exists `medicine_enzyme_interaction`.`medicine_enzyme_interaction`;
CREATE TABLE IF NOT EXISTS `medicine_enzyme_interaction`.`medicine_enzyme_interaction` (
    `enzyme_id` INT,
    `medicine_id` INT,
    `interaction_type` STRING,
    PRIMARY KEY (`enzyme_id`, `medicine_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`medicine_id`) REFERENCES `medicine_enzyme_interaction`.`medicine` (`id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`enzyme_id`) REFERENCES `medicine_enzyme_interaction`.`enzyme` (`id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/medicine_enzyme_interaction/data/medicine_enzyme_interaction.csv' INTO TABLE `medicine_enzyme_interaction`.`medicine_enzyme_interaction`;



--- Database: chinook_1 ----------------------------------------

create database if not exists `chinook_1`;

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



--- Database: driving_school ----------------------------------------

create database if not exists `driving_school`;

drop table if exists `driving_school`.`Addresses`;
CREATE TABLE IF NOT EXISTS `driving_school`.`Addresses` (
    `address_id` INT,
    `line_1_number_building` STRING,
    `city` STRING,
    `zip_postcode` STRING,
    `state_province_county` STRING,
    `country` STRING,
    PRIMARY KEY (`address_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/driving_school/data/Addresses.csv' INTO TABLE `driving_school`.`Addresses`;


drop table if exists `driving_school`.`Staff`;
CREATE TABLE IF NOT EXISTS `driving_school`.`Staff` (
    `staff_id` INT,
    `staff_address_id` INT NOT NULL,
    `nickname` STRING,
    `first_name` STRING,
    `middle_name` STRING,
    `last_name` STRING,
    `date_of_birth` TIMESTAMP,
    `date_joined_staff` TIMESTAMP,
    `date_left_staff` TIMESTAMP,
    PRIMARY KEY (`staff_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`staff_address_id`) REFERENCES `driving_school`.`Addresses` (`address_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/driving_school/data/Staff.csv' INTO TABLE `driving_school`.`Staff`;


drop table if exists `driving_school`.`Vehicles`;
CREATE TABLE IF NOT EXISTS `driving_school`.`Vehicles` (
    `vehicle_id` INT,
    `vehicle_details` STRING,
    PRIMARY KEY (`vehicle_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/driving_school/data/Vehicles.csv' INTO TABLE `driving_school`.`Vehicles`;


drop table if exists `driving_school`.`Customers`;
CREATE TABLE IF NOT EXISTS `driving_school`.`Customers` (
    `customer_id` INT,
    `customer_address_id` INT NOT NULL,
    `customer_status_code` STRING NOT NULL,
    `date_became_customer` TIMESTAMP,
    `date_of_birth` TIMESTAMP,
    `first_name` STRING,
    `last_name` STRING,
    `amount_outstanding` REAL,
    `email_address` STRING,
    `phone_number` STRING,
    `cell_mobile_phone_number` STRING,
    PRIMARY KEY (`customer_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`customer_address_id`) REFERENCES `driving_school`.`Addresses` (`address_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/driving_school/data/Customers.csv' INTO TABLE `driving_school`.`Customers`;


drop table if exists `driving_school`.`Customer_Payments`;
CREATE TABLE IF NOT EXISTS `driving_school`.`Customer_Payments` (
    `customer_id` INT NOT NULL,
    `datetime_payment` TIMESTAMP NOT NULL,
    `payment_method_code` STRING NOT NULL,
    `amount_payment` REAL,
    PRIMARY KEY (`customer_id`, `datetime_payment`) DISABLE NOVALIDATE,
    FOREIGN KEY (`customer_id`) REFERENCES `driving_school`.`Customers` (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/driving_school/data/Customer_Payments.csv' INTO TABLE `driving_school`.`Customer_Payments`;


drop table if exists `driving_school`.`Lessons`;
CREATE TABLE IF NOT EXISTS `driving_school`.`Lessons` (
    `lesson_id` INT,
    `customer_id` INT NOT NULL,
    `lesson_status_code` STRING NOT NULL,
    `staff_id` INT,
    `vehicle_id` INT NOT NULL,
    `lesson_date` TIMESTAMP,
    `lesson_time` STRING,
    `price` REAL,
    PRIMARY KEY (`lesson_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`customer_id`) REFERENCES `driving_school`.`Customers` (`customer_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`staff_id`) REFERENCES `driving_school`.`Staff` (`staff_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`vehicle_id`) REFERENCES `driving_school`.`Vehicles` (`vehicle_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/driving_school/data/Lessons.csv' INTO TABLE `driving_school`.`Lessons`;



--- Database: news_report ----------------------------------------

create database if not exists `news_report`;

drop table if exists `news_report`.`event`;
CREATE TABLE IF NOT EXISTS `news_report`.`event` (
    `Event_ID` INT,
    `Date` STRING,
    `Venue` STRING,
    `Name` STRING,
    `Event_Attendance` INT,
    PRIMARY KEY (`Event_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/news_report/data/event.csv' INTO TABLE `news_report`.`event`;


drop table if exists `news_report`.`journalist`;
CREATE TABLE IF NOT EXISTS `news_report`.`journalist` (
    `journalist_ID` INT,
    `Name` STRING,
    `Nationality` STRING,
    `Age` STRING,
    `Years_working` INT,
    PRIMARY KEY (`journalist_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/news_report/data/journalist.csv' INTO TABLE `news_report`.`journalist`;


drop table if exists `news_report`.`news_report`;
CREATE TABLE IF NOT EXISTS `news_report`.`news_report` (
    `journalist_ID` INT,
    `Event_ID` INT,
    `Work_Type` STRING,
    PRIMARY KEY (`journalist_ID`, `Event_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Event_ID`) REFERENCES `news_report`.`event` (`Event_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`journalist_ID`) REFERENCES `news_report`.`journalist` (`journalist_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/news_report/data/news_report.csv' INTO TABLE `news_report`.`news_report`;



--- Database: icfp_1 ----------------------------------------

create database if not exists `icfp_1`;

drop table if exists `icfp_1`.`Inst`;
CREATE TABLE IF NOT EXISTS `icfp_1`.`Inst` (
    `instID` INT,
    `name` STRING,
    `country` STRING,
    PRIMARY KEY (`instID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/icfp_1/data/Inst.csv' INTO TABLE `icfp_1`.`Inst`;


drop table if exists `icfp_1`.`Authors`;
CREATE TABLE IF NOT EXISTS `icfp_1`.`Authors` (
    `authID` INT,
    `lname` STRING,
    `fname` STRING,
    PRIMARY KEY (`authID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/icfp_1/data/Authors.csv' INTO TABLE `icfp_1`.`Authors`;


drop table if exists `icfp_1`.`Papers`;
CREATE TABLE IF NOT EXISTS `icfp_1`.`Papers` (
    `paperID` INT,
    `title` STRING,
    PRIMARY KEY (`paperID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/icfp_1/data/Papers.csv' INTO TABLE `icfp_1`.`Papers`;


drop table if exists `icfp_1`.`Authorship`;
CREATE TABLE IF NOT EXISTS `icfp_1`.`Authorship` (
    `authID` INT,
    `instID` INT,
    `paperID` INT,
    `authOrder` INT,
    PRIMARY KEY (`authID`, `instID`, `paperID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`paperID`) REFERENCES `icfp_1`.`Papers` (`paperID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`instID`) REFERENCES `icfp_1`.`Inst` (`instID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`authID`) REFERENCES `icfp_1`.`Authors` (`authID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/icfp_1/data/Authorship.csv' INTO TABLE `icfp_1`.`Authorship`;



--- Database: cre_Doc_Tracking_DB ----------------------------------------

create database if not exists `cre_Doc_Tracking_DB`;

drop table if exists `cre_Doc_Tracking_DB`.`Ref_Document_Types`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Tracking_DB`.`Ref_Document_Types` (
    `Document_Type_Code` CHAR(15) NOT NULL,
    `Document_Type_Name` STRING NOT NULL,
    `Document_Type_Description` STRING NOT NULL,
    PRIMARY KEY (`Document_Type_Code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Doc_Tracking_DB/data/Ref_Document_Types.csv' INTO TABLE `cre_Doc_Tracking_DB`.`Ref_Document_Types`;


drop table if exists `cre_Doc_Tracking_DB`.`Ref_Calendar`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Tracking_DB`.`Ref_Calendar` (
    `Calendar_Date` TIMESTAMP NOT NULL,
    `Day_Number` INT,
    PRIMARY KEY (`Calendar_Date`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Doc_Tracking_DB/data/Ref_Calendar.csv' INTO TABLE `cre_Doc_Tracking_DB`.`Ref_Calendar`;


drop table if exists `cre_Doc_Tracking_DB`.`Ref_Locations`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Tracking_DB`.`Ref_Locations` (
    `Location_Code` CHAR(15) NOT NULL,
    `Location_Name` STRING NOT NULL,
    `Location_Description` STRING NOT NULL,
    PRIMARY KEY (`Location_Code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Doc_Tracking_DB/data/Ref_Locations.csv' INTO TABLE `cre_Doc_Tracking_DB`.`Ref_Locations`;


drop table if exists `cre_Doc_Tracking_DB`.`Roles`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Tracking_DB`.`Roles` (
    `Role_Code` CHAR(15) NOT NULL,
    `Role_Name` STRING,
    `Role_Description` STRING,
    PRIMARY KEY (`Role_Code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Doc_Tracking_DB/data/Roles.csv' INTO TABLE `cre_Doc_Tracking_DB`.`Roles`;


drop table if exists `cre_Doc_Tracking_DB`.`All_Documents`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Tracking_DB`.`All_Documents` (
    `Document_ID` INT NOT NULL,
    `Date_Stored` TIMESTAMP,
    `Document_Type_Code` CHAR(15) NOT NULL,
    `Document_Name` CHAR(255),
    `Document_Description` CHAR(255),
    `Other_Details` STRING,
    PRIMARY KEY (`Document_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Date_Stored`) REFERENCES `cre_Doc_Tracking_DB`.`Ref_Calendar` (`Calendar_Date`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Document_Type_Code`) REFERENCES `cre_Doc_Tracking_DB`.`Ref_Document_Types` (`Document_Type_Code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Doc_Tracking_DB/data/All_Documents.csv' INTO TABLE `cre_Doc_Tracking_DB`.`All_Documents`;


drop table if exists `cre_Doc_Tracking_DB`.`Employees`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Tracking_DB`.`Employees` (
    `Employee_ID` INT NOT NULL,
    `Role_Code` CHAR(15) NOT NULL,
    `Employee_Name` STRING,
    `Gender_MFU` CHAR(1) NOT NULL,
    `Date_of_Birth` TIMESTAMP NOT NULL,
    `Other_Details` STRING,
    PRIMARY KEY (`Employee_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Role_Code`) REFERENCES `cre_Doc_Tracking_DB`.`Roles` (`Role_Code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Doc_Tracking_DB/data/Employees.csv' INTO TABLE `cre_Doc_Tracking_DB`.`Employees`;


drop table if exists `cre_Doc_Tracking_DB`.`Document_Locations`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Tracking_DB`.`Document_Locations` (
    `Document_ID` INT NOT NULL,
    `Location_Code` CHAR(15) NOT NULL,
    `Date_in_Location_From` TIMESTAMP NOT NULL,
    `Date_in_Locaton_To` TIMESTAMP,
    PRIMARY KEY (`Document_ID`, `Location_Code`, `Date_in_Location_From`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Document_ID`) REFERENCES `cre_Doc_Tracking_DB`.`All_Documents` (`Document_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Date_in_Locaton_To`) REFERENCES `cre_Doc_Tracking_DB`.`Ref_Calendar` (`Calendar_Date`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Date_in_Location_From`) REFERENCES `cre_Doc_Tracking_DB`.`Ref_Calendar` (`Calendar_Date`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Location_Code`) REFERENCES `cre_Doc_Tracking_DB`.`Ref_Locations` (`Location_Code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Doc_Tracking_DB/data/Document_Locations.csv' INTO TABLE `cre_Doc_Tracking_DB`.`Document_Locations`;


drop table if exists `cre_Doc_Tracking_DB`.`Documents_to_be_Destroyed`;
CREATE TABLE IF NOT EXISTS `cre_Doc_Tracking_DB`.`Documents_to_be_Destroyed` (
    `Document_ID` INT NOT NULL,
    `Destruction_Authorised_by_Employee_ID` INT,
    `Destroyed_by_Employee_ID` INT,
    `Planned_Destruction_Date` TIMESTAMP,
    `Actual_Destruction_Date` TIMESTAMP,
    `Other_Details` STRING,
    PRIMARY KEY (`Document_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Document_ID`) REFERENCES `cre_Doc_Tracking_DB`.`All_Documents` (`Document_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Actual_Destruction_Date`) REFERENCES `cre_Doc_Tracking_DB`.`Ref_Calendar` (`Calendar_Date`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Planned_Destruction_Date`) REFERENCES `cre_Doc_Tracking_DB`.`Ref_Calendar` (`Calendar_Date`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Destruction_Authorised_by_Employee_ID`) REFERENCES `cre_Doc_Tracking_DB`.`Employees` (`Employee_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Destroyed_by_Employee_ID`) REFERENCES `cre_Doc_Tracking_DB`.`Employees` (`Employee_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cre_Doc_Tracking_DB/data/Documents_to_be_Destroyed.csv' INTO TABLE `cre_Doc_Tracking_DB`.`Documents_to_be_Destroyed`;



--- Database: behavior_monitoring ----------------------------------------

create database if not exists `behavior_monitoring`;

drop table if exists `behavior_monitoring`.`Ref_Address_Types`;
CREATE TABLE IF NOT EXISTS `behavior_monitoring`.`Ref_Address_Types` (
    `address_type_code` STRING,
    `address_type_description` STRING,
    PRIMARY KEY (`address_type_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/behavior_monitoring/data/Ref_Address_Types.csv' INTO TABLE `behavior_monitoring`.`Ref_Address_Types`;


drop table if exists `behavior_monitoring`.`Ref_Detention_Type`;
CREATE TABLE IF NOT EXISTS `behavior_monitoring`.`Ref_Detention_Type` (
    `detention_type_code` STRING,
    `detention_type_description` STRING,
    PRIMARY KEY (`detention_type_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/behavior_monitoring/data/Ref_Detention_Type.csv' INTO TABLE `behavior_monitoring`.`Ref_Detention_Type`;


drop table if exists `behavior_monitoring`.`Ref_Incident_Type`;
CREATE TABLE IF NOT EXISTS `behavior_monitoring`.`Ref_Incident_Type` (
    `incident_type_code` STRING,
    `incident_type_description` STRING,
    PRIMARY KEY (`incident_type_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/behavior_monitoring/data/Ref_Incident_Type.csv' INTO TABLE `behavior_monitoring`.`Ref_Incident_Type`;


drop table if exists `behavior_monitoring`.`Addresses`;
CREATE TABLE IF NOT EXISTS `behavior_monitoring`.`Addresses` (
    `address_id` INT,
    `line_1` STRING,
    `line_2` STRING,
    `line_3` STRING,
    `city` STRING,
    `zip_postcode` STRING,
    `state_province_county` STRING,
    `country` STRING,
    `other_address_details` STRING,
    PRIMARY KEY (`address_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/behavior_monitoring/data/Addresses.csv' INTO TABLE `behavior_monitoring`.`Addresses`;


drop table if exists `behavior_monitoring`.`Students`;
CREATE TABLE IF NOT EXISTS `behavior_monitoring`.`Students` (
    `student_id` INT,
    `address_id` INT NOT NULL,
    `first_name` STRING,
    `middle_name` STRING,
    `last_name` STRING,
    `cell_mobile_number` STRING,
    `email_address` STRING,
    `date_first_rental` TIMESTAMP,
    `date_left_university` TIMESTAMP,
    `other_student_details` STRING,
    PRIMARY KEY (`student_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`address_id`) REFERENCES `behavior_monitoring`.`Addresses` (`address_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/behavior_monitoring/data/Students.csv' INTO TABLE `behavior_monitoring`.`Students`;


drop table if exists `behavior_monitoring`.`Teachers`;
CREATE TABLE IF NOT EXISTS `behavior_monitoring`.`Teachers` (
    `teacher_id` INT,
    `address_id` INT NOT NULL,
    `first_name` STRING,
    `middle_name` STRING,
    `last_name` STRING,
    `gender` STRING,
    `cell_mobile_number` STRING,
    `email_address` STRING,
    `other_details` STRING,
    PRIMARY KEY (`teacher_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`address_id`) REFERENCES `behavior_monitoring`.`Addresses` (`address_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/behavior_monitoring/data/Teachers.csv' INTO TABLE `behavior_monitoring`.`Teachers`;


drop table if exists `behavior_monitoring`.`Assessment_Notes`;
CREATE TABLE IF NOT EXISTS `behavior_monitoring`.`Assessment_Notes` (
    `notes_id` INT NOT NULL,
    `student_id` INT,
    `teacher_id` INT NOT NULL,
    `date_of_notes` TIMESTAMP,
    `text_of_notes` STRING,
    `other_details` STRING,
    FOREIGN KEY (`teacher_id`) REFERENCES `behavior_monitoring`.`Teachers` (`teacher_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`student_id`) REFERENCES `behavior_monitoring`.`Students` (`student_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/behavior_monitoring/data/Assessment_Notes.csv' INTO TABLE `behavior_monitoring`.`Assessment_Notes`;


drop table if exists `behavior_monitoring`.`Behavior_Incident`;
CREATE TABLE IF NOT EXISTS `behavior_monitoring`.`Behavior_Incident` (
    `incident_id` INT,
    `incident_type_code` STRING NOT NULL,
    `student_id` INT NOT NULL,
    `date_incident_start` TIMESTAMP,
    `date_incident_end` TIMESTAMP,
    `incident_summary` STRING,
    `recommendations` STRING,
    `other_details` STRING,
    PRIMARY KEY (`incident_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`student_id`) REFERENCES `behavior_monitoring`.`Students` (`student_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`incident_type_code`) REFERENCES `behavior_monitoring`.`Ref_Incident_Type` (`incident_type_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/behavior_monitoring/data/Behavior_Incident.csv' INTO TABLE `behavior_monitoring`.`Behavior_Incident`;


drop table if exists `behavior_monitoring`.`Detention`;
CREATE TABLE IF NOT EXISTS `behavior_monitoring`.`Detention` (
    `detention_id` INT,
    `detention_type_code` STRING NOT NULL,
    `teacher_id` INT,
    `datetime_detention_start` TIMESTAMP,
    `datetime_detention_end` TIMESTAMP,
    `detention_summary` STRING,
    `other_details` STRING,
    PRIMARY KEY (`detention_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`teacher_id`) REFERENCES `behavior_monitoring`.`Teachers` (`teacher_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`detention_type_code`) REFERENCES `behavior_monitoring`.`Ref_Detention_Type` (`detention_type_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/behavior_monitoring/data/Detention.csv' INTO TABLE `behavior_monitoring`.`Detention`;


drop table if exists `behavior_monitoring`.`Student_Addresses`;
CREATE TABLE IF NOT EXISTS `behavior_monitoring`.`Student_Addresses` (
    `student_id` INT NOT NULL,
    `address_id` INT NOT NULL,
    `date_address_from` TIMESTAMP NOT NULL,
    `date_address_to` TIMESTAMP,
    `monthly_rental` DECIMAL(19,4),
    `other_details` STRING,
    FOREIGN KEY (`student_id`) REFERENCES `behavior_monitoring`.`Students` (`student_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`address_id`) REFERENCES `behavior_monitoring`.`Addresses` (`address_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/behavior_monitoring/data/Student_Addresses.csv' INTO TABLE `behavior_monitoring`.`Student_Addresses`;


drop table if exists `behavior_monitoring`.`Students_in_Detention`;
CREATE TABLE IF NOT EXISTS `behavior_monitoring`.`Students_in_Detention` (
    `student_id` INT NOT NULL,
    `detention_id` INT NOT NULL,
    `incident_id` INT NOT NULL,
    FOREIGN KEY (`student_id`) REFERENCES `behavior_monitoring`.`Students` (`student_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`detention_id`) REFERENCES `behavior_monitoring`.`Detention` (`detention_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`incident_id`) REFERENCES `behavior_monitoring`.`Behavior_Incident` (`incident_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/behavior_monitoring/data/Students_in_Detention.csv' INTO TABLE `behavior_monitoring`.`Students_in_Detention`;



--- Database: restaurant_1 ----------------------------------------

create database if not exists `restaurant_1`;

drop table if exists `restaurant_1`.`Student`;
CREATE TABLE IF NOT EXISTS `restaurant_1`.`Student` (
    `StuID` INT,
    `LName` STRING,
    `Fname` STRING,
    `Age` INT,
    `Sex` STRING,
    `Major` INT,
    `Advisor` INT,
    `city_code` STRING,
    PRIMARY KEY (`StuID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/restaurant_1/data/Student.csv' INTO TABLE `restaurant_1`.`Student`;


drop table if exists `restaurant_1`.`Restaurant_Type`;
CREATE TABLE IF NOT EXISTS `restaurant_1`.`Restaurant_Type` (
    `ResTypeID` INT,
    `ResTypeName` STRING,
    `ResTypeDescription` STRING,
    PRIMARY KEY (`ResTypeID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/restaurant_1/data/Restaurant_Type.csv' INTO TABLE `restaurant_1`.`Restaurant_Type`;


drop table if exists `restaurant_1`.`Restaurant`;
CREATE TABLE IF NOT EXISTS `restaurant_1`.`Restaurant` (
    `ResID` INT,
    `ResName` STRING,
    `Address` STRING,
    `Rating` INT,
    PRIMARY KEY (`ResID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/restaurant_1/data/Restaurant.csv' INTO TABLE `restaurant_1`.`Restaurant`;


drop table if exists `restaurant_1`.`Type_Of_Restaurant`;
CREATE TABLE IF NOT EXISTS `restaurant_1`.`Type_Of_Restaurant` (
    `ResID` INT,
    `ResTypeID` INT,
    FOREIGN KEY (`ResTypeID`) REFERENCES `restaurant_1`.`Restaurant_Type` (`ResTypeID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`ResID`) REFERENCES `restaurant_1`.`Restaurant` (`ResID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/restaurant_1/data/Type_Of_Restaurant.csv' INTO TABLE `restaurant_1`.`Type_Of_Restaurant`;


drop table if exists `restaurant_1`.`Visits_Restaurant`;
CREATE TABLE IF NOT EXISTS `restaurant_1`.`Visits_Restaurant` (
    `StuID` INT,
    `ResID` INT,
    `Time` TIMESTAMP,
    `Spent` DECIMAL,
    FOREIGN KEY (`ResID`) REFERENCES `restaurant_1`.`Restaurant` (`ResID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`StuID`) REFERENCES `restaurant_1`.`Student` (`StuID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/restaurant_1/data/Visits_Restaurant.csv' INTO TABLE `restaurant_1`.`Visits_Restaurant`;



--- Database: product_catalog ----------------------------------------

create database if not exists `product_catalog`;

drop table if exists `product_catalog`.`Attribute_Definitions`;
CREATE TABLE IF NOT EXISTS `product_catalog`.`Attribute_Definitions` (
    `attribute_id` INT,
    `attribute_name` STRING,
    `attribute_data_type` STRING,
    PRIMARY KEY (`attribute_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/product_catalog/data/Attribute_Definitions.csv' INTO TABLE `product_catalog`.`Attribute_Definitions`;


drop table if exists `product_catalog`.`Catalogs`;
CREATE TABLE IF NOT EXISTS `product_catalog`.`Catalogs` (
    `catalog_id` INT,
    `catalog_name` STRING,
    `catalog_publisher` STRING,
    `date_of_publication` TIMESTAMP,
    `date_of_latest_revision` TIMESTAMP,
    PRIMARY KEY (`catalog_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/product_catalog/data/Catalogs.csv' INTO TABLE `product_catalog`.`Catalogs`;


drop table if exists `product_catalog`.`Catalog_Structure`;
CREATE TABLE IF NOT EXISTS `product_catalog`.`Catalog_Structure` (
    `catalog_level_number` INT,
    `catalog_id` INT NOT NULL,
    `catalog_level_name` STRING,
    PRIMARY KEY (`catalog_level_number`) DISABLE NOVALIDATE,
    FOREIGN KEY (`catalog_id`) REFERENCES `product_catalog`.`Catalogs` (`catalog_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/product_catalog/data/Catalog_Structure.csv' INTO TABLE `product_catalog`.`Catalog_Structure`;


drop table if exists `product_catalog`.`Catalog_Contents`;
CREATE TABLE IF NOT EXISTS `product_catalog`.`Catalog_Contents` (
    `catalog_entry_id` INT,
    `catalog_level_number` INT NOT NULL,
    `parent_entry_id` INT,
    `previous_entry_id` INT,
    `next_entry_id` INT,
    `catalog_entry_name` STRING,
    `product_stock_number` STRING,
    `price_in_dollars` REAL,
    `price_in_euros` REAL,
    `price_in_pounds` REAL,
    `capacity` STRING,
    `length` STRING,
    `height` STRING,
    `width` STRING,
    PRIMARY KEY (`catalog_entry_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`catalog_level_number`) REFERENCES `product_catalog`.`Catalog_Structure` (`catalog_level_number`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/product_catalog/data/Catalog_Contents.csv' INTO TABLE `product_catalog`.`Catalog_Contents`;


drop table if exists `product_catalog`.`Catalog_Contents_Additional_Attributes`;
CREATE TABLE IF NOT EXISTS `product_catalog`.`Catalog_Contents_Additional_Attributes` (
    `catalog_entry_id` INT NOT NULL,
    `catalog_level_number` INT NOT NULL,
    `attribute_id` INT NOT NULL,
    `attribute_value` STRING NOT NULL,
    FOREIGN KEY (`catalog_level_number`) REFERENCES `product_catalog`.`Catalog_Structure` (`catalog_level_number`) DISABLE NOVALIDATE,
    FOREIGN KEY (`catalog_entry_id`) REFERENCES `product_catalog`.`Catalog_Contents` (`catalog_entry_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/product_catalog/data/Catalog_Contents_Additional_Attributes.csv' INTO TABLE `product_catalog`.`Catalog_Contents_Additional_Attributes`;



--- Database: csu_1 ----------------------------------------

create database if not exists `csu_1`;

drop table if exists `csu_1`.`Campuses`;
CREATE TABLE IF NOT EXISTS `csu_1`.`Campuses` (
    `Id` INT,
    `Campus` STRING,
    `Location` STRING,
    `County` STRING,
    `Year` INT,
    PRIMARY KEY (`Id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/csu_1/data/Campuses.csv' INTO TABLE `csu_1`.`Campuses`;


drop table if exists `csu_1`.`csu_fees`;
CREATE TABLE IF NOT EXISTS `csu_1`.`csu_fees` (
    `Campus` INT,
    `Year` INT,
    `CampusFee` INT,
    PRIMARY KEY (`Campus`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Campus`) REFERENCES `csu_1`.`Campuses` (`Id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/csu_1/data/csu_fees.csv' INTO TABLE `csu_1`.`csu_fees`;


drop table if exists `csu_1`.`degrees`;
CREATE TABLE IF NOT EXISTS `csu_1`.`degrees` (
    `Year` INT,
    `Campus` INT,
    `Degrees` INT,
    PRIMARY KEY (`Year`, `Campus`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Campus`) REFERENCES `csu_1`.`Campuses` (`Id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/csu_1/data/degrees.csv' INTO TABLE `csu_1`.`degrees`;


drop table if exists `csu_1`.`discipline_enrollments`;
CREATE TABLE IF NOT EXISTS `csu_1`.`discipline_enrollments` (
    `Campus` INT,
    `Discipline` INT,
    `Year` INT,
    `Undergraduate` INT,
    `Graduate` INT,
    PRIMARY KEY (`Campus`, `Discipline`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Campus`) REFERENCES `csu_1`.`Campuses` (`Id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/csu_1/data/discipline_enrollments.csv' INTO TABLE `csu_1`.`discipline_enrollments`;


drop table if exists `csu_1`.`enrollments`;
CREATE TABLE IF NOT EXISTS `csu_1`.`enrollments` (
    `Campus` INT,
    `Year` INT,
    `TotalEnrollment_AY` INT,
    `FTE_AY` INT,
    PRIMARY KEY (`Campus`, `Year`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Campus`) REFERENCES `csu_1`.`Campuses` (`Id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/csu_1/data/enrollments.csv' INTO TABLE `csu_1`.`enrollments`;


drop table if exists `csu_1`.`faculty`;
CREATE TABLE IF NOT EXISTS `csu_1`.`faculty` (
    `Campus` INT,
    `Year` INT,
    `Faculty` REAL,
    FOREIGN KEY (`Campus`) REFERENCES `csu_1`.`Campuses` (`Id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/csu_1/data/faculty.csv' INTO TABLE `csu_1`.`faculty`;



--- Database: debate ----------------------------------------

create database if not exists `debate`;

drop table if exists `debate`.`people`;
CREATE TABLE IF NOT EXISTS `debate`.`people` (
    `People_ID` INT,
    `District` STRING,
    `Name` STRING,
    `Party` STRING,
    `Age` INT,
    PRIMARY KEY (`People_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/debate/data/people.csv' INTO TABLE `debate`.`people`;


drop table if exists `debate`.`debate`;
CREATE TABLE IF NOT EXISTS `debate`.`debate` (
    `Debate_ID` INT,
    `Date` STRING,
    `Venue` STRING,
    `Num_of_Audience` INT,
    PRIMARY KEY (`Debate_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/debate/data/debate.csv' INTO TABLE `debate`.`debate`;


drop table if exists `debate`.`debate_people`;
CREATE TABLE IF NOT EXISTS `debate`.`debate_people` (
    `Debate_ID` INT,
    `Affirmative` INT,
    `Negative` INT,
    `If_Affirmative_Win` BOOLEAN,
    PRIMARY KEY (`Debate_ID`, `Affirmative`, `Negative`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Negative`) REFERENCES `debate`.`people` (`People_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Affirmative`) REFERENCES `debate`.`people` (`People_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Debate_ID`) REFERENCES `debate`.`debate` (`Debate_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/debate/data/debate_people.csv' INTO TABLE `debate`.`debate_people`;



--- Database: railway ----------------------------------------

create database if not exists `railway`;

drop table if exists `railway`.`railway`;
CREATE TABLE IF NOT EXISTS `railway`.`railway` (
    `Railway_ID` INT,
    `Railway` STRING,
    `Builder` STRING,
    `Built` STRING,
    `Wheels` STRING,
    `Location` STRING,
    `ObjectNumber` STRING,
    PRIMARY KEY (`Railway_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/railway/data/railway.csv' INTO TABLE `railway`.`railway`;


drop table if exists `railway`.`train`;
CREATE TABLE IF NOT EXISTS `railway`.`train` (
    `Train_ID` INT,
    `Train_Num` STRING,
    `Name` STRING,
    `From` STRING,
    `Arrival` STRING,
    `Railway_ID` INT,
    PRIMARY KEY (`Train_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Railway_ID`) REFERENCES `railway`.`railway` (`Railway_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/railway/data/train.csv' INTO TABLE `railway`.`train`;


drop table if exists `railway`.`manager`;
CREATE TABLE IF NOT EXISTS `railway`.`manager` (
    `Manager_ID` INT,
    `Name` STRING,
    `Country` STRING,
    `Working_year_starts` STRING,
    `Age` INT,
    `Level` INT,
    PRIMARY KEY (`Manager_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/railway/data/manager.csv' INTO TABLE `railway`.`manager`;


drop table if exists `railway`.`railway_manage`;
CREATE TABLE IF NOT EXISTS `railway`.`railway_manage` (
    `Railway_ID` INT,
    `Manager_ID` INT,
    `From_Year` STRING,
    PRIMARY KEY (`Railway_ID`, `Manager_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Railway_ID`) REFERENCES `railway`.`railway` (`Railway_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Manager_ID`) REFERENCES `railway`.`manager` (`Manager_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/railway/data/railway_manage.csv' INTO TABLE `railway`.`railway_manage`;



--- Database: protein_institute ----------------------------------------

create database if not exists `protein_institute`;

drop table if exists `protein_institute`.`building`;
CREATE TABLE IF NOT EXISTS `protein_institute`.`building` (
    `building_id` STRING,
    `Name` STRING,
    `Street_address` STRING,
    `Years_as_tallest` STRING,
    `Height_feet` INT,
    `Floors` INT,
    PRIMARY KEY (`building_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/protein_institute/data/building.csv' INTO TABLE `protein_institute`.`building`;


drop table if exists `protein_institute`.`Institution`;
CREATE TABLE IF NOT EXISTS `protein_institute`.`Institution` (
    `Institution_id` STRING,
    `Institution` STRING,
    `Location` STRING,
    `Founded` REAL,
    `Type` STRING,
    `Enrollment` INT,
    `Team` STRING,
    `Primary_Conference` STRING,
    `building_id` STRING,
    PRIMARY KEY (`Institution_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`building_id`) REFERENCES `protein_institute`.`building` (`building_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/protein_institute/data/Institution.csv' INTO TABLE `protein_institute`.`Institution`;


drop table if exists `protein_institute`.`protein`;
CREATE TABLE IF NOT EXISTS `protein_institute`.`protein` (
    `common_name` STRING,
    `protein_name` STRING,
    `divergence_from_human_lineage` REAL,
    `accession_number` STRING,
    `sequence_length` REAL,
    `sequence_identity_to_human_protein` STRING,
    `Institution_id` STRING,
    PRIMARY KEY (`common_name`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Institution_id`) REFERENCES `protein_institute`.`Institution` (`Institution_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/protein_institute/data/protein.csv' INTO TABLE `protein_institute`.`protein`;



--- Database: machine_repair ----------------------------------------

create database if not exists `machine_repair`;

drop table if exists `machine_repair`.`repair`;
CREATE TABLE IF NOT EXISTS `machine_repair`.`repair` (
    `repair_ID` INT,
    `name` STRING,
    `Launch_Date` STRING,
    `Notes` STRING,
    PRIMARY KEY (`repair_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/machine_repair/data/repair.csv' INTO TABLE `machine_repair`.`repair`;


drop table if exists `machine_repair`.`machine`;
CREATE TABLE IF NOT EXISTS `machine_repair`.`machine` (
    `Machine_ID` INT,
    `Making_Year` INT,
    `Class` STRING,
    `Team` STRING,
    `Machine_series` STRING,
    `value_points` REAL,
    `quality_rank` INT,
    PRIMARY KEY (`Machine_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/machine_repair/data/machine.csv' INTO TABLE `machine_repair`.`machine`;


drop table if exists `machine_repair`.`technician`;
CREATE TABLE IF NOT EXISTS `machine_repair`.`technician` (
    `technician_id` INT,
    `Name` STRING,
    `Team` STRING,
    `Starting_Year` REAL,
    `Age` INT,
    PRIMARY KEY (`technician_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/machine_repair/data/technician.csv' INTO TABLE `machine_repair`.`technician`;


drop table if exists `machine_repair`.`repair_assignment`;
CREATE TABLE IF NOT EXISTS `machine_repair`.`repair_assignment` (
    `technician_id` INT,
    `repair_ID` INT,
    `Machine_ID` INT,
    PRIMARY KEY (`technician_id`, `repair_ID`, `Machine_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Machine_ID`) REFERENCES `machine_repair`.`machine` (`Machine_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`repair_ID`) REFERENCES `machine_repair`.`repair` (`repair_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`technician_id`) REFERENCES `machine_repair`.`technician` (`technician_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/machine_repair/data/repair_assignment.csv' INTO TABLE `machine_repair`.`repair_assignment`;



--- Database: insurance_and_eClaims ----------------------------------------

create database if not exists `insurance_and_eClaims`;

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



--- Database: museum_visit ----------------------------------------

create database if not exists `museum_visit`;

drop table if exists `museum_visit`.`museum`;
CREATE TABLE IF NOT EXISTS `museum_visit`.`museum` (
    `Museum_ID` INT,
    `Name` STRING,
    `Num_of_Staff` INT,
    `Open_Year` STRING,
    PRIMARY KEY (`Museum_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/museum_visit/data/museum.csv' INTO TABLE `museum_visit`.`museum`;


drop table if exists `museum_visit`.`visitor`;
CREATE TABLE IF NOT EXISTS `museum_visit`.`visitor` (
    `ID` INT,
    `Name` STRING,
    `Level_of_membership` INT,
    `Age` INT,
    PRIMARY KEY (`ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/museum_visit/data/visitor.csv' INTO TABLE `museum_visit`.`visitor`;


drop table if exists `museum_visit`.`visit`;
CREATE TABLE IF NOT EXISTS `museum_visit`.`visit` (
    `Museum_ID` INT,
    `visitor_ID` INT,
    `Num_of_Ticket` INT,
    `Total_spent` REAL,
    PRIMARY KEY (`Museum_ID`, `visitor_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`visitor_ID`) REFERENCES `museum_visit`.`visitor` (`ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Museum_ID`) REFERENCES `museum_visit`.`museum` (`Museum_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/museum_visit/data/visit.csv' INTO TABLE `museum_visit`.`visit`;



--- Database: wine_1 ----------------------------------------

create database if not exists `wine_1`;

drop table if exists `wine_1`.`grapes`;
CREATE TABLE IF NOT EXISTS `wine_1`.`grapes` (
    `ID` INT,
    `Grape` STRING,
    `Color` STRING,
    PRIMARY KEY (`ID`) DISABLE NOVALIDATE,
    UNIQUE (`Grape`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/wine_1/data/grapes.csv' INTO TABLE `wine_1`.`grapes`;


drop table if exists `wine_1`.`appellations`;
CREATE TABLE IF NOT EXISTS `wine_1`.`appellations` (
    `No` INT,
    `Appelation` STRING,
    `County` STRING,
    `State` STRING,
    `Area` STRING,
    `isAVA` STRING,
    PRIMARY KEY (`No`) DISABLE NOVALIDATE,
    UNIQUE (`Appelation`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/wine_1/data/appellations.csv' INTO TABLE `wine_1`.`appellations`;


drop table if exists `wine_1`.`wine`;
CREATE TABLE IF NOT EXISTS `wine_1`.`wine` (
    `No` INT,
    `Grape` STRING,
    `Winery` STRING,
    `Appelation` STRING,
    `State` STRING,
    `Name` STRING,
    `Year` INT,
    `Price` INT,
    `Score` INT,
    `Cases` INT,
    `Drink` STRING,
    FOREIGN KEY (`Appelation`) REFERENCES `wine_1`.`appellations` (`Appelation`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Grape`) REFERENCES `wine_1`.`grapes` (`Grape`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/wine_1/data/wine.csv' INTO TABLE `wine_1`.`wine`;



--- Database: swimming ----------------------------------------

create database if not exists `swimming`;

drop table if exists `swimming`.`swimmer`;
CREATE TABLE IF NOT EXISTS `swimming`.`swimmer` (
    `ID` INT,
    `name` STRING,
    `Nationality` STRING,
    `meter_100` REAL,
    `meter_200` STRING,
    `meter_300` STRING,
    `meter_400` STRING,
    `meter_500` STRING,
    `meter_600` STRING,
    `meter_700` STRING,
    `Time` STRING,
    PRIMARY KEY (`ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/swimming/data/swimmer.csv' INTO TABLE `swimming`.`swimmer`;


drop table if exists `swimming`.`stadium`;
CREATE TABLE IF NOT EXISTS `swimming`.`stadium` (
    `ID` INT,
    `name` STRING,
    `Capacity` INT,
    `City` STRING,
    `Country` STRING,
    `Opening_year` INT,
    PRIMARY KEY (`ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/swimming/data/stadium.csv' INTO TABLE `swimming`.`stadium`;


drop table if exists `swimming`.`event`;
CREATE TABLE IF NOT EXISTS `swimming`.`event` (
    `ID` INT,
    `Name` STRING,
    `Stadium_ID` INT,
    `Year` STRING,
    PRIMARY KEY (`ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Stadium_ID`) REFERENCES `swimming`.`stadium` (`ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/swimming/data/event.csv' INTO TABLE `swimming`.`event`;


drop table if exists `swimming`.`record`;
CREATE TABLE IF NOT EXISTS `swimming`.`record` (
    `ID` INT,
    `Result` STRING,
    `Swimmer_ID` INT,
    `Event_ID` INT,
    PRIMARY KEY (`Swimmer_ID`, `Event_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Swimmer_ID`) REFERENCES `swimming`.`swimmer` (`ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Event_ID`) REFERENCES `swimming`.`event` (`ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/swimming/data/record.csv' INTO TABLE `swimming`.`record`;



--- Database: election ----------------------------------------

create database if not exists `election`;

drop table if exists `election`.`county`;
CREATE TABLE IF NOT EXISTS `election`.`county` (
    `County_Id` INT,
    `County_name` STRING,
    `Population` REAL,
    `Zip_code` STRING,
    PRIMARY KEY (`County_Id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/election/data/county.csv' INTO TABLE `election`.`county`;


drop table if exists `election`.`party`;
CREATE TABLE IF NOT EXISTS `election`.`party` (
    `Party_ID` INT,
    `Year` REAL,
    `Party` STRING,
    `Governor` STRING,
    `Lieutenant_Governor` STRING,
    `Comptroller` STRING,
    `Attorney_General` STRING,
    `US_Senate` STRING,
    PRIMARY KEY (`Party_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/election/data/party.csv' INTO TABLE `election`.`party`;


drop table if exists `election`.`election`;
CREATE TABLE IF NOT EXISTS `election`.`election` (
    `Election_ID` INT,
    `Counties_Represented` STRING,
    `District` INT,
    `Delegate` STRING,
    `Party` INT,
    `First_Elected` REAL,
    `Committee` STRING,
    PRIMARY KEY (`Election_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`District`) REFERENCES `election`.`county` (`County_Id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Party`) REFERENCES `election`.`party` (`Party_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/election/data/election.csv' INTO TABLE `election`.`election`;



--- Database: dorm_1 ----------------------------------------

create database if not exists `dorm_1`;

drop table if exists `dorm_1`.`Student`;
CREATE TABLE IF NOT EXISTS `dorm_1`.`Student` (
    `StuID` INT,
    `LName` STRING,
    `Fname` STRING,
    `Age` INT,
    `Sex` STRING,
    `Major` INT,
    `Advisor` INT,
    `city_code` STRING,
    PRIMARY KEY (`StuID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/dorm_1/data/Student.csv' INTO TABLE `dorm_1`.`Student`;


drop table if exists `dorm_1`.`Dorm`;
CREATE TABLE IF NOT EXISTS `dorm_1`.`Dorm` (
    `dormid` INT,
    `dorm_name` STRING,
    `student_capacity` INT,
    `gender` STRING,
    UNIQUE (`dormid`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/dorm_1/data/Dorm.csv' INTO TABLE `dorm_1`.`Dorm`;


drop table if exists `dorm_1`.`Dorm_amenity`;
CREATE TABLE IF NOT EXISTS `dorm_1`.`Dorm_amenity` (
    `amenid` INT,
    `amenity_name` STRING,
    UNIQUE (`amenid`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/dorm_1/data/Dorm_amenity.csv' INTO TABLE `dorm_1`.`Dorm_amenity`;


drop table if exists `dorm_1`.`Has_amenity`;
CREATE TABLE IF NOT EXISTS `dorm_1`.`Has_amenity` (
    `dormid` INT,
    `amenid` INT,
    FOREIGN KEY (`amenid`) REFERENCES `dorm_1`.`Dorm_amenity` (`amenid`) DISABLE NOVALIDATE,
    FOREIGN KEY (`dormid`) REFERENCES `dorm_1`.`Dorm` (`dormid`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/dorm_1/data/Has_amenity.csv' INTO TABLE `dorm_1`.`Has_amenity`;


drop table if exists `dorm_1`.`Lives_in`;
CREATE TABLE IF NOT EXISTS `dorm_1`.`Lives_in` (
    `stuid` INT,
    `dormid` INT,
    `room_number` INT,
    FOREIGN KEY (`dormid`) REFERENCES `dorm_1`.`Dorm` (`dormid`) DISABLE NOVALIDATE,
    FOREIGN KEY (`stuid`) REFERENCES `dorm_1`.`Student` (`StuID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/dorm_1/data/Lives_in.csv' INTO TABLE `dorm_1`.`Lives_in`;



--- Database: course_teach ----------------------------------------

create database if not exists `course_teach`;

drop table if exists `course_teach`.`course`;
CREATE TABLE IF NOT EXISTS `course_teach`.`course` (
    `Course_ID` INT,
    `Staring_Date` STRING,
    `Course` STRING,
    PRIMARY KEY (`Course_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/course_teach/data/course.csv' INTO TABLE `course_teach`.`course`;


drop table if exists `course_teach`.`teacher`;
CREATE TABLE IF NOT EXISTS `course_teach`.`teacher` (
    `Teacher_ID` INT,
    `Name` STRING,
    `Age` STRING,
    `Hometown` STRING,
    PRIMARY KEY (`Teacher_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/course_teach/data/teacher.csv' INTO TABLE `course_teach`.`teacher`;


drop table if exists `course_teach`.`course_arrange`;
CREATE TABLE IF NOT EXISTS `course_teach`.`course_arrange` (
    `Course_ID` INT,
    `Teacher_ID` INT,
    `Grade` INT,
    PRIMARY KEY (`Course_ID`, `Teacher_ID`, `Grade`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Teacher_ID`) REFERENCES `course_teach`.`teacher` (`Teacher_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Course_ID`) REFERENCES `course_teach`.`course` (`Course_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/course_teach/data/course_arrange.csv' INTO TABLE `course_teach`.`course_arrange`;



--- Database: club_1 ----------------------------------------

create database if not exists `club_1`;

drop table if exists `club_1`.`Student`;
CREATE TABLE IF NOT EXISTS `club_1`.`Student` (
    `StuID` INT,
    `LName` STRING,
    `Fname` STRING,
    `Age` INT,
    `Sex` STRING,
    `Major` INT,
    `Advisor` INT,
    `city_code` STRING,
    PRIMARY KEY (`StuID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/club_1/data/Student.csv' INTO TABLE `club_1`.`Student`;


drop table if exists `club_1`.`Club`;
CREATE TABLE IF NOT EXISTS `club_1`.`Club` (
    `ClubID` INT,
    `ClubName` STRING,
    `ClubDesc` STRING,
    `ClubLocation` STRING,
    PRIMARY KEY (`ClubID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/club_1/data/Club.csv' INTO TABLE `club_1`.`Club`;


drop table if exists `club_1`.`Member_of_club`;
CREATE TABLE IF NOT EXISTS `club_1`.`Member_of_club` (
    `StuID` INT,
    `ClubID` INT,
    `Position` STRING,
    FOREIGN KEY (`ClubID`) REFERENCES `club_1`.`Club` (`ClubID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`StuID`) REFERENCES `club_1`.`Student` (`StuID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/club_1/data/Member_of_club.csv' INTO TABLE `club_1`.`Member_of_club`;



--- Database: concert_singer ----------------------------------------

create database if not exists `concert_singer`;

drop table if exists `concert_singer`.`stadium`;
CREATE TABLE IF NOT EXISTS `concert_singer`.`stadium` (
    `Stadium_ID` INT,
    `Location` STRING,
    `Name` STRING,
    `Capacity` INT,
    `Highest` INT,
    `Lowest` INT,
    `Average` INT,
    PRIMARY KEY (`Stadium_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/concert_singer/data/stadium.csv' INTO TABLE `concert_singer`.`stadium`;


drop table if exists `concert_singer`.`singer`;
CREATE TABLE IF NOT EXISTS `concert_singer`.`singer` (
    `Singer_ID` INT,
    `Name` STRING,
    `Country` STRING,
    `Song_Name` STRING,
    `Song_release_year` STRING,
    `Age` INT,
    `Is_male` BOOLEAN,
    PRIMARY KEY (`Singer_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/concert_singer/data/singer.csv' INTO TABLE `concert_singer`.`singer`;


drop table if exists `concert_singer`.`concert`;
CREATE TABLE IF NOT EXISTS `concert_singer`.`concert` (
    `concert_ID` INT,
    `concert_Name` STRING,
    `Theme` STRING,
    `Stadium_ID` INT,
    `Year` STRING,
    PRIMARY KEY (`concert_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Stadium_ID`) REFERENCES `concert_singer`.`stadium` (`Stadium_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/concert_singer/data/concert.csv' INTO TABLE `concert_singer`.`concert`;


drop table if exists `concert_singer`.`singer_in_concert`;
CREATE TABLE IF NOT EXISTS `concert_singer`.`singer_in_concert` (
    `concert_ID` INT,
    `Singer_ID` INT,
    PRIMARY KEY (`concert_ID`, `Singer_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Singer_ID`) REFERENCES `concert_singer`.`singer` (`Singer_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`concert_ID`) REFERENCES `concert_singer`.`concert` (`concert_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/concert_singer/data/singer_in_concert.csv' INTO TABLE `concert_singer`.`singer_in_concert`;



--- Database: sakila_1 ----------------------------------------

create database if not exists `sakila_1`;

drop table if exists `sakila_1`.`actor`;
CREATE TABLE IF NOT EXISTS `sakila_1`.`actor` (
    `actor_id` INT NOT NULL,
    `first_name` STRING NOT NULL,
    `last_name` STRING NOT NULL,
    `last_update` TIMESTAMP NOT NULL,
    PRIMARY KEY (`actor_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sakila_1/data/actor.csv' INTO TABLE `sakila_1`.`actor`;


drop table if exists `sakila_1`.`country`;
CREATE TABLE IF NOT EXISTS `sakila_1`.`country` (
    `country_id` INT NOT NULL,
    `country` STRING NOT NULL,
    `last_update` TIMESTAMP NOT NULL,
    PRIMARY KEY (`country_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sakila_1/data/country.csv' INTO TABLE `sakila_1`.`country`;


drop table if exists `sakila_1`.`city`;
CREATE TABLE IF NOT EXISTS `sakila_1`.`city` (
    `city_id` INT NOT NULL,
    `city` STRING NOT NULL,
    `country_id` INT NOT NULL,
    `last_update` TIMESTAMP NOT NULL,
    PRIMARY KEY (`city_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`country_id`) REFERENCES `sakila_1`.`country` (`country_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sakila_1/data/city.csv' INTO TABLE `sakila_1`.`city`;


drop table if exists `sakila_1`.`address`;
CREATE TABLE IF NOT EXISTS `sakila_1`.`address` (
    `address_id` INT NOT NULL,
    `address` STRING NOT NULL,
    `address2` STRING,
    `district` STRING NOT NULL,
    `city_id` INT NOT NULL,
    `postal_code` STRING,
    `phone` STRING NOT NULL,
    `last_update` TIMESTAMP NOT NULL,
    PRIMARY KEY (`address_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`city_id`) REFERENCES `sakila_1`.`city` (`city_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sakila_1/data/address.csv' INTO TABLE `sakila_1`.`address`;


drop table if exists `sakila_1`.`category`;
CREATE TABLE IF NOT EXISTS `sakila_1`.`category` (
    `category_id` SMALLINT NOT NULL,
    `name` STRING NOT NULL,
    `last_update` TIMESTAMP NOT NULL,
    PRIMARY KEY (`category_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sakila_1/data/category.csv' INTO TABLE `sakila_1`.`category`;


drop table if exists `sakila_1`.`staff`;
CREATE TABLE IF NOT EXISTS `sakila_1`.`staff` (
    `staff_id` SMALLINT NOT NULL,
    `first_name` STRING NOT NULL,
    `last_name` STRING NOT NULL,
    `address_id` INT NOT NULL,
    `picture` BINARY,
    `email` STRING,
    `store_id` SMALLINT NOT NULL,
    `active` BOOLEAN NOT NULL,
    `username` STRING NOT NULL,
    `password` STRING,
    `last_update` TIMESTAMP NOT NULL,
    PRIMARY KEY (`staff_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`address_id`) REFERENCES `sakila_1`.`address` (`address_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sakila_1/data/staff.csv' INTO TABLE `sakila_1`.`staff`;


drop table if exists `sakila_1`.`store`;
CREATE TABLE IF NOT EXISTS `sakila_1`.`store` (
    `store_id` SMALLINT NOT NULL,
    `manager_staff_id` SMALLINT NOT NULL,
    `address_id` INT NOT NULL,
    `last_update` TIMESTAMP NOT NULL,
    PRIMARY KEY (`store_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`address_id`) REFERENCES `sakila_1`.`address` (`address_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`manager_staff_id`) REFERENCES `sakila_1`.`staff` (`staff_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sakila_1/data/store.csv' INTO TABLE `sakila_1`.`store`;


drop table if exists `sakila_1`.`customer`;
CREATE TABLE IF NOT EXISTS `sakila_1`.`customer` (
    `customer_id` INT NOT NULL,
    `store_id` SMALLINT NOT NULL,
    `first_name` STRING NOT NULL,
    `last_name` STRING NOT NULL,
    `email` STRING,
    `address_id` INT NOT NULL,
    `active` BOOLEAN NOT NULL,
    `create_date` TIMESTAMP NOT NULL,
    `last_update` TIMESTAMP,
    PRIMARY KEY (`customer_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`store_id`) REFERENCES `sakila_1`.`store` (`store_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`address_id`) REFERENCES `sakila_1`.`address` (`address_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sakila_1/data/customer.csv' INTO TABLE `sakila_1`.`customer`;


drop table if exists `sakila_1`.`language`;
CREATE TABLE IF NOT EXISTS `sakila_1`.`language` (
    `language_id` SMALLINT NOT NULL,
    `name` CHAR(20) NOT NULL,
    `last_update` TIMESTAMP NOT NULL,
    PRIMARY KEY (`language_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sakila_1/data/language.csv' INTO TABLE `sakila_1`.`language`;


drop table if exists `sakila_1`.`film`;
CREATE TABLE IF NOT EXISTS `sakila_1`.`film` (
    `film_id` INT NOT NULL,
    `title` STRING NOT NULL,
    `description` STRING,
    `release_year` INT,
    `language_id` SMALLINT NOT NULL,
    `original_language_id` SMALLINT,
    `rental_duration` SMALLINT NOT NULL,
    `rental_rate` DECIMAL(4,2) NOT NULL,
    `length` INT,
    `replacement_cost` DECIMAL(5,2) NOT NULL,
    `rating` STRING,
    `special_features` STRING,
    `last_update` TIMESTAMP NOT NULL,
    PRIMARY KEY (`film_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`original_language_id`) REFERENCES `sakila_1`.`language` (`language_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`language_id`) REFERENCES `sakila_1`.`language` (`language_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sakila_1/data/film.csv' INTO TABLE `sakila_1`.`film`;


drop table if exists `sakila_1`.`film_actor`;
CREATE TABLE IF NOT EXISTS `sakila_1`.`film_actor` (
    `actor_id` INT NOT NULL,
    `film_id` INT NOT NULL,
    `last_update` TIMESTAMP NOT NULL,
    PRIMARY KEY (`actor_id`, `film_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`film_id`) REFERENCES `sakila_1`.`film` (`film_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`actor_id`) REFERENCES `sakila_1`.`actor` (`actor_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sakila_1/data/film_actor.csv' INTO TABLE `sakila_1`.`film_actor`;


drop table if exists `sakila_1`.`film_category`;
CREATE TABLE IF NOT EXISTS `sakila_1`.`film_category` (
    `film_id` INT NOT NULL,
    `category_id` SMALLINT NOT NULL,
    `last_update` TIMESTAMP NOT NULL,
    PRIMARY KEY (`film_id`, `category_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`category_id`) REFERENCES `sakila_1`.`category` (`category_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`film_id`) REFERENCES `sakila_1`.`film` (`film_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sakila_1/data/film_category.csv' INTO TABLE `sakila_1`.`film_category`;


drop table if exists `sakila_1`.`film_text`;
CREATE TABLE IF NOT EXISTS `sakila_1`.`film_text` (
    `film_id` SMALLINT NOT NULL,
    `title` STRING NOT NULL,
    `description` STRING,
    PRIMARY KEY (`film_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sakila_1/data/film_text.csv' INTO TABLE `sakila_1`.`film_text`;


drop table if exists `sakila_1`.`inventory`;
CREATE TABLE IF NOT EXISTS `sakila_1`.`inventory` (
    `inventory_id` INT NOT NULL,
    `film_id` INT NOT NULL,
    `store_id` SMALLINT NOT NULL,
    `last_update` TIMESTAMP NOT NULL,
    PRIMARY KEY (`inventory_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`film_id`) REFERENCES `sakila_1`.`film` (`film_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`store_id`) REFERENCES `sakila_1`.`store` (`store_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sakila_1/data/inventory.csv' INTO TABLE `sakila_1`.`inventory`;


drop table if exists `sakila_1`.`rental`;
CREATE TABLE IF NOT EXISTS `sakila_1`.`rental` (
    `rental_id` INT NOT NULL,
    `rental_date` TIMESTAMP NOT NULL,
    `inventory_id` INT NOT NULL,
    `customer_id` INT NOT NULL,
    `return_date` TIMESTAMP,
    `staff_id` SMALLINT NOT NULL,
    `last_update` TIMESTAMP NOT NULL,
    PRIMARY KEY (`rental_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`customer_id`) REFERENCES `sakila_1`.`customer` (`customer_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`inventory_id`) REFERENCES `sakila_1`.`inventory` (`inventory_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`staff_id`) REFERENCES `sakila_1`.`staff` (`staff_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sakila_1/data/rental.csv' INTO TABLE `sakila_1`.`rental`;


drop table if exists `sakila_1`.`payment`;
CREATE TABLE IF NOT EXISTS `sakila_1`.`payment` (
    `payment_id` INT NOT NULL,
    `customer_id` INT NOT NULL,
    `staff_id` SMALLINT NOT NULL,
    `rental_id` INT,
    `amount` DECIMAL(5,2) NOT NULL,
    `payment_date` TIMESTAMP NOT NULL,
    `last_update` TIMESTAMP,
    PRIMARY KEY (`payment_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`staff_id`) REFERENCES `sakila_1`.`staff` (`staff_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`customer_id`) REFERENCES `sakila_1`.`customer` (`customer_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`rental_id`) REFERENCES `sakila_1`.`rental` (`rental_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sakila_1/data/payment.csv' INTO TABLE `sakila_1`.`payment`;



--- Database: customers_card_transactions ----------------------------------------

create database if not exists `customers_card_transactions`;

drop table if exists `customers_card_transactions`.`Accounts`;
CREATE TABLE IF NOT EXISTS `customers_card_transactions`.`Accounts` (
    `account_id` INT,
    `customer_id` INT NOT NULL,
    `account_name` STRING,
    `other_account_details` STRING,
    PRIMARY KEY (`account_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_card_transactions/data/Accounts.csv' INTO TABLE `customers_card_transactions`.`Accounts`;


drop table if exists `customers_card_transactions`.`Customers`;
CREATE TABLE IF NOT EXISTS `customers_card_transactions`.`Customers` (
    `customer_id` INT,
    `customer_first_name` STRING,
    `customer_last_name` STRING,
    `customer_address` STRING,
    `customer_phone` STRING,
    `customer_email` STRING,
    `other_customer_details` STRING,
    PRIMARY KEY (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_card_transactions/data/Customers.csv' INTO TABLE `customers_card_transactions`.`Customers`;


drop table if exists `customers_card_transactions`.`Customers_Cards`;
CREATE TABLE IF NOT EXISTS `customers_card_transactions`.`Customers_Cards` (
    `card_id` INT,
    `customer_id` INT NOT NULL,
    `card_type_code` STRING NOT NULL,
    `card_number` STRING,
    `date_valid_from` TIMESTAMP,
    `date_valid_to` TIMESTAMP,
    `other_card_details` STRING,
    PRIMARY KEY (`card_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_card_transactions/data/Customers_Cards.csv' INTO TABLE `customers_card_transactions`.`Customers_Cards`;


drop table if exists `customers_card_transactions`.`Financial_Transactions`;
CREATE TABLE IF NOT EXISTS `customers_card_transactions`.`Financial_Transactions` (
    `transaction_id` INT NOT NULL,
    `previous_transaction_id` INT,
    `account_id` INT NOT NULL,
    `card_id` INT NOT NULL,
    `transaction_type` STRING NOT NULL,
    `transaction_date` TIMESTAMP,
    `transaction_amount` REAL,
    `transaction_comment` STRING,
    `other_transaction_details` STRING,
    FOREIGN KEY (`account_id`) REFERENCES `customers_card_transactions`.`Accounts` (`account_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`card_id`) REFERENCES `customers_card_transactions`.`Customers_Cards` (`card_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_card_transactions/data/Financial_Transactions.csv' INTO TABLE `customers_card_transactions`.`Financial_Transactions`;



--- Database: poker_player ----------------------------------------

create database if not exists `poker_player`;

drop table if exists `poker_player`.`people`;
CREATE TABLE IF NOT EXISTS `poker_player`.`people` (
    `People_ID` INT,
    `Nationality` STRING,
    `Name` STRING,
    `Birth_Date` STRING,
    `Height` REAL,
    PRIMARY KEY (`People_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/poker_player/data/people.csv' INTO TABLE `poker_player`.`people`;


drop table if exists `poker_player`.`poker_player`;
CREATE TABLE IF NOT EXISTS `poker_player`.`poker_player` (
    `Poker_Player_ID` INT,
    `People_ID` INT,
    `Final_Table_Made` REAL,
    `Best_Finish` REAL,
    `Money_Rank` REAL,
    `Earnings` REAL,
    PRIMARY KEY (`Poker_Player_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`People_ID`) REFERENCES `poker_player`.`people` (`People_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/poker_player/data/poker_player.csv' INTO TABLE `poker_player`.`poker_player`;



--- Database: customers_and_invoices ----------------------------------------

create database if not exists `customers_and_invoices`;

drop table if exists `customers_and_invoices`.`Customers`;
CREATE TABLE IF NOT EXISTS `customers_and_invoices`.`Customers` (
    `customer_id` INT,
    `customer_first_name` STRING,
    `customer_middle_initial` STRING,
    `customer_last_name` STRING,
    `gender` STRING,
    `email_address` STRING,
    `login_name` STRING,
    `login_password` STRING,
    `phone_number` STRING,
    `town_city` STRING,
    `state_county_province` STRING,
    `country` STRING,
    PRIMARY KEY (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_and_invoices/data/Customers.csv' INTO TABLE `customers_and_invoices`.`Customers`;


drop table if exists `customers_and_invoices`.`Orders`;
CREATE TABLE IF NOT EXISTS `customers_and_invoices`.`Orders` (
    `order_id` INT,
    `customer_id` INT NOT NULL,
    `date_order_placed` TIMESTAMP NOT NULL,
    `order_details` STRING,
    PRIMARY KEY (`order_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`customer_id`) REFERENCES `customers_and_invoices`.`Customers` (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_and_invoices/data/Orders.csv' INTO TABLE `customers_and_invoices`.`Orders`;


drop table if exists `customers_and_invoices`.`Invoices`;
CREATE TABLE IF NOT EXISTS `customers_and_invoices`.`Invoices` (
    `invoice_number` INT,
    `order_id` INT NOT NULL,
    `invoice_date` TIMESTAMP,
    PRIMARY KEY (`invoice_number`) DISABLE NOVALIDATE,
    FOREIGN KEY (`order_id`) REFERENCES `customers_and_invoices`.`Orders` (`order_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_and_invoices/data/Invoices.csv' INTO TABLE `customers_and_invoices`.`Invoices`;


drop table if exists `customers_and_invoices`.`Accounts`;
CREATE TABLE IF NOT EXISTS `customers_and_invoices`.`Accounts` (
    `account_id` INT,
    `customer_id` INT NOT NULL,
    `date_account_opened` TIMESTAMP,
    `account_name` STRING,
    `other_account_details` STRING,
    PRIMARY KEY (`account_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`customer_id`) REFERENCES `customers_and_invoices`.`Customers` (`customer_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_and_invoices/data/Accounts.csv' INTO TABLE `customers_and_invoices`.`Accounts`;


drop table if exists `customers_and_invoices`.`Product_Categories`;
CREATE TABLE IF NOT EXISTS `customers_and_invoices`.`Product_Categories` (
    `production_type_code` STRING,
    `product_type_description` STRING,
    `vat_rating` DECIMAL(19,4),
    PRIMARY KEY (`production_type_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_and_invoices/data/Product_Categories.csv' INTO TABLE `customers_and_invoices`.`Product_Categories`;


drop table if exists `customers_and_invoices`.`Products`;
CREATE TABLE IF NOT EXISTS `customers_and_invoices`.`Products` (
    `product_id` INT,
    `parent_product_id` INT,
    `production_type_code` STRING NOT NULL,
    `unit_price` DECIMAL(19,4),
    `product_name` STRING,
    `product_color` STRING,
    `product_size` STRING,
    PRIMARY KEY (`product_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`production_type_code`) REFERENCES `customers_and_invoices`.`Product_Categories` (`production_type_code`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_and_invoices/data/Products.csv' INTO TABLE `customers_and_invoices`.`Products`;


drop table if exists `customers_and_invoices`.`Financial_Transactions`;
CREATE TABLE IF NOT EXISTS `customers_and_invoices`.`Financial_Transactions` (
    `transaction_id` INT NOT NULL,
    `account_id` INT NOT NULL,
    `invoice_number` INT,
    `transaction_type` STRING NOT NULL,
    `transaction_date` TIMESTAMP,
    `transaction_amount` DECIMAL(19,4),
    `transaction_comment` STRING,
    `other_transaction_details` STRING,
    FOREIGN KEY (`account_id`) REFERENCES `customers_and_invoices`.`Accounts` (`account_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`invoice_number`) REFERENCES `customers_and_invoices`.`Invoices` (`invoice_number`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_and_invoices/data/Financial_Transactions.csv' INTO TABLE `customers_and_invoices`.`Financial_Transactions`;


drop table if exists `customers_and_invoices`.`Order_Items`;
CREATE TABLE IF NOT EXISTS `customers_and_invoices`.`Order_Items` (
    `order_item_id` INT,
    `order_id` INT NOT NULL,
    `product_id` INT NOT NULL,
    `product_quantity` STRING,
    `other_order_item_details` STRING,
    PRIMARY KEY (`order_item_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`order_id`) REFERENCES `customers_and_invoices`.`Orders` (`order_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`product_id`) REFERENCES `customers_and_invoices`.`Products` (`product_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_and_invoices/data/Order_Items.csv' INTO TABLE `customers_and_invoices`.`Order_Items`;


drop table if exists `customers_and_invoices`.`Invoice_Line_Items`;
CREATE TABLE IF NOT EXISTS `customers_and_invoices`.`Invoice_Line_Items` (
    `order_item_id` INT NOT NULL,
    `invoice_number` INT NOT NULL,
    `product_id` INT NOT NULL,
    `product_title` STRING,
    `product_quantity` STRING,
    `product_price` DECIMAL(19,4),
    `derived_product_cost` DECIMAL(19,4),
    `derived_vat_payable` DECIMAL(19,4),
    `derived_total_cost` DECIMAL(19,4),
    FOREIGN KEY (`product_id`) REFERENCES `customers_and_invoices`.`Products` (`product_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`invoice_number`) REFERENCES `customers_and_invoices`.`Invoices` (`invoice_number`) DISABLE NOVALIDATE,
    FOREIGN KEY (`order_item_id`) REFERENCES `customers_and_invoices`.`Order_Items` (`order_item_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/customers_and_invoices/data/Invoice_Line_Items.csv' INTO TABLE `customers_and_invoices`.`Invoice_Line_Items`;



--- Database: musical ----------------------------------------

create database if not exists `musical`;

drop table if exists `musical`.`musical`;
CREATE TABLE IF NOT EXISTS `musical`.`musical` (
    `Musical_ID` INT,
    `Name` STRING,
    `Year` INT,
    `Award` STRING,
    `Category` STRING,
    `Nominee` STRING,
    `Result` STRING,
    PRIMARY KEY (`Musical_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/musical/data/musical.csv' INTO TABLE `musical`.`musical`;


drop table if exists `musical`.`actor`;
CREATE TABLE IF NOT EXISTS `musical`.`actor` (
    `Actor_ID` INT,
    `Name` STRING,
    `Musical_ID` INT,
    `Character` STRING,
    `Duration` STRING,
    `age` INT,
    PRIMARY KEY (`Actor_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Musical_ID`) REFERENCES `musical`.`actor` (`Actor_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/musical/data/actor.csv' INTO TABLE `musical`.`actor`;



--- Database: sports_competition ----------------------------------------

create database if not exists `sports_competition`;

drop table if exists `sports_competition`.`club`;
CREATE TABLE IF NOT EXISTS `sports_competition`.`club` (
    `Club_ID` INT,
    `name` STRING,
    `Region` STRING,
    `Start_year` STRING,
    PRIMARY KEY (`Club_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sports_competition/data/club.csv' INTO TABLE `sports_competition`.`club`;


drop table if exists `sports_competition`.`club_rank`;
CREATE TABLE IF NOT EXISTS `sports_competition`.`club_rank` (
    `Rank` REAL,
    `Club_ID` INT,
    `Gold` REAL,
    `Silver` REAL,
    `Bronze` REAL,
    `Total` REAL,
    PRIMARY KEY (`Rank`, `Club_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Club_ID`) REFERENCES `sports_competition`.`club` (`Club_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sports_competition/data/club_rank.csv' INTO TABLE `sports_competition`.`club_rank`;


drop table if exists `sports_competition`.`player`;
CREATE TABLE IF NOT EXISTS `sports_competition`.`player` (
    `Player_ID` INT,
    `name` STRING,
    `Position` STRING,
    `Club_ID` INT,
    `Apps` REAL,
    `Tries` REAL,
    `Goals` STRING,
    `Points` REAL,
    PRIMARY KEY (`Player_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Club_ID`) REFERENCES `sports_competition`.`club` (`Club_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sports_competition/data/player.csv' INTO TABLE `sports_competition`.`player`;


drop table if exists `sports_competition`.`competition`;
CREATE TABLE IF NOT EXISTS `sports_competition`.`competition` (
    `Competition_ID` INT,
    `Year` REAL,
    `Competition_type` STRING,
    `Country` STRING,
    PRIMARY KEY (`Competition_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sports_competition/data/competition.csv' INTO TABLE `sports_competition`.`competition`;


drop table if exists `sports_competition`.`competition_result`;
CREATE TABLE IF NOT EXISTS `sports_competition`.`competition_result` (
    `Competition_ID` INT,
    `Club_ID_1` INT,
    `Club_ID_2` INT,
    `Score` STRING,
    PRIMARY KEY (`Competition_ID`, `Club_ID_1`, `Club_ID_2`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Competition_ID`) REFERENCES `sports_competition`.`competition` (`Competition_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Club_ID_2`) REFERENCES `sports_competition`.`club` (`Club_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Club_ID_1`) REFERENCES `sports_competition`.`club` (`Club_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/sports_competition/data/competition_result.csv' INTO TABLE `sports_competition`.`competition_result`;



--- Database: network_2 ----------------------------------------

create database if not exists `network_2`;

drop table if exists `network_2`.`Person`;
CREATE TABLE IF NOT EXISTS `network_2`.`Person` (
    `name` STRING,
    `age` INT,
    `city` STRING,
    `gender` STRING,
    `job` STRING,
    PRIMARY KEY (`name`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/network_2/data/Person.csv' INTO TABLE `network_2`.`Person`;


drop table if exists `network_2`.`PersonFriend`;
CREATE TABLE IF NOT EXISTS `network_2`.`PersonFriend` (
    `name` STRING,
    `friend` STRING,
    `year` INT,
    FOREIGN KEY (`friend`) REFERENCES `network_2`.`Person` (`name`) DISABLE NOVALIDATE,
    FOREIGN KEY (`name`) REFERENCES `network_2`.`Person` (`name`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/network_2/data/PersonFriend.csv' INTO TABLE `network_2`.`PersonFriend`;



--- Database: party_people ----------------------------------------

create database if not exists `party_people`;

drop table if exists `party_people`.`region`;
CREATE TABLE IF NOT EXISTS `party_people`.`region` (
    `Region_ID` INT,
    `Region_name` STRING,
    `Date` STRING,
    `Label` STRING,
    `Format` STRING,
    `Catalogue` STRING,
    PRIMARY KEY (`Region_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/party_people/data/region.csv' INTO TABLE `party_people`.`region`;


drop table if exists `party_people`.`party`;
CREATE TABLE IF NOT EXISTS `party_people`.`party` (
    `Party_ID` INT,
    `Minister` STRING,
    `Took_office` STRING,
    `Left_office` STRING,
    `Region_ID` INT,
    `Party_name` STRING,
    PRIMARY KEY (`Party_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Region_ID`) REFERENCES `party_people`.`region` (`Region_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/party_people/data/party.csv' INTO TABLE `party_people`.`party`;


drop table if exists `party_people`.`member`;
CREATE TABLE IF NOT EXISTS `party_people`.`member` (
    `Member_ID` INT,
    `Member_Name` STRING,
    `Party_ID` INT,
    `In_office` STRING,
    PRIMARY KEY (`Member_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Party_ID`) REFERENCES `party_people`.`party` (`Party_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/party_people/data/member.csv' INTO TABLE `party_people`.`member`;


drop table if exists `party_people`.`party_events`;
CREATE TABLE IF NOT EXISTS `party_people`.`party_events` (
    `Event_ID` INT,
    `Event_Name` STRING,
    `Party_ID` INT,
    `Member_in_charge_ID` INT,
    PRIMARY KEY (`Event_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Member_in_charge_ID`) REFERENCES `party_people`.`member` (`Member_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Party_ID`) REFERENCES `party_people`.`party` (`Party_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/party_people/data/party_events.csv' INTO TABLE `party_people`.`party_events`;



--- Database: cinema ----------------------------------------

create database if not exists `cinema`;

drop table if exists `cinema`.`film`;
CREATE TABLE IF NOT EXISTS `cinema`.`film` (
    `Film_ID` INT,
    `Rank_in_series` INT,
    `Number_in_season` INT,
    `Title` STRING,
    `Directed_by` STRING,
    `Original_air_date` STRING,
    `Production_code` STRING,
    PRIMARY KEY (`Film_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cinema/data/film.csv' INTO TABLE `cinema`.`film`;


drop table if exists `cinema`.`cinema`;
CREATE TABLE IF NOT EXISTS `cinema`.`cinema` (
    `Cinema_ID` INT,
    `Name` STRING,
    `Openning_year` INT,
    `Capacity` INT,
    `Location` STRING,
    PRIMARY KEY (`Cinema_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cinema/data/cinema.csv' INTO TABLE `cinema`.`cinema`;


drop table if exists `cinema`.`schedule`;
CREATE TABLE IF NOT EXISTS `cinema`.`schedule` (
    `Cinema_ID` INT,
    `Film_ID` INT,
    `Date` STRING,
    `Show_times_per_day` INT,
    `Price` DECIMAL,
    PRIMARY KEY (`Cinema_ID`, `Film_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Cinema_ID`) REFERENCES `cinema`.`cinema` (`Cinema_ID`) DISABLE NOVALIDATE,
    FOREIGN KEY (`Film_ID`) REFERENCES `cinema`.`film` (`Film_ID`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/cinema/data/schedule.csv' INTO TABLE `cinema`.`schedule`;



--- Database: baseball_1 ----------------------------------------

create database if not exists `baseball_1`;

drop table if exists `baseball_1`.`team`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`team` (
    `year` INT,
    `league_id` STRING,
    `team_id` STRING,
    `franchise_id` STRING,
    `div_id` STRING,
    `rank` INT,
    `g` INT,
    `ghome` NUMERIC,
    `w` INT,
    `l` INT,
    `div_win` STRING,
    `wc_win` STRING,
    `lg_win` STRING,
    `ws_win` STRING,
    `r` INT,
    `ab` INT,
    `h` INT,
    `double` INT,
    `triple` INT,
    `hr` INT,
    `bb` INT,
    `so` NUMERIC,
    `sb` NUMERIC,
    `cs` NUMERIC,
    `hbp` NUMERIC,
    `sf` NUMERIC,
    `ra` INT,
    `er` INT,
    `era` NUMERIC,
    `cg` INT,
    `sho` INT,
    `sv` INT,
    `ipouts` INT,
    `ha` INT,
    `hra` INT,
    `bba` INT,
    `soa` INT,
    `e` INT,
    `dp` NUMERIC,
    `fp` NUMERIC,
    `name` STRING,
    `park` STRING,
    `attendance` NUMERIC,
    `bpf` INT,
    `ppf` INT,
    `team_id_br` STRING,
    `team_id_lahman45` STRING,
    `team_id_retro` STRING,
    UNIQUE (`team_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/team.csv' INTO TABLE `baseball_1`.`team`;


drop table if exists `baseball_1`.`player`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`player` (
    `player_id` STRING,
    `birth_year` NUMERIC,
    `birth_month` NUMERIC,
    `birth_day` NUMERIC,
    `birth_country` STRING,
    `birth_state` STRING,
    `birth_city` STRING,
    `death_year` NUMERIC,
    `death_month` NUMERIC,
    `death_day` NUMERIC,
    `death_country` STRING,
    `death_state` STRING,
    `death_city` STRING,
    `name_first` STRING,
    `name_last` STRING,
    `name_given` STRING,
    `weight` NUMERIC,
    `height` NUMERIC,
    `bats` STRING,
    `throws` STRING,
    `debut` STRING,
    `final_game` STRING,
    `retro_id` STRING,
    `bbref_id` STRING,
    UNIQUE (`player_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/player.csv' INTO TABLE `baseball_1`.`player`;


drop table if exists `baseball_1`.`all_star`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`all_star` (
    `player_id` STRING,
    `year` INT,
    `game_num` INT,
    `game_id` STRING,
    `team_id` STRING,
    `league_id` STRING,
    `gp` NUMERIC,
    `starting_pos` NUMERIC,
    FOREIGN KEY (`player_id`) REFERENCES `baseball_1`.`player` (`player_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/all_star.csv' INTO TABLE `baseball_1`.`all_star`;


drop table if exists `baseball_1`.`appearances`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`appearances` (
    `year` INT,
    `team_id` STRING,
    `league_id` STRING,
    `player_id` STRING,
    `g_all` NUMERIC,
    `gs` NUMERIC,
    `g_batting` INT,
    `g_defense` NUMERIC,
    `g_p` INT,
    `g_c` INT,
    `g_1b` INT,
    `g_2b` INT,
    `g_3b` INT,
    `g_ss` INT,
    `g_lf` INT,
    `g_cf` INT,
    `g_rf` INT,
    `g_of` INT,
    `g_dh` NUMERIC,
    `g_ph` NUMERIC,
    `g_pr` NUMERIC,
    FOREIGN KEY (`player_id`) REFERENCES `baseball_1`.`player` (`player_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`team_id`) REFERENCES `baseball_1`.`team` (`team_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/appearances.csv' INTO TABLE `baseball_1`.`appearances`;


drop table if exists `baseball_1`.`manager_award`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`manager_award` (
    `player_id` STRING,
    `award_id` STRING,
    `year` INT,
    `league_id` STRING,
    `tie` STRING,
    `notes` NUMERIC,
    FOREIGN KEY (`player_id`) REFERENCES `baseball_1`.`player` (`player_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/manager_award.csv' INTO TABLE `baseball_1`.`manager_award`;


drop table if exists `baseball_1`.`player_award`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`player_award` (
    `player_id` STRING,
    `award_id` STRING,
    `year` INT,
    `league_id` STRING,
    `tie` STRING,
    `notes` STRING,
    FOREIGN KEY (`player_id`) REFERENCES `baseball_1`.`player` (`player_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/player_award.csv' INTO TABLE `baseball_1`.`player_award`;


drop table if exists `baseball_1`.`manager_award_vote`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`manager_award_vote` (
    `award_id` STRING,
    `year` INT,
    `league_id` STRING,
    `player_id` STRING,
    `points_won` INT,
    `points_max` INT,
    `votes_first` INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/manager_award_vote.csv' INTO TABLE `baseball_1`.`manager_award_vote`;


drop table if exists `baseball_1`.`player_award_vote`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`player_award_vote` (
    `award_id` STRING,
    `year` INT,
    `league_id` STRING,
    `player_id` STRING,
    `points_won` NUMERIC,
    `points_max` INT,
    `votes_first` NUMERIC,
    FOREIGN KEY (`player_id`) REFERENCES `baseball_1`.`player` (`player_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/player_award_vote.csv' INTO TABLE `baseball_1`.`player_award_vote`;


drop table if exists `baseball_1`.`batting`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`batting` (
    `player_id` STRING,
    `year` INT,
    `stint` INT,
    `team_id` STRING,
    `league_id` STRING,
    `g` INT,
    `ab` NUMERIC,
    `r` NUMERIC,
    `h` NUMERIC,
    `double` NUMERIC,
    `triple` NUMERIC,
    `hr` NUMERIC,
    `rbi` NUMERIC,
    `sb` NUMERIC,
    `cs` NUMERIC,
    `bb` NUMERIC,
    `so` NUMERIC,
    `ibb` NUMERIC,
    `hbp` NUMERIC,
    `sh` NUMERIC,
    `sf` NUMERIC,
    `g_idp` NUMERIC,
    FOREIGN KEY (`player_id`) REFERENCES `baseball_1`.`player` (`player_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/batting.csv' INTO TABLE `baseball_1`.`batting`;


drop table if exists `baseball_1`.`batting_postseason`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`batting_postseason` (
    `year` INT,
    `round` STRING,
    `player_id` STRING,
    `team_id` STRING,
    `league_id` STRING,
    `g` INT,
    `ab` INT,
    `r` INT,
    `h` INT,
    `double` INT,
    `triple` INT,
    `hr` INT,
    `rbi` INT,
    `sb` INT,
    `cs` NUMERIC,
    `bb` INT,
    `so` INT,
    `ibb` NUMERIC,
    `hbp` NUMERIC,
    `sh` NUMERIC,
    `sf` NUMERIC,
    `g_idp` NUMERIC,
    FOREIGN KEY (`team_id`) REFERENCES `baseball_1`.`team` (`team_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`player_id`) REFERENCES `baseball_1`.`player` (`player_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/batting_postseason.csv' INTO TABLE `baseball_1`.`batting_postseason`;


drop table if exists `baseball_1`.`college`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`college` (
    `college_id` STRING,
    `name_full` STRING,
    `city` STRING,
    `state` STRING,
    `country` STRING,
    UNIQUE (`college_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/college.csv' INTO TABLE `baseball_1`.`college`;


drop table if exists `baseball_1`.`player_college`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`player_college` (
    `player_id` STRING,
    `college_id` STRING,
    `year` INT,
    FOREIGN KEY (`college_id`) REFERENCES `baseball_1`.`college` (`college_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`player_id`) REFERENCES `baseball_1`.`player` (`player_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/player_college.csv' INTO TABLE `baseball_1`.`player_college`;


drop table if exists `baseball_1`.`fielding`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`fielding` (
    `player_id` STRING,
    `year` INT,
    `stint` INT,
    `team_id` STRING,
    `league_id` STRING,
    `pos` STRING,
    `g` INT,
    `gs` NUMERIC,
    `inn_outs` NUMERIC,
    `po` NUMERIC,
    `a` NUMERIC,
    `e` NUMERIC,
    `dp` NUMERIC,
    `pb` NUMERIC,
    `wp` NUMERIC,
    `sb` NUMERIC,
    `cs` NUMERIC,
    `zr` NUMERIC,
    FOREIGN KEY (`player_id`) REFERENCES `baseball_1`.`player` (`player_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/fielding.csv' INTO TABLE `baseball_1`.`fielding`;


drop table if exists `baseball_1`.`fielding_outfield`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`fielding_outfield` (
    `player_id` STRING,
    `year` INT,
    `stint` INT,
    `glf` NUMERIC,
    `gcf` NUMERIC,
    `grf` NUMERIC,
    FOREIGN KEY (`player_id`) REFERENCES `baseball_1`.`player` (`player_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/fielding_outfield.csv' INTO TABLE `baseball_1`.`fielding_outfield`;


drop table if exists `baseball_1`.`fielding_postseason`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`fielding_postseason` (
    `player_id` STRING,
    `year` INT,
    `team_id` STRING,
    `league_id` STRING,
    `round` STRING,
    `pos` STRING,
    `g` INT,
    `gs` NUMERIC,
    `inn_outs` NUMERIC,
    `po` INT,
    `a` INT,
    `e` INT,
    `dp` INT,
    `tp` INT,
    `pb` NUMERIC,
    `sb` NUMERIC,
    `cs` NUMERIC,
    FOREIGN KEY (`team_id`) REFERENCES `baseball_1`.`team` (`team_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`player_id`) REFERENCES `baseball_1`.`player` (`player_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/fielding_postseason.csv' INTO TABLE `baseball_1`.`fielding_postseason`;


drop table if exists `baseball_1`.`hall_of_fame`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`hall_of_fame` (
    `player_id` STRING,
    `yearid` INT,
    `votedby` STRING,
    `ballots` NUMERIC,
    `needed` NUMERIC,
    `votes` NUMERIC,
    `inducted` STRING,
    `category` STRING,
    `needed_note` STRING,
    FOREIGN KEY (`player_id`) REFERENCES `baseball_1`.`player` (`player_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/hall_of_fame.csv' INTO TABLE `baseball_1`.`hall_of_fame`;


drop table if exists `baseball_1`.`park`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`park` (
    `park_id` STRING,
    `park_name` STRING,
    `park_alias` STRING,
    `city` STRING,
    `state` STRING,
    `country` STRING,
    UNIQUE (`park_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/park.csv' INTO TABLE `baseball_1`.`park`;


drop table if exists `baseball_1`.`home_game`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`home_game` (
    `year` INT,
    `league_id` STRING,
    `team_id` STRING,
    `park_id` STRING,
    `span_first` STRING,
    `span_last` STRING,
    `games` INT,
    `openings` INT,
    `attendance` INT,
    FOREIGN KEY (`park_id`) REFERENCES `baseball_1`.`park` (`park_id`) DISABLE NOVALIDATE,
    FOREIGN KEY (`team_id`) REFERENCES `baseball_1`.`team` (`team_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/home_game.csv' INTO TABLE `baseball_1`.`home_game`;


drop table if exists `baseball_1`.`manager`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`manager` (
    `player_id` STRING,
    `year` INT,
    `team_id` STRING,
    `league_id` STRING,
    `inseason` INT,
    `g` INT,
    `w` INT,
    `l` INT,
    `rank` NUMERIC,
    `plyr_mgr` STRING,
    FOREIGN KEY (`team_id`) REFERENCES `baseball_1`.`team` (`team_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/manager.csv' INTO TABLE `baseball_1`.`manager`;


drop table if exists `baseball_1`.`manager_half`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`manager_half` (
    `player_id` STRING,
    `year` INT,
    `team_id` STRING,
    `league_id` STRING,
    `inseason` INT,
    `half` INT,
    `g` INT,
    `w` INT,
    `l` INT,
    `rank` INT,
    FOREIGN KEY (`team_id`) REFERENCES `baseball_1`.`team` (`team_id`) DISABLE NOVALIDATE
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/manager_half.csv' INTO TABLE `baseball_1`.`manager_half`;


drop table if exists `baseball_1`.`pitching`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`pitching` (
    `player_id` STRING,
    `year` INT,
    `stint` INT,
    `team_id` STRING,
    `league_id` STRING,
    `w` INT,
    `l` INT,
    `g` INT,
    `gs` INT,
    `cg` INT,
    `sho` INT,
    `sv` INT,
    `ipouts` NUMERIC,
    `h` INT,
    `er` INT,
    `hr` INT,
    `bb` INT,
    `so` INT,
    `baopp` NUMERIC,
    `era` NUMERIC,
    `ibb` NUMERIC,
    `wp` NUMERIC,
    `hbp` NUMERIC,
    `bk` INT,
    `bfp` NUMERIC,
    `gf` NUMERIC,
    `r` INT,
    `sh` NUMERIC,
    `sf` NUMERIC,
    `g_idp` NUMERIC
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/pitching.csv' INTO TABLE `baseball_1`.`pitching`;


drop table if exists `baseball_1`.`pitching_postseason`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`pitching_postseason` (
    `player_id` STRING,
    `year` INT,
    `round` STRING,
    `team_id` STRING,
    `league_id` STRING,
    `w` INT,
    `l` INT,
    `g` INT,
    `gs` INT,
    `cg` INT,
    `sho` INT,
    `sv` INT,
    `ipouts` INT,
    `h` INT,
    `er` INT,
    `hr` INT,
    `bb` INT,
    `so` INT,
    `baopp` STRING,
    `era` NUMERIC,
    `ibb` NUMERIC,
    `wp` NUMERIC,
    `hbp` NUMERIC,
    `bk` NUMERIC,
    `bfp` NUMERIC,
    `gf` INT,
    `r` INT,
    `sh` NUMERIC,
    `sf` NUMERIC,
    `g_idp` NUMERIC
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/pitching_postseason.csv' INTO TABLE `baseball_1`.`pitching_postseason`;


drop table if exists `baseball_1`.`salary`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`salary` (
    `year` INT,
    `team_id` STRING,
    `league_id` STRING,
    `player_id` STRING,
    `salary` INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/salary.csv' INTO TABLE `baseball_1`.`salary`;


drop table if exists `baseball_1`.`postseason`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`postseason` (
    `year` INT,
    `round` STRING,
    `team_id_winner` STRING,
    `league_id_winner` STRING,
    `team_id_loser` STRING,
    `league_id_loser` STRING,
    `wins` INT,
    `losses` INT,
    `ties` INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/postseason.csv' INTO TABLE `baseball_1`.`postseason`;


drop table if exists `baseball_1`.`team_franchise`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`team_franchise` (
    `franchise_id` STRING,
    `franchise_name` STRING,
    `active` STRING,
    `na_assoc` STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/team_franchise.csv' INTO TABLE `baseball_1`.`team_franchise`;


drop table if exists `baseball_1`.`team_half`;
CREATE TABLE IF NOT EXISTS `baseball_1`.`team_half` (
    `year` INT,
    `league_id` STRING,
    `team_id` STRING,
    `half` INT,
    `div_id` STRING,
    `div_win` STRING,
    `rank` INT,
    `g` INT,
    `w` INT,
    `l` INT
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
tblproperties("skip.header.line.count"="1")
;
LOAD DATA INPATH '${DATASET_DIR}/baseball_1/data/team_half.csv' INTO TABLE `baseball_1`.`team_half`;



--- Database: book_2 ----------------------------------------

create database if not exists `book_2`;

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

