-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Library
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `Library` ;

-- -----------------------------------------------------
-- Schema Library
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Library` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema company
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `company` ;

-- -----------------------------------------------------
-- Schema company
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `company` DEFAULT CHARACTER SET utf8 ;
USE `Library` ;

-- -----------------------------------------------------
-- Table `Library`.`Employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Library`.`Employee` ;

CREATE TABLE IF NOT EXISTS `Library`.`Employee` (
  `ID` CHAR(14) NOT NULL,
  `FName` VARCHAR(45) NOT NULL,
  `Minit` VARCHAR(45) NULL,
  `LName` VARCHAR(45) NULL,
  `Address` VARCHAR(45) NULL,
  `Salary` DECIMAL(5) NULL,
  `Phone` CHAR(11) NULL,
  `Sex` VARCHAR(7) NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `Phone_UNIQUE` (`Phone` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`Department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Library`.`Department` ;

CREATE TABLE IF NOT EXISTS `Library`.`Department` (
  `No` INT NOT NULL,
  `Name` VARCHAR(45) NOT NULL,
  `Location` VARCHAR(45) NULL,
  `Mgr_id` CHAR(14) NULL,
  `Mgr_start_date` DATE NULL,
  PRIMARY KEY (`No`),
  INDEX `fk_Department_Employee_idx` (`Mgr_id` ASC) VISIBLE,
  CONSTRAINT `fk_Department_Employee`
    FOREIGN KEY (`Mgr_id`)
    REFERENCES `Library`.`Employee` (`ID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`Author`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Library`.`Author` ;

CREATE TABLE IF NOT EXISTS `Library`.`Author` (
  `No` INT NOT NULL,
  `Sex` VARCHAR(7) NULL,
  `Name` VARCHAR(45) NULL,
  PRIMARY KEY (`No`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`Suppliers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Library`.`Suppliers` ;

CREATE TABLE IF NOT EXISTS `Library`.`Suppliers` (
  `Name` VARCHAR(45) NOT NULL,
  `Address` VARCHAR(45) NULL,
  `Office_Phone` CHAR(11) NULL,
  PRIMARY KEY (`Name`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`Book`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Library`.`Book` ;

