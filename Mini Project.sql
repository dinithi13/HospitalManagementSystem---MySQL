-- Switch to using the Suwapiyasa database
USE Suwapiyasa;

# Q1 - 521444611
-- Create a view to display patient's information along with surgery details
CREATE VIEW PatientSurgeryView AS
SELECT
    p.patientID AS 'Patient ID',
    CONCAT(p.initial, ' ', p.surname) AS 'Patient Name',
    CONCAT(l.bedNo, '/', l.roomNo) AS 'Location',
    s.surgeryName AS 'Surgery Name',
    s.date AS 'Surgery Date'
FROM
    Patient p
INNER JOIN
    Surgery s ON p.patientID = s.patientID
INNER JOIN
    Location l ON p.roomNo = l.roomNo;
    
    -- To view the result
SELECT * FROM PatientSurgeryView;

# Q2 - 521444611
-- Create the MedInfo table
CREATE TABLE MedInfo (
    MedName varchar(50) NOT NULL PRIMARY KEY,
    QuantityAvailable int NOT NULL,
    ExpirationDate date NOT NULL
);

SELECT * FROM MedInfo;

# Q2(i) - 521444611
-- Trigger to load data into 'MedInfo' table when a new record is inserted into 'Medication' table
DELIMITER //
CREATE TRIGGER InsertMedicationTrigger
AFTER INSERT ON Medication
FOR EACH ROW
BEGIN
    INSERT INTO MedInfo (MedName, QuantityAvailable, ExpirationDate)
    VALUES (NEW.name, NEW.quantityOnHand, NEW.expDate);
END;
//
DELIMITER ;

# Q2(ii) - 521444611
-- Trigger to update automatically 'MedInfo' table when a record in 'Medication' table is updated
DELIMITER //
CREATE TRIGGER UpdateMedicationTrigger
AFTER UPDATE ON Medication
FOR EACH ROW
BEGIN
    UPDATE MedInfo
    SET QuantityAvailable = NEW.quantityOnHand, ExpirationDate = NEW.expDate
    WHERE MedName = NEW.name;
END;
//
DELIMITER ;
-- To check if the 'MedInfo' table updates correctly after inserting data into the 'Medication' table
INSERT INTO Medication (code, name, quantityOnHand, quantityOrdered, cost, expDate) VALUES 
('MA04', 'Panadol', 550, 520, 3.99, '2024-11-30'),
('MA05', 'Ibuprofen', 150, 20, 4.99, '2023-10-31');
SELECT * FROM MedInfo;

# Q2(iii) - 521444611
-- Trigger to delete  records in 'MedInfo' table when a record in 'Medication' table is deleted
DELIMITER //
CREATE TRIGGER DeleteMedicationTrigger
AFTER DELETE ON Medication
FOR EACH ROW
BEGIN
    DELETE FROM MedInfo WHERE MedName = OLD.name;
END;
//
DELIMITER ;

-- To check if the 'MedInfo' table deletes values correctly after deleting data from the 'Medication' table
DELETE FROM Medication WHERE code = 'MA05';
SELECT * FROM MedInfo;

# Q3 - 521444611
-- Define a stored procedure to calculate the number of medications taken by a patient.
DELIMITER //
CREATE PROCEDURE GetNoOfMedications(
    IN patientIDInput INT,         
    INOUT noOfMedications INT     
)
BEGIN
    SELECT COUNT(*) INTO noOfMedications
    FROM Medication M
    JOIN Patient P ON M.code = P.code
    WHERE P.patientID = patientIDInput;
END;
//
DELIMITER ;

-- Set a session variable 'patientID' with an example patient ID
SET @patientID = 101;

--  to calculate the medication count for the patient.
CALL GetNoOfMedications(@patientID, @noOfMedications);

-- Retrieve and display the calculated number of medications saved in the 'noOfMedications' variable
SELECT @noOfMedications;


# Q4 - 521444611
-- To calculate the number of days until medication expiration.
DELIMITER //
CREATE FUNCTION NoOfDaysUntilExpiration(expDate DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    RETURN DATEDIFF(expDate, CURDATE());
END;
//
DELIMITER ;
-- To find medications with less than 30 days remaining for expiry
SELECT * FROM Medication
WHERE NoOfDaysUntilExpiration(expDate) <= 30;

# Q5 - 521444611
-- Retrieve all records from the Staff table after exporting data from Staff.xml file
SELECT * FROM Staff;
-- Retrieve all records from the Patient table after exporting data from Patient.xml file
SELECT * FROM Patient;

