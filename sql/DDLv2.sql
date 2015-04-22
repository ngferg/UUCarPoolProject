SET foreign_key_checks=0;

DROP TABLE IF EXISTS Address;

DROP TABLE IF EXISTS Person;

DROP TABLE IF EXISTS person_lives_at_address;

DROP TABLE IF EXISTS Car;

DROP TABLE IF EXISTS Event;

DROP TABLE IF EXISTS person_drives_for_event;

DROP TABLE IF EXISTS person_needs_ride_for_event;

DROP TABLE IF EXISTS person_has_car;

DROP TABLE IF EXISTS Photos;

DROP TABLE IF EXISTS Announcement;

DROP TABLE IF EXISTS event_has_announcements;

DROP TABLE IF EXISTS is_a_employee;

DROP TABLE IF EXISTS is_a_member;

DROP TABLE IF EXISTS `Group`;

DROP TABLE IF EXISTS group_has_members;

DROP TABLE IF EXISTS group_has_photos;

DROP TABLE IF EXISTS group_has_announcements;

DROP TABLE IF EXISTS annoucement_has_photos;

DROP TABLE IF EXISTS event_has_photos;

DROP TABLE IF EXISTS event_in_church;

DROP TABLE IF EXISTS event_out_of_church;

DROP TABLE IF EXISTS Family;

DROP TABLE IF EXISTS Phone;

DROP TABLE IF EXISTS person_has_phone;

DROP TABLE IF EXISTS Email;

DROP TABLE IF EXISTS person_has_email;

DROP TABLE IF EXISTS person_goes_to_event;
SET foreign_key_checks=1;



CREATE TABLE Address(
	aid INTEGER AUTO_INCREMENT NOT NULL,
	houseNumber VARCHAR(31) NOT NULL,
	suiteNumber VARCHAR(31),
	street VARCHAR(127) NOT NULL,
	city VARCHAR(127) NOT NULL,
	zipcode INTEGER NOT NULL,
	PRIMARY KEY (aid))ENGINE=InnoDB;


CREATE TABLE Person(
	pid INTEGER AUTO_INCREMENT NOT NULL,
	firstName VARCHAR(63) NOT NULL,
	lastName VARCHAR(63) NOT NULL,
	emailAddress VARCHAR(255) NOT NULL,
	PRIMARY KEY (pid))ENGINE=InnoDB;


CREATE TABLE person_lives_at_address(
	aid INTEGER NOT NULL,
	pid INTEGER NOT NULL,
	FOREIGN KEY (aid) REFERENCES Address(aid) ON DELETE CASCADE,
	FOREIGN KEY (pid) REFERENCES Person(pid) ON DELETE CASCADE,
	PRIMARY KEY(aid,pid))ENGINE=InnoDB;


CREATE TABLE Car(
	cid INTEGER AUTO_INCREMENT NOT NULL,
	openSeats INTEGER NOT NULL,
	make VARCHAR(63) NOT NULL,
	model VARCHAR(63) NOT NULL,
	color VARCHAR(20) NOT NULL,
	license_num VARCHAR(20) NOT NULL,
	PRIMARY KEY(cid))ENGINE=InnoDB;


CREATE TABLE Event(
	eid INTEGER AUTO_INCREMENT NOT NULL,
	eventName VARCHAR(127) NOT NULL,
	startTime TIMESTAMP NOT NULL,
	endTime TIMESTAMP NOT NULL,
	description VARCHAR(1023) NOT NULL,
	eventType VARCHAR(31) NOT NULL,
	PRIMARY KEY(eid))ENGINE=InnoDB;


CREATE TABLE person_drives_for_event(
	pid INTEGER NOT NULL,
	eid INTEGER NOT NULL,
	FOREIGN KEY(pid) REFERENCES Person(pid) ON DELETE CASCADE,
	FOREIGN KEY(eid) REFERENCES Event(eid) ON DELETE CASCADE,
	PRIMARY KEY(pid,eid))ENGINE=InnoDB;


CREATE TABLE person_needs_ride_for_event(
 	pid INTEGER NOT NULL,
 	eid INTEGER NOT NULL,
 	FOREIGN KEY(pid) REFERENCES Person(pid) ON DELETE CASCADE,
 	FOREIGN KEY(eid) REFERENCES Event(eid) ON DELETE CASCADE,
 	PRIMARY KEY(pid,eid))ENGINE=InnoDB;


CREATE TABLE person_has_car(
	pid INTEGER NOT NULL,
	cid INTEGER NOT NULL,
	FOREIGN KEY(pid) REFERENCES Person(pid) ON DELETE CASCADE,
	FOREIGN KEY(cid) REFERENCES Car(cid) ON DELETE CASCADE,
	PRIMARY KEY(pid,cid))ENGINE=InnoDB;


CREATE TABLE Photos(
	pid INTEGER AUTO_INCREMENT NOT NULL,
	updloadDate TIMESTAMP NOT NULL,
	PRIMARY KEY(pid))ENGINE=InnoDB;


CREATE TABLE Announcement(
	aid INTEGER AUTO_INCREMENT NOT NULL,
	content VARCHAR(2047) NOT NULL,
	aDate TIMESTAMP NOT NULL,
	PRIMARY KEY(aid))ENGINE=InnoDB;