CREATE TABLE IF NOT EXISTS `Library`.`Book` (
  `No` INT NOT NULL,
  `Name` VARCHAR(100) NULL,
  `Cost` FLOAT NULL,
  `Publish_year` DOUBLE NULL,
  `Quantity` DOUBLE NULL,
  `A_No` INT NOT NULL,
  `Department_No` INT NOT NULL,
  `S_Name` VARCHAR(45) NOT NULL DEFAULT 'Unknown',
  PRIMARY KEY (`No`),
  INDEX `fk_Book_Author1_idx` (`A_No` ASC) VISIBLE,
  INDEX `fk_Book_Department1_idx` (`Department_No` ASC) VISIBLE,
  INDEX `fk_Book_Suppliers1_idx` (`S_Name` ASC) VISIBLE,
  CONSTRAINT `fk_Book_Author1`
    FOREIGN KEY (`A_No`)
    REFERENCES `Library`.`Author` (`No`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Book_Department1`
    FOREIGN KEY (`Department_No`)
    REFERENCES `Library`.`Department` (`No`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Book_Suppliers1`
    FOREIGN KEY (`S_Name`)
    REFERENCES `Library`.`Suppliers` (`Name`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`Customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Library`.`Customer` ;

CREATE TABLE IF NOT EXISTS `Library`.`Customer` (
  `SSN` CHAR(4) NOT NULL,
  `Name` VARCHAR(45) NULL,
  `Address` VARCHAR(45) NULL,
  `Phone` CHAR(11) NULL,
  PRIMARY KEY (`SSN`))
ENGINE = InnoDB
PACK_KEYS = DEFAULT;


-- -----------------------------------------------------
-- Table `Library`.`Buy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Library`.`Buy` ;

CREATE TABLE IF NOT EXISTS `Library`.`Buy` (
  `Book_No` INT NOT NULL,
  `Customer_SSN` CHAR(4) NOT NULL,
  `Method_of_payment` VARCHAR(45) NULL,
  PRIMARY KEY (`Book_No`, `Customer_SSN`),
  INDEX `fk_Book_has_Customer_Customer1_idx` (`Customer_SSN` ASC) VISIBLE,
  INDEX `fk_Book_has_Customer_Book1_idx` (`Book_No` ASC) VISIBLE,
  CONSTRAINT `fk_Book_has_Customer_Book1`
    FOREIGN KEY (`Book_No`)
    REFERENCES `Library`.`Book` (`No`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Book_has_Customer_Customer1`
    FOREIGN KEY (`Customer_SSN`)
    REFERENCES `Library`.`Customer` (`SSN`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`Borrow`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Library`.`Borrow` ;

CREATE TABLE IF NOT EXISTS `Library`.`Borrow` (
  `Book_No` INT NOT NULL,
  `Customer_SSN` CHAR(4) NOT NULL,
  `Borrow_date` DATE NULL,
  `Return_date` DATE NULL,
  PRIMARY KEY (`Book_No`, `Customer_SSN`),
  INDEX `fk_Book_has_Customer_Customer2_idx` (`Customer_SSN` ASC) VISIBLE,
  INDEX `fk_Book_has_Customer_Book2_idx` (`Book_No` ASC) VISIBLE,
  CONSTRAINT `fk_Book_has_Customer_Book2`
    FOREIGN KEY (`Book_No`)
    REFERENCES `Library`.`Book` (`No`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Book_has_Customer_Customer2`
    FOREIGN KEY (`Customer_SSN`)
    REFERENCES `Library`.`Customer` (`SSN`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`Registrar`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Library`.`Registrar` ;

CREATE TABLE IF NOT EXISTS `Library`.`Registrar` (
  `ID` CHAR(14) NOT NULL,
  `Comp_no` INT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_Registrar_Employee1_idx` (`ID` ASC) VISIBLE,
  CONSTRAINT `fk_Registrar_Employee1`
    FOREIGN KEY (`ID`)
    REFERENCES `Library`.`Employee` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`Worker`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Library`.`Worker` ;

CREATE TABLE IF NOT EXISTS `Library`.`Worker` (
  `ID` CHAR(14) NOT NULL,
  `D_No` INT NOT NULL,
  INDEX `fk_Worker_Employee1_idx` (`ID` ASC) VISIBLE,
  INDEX `fk_Worker_Department1_idx` (`D_No` ASC) VISIBLE,
  PRIMARY KEY (`ID`),
  CONSTRAINT `fk_Worker_Employee1`
    FOREIGN KEY (`ID`)
    REFERENCES `Library`.`Employee` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Worker_Department1`
    FOREIGN KEY (`D_No`)
    REFERENCES `Library`.`Department` (`No`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Library`.`Dependent`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `Library`.`Dependent` ;

CREATE TABLE IF NOT EXISTS `Library`.`Dependent` (
  `Name` VARCHAR(15) NOT NULL,
  `E_ID` CHAR(14) NOT NULL,
  `Sex` VARCHAR(7) NULL,
  `Relationship` VARCHAR(45) NULL,
  `B_Date` DATE NULL,
  PRIMARY KEY (`Name`, `E_ID`),
  INDEX `fk_Dependent_Employee1_idx` (`E_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Dependent_Employee1`
    FOREIGN KEY (`E_ID`)
    REFERENCES `Library`.`Employee` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `company` ;

-- -----------------------------------------------------
-- Table `company`.`employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `company`.`employee` ;

CREATE TABLE IF NOT EXISTS `company`.`employee` (
  `SSN` INT NOT NULL,
  `Name` VARCHAR(45) NULL DEFAULT NULL,
  `Minit` CHAR(1) NULL DEFAULT NULL,
  `Lname` VARCHAR(45) NULL DEFAULT NULL,
  `Address` VARCHAR(45) NULL DEFAULT NULL,
  `Salary` DECIMAL(10,0) NULL DEFAULT NULL,
  `Sex` CHAR(1) NULL DEFAULT NULL,
  `BData` DATE NULL DEFAULT NULL,
  `Dnumber` INT NOT NULL,
  `SuperVisor ssn` INT NULL DEFAULT NULL,
  PRIMARY KEY (`SSN`),
  INDEX `Dnumber` (`Dnumber` ASC) VISIBLE,
  INDEX `SuperVisor ssn` (`SuperVisor ssn` ASC) VISIBLE,
  CONSTRAINT `employee_ibfk_1`
    FOREIGN KEY (`Dnumber`)
    REFERENCES `company`.`department` (`Number`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `employee_ibfk_2`
    FOREIGN KEY (`SuperVisor ssn`)
    REFERENCES `company`.`employee` (`SSN`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `employee_ibfk_3`
    FOREIGN KEY (`Dnumber`)
    REFERENCES `company`.`department` (`Number`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `employee_ibfk_4`
    FOREIGN KEY (`SuperVisor ssn`)
    REFERENCES `company`.`employee` (`SSN`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `company`.`department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `company`.`department` ;

CREATE TABLE IF NOT EXISTS `company`.`department` (
  `Number` INT NOT NULL,
  `Name` VARCHAR(45) NULL DEFAULT NULL,
  `Manager Start date` DATE NULL DEFAULT NULL,
  `Manager SSN` INT NOT NULL,
  PRIMARY KEY (`Number`),
  INDEX `Manager SSN` (`Manager SSN` ASC) VISIBLE,
  CONSTRAINT `department_ibfk_1`
    FOREIGN KEY (`Manager SSN`)
    REFERENCES `company`.`employee` (`SSN`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `company`.`depentent`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `company`.`depentent` ;

CREATE TABLE IF NOT EXISTS `company`.`depentent` (
  `Relationship` VARCHAR(45) NULL DEFAULT NULL,
  `Birthdate` DATE NULL DEFAULT NULL,
  `Fname` VARCHAR(45) NOT NULL,
  `Sex` CHAR(1) NULL DEFAULT NULL,
  `ESSN` INT NOT NULL,
  PRIMARY KEY (`Fname`, `ESSN`),
  INDEX `ESSN` (`ESSN` ASC) VISIBLE,
  CONSTRAINT `depentent_ibfk_1`
    FOREIGN KEY (`ESSN`)
    REFERENCES `company`.`employee` (`SSN`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `company`.`dept_location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `company`.`dept_location` ;

CREATE TABLE IF NOT EXISTS `company`.`dept_location` (
  `Location` VARCHAR(45) NOT NULL,
  `Department_Number` INT NOT NULL,
  PRIMARY KEY (`Location`, `Department_Number`),
  INDEX `Department_Number` (`Department_Number` ASC) VISIBLE,
  CONSTRAINT `dept_location_ibfk_1`
    FOREIGN KEY (`Department_Number`)
    REFERENCES `company`.`department` (`Number`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `company`.`project`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `company`.`project` ;

CREATE TABLE IF NOT EXISTS `company`.`project` (
  `Number` INT NOT NULL,
  `Name` VARCHAR(45) NULL DEFAULT NULL,
  `Location` VARCHAR(45) NULL DEFAULT NULL,
  `Dno.` INT NULL DEFAULT NULL,
  PRIMARY KEY (`Number`),
  INDEX `Dno.` (`Dno.` ASC) VISIBLE,
  CONSTRAINT `project_ibfk_1`
    FOREIGN KEY (`Dno.`)
    REFERENCES `company`.`department` (`Number`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `company`.`works_on`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `company`.`works_on` ;

CREATE TABLE IF NOT EXISTS `company`.`works_on` (
  `Project_Number` INT NOT NULL,
  `Employee_SSN` INT NOT NULL,
  `H.P.W` DECIMAL(10,0) NULL DEFAULT NULL,
  PRIMARY KEY (`Project_Number`, `Employee_SSN`),
  INDEX `Employee_SSN` (`Employee_SSN` ASC) VISIBLE,
  CONSTRAINT `works_on_ibfk_1`
    FOREIGN KEY (`Project_Number`)
    REFERENCES `company`.`project` (`Number`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `works_on_ibfk_2`
    FOREIGN KEY (`Employee_SSN`)
    REFERENCES `company`.`employee` (`SSN`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Data for table `Library`.`Employee`
-- -----------------------------------------------------
START TRANSACTION;
USE `Library`;
INSERT INTO `Library`.`Employee` (`ID`, `FName`, `Minit`, `LName`, `Address`, `Salary`, `Phone`, `Sex`) VALUES ('30203014221519', 'mahmoud', 'amr', 'ali', '123,giza,egypt', 4000, '01060310380', 'male');
INSERT INTO `Library`.`Employee` (`ID`, `FName`, `Minit`, `LName`, `Address`, `Salary`, `Phone`, `Sex`) VALUES ('30206020101492', 'Ali', 'ibrhim', 'omar', '231,giza,egypt', 4200, '01025246320', 'male');
INSERT INTO `Library`.`Employee` (`ID`, `FName`, `Minit`, `LName`, `Address`, `Salary`, `Phone`, `Sex`) VALUES ('30201520143021', 'maya', 'amr', 'anas', '167,giza,egypt', 4500, '01120301411', 'female');
INSERT INTO `Library`.`Employee` (`ID`, `FName`, `Minit`, `LName`, `Address`, `Salary`, `Phone`, `Sex`) VALUES ('30110170102295', 'abdelrhman', 'mouse', 'ahmed', '700,giza,egypt', 4500, '01152588518', 'male');
INSERT INTO `Library`.`Employee` (`ID`, `FName`, `Minit`, `LName`, `Address`, `Salary`, `Phone`, `Sex`) VALUES ('30111416189011', 'mariam', 'mohy', 'ahmed', '32,giza,egypt', 4000, '01223057990', 'female');
INSERT INTO `Library`.`Employee` (`ID`, `FName`, `Minit`, `LName`, `Address`, `Salary`, `Phone`, `Sex`) VALUES ('30121519181722', 'Ahmed', 'ali', 'fahmy', '55,cairo,egypt', 4000, '01550112231', 'male');
INSERT INTO `Library`.`Employee` (`ID`, `FName`, `Minit`, `LName`, `Address`, `Salary`, `Phone`, `Sex`) VALUES ('30112023154222', 'fatma', 'elsayed', 'ali', '12,cairo,egypt', 4100, '01213151791', 'female');
INSERT INTO `Library`.`Employee` (`ID`, `FName`, `Minit`, `LName`, `Address`, `Salary`, `Phone`, `Sex`) VALUES ('30201401541221', 'martina', 'petar', 'kirols', '22,cairo,egypt', 4300, '01223242519', 'female');
INSERT INTO `Library`.`Employee` (`ID`, `FName`, `Minit`, `LName`, `Address`, `Salary`, `Phone`, `Sex`) VALUES ('30151794654551', 'Ahmed ', 'Gamal', 'yaser', '70,cairo,egypt', 4000, '01111411210', 'male');
INSERT INTO `Library`.`Employee` (`ID`, `FName`, `Minit`, `LName`, `Address`, `Salary`, `Phone`, `Sex`) VALUES ('30111214151311', 'mohamed', 'Osama', 'Abdelrhman', '90,cairo,egypt', 4000, '01002425934', 'male');
INSERT INTO `Library`.`Employee` (`ID`, `FName`, `Minit`, `LName`, `Address`, `Salary`, `Phone`, `Sex`) VALUES ('30111515841221', 'Hazem', 'emam', 'ali', '21,cairo,egypt', 4500, '01000504020', 'male');
INSERT INTO `Library`.`Employee` (`ID`, `FName`, `Minit`, `LName`, `Address`, `Salary`, `Phone`, `Sex`) VALUES ('30111215131551', 'Nour', 'Ahmed', 'amr', '1,alex,egypt', 4200, '01151521512', 'female');
INSERT INTO `Library`.`Employee` (`ID`, `FName`, `Minit`, `LName`, `Address`, `Salary`, `Phone`, `Sex`) VALUES ('30101515155523', 'Mustafe', 'Mahmoud', 'Ibrhim', '89,alex,egypt', 4600, '01222215456', 'male');
INSERT INTO `Library`.`Employee` (`ID`, `FName`, `Minit`, `LName`, `Address`, `Salary`, `Phone`, `Sex`) VALUES ('30151450786525', 'aya', 'magdy', 'yousef', '12,alex,egypt', 4450, '01097818754', 'female');
INSERT INTO `Library`.`Employee` (`ID`, `FName`, `Minit`, `LName`, `Address`, `Salary`, `Phone`, `Sex`) VALUES ('30111251212231', 'samy', 'ahmed', 'elsayed', '17,st ahmed esmat', 4450, '01123153183', 'male');
INSERT INTO `Library`.`Employee` (`ID`, `FName`, `Minit`, `LName`, `Address`, `Salary`, `Phone`, `Sex`) VALUES ('30111256648621', 'Anas', 'Ahmed', 'Ezat', '19,st ahmed esmat', 4550, '01121531566', 'male');
INSERT INTO `Library`.`Employee` (`ID`, `FName`, `Minit`, `LName`, `Address`, `Salary`, `Phone`, `Sex`) VALUES ('30122513351232', 'Adel', 'mohamed', 'ali', '22,st ahmed zaky', 5000, '01022251456', 'male');
INSERT INTO `Library`.`Employee` (`ID`, `FName`, `Minit`, `LName`, `Address`, `Salary`, `Phone`, `Sex`) VALUES ('30121522541222', 'Haba', 'elsayed', 'ahmed', '19, st ahmed orabi', 4500, '01112543548', 'famle');
INSERT INTO `Library`.`Employee` (`ID`, `FName`, `Minit`, `LName`, `Address`, `Salary`, `Phone`, `Sex`) VALUES ('30112315139521', 'Soha', 'elshamy', 'ibrahim', '23, st ahmed orabi', 4700, '01066545558', 'famle');
INSERT INTO `Library`.`Employee` (`ID`, `FName`, `Minit`, `LName`, `Address`, `Salary`, `Phone`, `Sex`) VALUES ('30112546223665', 'sandy ', 'ibrahim', 'amr', '15, st elmanil', 4800, '01222354566', 'famle');
INSERT INTO `Library`.`Employee` (`ID`, `FName`, `Minit`, `LName`, `Address`, `Salary`, `Phone`, `Sex`) VALUES ('30225123552332', 'ahmed', 'mohamed', 'elsawy', '9, st ahmed zaky', 4700, '01025466953', 'male');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Library`.`Department`
-- -----------------------------------------------------
START TRANSACTION;
USE `Library`;
INSERT INTO `Library`.`Department` (`No`, `Name`, `Location`, `Mgr_id`, `Mgr_start_date`) VALUES (101, '’ِMathmatics', 'corner_1', '30206020101492', '2015-12-1');
INSERT INTO `Library`.`Department` (`No`, `Name`, `Location`, `Mgr_id`, `Mgr_start_date`) VALUES (102, 'Physics', 'corner_1', '30110170102295', '2017-2-3');
INSERT INTO `Library`.`Department` (`No`, `Name`, `Location`, `Mgr_id`, `Mgr_start_date`) VALUES (103, 'Chemistry', 'corner_2', '30111141618901', '2019-3-2');
INSERT INTO `Library`.`Department` (`No`, `Name`, `Location`, `Mgr_id`, `Mgr_start_date`) VALUES (104, 'Astronomy', 'corner_3', '30121519181722', '2014-1-4');
INSERT INTO `Library`.`Department` (`No`, `Name`, `Location`, `Mgr_id`, `Mgr_start_date`) VALUES (105, 'Biology', 'corner_2', '30201401541221', '2020-9-4');
INSERT INTO `Library`.`Department` (`No`, `Name`, `Location`, `Mgr_id`, `Mgr_start_date`) VALUES (106, 'Botany', 'corner_3', '30111214151311', '2011-11-11');
INSERT INTO `Library`.`Department` (`No`, `Name`, `Location`, `Mgr_id`, `Mgr_start_date`) VALUES (107, 'Fantasy', 'corner_4', '30101515155523', '2010-8-2');
INSERT INTO `Library`.`Department` (`No`, `Name`, `Location`, `Mgr_id`, `Mgr_start_date`) VALUES (108, 'Sports', 'corner_4', '30111515841221', '2021-5-24');
INSERT INTO `Library`.`Department` (`No`, `Name`, `Location`, `Mgr_id`, `Mgr_start_date`) VALUES (109, 'drama', 'corner_4', '30111214151311', '2019-1-24');
INSERT INTO `Library`.`Department` (`No`, `Name`, `Location`, `Mgr_id`, `Mgr_start_date`) VALUES (110, 'romantic', 'corner_4', '30121519181722', '2018-2-3');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Library`.`Author`
-- -----------------------------------------------------
START TRANSACTION;
USE `Library`;
INSERT INTO `Library`.`Author` (`No`, `Sex`, `Name`) VALUES (01, 'male', 'Charlis Dickens');
INSERT INTO `Library`.`Author` (`No`, `Sex`, `Name`) VALUES (02, 'male', 'waliam shiksbeer');
INSERT INTO `Library`.`Author` (`No`, `Sex`, `Name`) VALUES (03, 'male', 'john melton');
INSERT INTO `Library`.`Author` (`No`, `Sex`, `Name`) VALUES (04, 'male', 'jein osten');
INSERT INTO `Library`.`Author` (`No`, `Sex`, `Name`) VALUES (05, 'male ', 'luis carol');
INSERT INTO `Library`.`Author` (`No`, `Sex`, `Name`) VALUES (06, 'male', 'john kits');
INSERT INTO `Library`.`Author` (`No`, `Sex`, `Name`) VALUES (07, 'male', 'eric implr');
INSERT INTO `Library`.`Author` (`No`, `Sex`, `Name`) VALUES (08, 'male', 'oscar wailed');
INSERT INTO `Library`.`Author` (`No`, `Sex`, `Name`) VALUES (09, 'male', 'adam smith');
INSERT INTO `Library`.`Author` (`No`, `Sex`, `Name`) VALUES (10, 'male', 'Steven Spander');
INSERT INTO `Library`.`Author` (`No`, `Sex`, `Name`) VALUES (11, 'male', 'edween morgan');
INSERT INTO `Library`.`Author` (`No`, `Sex`, `Name`) VALUES (12, 'male', 'Taha Hussin');
INSERT INTO `Library`.`Author` (`No`, `Sex`, `Name`) VALUES (13, 'male', 'nagib mahfoz');
INSERT INTO `Library`.`Author` (`No`, `Sex`, `Name`) VALUES (14, 'male', 'ahmed khaled tawfiq');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Library`.`Suppliers`
-- -----------------------------------------------------
START TRANSACTION;
USE `Library`;
INSERT INTO `Library`.`Suppliers` (`Name`, `Address`, `Office_Phone`) VALUES ('blazee fox', '15,los angeles,usa', '45678874');
INSERT INTO `Library`.`Suppliers` (`Name`, `Address`, `Office_Phone`) VALUES ('Diversion Books', '17.newyork,usa', '78125614');
INSERT INTO `Library`.`Suppliers` (`Name`, `Address`, `Office_Phone`) VALUES ('bean', '14,london,england', '84745241');
INSERT INTO `Library`.`Suppliers` (`Name`, `Address`, `Office_Phone`) VALUES ('On Stage Publishing', '8,tokyo,japan', '04578417');
INSERT INTO `Library`.`Suppliers` (`Name`, `Address`, `Office_Phone`) VALUES ('Avon Romance', '6,london,england', '87412457');
INSERT INTO `Library`.`Suppliers` (`Name`, `Address`, `Office_Phone`) VALUES (' Quarto Knows', '9,Beijing,china', '31458749');
INSERT INTO `Library`.`Suppliers` (`Name`, `Address`, `Office_Phone`) VALUES ('dar el shourok', '18,nasrcity,cairo,egypt', '22962603');
INSERT INTO `Library`.`Suppliers` (`Name`, `Address`, `Office_Phone`) VALUES ('nahdit masr', '14,eltahrer streat,cairo,egypt', '22547812');
INSERT INTO `Library`.`Suppliers` (`Name`, `Address`, `Office_Phone`) VALUES ('dar el mareef', '16,eldoky streat,cairo,egypt', '24512547');
INSERT INTO `Library`.`Suppliers` (`Name`, `Address`, `Office_Phone`) VALUES ('dar madarek', '4,talat harb streat,cairo,egypt', '22369874');
INSERT INTO `Library`.`Suppliers` (`Name`, `Address`, `Office_Phone`) VALUES ('dar elgendy', '22,eldoha,qater', '14547412');
INSERT INTO `Library`.`Suppliers` (`Name`, `Address`, `Office_Phone`) VALUES ('dar nashry', '15,gada,suadi arabia', '45789451');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Library`.`Book`
-- -----------------------------------------------------
START TRANSACTION;
USE `Library`;
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1000, 'الحساب الذهني', 170, 2005, 232, 1, 101, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1001, 'استفسارات حسابية ', 150, 2009, 251, 2, 101, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1002, 'الأصول', 180, 1989, 366, 4, 101, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1003, 'الأصول الرياضية للفلسفة الطبيعية', 110, 1901, 322, 3, 101, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1004, 'الأكر', 120, 1883, 422, 1, 101, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1005, 'البحث عن الحل', 150, 1910, 666, 2, 101, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1006, 'البصريات', 170, 1899, 444, 5, 101, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1007, 'البيان والتذكار في علم مسائل الغبار', 120, 1895, 333, 4, 101, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1008, 'المختصر في حساب الجبر والمقابلة', 135, 1835, 777, 2, 101, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1009, 'عالم مجرد', 200, 1820, 555, 1, 101, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1010, 'الرياضيات للفضوليين', 150, 1900, 111, 3, 101, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1011, 'نظرية الببغاء', 180, 1923, 654, 7, 101, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1012, 'الرياضيات والشكل الأمثل', 110, 1920, 465, 12, 101, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1013, 'العناصر لإقليدس', 250, 1830, 444, 13, 101, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1014, ' أساسيات الفيزياء – بوش', 180, 1820, 788, 14, 102, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1015, 'عجائب الفيزياء – ألغاز، مفارقات، وغرائب', 170, 1935, 777, 12, 102, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1016, 'الفيزياء للعلماء والمهندسين', 150, 1886, 888, 14, 102, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1017, 'محاضرات فاينمان في الفيزياء', 180, 1900, 555, 12, 102, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1018, 'أساسيات الفيزياء للمبتدئين', 190, 1850, 333, 13, 102, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1019, 'الكون الأنيق', 160, 1932, 555, 10, 102, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1020, 'تاريخ موجز للزمن', 135, 1924, 234, 3, 102, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1021, 'فيزياء الجسيمات ', 125, 1854, 457, 9, 102, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1022, 'ما السرُّ في زرقة البحر؟', 180, 1935, 489, 10, 102, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1023, ' أحلام الفيزيائيين', 190, 1980, 956, 10, 102, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1024, 'مقدمه فى فيزياء اشباه الموصلات ', 120, 1830, 956, 11, 102, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1025, ' مع القفزة الكومونية', 145, 1935, 346, 14, 102, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1026, 'أساسيات الكيمياء العضوية', 150, 1996, 76, 12, 103, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1027, 'روعة الكيمياء', 140, 2021, 978, 13, 103, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1028, 'اساسيات الكيمياء الفيزيائية', 145, 2003, 456, 10, 103, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1029, 'أسس الكيمياء العضوية', 125, 2005, 678, 7, 103, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1030, 'organic Chemistry as a Second Language', 125, 2004, 234, 5, 103, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1031, 'Stuff Matters: Exploring the Marvelous Materials That', 160, 2013, 234, 12, 103, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1032, 'Organic Analysis', 165, 1953, 546, 14, 103, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1033, 'أسرار الكيمياء', 145, 1955, 764, 14, 103, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1034, 'prentice Hall Chemistry', 105, 2004, 333, 14, 103, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1035, 'رسائل إلى كيميائية شابة', 110, 2021, 222, 13, 103, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1036, 'الكيمياء الفيزيائية العملية', 115, 2001, 111, 2, 103, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1037, 'الكيمياء العضوية العملية', 110, 2002, 666, 3, 103, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1038, 'الكيمياء العضوية الاليفاتية', 120, 1993, 788, 14, 103, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1039, 'Essential organic chemistry', 135, 2006, 900, 12, 103, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1040, 'Organic Chemistry, 9e', 135, 1987, 999, 12, 103, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1041, 'Fundamentals of Organic Chemistry', 150, 1982, 888, 13, 103, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1042, 'الثقوب السوداء والأكوان الناشئة', 200, 1953, 777, 14, 104, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1043, 'الزيج الحاكمي', 145, 1945, 666, 10, 104, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1044, 'السر المقدس للكون (كتاب)', 123, 1933, 554, 3, 104, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1045, 'الظاهرات (أراطس)', 150, 1911, 234, 1, 104, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1046, 'الفلك الجديد (كتاب)', 250, 1835, 222, 4, 104, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1047, 'الفيزياء الفلكية بإيجاز', 140, 1888, 111, 5, 104, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1048, 'الكتاب في دورات الكواكب السماوية', 112, 1920, 333, 6, 104, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1049, 'الكون (كتاب كارل ساغان)', 115, 1925, 555, 7, 104, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1050, 'الكون في قشرة جوز', 122, 1935, 777, 8, 104, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1051, 'المجسطي', 171, 1908, 666, 9, 104, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1052, 'الموت بواسطة ثقب أسود', 142, 1845, 232, 10, 104, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1053, 'التصميم العظيم', 124, 1734, 555, 11, 104, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1054, 'تقويم فلكي', 140, 2000, 555, 2, 104, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1055, 'تقويم مور القديم', 155, 1790, 234, 14, 104, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1056, 'حوار حول النظامين الرئيسيين للكون', 450, 1632, 233, 12, 104, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1057, 'رسالة فلكية (كتاب)', 510, 1610, 222, 13, 104, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1058, 'عن السماوات', 1110, 350, 555, 10, 104, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1059, 'كتاب الأنواء', 320, 1912, 777, 10, 104, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1060, ' Molecular Biology of the Cell ', 300, 2002, 555, 11, 105, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1061, ' Ecology: From Individuals to Ecosystems ', 310, 2005, 900, 11, 105, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1111, ' The Way Life Works', 180, 2003, 666, 10, 105, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1062, ' On Becoming a Biologist', 110, 2004, 655, 10, 105, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1063, ' Biology, Visualizing Life', 107, 1999, 444, 12, 105, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1067, 'Asking About Life ', 137, 2003, 222, 13, 105, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1068, ' Liddell & Scott ', 180, 1940, 674, 11, 106, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1069, 'علم تصنيف النبات ', 150, 1919, 433, 11, 106, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1070, 'اساسيات علم تشريح النبات ', 180, 2000, 222, 12, 106, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1071, 'كتاب الموجز في علم النبات العام.', 190, 1980, 777, 14, 106, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1072, 'كتاب إسهامات العرب في علم النبات.', 210, 1981, 555, 12, 106, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1073, 'كتاب مبادئ علم النبات', 214, 1965, 999, 13, 106, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1074, 'كتاب علم تشريح النبات.', 215, 1970, 333, 10, 106, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1075, 'معجزة النبات', 211, 2008, 555, 1, 106, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1076, 'الموجز في علم النبات', 310, 2015, 222, 1, 106, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1078, 'ألف ليلة وليلة', 150, 1955, 999, 2, 107, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1079, 'كليلة ودمنة', 160, 1830, 777, 3, 107, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1080, 'أرض النفاق', 180, 1935, 544, 1, 107, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1081, 'مخطوطة بن إسحاق: مدينة الموتى', 190, 1815, 333, 4, 107, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1082, 'جبانة الأجانب', 210, 1921, 777, 5, 107, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1083, 'المصعد رقم 7', 212, 2001, 222, 6, 107, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1084, 'قيس وليلي', 220, 1944, 666, 7, 107, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1085, 'الأدب العجائبي والعالم الغرائبي', 170, 1913, 222, 8, 107, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1086, 'أرواح عالقة', 180, 2006, 999, 9, 107, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1087, 'فن الاتصال بين التعليم والرياضه', 190, 2010, 444, 3, 108, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1088, 'القوه والتدريب الرياضي', 200, 2001, 222, 11, 108, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1089, 'الاعياء النفسيه عند الرياضيين', 100, 2009, 333, 11, 108, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1090, 'ثقافة الرياضه', 120, 2015, 111, 12, 108, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1091, 'التغذيه والنشاط الرياضي', 85, 2020, 555, 13, 108, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1092, 'رياضة الكره الحره', 100, 2021, 555, 10, 108, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1093, 'رياضة الصفاء', 120, 2011, 533, 10, 108, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1094, 'طائرة ورقية عداء', 125, 2000, 344, 14, 109, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1095, 'حارس اختي', 130, 2001, 788, 14, 109, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1096, 'ألف شمس رائعة', 135, 2006, 677, 14, 109, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1097, 'لقتل الطائر المحاكي', 140, 2009, 222, 2, 109, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1098, 'حياة بي', 150, 1999, 333, 1, 109, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1099, 'سارق الكتاب', 155, 1995, 34, 1, 109, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1100, 'شيفرة دافنشي', 165, 1996, 555, 1, 109, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1101, 'في قلبي أنثى عبرية', 170, 2012, 555, 2, 110, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1102, 'الأسود يليق بك', 180, 1999, 555, 2, 110, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1103, 'الحب في زمن الكوليرا', 190, 1990, 555, 4, 110, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1104, 'أحببتك أكثر مما ينبغي', 210, 2001, 555, 1, 110, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1105, 'الحب في المنفى', 160, 2003, 555, 2, 110, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1106, 'ذاكرة الجسد', 140, 1980, 555, 5, 110, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1107, 'عصر الحب', 145, 1990, 555, 8, 110, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1108, 'آنا كارينينا', 155, 2004, 555, 9, 110, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1109, 'جين أير', 160, 2005, 555, 7, 110, DEFAULT);
INSERT INTO `Library`.`Book` (`No`, `Name`, `Cost`, `Publish_year`, `Quantity`, `A_No`, `Department_No`, `S_Name`) VALUES (1110, 'هيبتا', 200, 2019, 555, 8, 110, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Library`.`Customer`
-- -----------------------------------------------------
START TRANSACTION;
USE `Library`;
INSERT INTO `Library`.`Customer` (`SSN`, `Name`, `Address`, `Phone`) VALUES ('1101', 'mohamed ahmed ', '15 elzhraa st.cairo', '01112225678');
INSERT INTO `Library`.`Customer` (`SSN`, `Name`, `Address`, `Phone`) VALUES ('1102', 'abdelrhman mahmoud', '16 ahmed essmat.cairo', '01001547858');
INSERT INTO `Library`.`Customer` (`SSN`, `Name`, `Address`, `Phone`) VALUES ('1103', 'mohamed mahmoud', '15 elharaam st.cairo', '01097509971');
INSERT INTO `Library`.`Customer` (`SSN`, `Name`, `Address`, `Phone`) VALUES ('1104', 'ibrahim yasser ', '18 abdo basha st.banha', '01585875851');
INSERT INTO `Library`.`Customer` (`SSN`, `Name`, `Address`, `Phone`) VALUES ('1105', 'mustafa kamel', '17 elqanater st.banha', '01585754124');
INSERT INTO `Library`.`Customer` (`SSN`, `Name`, `Address`, `Phone`) VALUES ('1106', 'yara ahmed', '12 elmotaam st.cairo', '01254785421');
INSERT INTO `Library`.`Customer` (`SSN`, `Name`, `Address`, `Phone`) VALUES ('1107', 'sara yousef', '14 elmaady st.cairo', '01025789654');
INSERT INTO `Library`.`Customer` (`SSN`, `Name`, `Address`, `Phone`) VALUES ('1108', 'sondos shdeed', '7 ahmed anwar st.cairo', '01114515424');
INSERT INTO `Library`.`Customer` (`SSN`, `Name`, `Address`, `Phone`) VALUES ('1109', 'mohamed shrief', '7 elsayed ahmed st.cairo', '01550154332');
INSERT INTO `Library`.`Customer` (`SSN`, `Name`, `Address`, `Phone`) VALUES ('1110', 'Ahmed Elsayed', ' 15 Ain shams st.cairo', '01223554851');
INSERT INTO `Library`.`Customer` (`SSN`, `Name`, `Address`, `Phone`) VALUES ('1111', 'shima mohamed', '12 Ahmed zaki st.cairo', '01001101201');
INSERT INTO `Library`.`Customer` (`SSN`, `Name`, `Address`, `Phone`) VALUES ('1112', 'Huda ahmed', '12 shobra st .cairo', '01145631231');
INSERT INTO `Library`.`Customer` (`SSN`, `Name`, `Address`, `Phone`) VALUES ('1113', 'Alaa Hisham', '12 Elabasia.cairo', '01112554452');
INSERT INTO `Library`.`Customer` (`SSN`, `Name`, `Address`, `Phone`) VALUES ('1114', 'Menna mohamed', '12 Elashreen st.cairo', '01101563152');
INSERT INTO `Library`.`Customer` (`SSN`, `Name`, `Address`, `Phone`) VALUES ('1115', 'Yomna Aboelsoud', '4 elobra st.cairo', '01547855651');
INSERT INTO `Library`.`Customer` (`SSN`, `Name`, `Address`, `Phone`) VALUES ('1116', 'yousef hamdy', '18 emad eldieen st.cairo', '01177846571');
INSERT INTO `Library`.`Customer` (`SSN`, `Name`, `Address`, `Phone`) VALUES ('1117', 'mona rafaat', '19 ramy rafaat', '01258954121');
INSERT INTO `Library`.`Customer` (`SSN`, `Name`, `Address`, `Phone`) VALUES ('1118', 'hams abo eldahab', '8 tessa st.elmoatam.cairo', '01578924563');
INSERT INTO `Library`.`Customer` (`SSN`, `Name`, `Address`, `Phone`) VALUES ('1119', 'rania ramy', '11 ahmed ismail st.cairo', '01578421315');
INSERT INTO `Library`.`Customer` (`SSN`, `Name`, `Address`, `Phone`) VALUES ('1120', 'hagar abdelaziz', '12 eltahrer.st.cairo', '01088811220');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Library`.`Buy`
-- -----------------------------------------------------
START TRANSACTION;
USE `Library`;
INSERT INTO `Library`.`Buy` (`Book_No`, `Customer_SSN`, `Method_of_payment`) VALUES (1001, '1101', 'fawary');
INSERT INTO `Library`.`Buy` (`Book_No`, `Customer_SSN`, `Method_of_payment`) VALUES (1003, '1102', 'credit cards');
INSERT INTO `Library`.`Buy` (`Book_No`, `Customer_SSN`, `Method_of_payment`) VALUES (1005, '1103', 'fawry');
INSERT INTO `Library`.`Buy` (`Book_No`, `Customer_SSN`, `Method_of_payment`) VALUES (1002, '1104', 'fawry');
INSERT INTO `Library`.`Buy` (`Book_No`, `Customer_SSN`, `Method_of_payment`) VALUES (1007, '1105', 'credit cards');
INSERT INTO `Library`.`Buy` (`Book_No`, `Customer_SSN`, `Method_of_payment`) VALUES (1009, '1106', 'fawary');
INSERT INTO `Library`.`Buy` (`Book_No`, `Customer_SSN`, `Method_of_payment`) VALUES (1110, '1107', 'cash');
INSERT INTO `Library`.`Buy` (`Book_No`, `Customer_SSN`, `Method_of_payment`) VALUES (1113, '1108', 'fawary');
INSERT INTO `Library`.`Buy` (`Book_No`, `Customer_SSN`, `Method_of_payment`) VALUES (1114, '1109', 'fawary');
INSERT INTO `Library`.`Buy` (`Book_No`, `Customer_SSN`, `Method_of_payment`) VALUES (1112, '1110', 'fawary');
INSERT INTO `Library`.`Buy` (`Book_No`, `Customer_SSN`, `Method_of_payment`) VALUES (1114, '1111', 'fawary');
INSERT INTO `Library`.`Buy` (`Book_No`, `Customer_SSN`, `Method_of_payment`) VALUES (1115, '1112', 'Vodafone cash');
INSERT INTO `Library`.`Buy` (`Book_No`, `Customer_SSN`, `Method_of_payment`) VALUES (1116, '1113', 'fawary');
INSERT INTO `Library`.`Buy` (`Book_No`, `Customer_SSN`, `Method_of_payment`) VALUES (1120, '1114', 'fawary');
INSERT INTO `Library`.`Buy` (`Book_No`, `Customer_SSN`, `Method_of_payment`) VALUES (1122, '1115', 'fawary');
INSERT INTO `Library`.`Buy` (`Book_No`, `Customer_SSN`, `Method_of_payment`) VALUES (1124, '1115', 'fawary');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Library`.`Borrow`
-- -----------------------------------------------------
START TRANSACTION;
USE `Library`;
INSERT INTO `Library`.`Borrow` (`Book_No`, `Customer_SSN`, `Borrow_date`, `Return_date`) VALUES (1005, '1101', '2020-02-05', '2020-02-10');
INSERT INTO `Library`.`Borrow` (`Book_No`, `Customer_SSN`, `Borrow_date`, `Return_date`) VALUES (1015, '1102', '2020-03-12', '2020-03-16');
INSERT INTO `Library`.`Borrow` (`Book_No`, `Customer_SSN`, `Borrow_date`, `Return_date`) VALUES (1020, '1103', '2020-02-15', '2020-02-17');
INSERT INTO `Library`.`Borrow` (`Book_No`, `Customer_SSN`, `Borrow_date`, `Return_date`) VALUES (1045, '1104', '2020-03-16', '2020-03-18');
INSERT INTO `Library`.`Borrow` (`Book_No`, `Customer_SSN`, `Borrow_date`, `Return_date`) VALUES (1000, '1105', '2020-03-17', '2020-03-19');
INSERT INTO `Library`.`Borrow` (`Book_No`, `Customer_SSN`, `Borrow_date`, `Return_date`) VALUES (1001, '1106', '2020-03-22', '2020-03-26');
INSERT INTO `Library`.`Borrow` (`Book_No`, `Customer_SSN`, `Borrow_date`, `Return_date`) VALUES (1006, '1107', '2020-04-12', '2020-04-15');
INSERT INTO `Library`.`Borrow` (`Book_No`, `Customer_SSN`, `Borrow_date`, `Return_date`) VALUES (1009, '1108', '2020-04-13', '2020-04-18');
INSERT INTO `Library`.`Borrow` (`Book_No`, `Customer_SSN`, `Borrow_date`, `Return_date`) VALUES (1010, '1109', '2020-05-02', '2020-05-06');
INSERT INTO `Library`.`Borrow` (`Book_No`, `Customer_SSN`, `Borrow_date`, `Return_date`) VALUES (1011, '1110', '2020-06-02', '2020-06-08');
INSERT INTO `Library`.`Borrow` (`Book_No`, `Customer_SSN`, `Borrow_date`, `Return_date`) VALUES (1022, '1111', '2020-07-14', '2020-07-18');
INSERT INTO `Library`.`Borrow` (`Book_No`, `Customer_SSN`, `Borrow_date`, `Return_date`) VALUES (1033, '1112', '2020-08-17', '2020-08-20');
INSERT INTO `Library`.`Borrow` (`Book_No`, `Customer_SSN`, `Borrow_date`, `Return_date`) VALUES (1045, '1113', '2020-11-24', '2020-11-29');

COMMIT;


-- -----------------------------------------------------
-- Data for table `Library`.`Registrar`
-- -----------------------------------------------------
START TRANSACTION;
USE `Library`;
INSERT INTO `Library`.`Registrar` (`ID`, `Comp_no`) VALUES ('30121519181722', 1);
INSERT INTO `Library`.`Registrar` (`ID`, `Comp_no`) VALUES ('30111214151311', 3);
INSERT INTO `Library`.`Registrar` (`ID`, `Comp_no`) VALUES ('30111515841221', 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Library`.`Worker`
-- -----------------------------------------------------
START TRANSACTION;
USE `Library`;
INSERT INTO `Library`.`Worker` (`ID`, `D_No`) VALUES ('30111251212231', 101);
INSERT INTO `Library`.`Worker` (`ID`, `D_No`) VALUES ('30111256648621', 102);
INSERT INTO `Library`.`Worker` (`ID`, `D_No`) VALUES ('30206020101492', 103);
INSERT INTO `Library`.`Worker` (`ID`, `D_No`) VALUES ('30111214151311', 104);
INSERT INTO `Library`.`Worker` (`ID`, `D_No`) VALUES ('30111215131551', 106);
INSERT INTO `Library`.`Worker` (`ID`, `D_No`) VALUES ('30122513351232', 109);
INSERT INTO `Library`.`Worker` (`ID`, `D_No`) VALUES ('30121522541222', 108);
INSERT INTO `Library`.`Worker` (`ID`, `D_No`) VALUES ('30112315139521', 105);
INSERT INTO `Library`.`Worker` (`ID`, `D_No`) VALUES ('30112546223665', 109);
INSERT INTO `Library`.`Worker` (`ID`, `D_No`) VALUES ('30225123552332', 110);

COMMIT;


-- -----------------------------------------------------
-- Data for table `Library`.`Dependent`
-- -----------------------------------------------------
START TRANSACTION;
USE `Library`;
INSERT INTO `Library`.`Dependent` (`Name`, `E_ID`, `Sex`, `Relationship`, `B_Date`) VALUES ('Amal', '30203014221519', 'fmale', 'wife', '1988-10-12');
INSERT INTO `Library`.`Dependent` (`Name`, `E_ID`, `Sex`, `Relationship`, `B_Date`) VALUES ('samy', '30206020101492', 'male', 'son', '2009-8-9');
INSERT INTO `Library`.`Dependent` (`Name`, `E_ID`, `Sex`, `Relationship`, `B_Date`) VALUES ('Amr', '30110170102295', 'male', 'son', '2010-5-6');
INSERT INTO `Library`.`Dependent` (`Name`, `E_ID`, `Sex`, `Relationship`, `B_Date`) VALUES ('may', '30111416189011', 'fmale', 'daughter', '2015-9-12');
INSERT INTO `Library`.`Dependent` (`Name`, `E_ID`, `Sex`, `Relationship`, `B_Date`) VALUES ('sana', '30112023154222', 'fmale', 'wife', '1996-1-15');
INSERT INTO `Library`.`Dependent` (`Name`, `E_ID`, `Sex`, `Relationship`, `B_Date`) VALUES ('salwa', '30111214151311', 'fmale', 'wife', '1990-5-6');
INSERT INTO `Library`.`Dependent` (`Name`, `E_ID`, `Sex`, `Relationship`, `B_Date`) VALUES ('mohamed', '30201520143021', 'male', 'husband', '1984-2-9');
INSERT INTO `Library`.`Dependent` (`Name`, `E_ID`, `Sex`, `Relationship`, `B_Date`) VALUES ('Omar', '30111515841221', 'male', 'son', '2008-4-7');
INSERT INTO `Library`.`Dependent` (`Name`, `E_ID`, `Sex`, `Relationship`, `B_Date`) VALUES ('Saif', '30111215131551', 'male', 'son', '2009-9-18');
INSERT INTO `Library`.`Dependent` (`Name`, `E_ID`, `Sex`, `Relationship`, `B_Date`) VALUES ('Ahmed', '30101515155523', 'male', 'son', '2010-10-11');
INSERT INTO `Library`.`Dependent` (`Name`, `E_ID`, `Sex`, `Relationship`, `B_Date`) VALUES ('mahmoud', '30225123552332', 'male', 'son', '2007-9-22');
INSERT INTO `Library`.`Dependent` (`Name`, `E_ID`, `Sex`, `Relationship`, `B_Date`) VALUES ('yasser', '30112546223665', 'male', 'husband', '1988-6-2');
INSERT INTO `Library`.`Dependent` (`Name`, `E_ID`, `Sex`, `Relationship`, `B_Date`) VALUES ('yara', '30112315139521', 'female', 'son', '2013-7-4');
INSERT INTO `Library`.`Dependent` (`Name`, `E_ID`, `Sex`, `Relationship`, `B_Date`) VALUES ('amr', '30121522541222', 'male', 'husband', '1990-6-7');
INSERT INTO `Library`.`Dependent` (`Name`, `E_ID`, `Sex`, `Relationship`, `B_Date`) VALUES ('menna', '30122513351232', 'female', 'wife', '1994-12-30');

COMMIT;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
