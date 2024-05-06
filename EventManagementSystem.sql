CREATE DATABASE EventManagementSystem;

CREATE TABLE UserDetails(
	UserID BIGINT PRIMARY KEY IDENTITY(1,1),
	UserName VARCHAR(20) NOT NULL,
	UserEmail VARCHAR(30) NOT NULL,
	UserPassword VARCHAR(15) NOT NULL,
	UserMobile VARCHAR(15) NOT NULL,
	UserIsActive BIT NOT NULL
);

CREATE TABLE AdminDetails(
	AdminID BIGINT PRIMARY KEY IDENTITY(1,1),
	AdminName VARCHAR(20) NOT NULL,
	AdminEmail VARCHAR(30) NOT NULL,
	AdminPassword VARCHAR(15) NOT NULL,
	AdminMobile VARCHAR(15) NOT NULL,
	AdminIsActive BIT NOT NULL
);

CREATE TABLE EventDetails(
	EventID BIGINT PRIMARY KEY IDENTITY(1,1),
	EventName VARCHAR(20) NOT NULL,
	EventStartDate DATETIME  NOT NULL,
	EventEndDate DATETIME NOT NULL,
	EventDiscription VARCHAR(300)  NOT NULL,
	EventAddress VARCHAR(200)  NOT NULL,
	EventCreatedBy BIGINT FOREIGN KEY REFERENCES AdminDetails(AdminID)  NOT NULL,
	EventIsActive BIT NOT NULL,
	EventImage VARCHAR(MAX) NOT NULL,
	EventIsDelete BIT
);

CREATE TABLE ActivityDetails(
	ActivityID BIGINT PRIMARY KEY IDENTITY(1,1),
	ActivityName VARCHAR(20) NOT NULL,
	ActivityStartDate DATETIME NOT NULL,
	ActivityEndDate DATETIME NOT NULL,
	ActivityDiscription VARCHAR(300) NOT NULL,
	ActivityPrice BIGINT NOT NULL,
	EventID BIGINT FOREIGN KEY REFERENCES EventDetails(EventID) NOT NULL,
	IsActive BIT  NOT NULL,
	ActivityIsDelete BIT
);

ALTER TABLE ActivityDetails
ADD ActivityIsDelete BIT;

SELECT * FROM UserDetails;
SELECT * FROM AdminDetails;
SELECT * FROM EventDetails;
SELECT * FROM ActivityDetails;

INSERT INTO AdminDetails(AdminName, AdminEmail, AdminPassword, AdminMobile, AdminIsActive )
VALUES('Admin1','admin1@gmail.com','111111','1111111111',0)

INSERT INTO AdminDetails(AdminName, AdminEmail, AdminPassword, AdminMobile, AdminIsActive )
VALUES('Admin2','admin2@gmail.com','222222','2222222222',0)

INSERT INTO AdminDetails(AdminName, AdminEmail, AdminPassword, AdminMobile, AdminIsActive )
VALUES('Admin3','admin3@gmail.com','333333','3333333333',0)

INSERT INTO UserDetails(UserName, UserEmail, UserPassword, UserMobile, UserIsActive )
VALUES('User1','User1@gmail.com','111111','1111111111',0)

INSERT INTO UserDetails(UserName, UserEmail, UserPassword, UserMobile, UserIsActive )
VALUES('User2','User2@gmail.com','222222','2222222222',0)

EXEC Sp_Login 'User1@gmail.com','111111','User';

EXEC Sp_Login 'User11@gmail.com','111111','User';

EXEC Sp_Logout 'User3@gmail.com',3;

EXEC Sp_Login 'Admin1@gmail.com','111111','Admin';

EXEC Sp_Login 'Admin11@gmail.com','111111','Admin';

EXEC Sp_Logout 'Admin1@gmail.com';

UPDATE AdminDetails
SET AdminPassword = 'Admin@3333'
WHERE AdminID = 3

SELECT * FROM EventDetails;

TRUNCATE TABLE EventDetails;

ALTER TABLE EventDetails
ADD EventIsDelete BIT;

UPDATE EventDetails
SET EventIsDelete = 0

ALTER TABLE ActivityDetails
ADD ActivityIsDelete BIT;

UPDATE ActivityDetails
SET ActivityIsDelete = 0

EXEC Sp_AddEvent 'Event1','','','','',1;

EXEC Sp_AddEvent 'Event','04/10/2024','04/11/2024','first time in gujarat','Ahmedabad',1,'G:\Parth Prajapati\Week Tasks\Week10Task\EventManagementAPI\EventManagementAPI\Images\14-24-16.png','Insert';

EXEC Sp_AddEvent 'Event','19/04/2024','21/04/2024','first time in gujarat','Ahmedabad',1,null,'Insert';

EXEC Sp_AddEvent @Flag = 'ViewWithoutPublish', @EventCreatedBy = 3;

EXEC Sp_AddEvent @Flag = 'ViewWithPublish', @EventName = 'Event1', @EventCreatedBy = 1;

SELECT * FROM ActivityDetails;

TRUNCATE TABLE ActivityDetails

EXEC Sp_AddActivity 'Activity2','10/04/2024 4:00:00','11/04/2024 5:00:00','first time in gujarat',null;

EXEC Sp_AddActivity 'Activity2','10/04/2024 4:00:00:00','11/04/2024 5:00:00','first time in gujarat',1000,2,'Insert';

EXEC Sp_AddActivity @Flag = 'ViewActivity', @EventID = 2

EXEC Sp_AddActivity @Flag = 'ViewWithPublish',@ActivityName = 'Activity1', @EventID = 1

EXEC Sp_AddActivity @Flag = 'Publish', @EventID = 1;

EXEC Sp_GetEvent @Flag = 'ViewWithoutPublish', @EventCreatedBy = 1;
EXEC Sp_DeleteEvent 2,'Delete';

SELECT * FROM EventDetails;
EXEC Sp_UpdateEvent 14,'Cricket Match','2024-05-25 15:52:00.000','2024-05-25 15:52:00.000','Cricket match between CSK and SRH','Narendra Modi Stadium, Ahmedabad','G:\Parth Prajapati\Week Tasks\Week10Task\EventManagementAPI\EventManagementAPI\Images\12-04-19.png','Update';
