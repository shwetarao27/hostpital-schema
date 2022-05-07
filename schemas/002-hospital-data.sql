-- Switch to hospital database to create the schema
USE hospital;

-- Create rooms
INSERT INTO rooms (name) VALUES
    ('A.001'),
    ('A.002'),
    ('B.001'),
    ('B.002');

-- Create Staff Roles
INSERT INTO staff_roles (title) VALUES ('DOCTOR'), ('NURSE');