CREATE TABLE event_has_announcements(
	aid INTEGER NOT NULL,
	eid INTEGER NOT NULL,
	FOREIGN KEY(aid) REFERENCES Announcement(aid) ON DELETE CASCADE,
	FOREIGN KEY(eid) REFERENCES Event(eid) ON DELETE CASCADE,
	PRIMARY KEY(aid,eid))ENGINE=InnoDB;


CREATE TABLE is_a_employee(
	pid INTEGER NOT NULL,
	position VARCHAR(63) NOT NULL,
	FOREIGN KEY(pid) REFERENCES Person(pid) ON DELETE CASCADE,
	PRIMARY KEY(pid))ENGINE=InnoDB;


CREATE TABLE is_a_member(
	pid INTEGER NOT NULL,
	FOREIGN KEY(pid) REFERENCES Person(pid) ON DELETE CASCADE,
	PRIMARY KEY(pid))ENGINE=InnoDB;


CREATE TABLE `Group`(
	gid INTEGER AUTO_INCREMENT NOT NULL,
	name VARCHAR(63) NOT NULL,
	sponsor INTEGER,
	FOREIGN KEY(sponsor) REFERENCES Person(pid),
	PRIMARY KEY(gid))ENGINE=InnoDB;


CREATE TABLE group_has_members(
	gid INTEGER NOT NULL,
	pid INTEGER NOT NULL,
	FOREIGN KEY(gid) REFERENCES `Group`(gid) ON DELETE CASCADE,
	FOREIGN KEY(pid) REFERENCES Person(pid) ON DELETE CASCADE,
	PRIMARY KEY(gid,pid))ENGINE=InnoDB;

CREATE TABLE group_has_photos(
	gid INTEGER NOT NULL,
	phid INTEGER NOT NULL,
	FOREIGN KEY(gid) REFERENCES `Group`(gid) ON DELETE CASCADE,
	FOREIGN KEY(phid) REFERENCES Photos(pid) ON DELETE CASCADE,
	PRIMARY KEY(gid,phid))ENGINE=InnoDB;


CREATE TABLE group_has_announcements(
	gid INTEGER NOT NULL,
	aid INTEGER NOT NULL,
	FOREIGN KEY(gid) REFERENCES `Group`(gid) ON DELETE CASCADE,
	FOREIGN KEY(aid) REFERENCES Announcement(aid) ON DELETE CASCADE,
	PRIMARY KEY(gid,aid))ENGINE=InnoDB;


CREATE TABLE annoucement_has_photos(
	aid INTEGER NOT NULL,
	pid INTEGER NOT NULL,
	FOREIGN KEY(aid) REFERENCES Announcement(aid) ON DELETE CASCADE,
	FOREIGN KEY(pid) REFERENCES Photos(pid) ON DELETE CASCADE,
	PRIMARY KEY(aid,pid))ENGINE=InnoDB;


CREATE TABLE event_has_photos(
	eid INTEGER NOT NULL,
	pid INTEGER NOT NULL,
	FOREIGN KEY(eid) REFERENCES Event(eid) ON DELETE CASCADE,
	FOREIGN KEY(pid) REFERENCES Photos(pid) ON DELETE CASCADE,
	PRIMARY KEY(eid,pid))ENGINE=InnoDB;


CREATE TABLE event_in_church(
	eid INTEGER NOT NULL,
	FOREIGN KEY(eid) REFERENCES Event(eid) ON DELETE CASCADE,
	PRIMARY KEY(eid))ENGINE=InnoDB;


CREATE TABLE event_out_of_church(
    eid INTEGER NOT NULL,
    FOREIGN KEY(eid) REFERENCES Event(eid) ON DELETE CASCADE,
    PRIMARY KEY(eid))ENGINE=InnoDB;


CREATE TABLE Family(
	fid INTEGER NOT NULL,
	name VARCHAR(63) NOT NULL,
	pid INTEGER NOT NULL,
	FOREIGN KEY(pid) REFERENCES Person(pid) ON DELETE CASCADE,
	PRIMARY KEY(fid, pid))ENGINE=InnoDB;


CREATE TABLE Phone(
	phone_number CHAR(10) NOT NULL,
	PRIMARY KEY(phone_number))ENGINE=InnoDB;


CREATE TABLE person_has_phone(
	phone_number CHAR(10) NOT NULL,
	pid INTEGER NOT NULL,
	FOREIGN KEY(phone_number) REFERENCES Phone(phone_number) ON DELETE CASCADE,
	FOREIGN KEY(pid) REFERENCES Person(pid) ON DELETE CASCADE,
	PRIMARY KEY(phone_number, pid))ENGINE=InnoDB;


CREATE TABLE Email(
    address VARCHAR(255) NOT NULL,
    PRIMARY KEY(address))ENGINE=InnoDB;


CREATE TABLE person_has_email(
    address VARCHAR(255) NOT NULL,
    pid INTEGER NOT NULL,
    FOREIGN KEY(address) REFERENCES Email(address) ON DELETE CASCADE,
    FOREIGN KEY(pid) REFERENCES Person(pid) ON DELETE CASCADE,
    PRIMARY KEY(address, pid))ENGINE=InnoDB;

CREATE TABLE person_goes_to_event(
	pid INTEGER,
	eid INTEGER,
	PRIMARY KEY(pid,eid),
	FOREIGN KEY(pid) REFERENCES Person(pid) ON DELETE CASCADE,
	FOREIGN KEY(eid) REFERENCES Event(eid) ON DELETE CASCADE
	)ENGINE=InnoDB;