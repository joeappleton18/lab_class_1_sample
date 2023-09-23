DROP DATABASE IF EXISTS Library;
CREATE DATABASE Library;
USE Library;

CREATE TABLE Publisher (
    Pub_Name            VARCHAR(255) UNIQUE NOT NULL,
    Pub_Location        VARCHAR(255),
    PRIMARY KEY (Pub_Name)
);

CREATE TABLE Item (
    Item_ID             VARCHAR(13) UNIQUE NOT NULL,
    Pub_Name            VARCHAR(255),
    Item_Title          VARCHAR(255) NOT NULL,
    Item_Available_Online    BOOLEAN,
    Item_Date_Released  SMALLINT,
    Item_Subject        VARCHAR(255),
    Item_Copies         TINYINT DEFAULT 1,
    Item_Type           ENUM('Book', 'Journal', 'Other'),
    PRIMARY KEY (Item_ID),
    FOREIGN KEY (Pub_Name) REFERENCES Publisher (Pub_Name)
);

CREATE TABLE Book (
    Item_ID             VARCHAR(13) UNIQUE NOT NULL,
    Book_Edition        VARCHAR(255),
    PRIMARY KEY (Item_ID),
    FOREIGN KEY (Item_ID) REFERENCES Item(Item_ID) ON DELETE CASCADE
);

CREATE TABLE Journal (
    Item_ID             VARCHAR(13) UNIQUE NOT NULL,
    Frequency           VARCHAR(255),
    In_Production       BOOLEAN,
    PRIMARY KEY (Item_ID),
    FOREIGN KEY (Item_ID) REFERENCES Item(Item_ID) ON DELETE CASCADE
);

CREATE TABLE Author (
    Auth_ID           INT(8) ZEROFILL NOT NULL AUTO_INCREMENT,
    Auth_FName               VARCHAR(255),
    Auth_LName               VARCHAR(255),
    Auth_Title               VARCHAR(255),
    PRIMARY KEY (Auth_ID)
);

CREATE TABLE Creates (
    Item_ID             VARCHAR(13) NOT NULL,
    Auth_ID           INT(8) ZEROFILL NOT NULL,
    PRIMARY KEY (Item_ID, Auth_ID),
    FOREIGN KEY (Item_ID) REFERENCES Item(Item_ID) ON DELETE CASCADE,
    FOREIGN KEY (Auth_ID) REFERENCES Author(Auth_ID)
);


CREATE TABLE Student (
    URN                 INT(7) UNIQUE NOT NULL,
    Stu_FName           VARCHAR(255) NOT NULL,
    Stu_LName           VARCHAR(255) NOT NULL,
    Stu_Gender          ENUM('Male', 'Female', 'Other'),
    Stu_Email           VARCHAR(255),
    Stu_Phone           VARCHAR(11),
    PRIMARY KEY (URN)
);

CREATE TABLE Loan (
    URN                 INT(7) NOT NULL,
    Item_ID             VARCHAR(13) NOT NULL,
    Date_Out            TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Date_Due            TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (URN, Item_ID, Date_Out),
    FOREIGN KEY (URN) REFERENCES Student(URN),
    FOREIGN KEY (Item_ID) REFERENCES Item(Item_ID)
    
);

INSERT INTO Publisher VALUES ('Pearson Education Limited', 'Harlow, United Kingdom'),
    ('O''Reilly', 'Farnham, United Kingdom'),
    ('Springer', 'Berlin, Heidelberg'),
    ('Big Book Publishings', 'Guildford, United Kingdom'),
    ('Idea Group Pub.', 'Hershey, PA'),
    ('Beeblebooks', 'Brussels, Belgium'),
    ('International Publishing Dex', 'Pallet Town, Kanto'),
    ('Alpacca Books', 'Hilton, United Kingdom'),
    ('Generic Name Group', 'Gothenburg, Sweden');
    
INSERT INTO Item VALUES ('9780596006303', 'Pearson Education Limited', 'Fundamentals of Database Systems, Global Edition', 1, 2016, 'Databases', 20, 'Book'),
    ('9781292097626', 'O''Reilly', 'Head first PHP & MySQL', 1, 2009, 'Web site development', 15, 'Book'),
    ('9783540007456', 'Springer', 'Web, Web-Services, and Database Systems', 0, 2003, 'World Wide Web', 4, 'Book'),
    ('9784956315752', 'Big Book Publishings', 'Website goes brrrr', 0, 2018, 'World Wide Web', 31, 'Book'),
    ('9776374125863', 'Alpacca Books', 'The Dangers of Database Design', 1, 1988, 'Database Management', 10, 'Book');

