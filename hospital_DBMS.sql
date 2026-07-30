
-- Create Database
CREATE DATABASE hospital_DB;
USE hospital_DB;


-- CREATING DEPARTMENT TABLE
create table departments
(
  departmentID int auto_increment primary key,
  name varchar(50) not null
);


-- CREATING TABLE DOCTORS
create table doctors
(
  doctorID int auto_increment primary key,
  name varchar(50),
  specialization varchar(100),
  role varchar(50),
  department_id int,
  foreign key (department_id) references departments(departmentID)
);


-- CREATE PATIENTS TABLE
CREATE TABLE patients
(
  patientID int auto_increment primary key,
  name varchar(50),
  dateOfBirth date,
  gender varchar(1),
  phone varchar(15),
  constraint check (gender in('m', 'f','o'))
);


-- CREATE APPOINTMENTS TABLE
CREATE TABLE appointments
(
 appointmentID int auto_increment primary key,
 patient_id int ,
 doctor_id int,
 appointment_time datetime,
 status varchar(50),
 foreign key (patient_id) references patients(patientID),
 foreign key (doctor_id) references doctors(doctorID),
 constraint check (status in ('Scheduled','Completed','Cancelled'))
);


-- CREATE PRESCRIPTION TABLE
CREATE TABLE prescriptions
( 
prescriptionID INT auto_increment primary key,
appointment_id INT,
medication VARCHAR(100),
dosage VARCHAR(100),
FOREIGN KEY  (appointment_id) REFERENCES appointments(appointmentID)
);


-- CREATE BILLS TABLE
CREATE TABLE bills
( 
 billID INT auto_increment primary key,
 appointment_ID INT,
 amount DECIMAL(10,2),
 paid TINYINT(1),
 billDate DATETIME DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY (appointment_ID) REFERENCES appointments(appointmentID)
);


-- CREATE LABREPORT TABLES
CREATE TABLE labReports
( 
 reportID INT auto_increment primary key,
 Appointment_id INT,
 reportData TEXT,
 createdAt DATETIME DEFAULT CURRENT_TIMESTAMP,
 FOREIGN KEY (Appointment_id) REFERENCES appointments(appointmentID)
);









-- INSERTION IN DATABASE

SELECT * FROM hospital_data;

SELECT `Departments.DepartmentID` FROM hospital_data;

SELECT * FROM INFORMATION_SCHEMA.COLUMNS ;

SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS 
WHERE 
TABLE_SCHEMA = 'hospital_DB'
AND TABLE_NAME = 'hospital_data'
AND COLUMN_NAME LIKE 'Departments.%' ;






-- INSERTING VALUES INTO DEPARTMENT TABLE

SELECT concat('select',group_concat(concat('`',COLUMN_NAME ,'`')), 'from hospital_data')
FROM INFORMATION_SCHEMA.COLUMNS
WHERE 
TABLE_SCHEMA = 'hospital_DB'
AND TABLE_NAME = 'hospital_data'
AND COLUMN_NAME LIKE 'Departments.%'  ;

-- o/p : 'select`Departments.DepartmentID`,`Departments.Name`from hospital_data'

insert into departments(departmentID,name) 
select`Departments.DepartmentID`,`Departments.Name`from hospital_data
where `Departments.DepartmentID`<>'' ;

select * from departments ;






-- INSERTING VALUES INTO DOCTORS TABLE

SELECT concat('select',group_concat(concat('`',COLUMN_NAME ,'`')), 'from hospital_data')
FROM INFORMATION_SCHEMA.COLUMNS
WHERE 
TABLE_SCHEMA = 'hospital_DB'
AND TABLE_NAME = 'hospital_data'
AND COLUMN_NAME LIKE 'Doctors.%'  ;

-- o/p : select`Doctors.DoctorID`,`Doctors.Name`,`Doctors.Specialization`,`Doctors.Role`,`Doctors.DepartmentID`from hospital_data


INSERT INTO doctors(department_id, doctorID, name, role, specialization)
select`Doctors.DepartmentID`,`Doctors.DoctorID`,`Doctors.Name`,
`Doctors.Role`,`Doctors.Specialization`from hospital_data
WHERE `Doctors.DepartmentID`<>'' ; 

