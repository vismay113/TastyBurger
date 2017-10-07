/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 * Author:  comuser
 * Created: 06/09/2017
 */

-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema tastyburger
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `tastyburger` ;

-- -----------------------------------------------------
-- Schema tastyburger
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tastyburger` DEFAULT CHARACTER SET utf8 ;

USE `tastyburger` ;

-- -----------------------------------------------------
-- Table `tastyburger`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tastyburger`.`category` ;

CREATE TABLE IF NOT EXISTS `tastyburger`.`category` (
  `category_id` TINYINT(3) UNSIGNED NOT NULL AUTO_INCREMENT,
  `category_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`category_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `tastyburger`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tastyburger`.`customer` ;

CREATE TABLE IF NOT EXISTS `tastyburger`.`customer` (
  `customer_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `suburb` VARCHAR(45) NOT NULL,
  `postcode` VARCHAR(4) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `role` VARCHAR(1) NULL DEFAULT 'c',
  `code` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8
COMMENT = 'maintains customer details\n';


-- -----------------------------------------------------
-- Table `tastyburger`.`deliverer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tastyburger`.`deliverer` ;

CREATE TABLE IF NOT EXISTS `tastyburger`.`deliverer` (
  `deliverer_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `deliverer_name` VARCHAR(45) NOT NULL,
  `deliverer_contact_number` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`deliverer_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `tastyburger`.`payment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tastyburger`.`payment` ;

CREATE TABLE IF NOT EXISTS `tastyburger`.`payment` (
  `payment_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `payment_amount` DECIMAL(6,2) NOT NULL,
  `payment_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `payment_method` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`payment_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `tastyburger`.`customer_order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tastyburger`.`customer_order` ;

CREATE TABLE IF NOT EXISTS `tastyburger`.`customer_order` (
  `order_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `amount` DECIMAL(6,2) NOT NULL,
  `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `status` VARCHAR(45) NULL DEFAULT NULL,
  `comment` TEXT NULL DEFAULT NULL,
  `delivery_address` VARCHAR(45) NOT NULL,
  `delivery_suburb` VARCHAR(45) NOT NULL,
  `delivery_postcode` VARCHAR(45) NOT NULL,
  `customer_customer_id` INT(10) UNSIGNED NOT NULL,
  `deliverer_deliverer_id` INT(10) UNSIGNED NULL DEFAULT NULL,
  `payment_payment_id` INT(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`order_id`),
  INDEX `fk_customer_order_customer1_idx` (`customer_customer_id` ASC),
  INDEX `fk_customer_order_deliverer1_idx` (`deliverer_deliverer_id` ASC),
  INDEX `fk_customer_order_payment1_idx` (`payment_payment_id` ASC),
  CONSTRAINT `fk_customer_order_customer1`
    FOREIGN KEY (`customer_customer_id`)
    REFERENCES `tastyburger`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customer_order_deliverer1`
    FOREIGN KEY (`deliverer_deliverer_id`)
    REFERENCES `tastyburger`.`deliverer` (`deliverer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_customer_order_payment1`
    FOREIGN KEY (`payment_payment_id`)
    REFERENCES `tastyburger`.`payment` (`payment_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8
COMMENT = 'detail of customer order	';


-- -----------------------------------------------------
-- Table `tastyburger`.`item`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tastyburger`.`item` ;

CREATE TABLE IF NOT EXISTS `tastyburger`.`item` (
  `item_id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `item_name` VARCHAR(45) NOT NULL,
  `price` DECIMAL(5,2) NOT NULL,
  `ingredients` TINYTEXT NULL DEFAULT NULL,
  `last_update` VARCHAR(45) NOT NULL DEFAULT 'CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP',
  `category_category_id` TINYINT(3) UNSIGNED NOT NULL,
  PRIMARY KEY (`item_id`),
  INDEX `fk_item_category_idx` (`category_category_id` ASC),
  CONSTRAINT `fk_item_category`
    FOREIGN KEY (`category_category_id`)
    REFERENCES `tastyburger`.`category` (`category_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `tastyburger`.`item_has_customer_order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tastyburger`.`item_has_customer_order` ;

CREATE TABLE IF NOT EXISTS `tastyburger`.`item_has_customer_order` (
  `item_item_id` INT(10) UNSIGNED NOT NULL,
  `customer_order_order_id` INT(10) UNSIGNED NOT NULL,
  `quantity` SMALLINT(5) UNSIGNED NOT NULL DEFAULT '1',
  PRIMARY KEY (`item_item_id`, `customer_order_order_id`),
  INDEX `fk_item_has_customer_order_customer_order1_idx` (`customer_order_order_id` ASC),
  INDEX `fk_item_has_customer_order_item1_idx` (`item_item_id` ASC),
  CONSTRAINT `fk_item_has_customer_order_customer_order1`
    FOREIGN KEY (`customer_order_order_id`)
    REFERENCES `tastyburger`.`customer_order` (`order_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_item_has_customer_order_item1`
    FOREIGN KEY (`item_item_id`)
    REFERENCES `tastyburger`.`item` (`item_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

USE `saikiran enterprises` ;

-- -----------------------------------------------------
-- Table `tastyburger`.`images`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tastyburger`.`images` ;

CREATE TABLE IF NOT EXISTS `tastyburger`.`images` (
  `image-id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `image-name` VARCHAR(255) NOT NULL,
  `product-name` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`image-id`),
  UNIQUE INDEX `image-name` (`image-name` ASC))
ENGINE = MyISAM
AUTO_INCREMENT = 143
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