INSERT INTO Item VALUES ('15338010', 'Idea Group Pub.', 'Journal of database management', 1, 1992, 'Database Management', 1, 'Journal'),
    ('10538666', 'O''Reilly', 'Database Engineering', 1, 1983, 'Database Management', 4, 'Journal'),
    ('13796431', 'Beeblebooks', 'Constructing a Hyperspace Bypass', 0, 2002, 'Improbability', 42, 'Journal'),
    ('11116642', 'International Publishing Dex', 'Catching bugs effectively', 1, 1998, 'Web site development', 3, 'Journal'),
    ('15432112', 'Generic Name Group', 'Web Technologies', 1, 1989, 'World Wide Web', 14, 'Journal');

INSERT INTO Item VALUES ('3540365605', 'Springer', 'Databases and You', 1, 2005, 'Database Management', 0, 'Other');

INSERT INTO Book VALUES ('9780596006303', '7th Edition'),
    ('9781292097626', NULL),
    ('9783540007456', '2nd Edition'),
    ('9784956315752', 'Game of the Year Edition'),
    ('9776374125863', '13th Edition');

INSERT INTO Journal VALUES ('15338010', 'Quarterly', 1),
    ('10538666', 'Hourly', 0),
    ('13796431', 'Tuesdays', 1),
    ('11116642', 'Every 5 months', 0),
    ('15432112', 'Quarterly', 1);
    
    INSERT INTO Author (Auth_FName, Auth_LName, Auth_Title) VALUES ('Kevin', 'Bacon', 'Dr'),
    ('Tricia', 'McMillan', 'Prof'),
    ('Masahiro', 'Sakurai', NULL),
    ('Barry', 'Benson', 'Dr'),
    ('Tracey', 'Phillips', NULL),
    ('Emily', 'Willson', 'Prof'),
    ('Barry', 'Benson', 'Prof'),
    ('Clive', 'Matcham', 'Prof'),
    ('Celine', 'Dione', 'Dr'),
    ('Leroy', 'Jenkins', NULL);
    
    INSERT INTO Creates VALUES ('9780596006303', 1),
    ('9781292097626', 2),
    ('9783540007456', 3),
    ('9784956315752', 1),
    ('9784956315752', 4),
    ('9776374125863', 5),
    ('15338010', 6),
    ('10538666', 7),
    ('10538666', 9),
    ('10538666', 8),
    ('13796431', 2),
    ('11116642', 3),
    ('15432112', 9),
    ('3540365605', 10);
    

INSERT INTO Student VALUES (6639553, 'Tim', 'Allen', 'Male', 'ta00176@surrey.ac.uk', '07777253196'),
    (6498532, 'Bill', 'Nye', 'Male', 'bn05461@surrey.ac.uk', '07987654321'),
    (6675823, 'Phillipa', 'Swift', 'Female', 'ps00681@surrey.ac.uk', '01443586984'),
    (6543210, 'Billy', 'Mays', 'Male', 'bm00077@surrey.ac.uk', '07458648541'),
    (6748231, 'Amelia', 'Pond', 'Female', 'ap00987@surrey.ac.uk', '01458674586'),
    (6663211, 'Dawn', 'French', 'Female', 'df00713@surrey.ac.uk', '07766842139'),
    (6642189, 'Four', 'Klift', 'Other', 'fk00852@surrey.ac.uk', '07965136455'),
    (6693128, 'Frank', 'Bean', 'Male', 'fb00186@surrey.ac.uk', '07349582716'),
    (6748531, 'Cecilia', 'Barnaby', 'Female', 'cb00707@surrey.ac.uk', '07916234823'),
    (6646489, 'Bjorn', 'Boroughman', 'Other', 'bb01234@surrey.ac.uk', '07476385219');

INSERT INTO Loan (URN, Item_ID) VALUES (6639553, '9780596006303'),
    (6498532, '9783540007456'),
    (6675823, '9776374125863'),
    (6543210, '9776374125863'),
    (6543210, '10538666'),
    (6748231, '13796431'),
    (6642189, '11116642'),
    (6693128, '11116642'),
    (6748531, '15432112'),
    (6748531, '3540365605');