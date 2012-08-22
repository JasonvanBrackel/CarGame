CREATE DATABASE [CarGame]
GO

USE [CarGame]
GO

CREATE TABLE dbo.Type (
	Id INT IDENTITY(1,1) NOT NULL,
	Name NVARCHAR(50) NOT NULL		
)

ALTER TABLE 
	dbo.Type
ADD CONSTRAINT
	PK_Type
PRIMARY KEY (
	Id
)

INSERT INTO dbo.Type (Name) VALUES ('Car')
INSERT INTO dbo.Type (Name) VALUES ('Truck')
INSERT INTO dbo.Type (Name) VALUES ('Motorcycle') 


CREATE TABLE dbo.Vehicle (
	Id INT IDENTITY(1,1) NOT NULL,
	Name NVARCHAR(100) NOT NULL,
	TypeId INT NOT NULL,
	ImagePath NVARCHAR(4000) NULL
)

ALTER TABLE 
	dbo.Vehicle
ADD CONSTRAINT
	PK_Vehicle
PRIMARY KEY (
	Id
)

ALTER TABLE
	dbo.Vehicle
ADD CONSTRAINT
	FK_Type_Vehicle
FOREIGN KEY (
	TypeId
)
REFERENCES 
	dbo.Type (
		Id
)
GO

CREATE PROCEDURE dbo.GetNextVehicle
	@Id INT
AS
BEGIN
DECLARE @Return INT 

SET @Return = ISNULL((SELECT TOP 1 Id FROM dbo.Vehicle WHERE Id > @Id), 0)

IF @Return > 0 
BEGIN
SELECT TOP 1 
	Id,
	Name,
	TypeId,
	ImagePath
FROM
	dbo.Vehicle
WHERE
	Id > @Id
END
ELSE
BEGIN
SELECT TOP 1 
	Id,
	Name,
	TypeId,
	ImagePath
FROM
	dbo.Vehicle
WHERE
	Id = (SELECT MIN(Id) FROM dbo.Vehicle)
END
END
GO

CREATE PROCEDURE dbo.GetPreviousVehicle
	@Id INT
AS
BEGIN
DECLARE @Return INT

SET @Return = ISNULL((SELECT TOP 1 Id FROM dbo.Vehicle WHERE Id < @Id ORDER BY Id DESC), 0)

IF @Return > 0 
BEGIN
SELECT TOP 1 
	Id,
	Name,
	TypeId,
	ImagePath
FROM
	dbo.Vehicle
WHERE
	Id < @Id
ORDER BY Id DESC
END
ELSE
BEGIN
SELECT TOP 1 
	Id,
	Name,
	TypeId,
	ImagePath
FROM
	dbo.Vehicle
WHERE
	Id = (SELECT MAX(Id) FROM dbo.Vehicle)
END
END
GO