select * from doctors ;






-- INSERTING VALUES INTO PATIENTS TABLE

SELECT concat('select',group_concat(concat('`',COLUMN_NAME ,'`')), 'from hospital_data')
FROM INFORMATION_SCHEMA.COLUMNS
WHERE 
TABLE_SCHEMA = 'hospital_DB'
AND TABLE_NAME = 'hospital_data'
AND COLUMN_NAME LIKE 'Patients.%' ;

INSERT INTO patients(patientID, name, dateOfBirth, gender, phone)
SELECT 
  `Patients.PatientID`,
  `Patients.Name`,
  STR_TO_DATE(`Patients.DateOfBirth`, '%d-%m-%Y'),  -- Correct format
  `Patients.Gender`, `Patients.Phone`
FROM hospital_data
WHERE `Patients.PatientID` <> '';

select * from patients ;





-- INSERT VALUES INTO APPOINTMENT TABLES

SELECT concat('select',group_concat(concat('`',COLUMN_NAME ,'`')), 'from hospital_data')
FROM INFORMATION_SCHEMA.COLUMNS
WHERE 
TABLE_SCHEMA = 'hospital_DB'
AND TABLE_NAME = 'hospital_data'
AND COLUMN_NAME LIKE 'Appointments.%' ;

INSERT INTO appointments(appointmentID, patient_id, doctor_id, appointment_time, status)
SELECT`Appointments.AppointmentID`,`Appointments.PatientID`,
`Appointments.DoctorID`,
STR_TO_DATE(`Appointments.AppointmentTime`,'%d-%m-%Y %H:%i'),
`Appointments.Status`FROM hospital_data ;

select * from appointments ;





-- INSERTING VALUE INTO PRESCRIPTIONS

SELECT concat('select',group_concat(concat('`',COLUMN_NAME ,'`')), 'from hospital_data')
FROM INFORMATION_SCHEMA.COLUMNS
WHERE 
TABLE_SCHEMA = 'hospital_DB'
AND TABLE_NAME = 'hospital_data'
AND COLUMN_NAME LIKE 'Prescriptions.%' ;

INSERT INTO prescriptions(prescriptionID, appointment_id, medication, dosage)
SELECT`Prescriptions.PrescriptionID`,`Prescriptions.AppointmentID`,
`Prescriptions.Medication`,`Prescriptions.Dosage`FROM HOSPITAL_DATA 
WHERE `Prescriptions.PrescriptionID` <>'' ;

select * from prescriptions ;






--  INSERT DATA INTO LABREPORTS

SELECT concat('select',group_concat(concat('`',COLUMN_NAME ,'`')), 'from hospital_data')
FROM INFORMATION_SCHEMA.COLUMNS
WHERE 
TABLE_SCHEMA = 'hospital_DB'
AND TABLE_NAME = 'hospital_data'
AND COLUMN_NAME LIKE 'LabReports.%' ;

  
INSERT INTO labReports(reportID, Appointment_id, reportData, createdAt)
SELECT `LabReports.ReportID`,`LabReports.AppointmentID`,`LabReports.ReportData`,
`LabReports.CreatedAt`FROM HOSPITAL_DATA
WHERE  `LabReports.ReportID`<>'' ;

select * from labReports ;




-- INSERT DATAI INTO BILLS( becoz SQL is case incensitive !! hence query excutes even for captal case )

SELECT CONCAT('SELECT',GROUP_CONCAT(CONCAT('`' , COLUMN_NAME,'`' )),'FROM HOSPITAL_DATA') FROM 
INFORMATION_SCHEMA.COLUMNS
WHERE 
  TABLE_SCHEMA = 'EHIAS'  -- replace with your actual DB
  AND TABLE_NAME = 'hospital_data'
  AND COLUMN_NAME LIKE 'BILLS.%';
  
  
INSERT INTO BILLS( BILLID, appointment_ID, AMOUNT, PAID, BILLDATE)
SELECT`Bills.BillID`,`Bills.AppointmentID`,`Bills.Amount`,`Bills.Paid`,
`Bills.BillDate`FROM HOSPITAL_DATA
WHERE `Bills.BillID`<>'';

SELECT * FROM BILLS;





-- POINT 4 --> TRIGGER

