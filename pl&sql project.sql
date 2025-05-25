-- 1. Sections Table
CREATE TABLE sections (
    section_id NUMBER PRIMARY KEY,
    section_name VARCHAR2(50) NOT NULL
);
-- 2. Children Table
CREATE TABLE children (
    child_id NUMBER PRIMARY KEY,
    full_name VARCHAR2(100) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender VARCHAR2(10),
    disability_status VARCHAR2(3) CHECK (disability_status IN ('Yes', 'No')),
    section_id NUMBER REFERENCES sections(section_id)
);
-- 3. Education Table
CREATE TABLE education (
    education_id NUMBER PRIMARY KEY,
    child_id NUMBER REFERENCES children(child_id),
    school_name VARCHAR2(100),
    grade_level VARCHAR2(30),
    performance_notes VARCHAR2(200)
);
-- 4. Staff Table
CREATE TABLE staff (
    staff_id NUMBER PRIMARY KEY,
    full_name VARCHAR2(100),
    position VARCHAR2(50),
    contact_number VARCHAR2(15)
);
-- 5. Support Services Table
CREATE TABLE support_services (
    service_id NUMBER PRIMARY KEY,
    service_type VARCHAR2(50),
    description VARCHAR2(200),
    child_id NUMBER REFERENCES children(child_id),
    staff_id NUMBER REFERENCES staff(staff_id),
    service_date DATE DEFAULT SYSDATE
);

-- Insert into Sections
INSERT INTO sections (section_id, section_name) VALUES (1, 'Disabled');
INSERT INTO sections (section_id, section_name) VALUES (2, 'Non-Disabled');
INSERT INTO sections (section_id, section_name) VALUES (3, 'Visually Impaired');
INSERT INTO sections (section_id, section_name) VALUES (4, 'Hearing Impaired');

-- Insert into Children
INSERT INTO children (child_id, full_name, date_of_birth, gender, disability_status, section_id)
VALUES (101, 'Alice Mukamana', TO_DATE('2012-03-15', 'YYYY-MM-DD'), 'Female', 'Yes', 1);

INSERT INTO children (child_id, full_name, date_of_birth, gender, disability_status, section_id)
VALUES (102, 'David Nshimiyimana', TO_DATE('2010-07-22', 'YYYY-MM-DD'), 'Male', 'No', 2);

INSERT INTO children (child_id, full_name, date_of_birth, gender, disability_status, section_id)
VALUES (103, 'Grace Uwimana', TO_DATE('2011-11-10', 'YYYY-MM-DD'), 'Female', 'Yes', 3);

INSERT INTO children (child_id, full_name, date_of_birth, gender, disability_status, section_id)
VALUES (104, 'Eric Habimana', TO_DATE('2013-05-02', 'YYYY-MM-DD'), 'Male', 'Yes', 4);



-- Insert Education Records
INSERT INTO education (education_id, child_id, school_name, grade_level, performance_notes)
VALUES (201, 101, 'Hope Academy', 'P5', 'Good progress in reading');

INSERT INTO education (education_id, child_id, school_name, grade_level, performance_notes)
VALUES (202, 102, 'Bright Future School', 'P6', 'Excellent in science and math');

INSERT INTO education (education_id, child_id, school_name, grade_level, performance_notes)
VALUES (203, 103, 'Vision Empowerment Center', 'P4', 'Adapting well with braille');

INSERT INTO education (education_id, child_id, school_name, grade_level, performance_notes)
VALUES (204, 104, 'Silent World School', 'P3', 'Shows improvement in sign language');


-- Insert Staff
INSERT INTO staff (staff_id, full_name, position, contact_number)
VALUES (301, 'Janet Mukazera', 'Social Worker', '0788123456');

INSERT INTO staff (staff_id, full_name, position, contact_number)
VALUES (302, 'James Nkurunziza', 'Counselor', '0788234567');

INSERT INTO staff (staff_id, full_name, position, contact_number)
VALUES (303, 'Claudine Irakoze', 'Education Officer', '0788345678');

INSERT INTO staff (staff_id, full_name, position, contact_number)
VALUES (304, 'Patrick Mugabo', 'Health Officer', '0788456789');


-- Insert Support Services
INSERT INTO support_services (service_id, service_type, description, child_id, staff_id, service_date)
VALUES (401, 'Counseling', 'Weekly therapy for emotional support', 101, 302, TO_DATE('2024-11-01', 'YYYY-MM-DD'));

INSERT INTO support_services (service_id, service_type, description, child_id, staff_id, service_date)
VALUES (402, 'Medical Checkup', 'Routine physical checkup', 102, 304, TO_DATE('2024-10-20', 'YYYY-MM-DD'));

