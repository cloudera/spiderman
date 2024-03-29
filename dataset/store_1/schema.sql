-- Dialect: MySQL | Database: store_1 | Table Count: 11

CREATE DATABASE IF NOT EXISTS `store_1`;

DROP TABLE IF EXISTS `store_1`.`artists`;
CREATE TABLE `store_1`.`artists` (
    `id` INTEGER,
    `name` VARCHAR(120),
    PRIMARY KEY (`id`),
    INDEX idx_id (`id`)
);

DROP TABLE IF EXISTS `store_1`.`albums`;
CREATE TABLE `store_1`.`albums` (
    `id` INTEGER,
    `title` VARCHAR(160) NOT NULL,
    `artist_id` INTEGER NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`artist_id`) REFERENCES `store_1`.`artists` (`id`),
    INDEX idx_id (`id`),
    INDEX idx_artist_id (`artist_id`)
);

DROP TABLE IF EXISTS `store_1`.`employees`;
CREATE TABLE `store_1`.`employees` (
    `id` INTEGER,
    `last_name` VARCHAR(20) NOT NULL,
    `first_name` VARCHAR(20) NOT NULL,
    `title` VARCHAR(30),
    `reports_to` INTEGER,
    `birth_date` TIMESTAMP,
    `hire_date` TIMESTAMP,
    `address` VARCHAR(70),
    `city` VARCHAR(40),
    `state` VARCHAR(40),
    `country` VARCHAR(40),
    `postal_code` VARCHAR(10),
    `phone` VARCHAR(24),
    `fax` VARCHAR(24),
    `email` VARCHAR(60),
    PRIMARY KEY (`id`),
    FOREIGN KEY (`reports_to`) REFERENCES `store_1`.`employees` (`id`),
    INDEX idx_id (`id`),
    INDEX idx_reports_to (`reports_to`)
);

DROP TABLE IF EXISTS `store_1`.`customers`;
CREATE TABLE `store_1`.`customers` (
    `id` INTEGER,
    `first_name` VARCHAR(40) NOT NULL,
    `last_name` VARCHAR(20) NOT NULL,
    `company` VARCHAR(80),
    `address` VARCHAR(70),
    `city` VARCHAR(40),
    `state` VARCHAR(40),
    `country` VARCHAR(40),
    `postal_code` VARCHAR(10),
    `phone` VARCHAR(24),
    `fax` VARCHAR(24),
    `email` VARCHAR(60) NOT NULL,
    `support_rep_id` INTEGER,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`support_rep_id`) REFERENCES `store_1`.`employees` (`id`),
    INDEX idx_id (`id`),
    INDEX idx_support_rep_id (`support_rep_id`)
);

DROP TABLE IF EXISTS `store_1`.`genres`;
CREATE TABLE `store_1`.`genres` (
    `id` INTEGER,
    `name` VARCHAR(120),
    PRIMARY KEY (`id`),
    INDEX idx_id (`id`)
);

DROP TABLE IF EXISTS `store_1`.`invoices`;
CREATE TABLE `store_1`.`invoices` (
    `id` INTEGER,
    `customer_id` INTEGER NOT NULL,
    `invoice_date` TIMESTAMP NOT NULL,
    `billing_address` VARCHAR(70),
    `billing_city` VARCHAR(40),
    `billing_state` VARCHAR(40),
    `billing_country` VARCHAR(40),
    `billing_postal_code` VARCHAR(10),
    `total` NUMERIC(10,2) NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`customer_id`) REFERENCES `store_1`.`customers` (`id`),
    INDEX idx_id (`id`),
    INDEX idx_customer_id (`customer_id`)
);

DROP TABLE IF EXISTS `store_1`.`media_types`;
CREATE TABLE `store_1`.`media_types` (
    `id` INTEGER,
    `name` VARCHAR(120),
    PRIMARY KEY (`id`),
    INDEX idx_id (`id`)
);

DROP TABLE IF EXISTS `store_1`.`tracks`;
CREATE TABLE `store_1`.`tracks` (
    `id` INTEGER,
    `name` VARCHAR(200) NOT NULL,
    `album_id` INTEGER,
    `media_type_id` INTEGER NOT NULL,
    `genre_id` INTEGER,
    `composer` VARCHAR(220),
    `milliseconds` INTEGER NOT NULL,
    `bytes` INTEGER,
    `unit_price` NUMERIC(10,2) NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`media_type_id`) REFERENCES `store_1`.`media_types` (`id`),
    FOREIGN KEY (`genre_id`) REFERENCES `store_1`.`genres` (`id`),
    FOREIGN KEY (`album_id`) REFERENCES `store_1`.`albums` (`id`),
    INDEX idx_id (`id`),
    INDEX idx_album_id (`album_id`),
    INDEX idx_media_type_id (`media_type_id`),
    INDEX idx_genre_id (`genre_id`)
);

DROP TABLE IF EXISTS `store_1`.`invoice_lines`;
CREATE TABLE `store_1`.`invoice_lines` (
    `id` INTEGER,
    `invoice_id` INTEGER NOT NULL,
    `track_id` INTEGER NOT NULL,
    `unit_price` NUMERIC(10,2) NOT NULL,
    `quantity` INTEGER NOT NULL,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`track_id`) REFERENCES `store_1`.`tracks` (`id`),
    FOREIGN KEY (`invoice_id`) REFERENCES `store_1`.`invoices` (`id`),
    INDEX idx_id (`id`),
    INDEX idx_invoice_id (`invoice_id`),
    INDEX idx_track_id (`track_id`)
);

DROP TABLE IF EXISTS `store_1`.`playlists`;
CREATE TABLE `store_1`.`playlists` (
    `id` INTEGER,
    `name` VARCHAR(120),
    PRIMARY KEY (`id`),
    INDEX idx_id (`id`)
);

DROP TABLE IF EXISTS `store_1`.`playlist_tracks`;
CREATE TABLE `store_1`.`playlist_tracks` (
    `playlist_id` INTEGER NOT NULL,
    `track_id` INTEGER NOT NULL,
    PRIMARY KEY (`playlist_id`, `track_id`),
    FOREIGN KEY (`track_id`) REFERENCES `store_1`.`tracks` (`id`),
    FOREIGN KEY (`playlist_id`) REFERENCES `store_1`.`playlists` (`id`),
    INDEX idx_playlist_id (`playlist_id`),
    INDEX idx_track_id (`track_id`)
);
