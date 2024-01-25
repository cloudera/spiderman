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