INSERT INTO support_services (service_id, service_type, description, child_id, staff_id, service_date)
VALUES (403, 'Special Education', 'Braille reading sessions', 103, 303, TO_DATE('2024-10-15', 'YYYY-MM-DD'));

INSERT INTO support_services (service_id, service_type, description, child_id, staff_id, service_date)
VALUES (404, 'Speech Therapy', 'Sign language training', 104, 302, TO_DATE('2024-11-05', 'YYYY-MM-DD'));

-- 1. DML & DDL OPERATIONS
-- -----------------------
-- Example: Updating a child’s grade level
UPDATE education
SET grade_level = 'P6'
WHERE child_id = 101;

-- Deleting a support service entry
DELETE FROM support_services
WHERE service_id = 404;

-- Creating a new table for audit logs
CREATE TABLE audit_log (
  log_id NUMBER PRIMARY KEY,
  activity VARCHAR2(100),
  log_date DATE DEFAULT SYSDATE
);

-- Altering a table: adding email to staff
ALTER TABLE staff ADD email VARCHAR2(100);

-- Dropping an unused table (example)
-- DROP TABLE unused_table;

-- 2. PROCEDURES, FUNCTIONS, CURSORS, EXCEPTION HANDLING
-- ------------------------------------------------------

-- PROCEDURE: Fetch child details by section
CREATE OR REPLACE PROCEDURE fetch_children_by_section(p_section_id IN NUMBER) IS
  CURSOR child_cursor IS
    SELECT full_name, date_of_birth, gender FROM children WHERE section_id = p_section_id;
  v_name children.full_name%TYPE;
  v_dob children.date_of_birth%TYPE;
  v_gender children.gender%TYPE;
BEGIN
  OPEN child_cursor;
  LOOP
    FETCH child_cursor INTO v_name, v_dob, v_gender;
    EXIT WHEN child_cursor%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Name: ' || v_name || ', DOB: ' || v_dob || ', Gender: ' || v_gender);
  END LOOP;
  CLOSE child_cursor;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error fetching children: ' || SQLERRM);
END;
/

-- FUNCTION: Count number of services per child
CREATE OR REPLACE FUNCTION get_service_count(p_child_id IN NUMBER) RETURN NUMBER IS
  v_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO v_count FROM support_services WHERE child_id = p_child_id;
  RETURN v_count;
EXCEPTION
  WHEN OTHERS THEN
    RETURN -1;
END;
/

-- 3. WINDOW FUNCTION USAGE
-- -------------------------
-- Rank children based on number of services
SELECT c.full_name, COUNT(s.service_id) AS total_services,
       RANK() OVER (ORDER BY COUNT(s.service_id) DESC) AS service_rank
FROM children c
LEFT JOIN support_services s ON c.child_id = s.child_id
GROUP BY c.full_name;

-- 4. PACKAGE IMPLEMENTATION
-- --------------------------
--Package Specification
CREATE OR REPLACE PACKAGE child_pkg IS
  PROCEDURE get_all_children;
  PROCEDURE get_children_by_section(p_section_id IN NUMBER);
END child_pkg;
/
-- package body
CREATE OR REPLACE PACKAGE BODY child_pkg IS

  PROCEDURE get_all_children IS
  BEGIN
    FOR rec IN (SELECT * FROM children) LOOP
      DBMS_OUTPUT.PUT_LINE('Name: ' || rec.full_name || ', Gender: ' || rec.gender || ', Section ID: ' || rec.section_id);
    END LOOP;
  END get_all_children;

  PROCEDURE get_children_by_section(p_section_id IN NUMBER) IS
  BEGIN
    FOR rec IN (SELECT * FROM children WHERE section_id = p_section_id) LOOP
      DBMS_OUTPUT.PUT_LINE('Name: ' || rec.full_name || ', Gender: ' || rec.gender);
    END LOOP;
  END get_children_by_section;

END child_pkg;
/
-- To list all children
BEGIN
  child_pkg.get_all_children;
END;
/
-- To list children in a specific section (e.g., section_id = 1)
BEGIN
  child_pkg.get_children_by_section(1);
END;
/

--Testing a Procedure with Parameters
BEGIN
  child_pkg.get_children_by_section(2); 
END;


