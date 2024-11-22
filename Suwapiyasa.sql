	-- Delete the Suwapiyasa database and all its contents if they are already exists.
DROP DATABASE IF EXISTS Suwapiyasa;

-- Create the Suwapiyasa database
CREATE DATABASE Suwapiyasa;

	-- Switch to using the Suwapiyasa database
USE Suwapiyasa;

	-- Create the Staff table
CREATE TABLE Staff(
empNo int NOT NULL UNIQUE PRIMARY KEY,
name varchar(50) NOT NULL,
gender varchar(6) NOT NULL,
address varchar(50) NOT NULL,
telNo int NOT NULL
);

	-- Create the Doctor table
CREATE TABLE Doctor(
HDNo varchar(5) PRIMARY KEY,
empNo int NOT NULL,
speciality varchar(20) NOT NULL,
salary decimal(10, 2),
FOREIGN KEY (empNo) REFERENCES Staff(empNo)
);

-- Create the Surgeon table
CREATE TABLE Surgeon(
empNo int ,
speciality varchar(20) NOT NULL,
contractType varchar(20) NOT NULL,
contractLength int,
FOREIGN KEY (empNo) REFERENCES Staff(empNo)
);

-- Create the Location table
CREATE TABLE Location(
roomNo int NOT NULL UNIQUE PRIMARY KEY,
bedNo int NOT NULL,
nursingUnit varchar(20) NOT NULL
);

	-- Create the Medication table
CREATE TABLE Medication(
code varchar(10) NOT NULL UNIQUE PRIMARY KEY,
name varchar(50) NOT NULL,
quantityOnHand int NOT NULL,
quantityOrdered int NOT NULL,
cost decimal(10, 2) NOT NULL,
expDate date NOT NULL
);

	-- Create the Patient table
CREATE TABLE Patient(
patientID int NOT NULL UNIQUE PRIMARY KEY,
initial varchar(5),
surname varchar(50),
age int,
address varchar(50),
teleNo int,
allergies varchar(100),
bloodType varchar(3),
roomNo int NOT NULL,
code varchar(10) NOT NULL,
FOREIGN KEY (roomNo) REFERENCES Location(roomNo),
FOREIGN KEY (code ) REFERENCES Medication(code)
);

	-- Create the Surgery table
CREATE TABLE Surgery(
surgeryName varchar(50) NOT NULL UNIQUE ,
patientID int,
date date,
time time,
category varchar(50),
specialNeed text,
theatre varchar(20),
empNo int NOT NULL,
FOREIGN KEY (patientID) REFERENCES Patient(patientID),
FOREIGN KEY (empNo) REFERENCES Staff(empNo)
);

	-- Create the Nurse table
CREATE TABLE Nurse(
empNo int NOT NULL,
yearsOfExperience int NOT NULL,
surgerySkill varchar(30) NOT NULL,
grade varchar(10) NOT NULL,
salary decimal(10, 2) NOT NULL,
patientID int,
FOREIGN KEY (empNo) REFERENCES Staff(empNo),
FOREIGN KEY (patientID) REFERENCES Patient(patientID)
);

	-- Switch to using the Suwapiyasa database
USE Suwapiyasa;

	-- Insert data into Staff table
INSERT INTO Staff (empNo, name, gender, address, telNo) VALUES
    (1080, 'Kamal Fernando', 'Male', '12/3,Ukwaththa,Kalutara', 0774565009),
    (2047, 'Nimali Perera ', 'Female', '45/6,Panadura', 0752936800),
    (3135, 'Saraah Rizmi', 'Female', '12/3,Wadduwa', 0774565009),
    (4268, 'Deneth peiris ', 'Male', '45/6,Palathota,Kalutara', 0752936800),
    (4362, 'Sunil Perera', 'Male', '22/1,Rathmalana',0745268905),
    (2028, 'Latha Gunasekara ', 'Female', '42/3,Thalpitiya', 0742936800);
    
SELECT * FROM Staff;
    
    -- Insert data into Doctor table
INSERT INTO Doctor (HDNo, empNo, speciality, salary) VALUES
    ('50H', 1080, 'Cardiology', 100000),
    ('52H', 4268, 'Neurology', 150000);
    
SELECT * FROM Doctor;

    
    -- Insert data into Surgeon table
INSERT INTO Surgeon (empNo, speciality, contractType, contractLength) VALUES
    (3135, 'Cardiac Surgery', 'Full-time', 4),
    (4362, 'Neurological Surgery', 'Part-time', 3);
    
SELECT * FROM Surgeon;
    
    -- Insert data into Location table
INSERT INTO Location (bedNo, roomNo, nursingUnit) VALUES
    (01, 11, 'Heart Ward'),
    (02, 12, 'Neuro Ward'),
	(03, 8, 'Pediatric Ward');
    
SELECT * FROM Location;

    
    -- Insert data into Medication table
INSERT INTO Medication (code, name, quantityOnHand, quantityOrdered, cost, expDate) VALUES
    ('MA01', 'Aspirin', 200, 30, 5.99, '2023-09-30'),
    ('MP02', 'Phenytoin', 120, 20, 6.35, '2024-03-15'),
    ('MA03', 'Acetaminophen', 250, 25, 3.85, '2023-12-20');
    
SELECT * FROM Medication;
    
    -- Insert data into Patient table
INSERT INTO Patient (patientID, initial, surname, age, address, teleNo, allergies, bloodType, roomNo, code) VALUES
    (101, 'K', 'Silva', 55, '70/5 Mathugama',0774565008, 'Peanuts', 'O', 11, 'MA01'),
    (102, 'L', 'Fernando', 45, '45/1 Maggona', 0752369800, 'None', 'B', 12, 'MP02'),
	(103, 'R.M.', 'Peiris', 65, '45/1 Maggona', 0752369800, 'Lactose', 'AB', 8, 'MA03');
    
SELECT * FROM Patient;
    
    -- Insert data into Surgery table
INSERT INTO Surgery (patientID, surgeryName, date, time, category, empNo, specialNeed) VALUES
    (101, 'Bypass', '2023-04-15', '10:00:00', 'Cardiac', 3135, 'require close and specialized monitoring'),
    (102, 'Brain Tumor Removal', '2023-05-20', '11:30:00',  'Neurological', 4362, 'requires special monitoring');
    
SELECT * FROM Surgery;
    
-- Insert data into Nurse table
INSERT INTO Nurse (empNo, yearsOfExperience, surgerySkill, grade, salary, patientID) VALUES
    (2047, 7, 'Cardiac', 'Senior', 70000, 101),
    (2028, 4, 'Neurological', 'Junior', 50000, 102);
    
SELECT * FROM Nurse;
 