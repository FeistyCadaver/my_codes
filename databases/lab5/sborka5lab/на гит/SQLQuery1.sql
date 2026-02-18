CREATE DATABASE bolnica;

GO

USE bolnica;
GO

CREATE TABLE patient
(
    mk_number TINYINT PRIMARY KEY,
    patient_name VARCHAR(128) NOT NULL,
    date_of_birth DATE NOT NULL,
    adres VARCHAR(128) NOT NULL,
    gender VARCHAR(2) NOT NULL CHECK (gender IN ('M', 'F', 'Ì', 'Æ')),
    discount_on_service DECIMAL(5,2) NOT NULL CHECK (discount_on_service >= 0 AND discount_on_service <= 100),
    CONSTRAINT CHK_Patient_Name CHECK (LEN(patient_name) > 0),
    CONSTRAINT CHK_Address CHECK (LEN(adres) > 0)
);

CREATE TABLE doctor
(
    doctor_id INT IDENTITY(1,1) PRIMARY KEY,
    d_name VARCHAR(128) NOT NULL,
    spec VARCHAR(64) NOT NULL,
    category VARCHAR(32) NOT NULL,
    CONSTRAINT CHK_Doctor_Name CHECK (LEN(d_name) > 0),
    CONSTRAINT CHK_Specialization CHECK (LEN(spec) > 0),
    CONSTRAINT CHK_Category CHECK (LEN(category) > 0)
);

CREATE TABLE diagnosis
(
    diagnosis_id INT IDENTITY(1,1) PRIMARY KEY,
    d_name VARCHAR(64) NOT NULL UNIQUE,
    category VARCHAR(32) NOT NULL,
    CONSTRAINT CHK_Diagnosis_Name CHECK (LEN(d_name) > 0),
    CONSTRAINT CHK_Diagnosis_Category CHECK (LEN(category) > 0)
);

CREATE TABLE appointment
(
    ticket_id INT IDENTITY(1,1) PRIMARY KEY,
    session_date DATETIME NOT NULL,
    purpose_visit VARCHAR(64) NOT NULL,
    visit_cost DECIMAL(10,2) NOT NULL CHECK (visit_cost >= 0),
    patient_mk_number TINYINT NOT NULL FOREIGN KEY REFERENCES patient(mk_number),
    doctor_id INT NOT NULL FOREIGN KEY REFERENCES doctor(doctor_id),
    diagnosis_id INT NULL FOREIGN KEY REFERENCES diagnosis(diagnosis_id),
    CONSTRAINT CHK_Purpose_Visit CHECK (LEN(purpose_visit) > 0),
    CONSTRAINT CHK_Session_Date CHECK (session_date <= GETDATE())
);