CREATE TABLE audit_logs (
    log_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    table_name VARCHAR2(50),
    operation VARCHAR2(20),
    record_id NUMBER,
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE OR REPLACE TRIGGER trg_log_child_insert
AFTER INSERT ON children
FOR EACH ROW
BEGIN
  INSERT INTO audit_log (table_name, operation, record_id)
  VALUES ('children', 'INSERT', :NEW.child_id);
END;
/

CREATE TABLE public_holidays (
    holiday_date DATE PRIMARY KEY,
    description VARCHAR2(100)
);

-- Insert sample holidays for testing
INSERT INTO public_holidays (holiday_date, description) VALUES (TO_DATE('2024-06-10', 'YYYY-MM-DD'), 'Staff Day');
INSERT INTO public_holidays (holiday_date, description) VALUES (TO_DATE('2024-06-14', 'YYYY-MM-DD'), 'National Clean-up Day');

-- Audit Table to Track User Activity
CREATE TABLE audit_logss (
    log_id NUMBER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
    user_id VARCHAR2(50),
    table_name VARCHAR2(50),
    operation VARCHAR2(20),
    record_id NUMBER,
    action_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR2(20)
);


-- Security Trigger to Prevent Manipulation on Weekdays and Holidays
CREATE OR REPLACE TRIGGER trg_block_on_restricted_days
BEFORE INSERT OR UPDATE OR DELETE ON children
FOR EACH ROW
DECLARE
    v_day VARCHAR2(10);
    v_count NUMBER;
BEGIN
    -- Get current day name (e.g., MON, TUE, etc.)
    SELECT TO_CHAR(SYSDATE, 'DY') INTO v_day FROM dual;
    
    -- Check if today is a weekday (Mon-Fri)
    IF v_day IN ('MON', 'TUE', 'WED', 'THU', 'FRI') THEN
        INSERT INTO audit_logs(user_id, table_name, operation, record_id, status)
        VALUES (USER, 'children', 'BLOCKED_WEEKDAY', NULL, 'Denied');
        RAISE_APPLICATION_ERROR(-20001, 'Operation not allowed on weekdays.');
    END IF;

    -- Check if today is a holiday in the next 30 days
    SELECT COUNT(*) INTO v_count
    FROM public_holidays
    WHERE holiday_date = TRUNC(SYSDATE)
      AND holiday_date <= (TRUNC(SYSDATE) + 30);
IF v_count > 0 THEN
        INSERT INTO audit_logs(user_id, table_name, operation, record_id, status)
        VALUES (USER, 'children', 'BLOCKED_HOLIDAY', NULL, 'Denied');
        RAISE_APPLICATION_ERROR(-20002, 'Operation not allowed on public holidays.');
    END IF;

    -- Log allowed actions (INSERT, UPDATE, DELETE)
    INSERT INTO audit_logs(user_id, table_name, operation, record_id, status)
    VALUES (USER, 'children', CASE
                                WHEN INSERTING THEN 'INSERT'
                                WHEN UPDATING THEN 'UPDATE'
                                WHEN DELETING THEN 'DELETE'
                             END,
            CASE
                WHEN INSERTING THEN :NEW.child_id
                WHEN UPDATING THEN :OLD.child_id
                WHEN DELETING THEN :OLD.child_id
            END,
            'Allowed');
EXCEPTION
    WHEN OTHERS THEN
        -- Optional: record failed attempts with error
        INSERT INTO audit_logs(user_id, table_name, operation, record_id, status)
        VALUES (USER, 'children', 'ERROR', NULL, SQLERRM);
        RAISE;
        END;
/

-- This will fail if run on a weekday or holiday
INSERT INTO children (child_id, full_name, date_of_birth, gender, disability_status, section_id)
VALUES (901, 'Blocked Test Child', TO_DATE('2015-01-01', 'YYYY-MM-DD'), 'Female', 'No', 2);


--INSERT INTO children (child_id, full_name, date_of_birth, gender, disability_status, section_id)
--VALUES (902, 'Test Case Trigger', DATE '2013-05-05', 'Male', 'Yes', 1

--INSERT INTO children (
 -- child_id, full_name, date_of_birth, gender, disability_status, section_id
--)
--VALUES (
--  1001, 'Trigger Test Child', TO_DATE('2015-06-15', 'YYYY-MM-DD'), 'Female', 'No', 2
--);

--SELECT * FROM audit_log WHERE record_id = 1001 ORDER BY action_time DESC;

INSERT INTO children(child_id, full_name, date_of_birth, gender, disability_status, section_id)
VALUES (301, 'Marie Uwase', TO_DATE('2014-01-25', 'YYYY-MM-DD'), 'Female', 'Yes', 1);

SELECT * FROM audit_logs WHERE table_name = 'children' ORDER BY action_time DESC;
insert into audit_logs(log_id,table_name,operation,record_id,action_time) values(11,'children'off_day'