DELIMITER $$

CREATE TRIGGER check_new_appointment
BEFORE INSERT ON appointments
FOR EACH ROW
BEGIN 
   IF NEW.appointment_time < NOW() THEN 
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Error: Appointment cannot be  in the past.';
   END IF ;
   
   IF  EXISTS
    (
      SELECT * FROM appointments
      WHERE doctor_id = NEW.doctor_id AND 
      appointment_time = NEW.appointment_time
      AND STATUS IN ('SCHEDULED')
	) THEN 
    SIGNAL SQLSTATE '45000'
	SET MESSAGE_TEXT= 'Error: Doctor Already has an appointment  at this time';
   END IF ;
END $$

DELIMITER ; 

-- Checkig if trigger works or not 

INSERT INTO appointments (appointmentID,patient_id,doctor_id,appointment_time,status)
VALUES(10000,1,1,'2026-07-31 10:00:00','Scheduled') ;

INSERT INTO appointments (appointmentID,patient_id,doctor_id,appointment_time,status)
VALUES(10001,1,1,'2026-07-31 10:00:00','Scheduled') ;

INSERT INTO appointments (appointmentID,patient_id,doctor_id,appointment_time,status)
VALUES(10001,1,1,'2026-07-30 10:00:00','Scheduled') ;






-- POINT 5 : Stored Procedure

DELIMITER $$
CREATE PROCEDURE  view_doctor_data(IN input_username VARCHAR(100), IN input_password VARCHAR(100))
BEGIN 
  DECLARE doc_role VARCHAR(100);
  DECLARE doc_dept INT;
  DECLARE doc_id INT;
  
  -- CHECK CREDENTIALS OF THE DOCTOR FROM Credendials table
  SELECT doctor_id INTO doc_id
  FROM  doctor_credentials 
  WHERE user_name = input_username AND password = input_password;
  
  -- GET ROLE AND DEPARTMENT FROM DOCTORS TABLE
  SELECT role , department_id
  INTO doc_role, doc_dept
  FROM doctors WHERE doctorID = doc_id;
  
  -- SHOW APPROPRIATE PATIENTS DATA. 
  
  IF doc_role ='senior' THEN
     SELECT D.doctorID,P.PatientID, P.name, P.gender, 
	 A.appointment_time, PR.medication, LR.reportData
	 FROM patients AS P INNER JOIN
	 appointments AS A ON A.patient_id = P.patientID
     JOIN doctors  D ON D.doctorID= A.doctor_id
	 LEFT JOIN prescriptions AS PR ON A.appointmentID = PR.appointment_id
	 LEFT JOIN labReports AS LR ON A.appointmentID = LR.Appointment_id
     WHERE D.department_id = doc_dept;
  ELSE
    SELECT A.doctor_id,P.PatientID, P.name, P.gender, 
	 A.appointment_time, PR.medication ,LR.reportData
	 FROM patients AS P INNER JOIN
	 appointments AS A ON A.patient_id = P.patientID
	 LEFT JOIN prescriptions AS PR ON A.appointmentID = PR.appointment_id
	 LEFT JOIN labReports AS LR ON A.appointmentID = LR.Appointment_id
     WHERE A.doctor_id = doc_id;
   END IF;
END $$
DELIMITER ;

-- check if stored procedure works or not 

CALL VIEW_DOCTOR_DATA('doctor1','W3jzIANG') ;
CALL VIEW_DOCTOR_DATA('doctor4','ic0pFSn0') ;










-- POINT 6 : Another stored procedure

DELIMITER //

CREATE PROCEDURE monthly_revenue(IN p_year INT , IN p_month INT)
BEGIN
 SELECT D1.name AS department,
	SUM(B.amount) AS total_revenue
	FROM bills AS B 
	INNER JOIN appointments AS A ON A.appointmentID = B.appointment_ID
	INNER JOIN doctors AS D ON A.doctor_id = D.doctorID
	INNER JOIN departments AS D1 ON D1.departmentID = D.doctorID
	WHERE  MONTH(B.billDate) = p_month AND YEAR(B.billDate) = p_year
GROUP BY D1.name;
END//

DELIMITER ;

-- check if stored procedure works or not 

CALL monthly_revenue(2025, 5) ;

