INSERT INTO Vehicle (Name, TypeId, ImagePath) VALUES ('1956 Flashsider',2,'cars/1956 Flashsider.jpg');
INSERT INTO Vehicle (Name, TypeId, ImagePath) VALUES ('1958 Chevy Impala',1,'cars/1958 Chevy Impala.jpg');
INSERT INTO Vehicle (Name, TypeId, ImagePath) VALUES ('1963 Studebaker Avanti',1,'cars/1963 Studebaker Avanti.jpg');
INSERT INTO Vehicle (Name, TypeId, ImagePath) VALUES ('1965 Mustang Fastback',1,'cars/1965 Mustang Fastback.jpg');
INSERT INTO Vehicle (Name, TypeId, ImagePath) VALUES ('1967 Chevelle SS 396',1,'cars/1967 Chevelle SS 396.jpg');
INSERT INTO Vehicle (Name, TypeId, ImagePath) VALUES ('1970 Chevelle SS',1,'cars/1970 Chevelle SS.jpg');
INSERT INTO Vehicle (Name, TypeId, ImagePath) VALUES ('1970 Pontiac GTO Judge',1,'cars/1970 Pontiac GTO Judge.jpg');
INSERT INTO Vehicle (Name, TypeId, ImagePath) VALUES ('1971 Dodge Challenger',1,'cars/1971 Dodge Challenger.jpg');
INSERT INTO Vehicle (Name, TypeId, ImagePath) VALUES ('1971 Maverick Grabber',1,'cars/1971 Maverick Grabber.jpg');
INSERT INTO Vehicle (Name, TypeId, ImagePath) VALUES ('2010 Ford Mustang GT',1,'cars/2010 Ford Mustang GT.jpg');
INSERT INTO Vehicle (Name, TypeId, ImagePath) VALUES ('24 Ours',2,'cars/24 Ours.jpg');
INSERT INTO Vehicle (Name, TypeId, ImagePath) VALUES ('5 Alarm',2,'cars/5 Alarm.jpg');
INSERT INTO Vehicle (Name, TypeId, ImagePath) VALUES ('Armored Truck',2,'cars/Armored Truck.jpg');
INSERT INTO Vehicle (Name, TypeId, ImagePath) VALUES ('Back Slider',2,'cars/Back Slider.jpg');
INSERT INTO Vehicle (Name, TypeId, ImagePath) VALUES ('Buzzerk',1,'cars/Buzzerk.jpg');
INSERT INTO Vehicle (Name, TypeId, ImagePath) VALUES ('C6 Corvette',1,'cars/C6 Corvette.jpg');
INSERT INTO Vehicle (Name, TypeId, ImagePath) VALUES ('Corvette Grand Sport',1,'cars/Corvette Grand Sport.jpg');
INSERT INTO Vehicle (Name, TypeId, ImagePath) VALUES ('Corvette Stingray',1,'cars/Corvette Stingray.jpg');
INSERT INTO Vehicle (Name, TypeId, ImagePath) VALUES ('Croc Rod',1,'cars/Croc Rod.jpg');
INSERT INTO Vehicle (Name, TypeId, ImagePath) VALUES ('Customized C3500',2,'cars/Customized C3500.jpg');
INSERT INTO Vehicle (Name, TypeId, ImagePath) VALUES ('Ducati 1098R',3,'cars/Ducati 1098R.jpg');
INSERT INTO Vehicle (Name, TypeId, ImagePath) VALUES ('F-Racer',1,'cars/F-Racer.jpg');
INSERT INTO Vehicle (Name, TypeId, ImagePath) VALUES ('Fast Cash',1,'cars/Fast Cash.jpg');
INSERT INTO Vehicle (Name, TypeId, ImagePath) VALUES ('Ferrari F430',1,'cars/Ferrari F430.jpg');
INSERT INTO Vehicle (Name, TypeId, ImagePath) VALUES ('Firebird',1,'cars/Firebird.jpg');
INSERT INTO Vehicle (Name, TypeId, ImagePath) VALUES ('Honda Racer',1,'cars/Honda Racer.jpg');
INSERT INTO Vehicle (Name, TypeId, ImagePath) VALUES ('Hummer H2 SUT',2,'cars/Hummer H2 SUT.jpg');
INSERT INTO Vehicle (Name, TypeId, ImagePath) VALUES ('Hyper Mite',1,'cars/Hyper Mite.jpg');
INSERT INTO Vehicle (Name, TypeId, ImagePath) VALUES ('Jet Threat 4.0',1,'cars/Jet Threat 4.0.jpg');
INSERT INTO Vehicle (Name, TypeId, ImagePath) VALUES ('Lotus Concept',1,'cars/Lotus Concept.jpg');
INSERT INTO Vehicle (Name, TypeId, ImagePath) VALUES ('Mustang Funny Car',1,'cars/Mustang Funny Car.jpg');
INSERT INTO Vehicle (Name, TypeId, ImagePath) VALUES ('Nissan 350Z',1,'cars/Nissan 350Z.jpg');
INSERT INTO Vehicle (Name, TypeId, ImagePath) VALUES ('Off Track',2,'cars/Off Track.jpg');
INSERT INTO Vehicle (Name, TypeId, ImagePath) VALUES ('Pikes Peak Tacoma',1,'cars/Pikes Peak Tacoma.jpg');
INSERT INTO Vehicle (Name, TypeId, ImagePath) VALUES ('Plymouth Duster Thruster',1,'cars/Plymouth Duster Thruster.jpg');
INSERT INTO Vehicle (Name, TypeId, ImagePath) VALUES ('Rockster',2,'cars/Rockster.jpg');
INSERT INTO Vehicle (Name, TypeId, ImagePath) VALUES ('Snow Ride',3,'cars/Snow Ride.jpg');
INSERT INTO Vehicle (Name, TypeId, ImagePath) VALUES ('Speed Trap',1,'cars/Speed Trap.jpg');
INSERT INTO Vehicle (Name, TypeId, ImagePath) VALUES ('Surf Crate',1,'cars/Surf Crate.jpg');
INSERT INTO Vehicle (Name, TypeId, ImagePath) VALUES ('Synkro',1,'cars/Synkro.jpg');

