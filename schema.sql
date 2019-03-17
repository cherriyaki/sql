-- Part 2.1 schema.sql
--
-- Submitted by: Cherry Lim Siang Sue, 1837527
--

-- DO NOT use these SQL commands in your submission(they will cause an
--  error on the NMS database server):
-- CREATE SCHEMA
-- USE

CREATE TABLE COACH (
	`name` VARCHAR(20) NOT NULL,
	surname VARCHAR(20) NOT NULL,
	dob DATE,
	idcoach INT NOT NULL AUTO_INCREMENT,
	phone CHAR(11),
	dailysalary DECIMAL(8,2),
	gender CHAR(1),

	PRIMARY KEY(idcoach)
);

CREATE TABLE CONTENDER (
	stagename VARCHAR(40) UNIQUE NOT NULL,
	`type` CHAR(1) NOT NULL,
	idcontender INT NOT NULL AUTO_INCREMENT,
	coach INT,

	PRIMARY KEY(idcontender),
	FOREIGN KEY(coach) REFERENCES COACH(idcoach)
	ON DELETE SET NULL
);

CREATE TABLE PARTICIPANT (
	`name` VARCHAR(20) NOT NULL,
	surname VARCHAR(20) NOT NULL,
	dob DATE,
	idparticipant INT NOT NULL AUTO_INCREMENT,
	phone CHAR(11),
	dailysalary DECIMAL(8,2),
	gender CHAR(1),
	contender INT NOT NULL,

	PRIMARY KEY(idparticipant),
	FOREIGN KEY(contender) REFERENCES CONTENDER(idcontender)
	ON DELETE CASCADE
);

CREATE TABLE TVSHOW (
	`location` VARCHAR(30) DEFAULT 'Studio' NOT NULL,
	`date` DATE NOT NULL,
	idshow INT NOT NULL AUTO_INCREMENT,
	starttime TIME,
	endtime TIME,

	PRIMARY KEY(idshow)
);

CREATE TABLE COACHINSHOW (
	coach INT NOT NULL,
	`show` INT NOT NULL,

	PRIMARY KEY(coach, `show`),
	FOREIGN KEY(coach) REFERENCES COACH(idcoach)
	ON DELETE CASCADE,
	FOREIGN KEY(`show`) REFERENCES TVSHOW(idshow)
);

CREATE TABLE CONTENDERINSHOW (
	contender INT NOT NULL,
	`show` INT NOT NULL,

	PRIMARY KEY(contender, `show`),
	FOREIGN KEY(contender) REFERENCES CONTENDER(idcontender)
	ON DELETE CASCADE,
	FOREIGN KEY(`show`) REFERENCES TVSHOW(idshow)
);
