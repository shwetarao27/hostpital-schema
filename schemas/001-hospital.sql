-- See MySQL Reference Manual for guidance
-- https://dev.mysql.com/doc/refman/5.7/en/

-- Create the hospital database
CREATE DATABASE hospital;

-- Create the hadmin user with default password
CREATE USER hadmin IDENTIFIED BY 'password';

-- Make the hadmin user admin of hospital database
GRANT ALL PRIVILEGES ON hospital.* TO 'hadmin';

-- Switch to hospital database to create the schema
USE hospital;

-- ---
-- CREATE CORE TABLES
-- ---

-- Rooms
CREATE TABLE rooms (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name CHAR(5) NOT NULL
);

-- Staff Role
CREATE TABLE staff_roles (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(25) NOT NULL
);

-- Staff
CREATE TABLE staff (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(64) NOT NULL,
    last_name VARCHAR(64) NOT NULL,
    employee_id BIGINT NOT NULL UNIQUE,
    role_id BIGINT NOT NULL,
    CONSTRAINT fk_role_for_staff FOREIGN KEY (role_id) REFERENCES staff_roles(id)
);

-- Insurance Providers
CREATE TABLE insurance_providers (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(64) NOT NULL
);

-- Patients
CREATE TABLE patients (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(64) NOT NULL,
    last_name VARCHAR(64) NOT NULL,
    policy_id VARCHAR(32) NOT NULL UNIQUE,
    provider_id BIGINT NOT NULL,
    CONSTRAINT fk_provider_for_patient FOREIGN KEY (provider_id) REFERENCES insurance_providers(id)
);

-- Active Admissions
CREATE TABLE active_admissions (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    diagnosis VARCHAR(1024) NOT NULL,
    date_admitted DATE NOT NULL,
    room_id BIGINT NOT NULL UNIQUE,
    patient_id BIGINT NOT NULL UNIQUE,
    doctor_id BIGINT NOT NULL,
    nurse_id BIGINT NOT NULL,
    CONSTRAINT fk_room_for_active_admission FOREIGN KEY (room_id) REFERENCES rooms(id),
    CONSTRAINT fk_patient_for_active_admission FOREIGN KEY (patient_id) REFERENCES patients(id),
    CONSTRAINT fk_doctor_for_active_admission FOREIGN KEY (doctor_id) REFERENCES staff(id),
    CONSTRAINT fk_nurse_for_active_admission FOREIGN KEY (nurse_id) REFERENCES staff(id)
);

-- Admissions History
CREATE TABLE admission_history (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    diagnosis VARCHAR(1024) NOT NULL,
    date_admitted DATE NOT NULL,
    date_discharged DATE NOT NULL,
    room_id BIGINT NOT NULL,
    patient_id BIGINT NOT NULL,
    doctor_id BIGINT NOT NULL,
    nurse_id BIGINT NOT NULL,
    CONSTRAINT fk_room_for_admission FOREIGN KEY (room_id) REFERENCES rooms(id),
    CONSTRAINT fk_patient_for_admission FOREIGN KEY (patient_id) REFERENCES patients(id),
    CONSTRAINT fk_doctor_for_admission FOREIGN KEY (doctor_id) REFERENCES staff(id),
    CONSTRAINT fk_nurse_for_admission FOREIGN KEY (nurse_id) REFERENCES staff(id)
);
