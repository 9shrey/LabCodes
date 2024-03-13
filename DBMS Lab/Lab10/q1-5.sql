/* 1. Based on the University database Schema in Lab 2, write a row trigger that records along with the time any 
change made in the Takes (ID, course-id, sec-id, semester, year, grade) table 
in log_change_Takes (Time_of_Change, ID, courseid,sec-id, semester, year, grade). */

create table log_change_Takes(
    Time_of_Change DATE,
    ID VARCHAR(5),
    course_id VARCHAR(8),
    sec_id VARCHAR(8),
    semester VARCHAR(6),
    year NUMERIC(4,0),
    grade VARCHAR(2),
    PRIMARY KEY (ID, course_id, sec_id, semester, year));

set serveroutput on
create or replace trigger logTakes
before insert or update of ID, course_id, sec_id, semester, year, grade or delete ON takes
for each row
begin
case
when inserting then
    insert into log_change_Takes 
    VALUES(SYSDATE,:NEW.ID, :NEW.course_id, :NEW.sec_id, :NEW.semester, :NEW.year, :NEW.grade);
when updating or deleting then
    insert into log_change_Takes 
    VALUES(SYSDATE,:OLD.ID, :OLD.course_id, :OLD.sec_id, :OLD.semester, :OLD.year, :OLD.grade);
end case;
end;
/

COMMIT; 
select * from takes where ID = 12345 and sec_id = 2; 
update takes SET sec_id = 1 where ID = 12345 and sec_id = 2; 
delete from takes where ID = 12345 and course_id = 'CS-190' 
select * from takes where ID = 12345 and sec_id = 2; 
select * from log_change_Takes; 
ROLLBACK; 

/* 2. Based on the University database schema in Lab: 2, write a row trigger to insert the existing values of the Instructor 
(ID, name, dept-name, salary) table into a new table Old_ Data_Instructor (ID, name, dept-name, salary) when the salary table is updated. */

create table Old_Data_Instructor (
    ID VARCHAR(5),
    name VARCHAR(20),
    dept_name VARCHAR(20),
    salary NUMERIC(8,2),
    PRIMARY KEY (ID));

create or replace trigger logSalary
before update of salary ON instructor
for each row
begin
insert into Old_Data_Instructor VALUES (:OLD.ID, :OLD.name, :OLD.dept_name, :OLD.salary);
end;
/

COMMIT; 
select * from instructor where ID = 12121; 
update instructor SET salary = salary * 1.5 where ID = 12121; 
select * from instructor where ID = 12121; 
select * from Old_Data_Instructor; 
ROLLBACK; 

/* 3. Based on the University Schema, write a database trigger on Instructor that checks the following:
i. The name of the instructor is a valid name containing only alphabets.
ii. The salary of an instructor is not zero and is positive
iii. The salary does not exceed the budget of the department to which the instructor belongs. */

create or replace trigger instrinsert
before insert ON instructor
for each row
DECLARE
sal NUMBER;
budg NUMBER;
begin
IF LENGTH(TRIM(TRANSLATE(:NEW.name, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ' '))) > 0 then
    RAISE_APPLICATION_ERRor(-20100,'Name must contain only alphabets');
ELSE
    IF :NEW.salary < 1 then
        RAISE_APPLICATION_ERRor(-20100,'Salary must be greater than 0');
    ELSE
        select SUM(salary) into sal from instructor where dept_name = :NEW.dept_name;
        select budget into budg from department where dept_name = :NEW.dept_name;
        IF sal + :NEW.salary > budg then
            RAISE_APPLICATION_ERRor(-20100,'Not enough department budget');  
        end IF;
    end IF;
end IF;
end;
/

COMMIT; 
select * from instructor; 
insert into instructor VALUES('12345','NewInstructor','Comp. Sci.',50000);
insert into instructor VALUES('12345','NewInstructor12','Music',20000);
insert into instructor VALUES('12345','NewInstructor','Music',30000);
select * from instructor; 
ROLLBACK; 

/* 4. create a transparent audit system for a table Client_master (client_no, name, address, Bal_due). 
The system must keep track of the records that are being deleted or updated. 
The functionality being when a record is deleted or modified the original record details and the date 
of operation are stored in the auditclient (client_no, name, bal_due, operation, userid, opdate) table, 
then the delete or update is allowed to go through. */

create table Client_master (
    client_no NUMBER,
    name VARCHAR(20),
    address VARCHAR(50),
    bal_due NUMBER,
    PRIMARY KEY (client_no));

insert into Client_master VALUES (1,'Client1','Addr1',20000);
insert into Client_master VALUES (2,'Client2','Addr2',10000);
insert into Client_master VALUES (3,'Client3','Addr3',50000);
insert into Client_master VALUES (4,'Client4','Addr4',80000);

create table auditclient (
    client_no NUMBER,
    name VARCHAR(20),
    bal_due NUMBER,
    operation VARCHAR(20),
    userid NUMBER,
    opdate DATE);

create or replace trigger auditLog
before update of bal_due or delete ON Client_master
for each row
begin
case
when updating then
    insert into auditClient VALUES (:OLD.client_no, :OLD.name, :OLD.bal_due, 'update', 1440, SYSDATE);
when deleting then 
    insert into auditClient VALUES (:OLD.client_no, :OLD.name, :OLD.bal_due, 'delete', 1440, SYSDATE);
end case;
end;
/


COMMIT; 
select * from Client_master; 
update Client_master SET bal_due = 10000 where client_no = 1;
delete from Client_master where client_no = 2;
select * from auditClient; 
ROLLBACK; 

/* 5. Based on the University database Schema in Lab 2, create a view Advisor_Student which is a natural join on Advisor, Student and Instructor tables. 
create an INSTEAD of trigger on Advisor_Student to enable the user to delete the corresponding entries in Advisor table. */

 
