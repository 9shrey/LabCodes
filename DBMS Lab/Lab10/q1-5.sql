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


--OUTPUT--

SQL> create table log_change_Takes(
  2      Time_of_Change DATE,
  3      ID VARCHAR(5),
  4      course_id VARCHAR(8),
  5      sec_id VARCHAR(8),
  6      semester VARCHAR(6),
  7      year NUMERIC(4,0),
  8      grade VARCHAR(2),
  9      PRIMARY KEY (ID, course_id, sec_id, semester, year));
create table log_change_Takes(
             *
ERROR at line 1:
ORA-00955: name is already used by an existing object


SQL>
SQL> set serveroutput on
SQL> create or replace trigger logTakes
  2  before insert or update of ID, course_id, sec_id, semester, year, grade or delete ON takes
  3  for each row
  4  begin
  5  case
  6  when inserting then
  7      insert into log_change_Takes
  8      VALUES(SYSDATE,:NEW.ID, :NEW.course_id, :NEW.sec_id, :NEW.semester, :NEW.year, :NEW.grade);
  9  when updating or deleting then
 10      insert into log_change_Takes
 11      VALUES(SYSDATE,:OLD.ID, :OLD.course_id, :OLD.sec_id, :OLD.semester, :OLD.year, :OLD.grade);
 12  end case;
 13  end;
 14  /

Trigger created.

SQL>
SQL> COMMIT;

Commit complete.

SQL> select * from takes where ID = 12345 and sec_id = 2;

ID    COURSE_I SEC_ID   SEMEST       YEAR GR
----- -------- -------- ------ ---------- --
12345 CS-190   2        Spring       2009 A

SQL> update takes SET sec_id = 1 where ID = 12345 and sec_id = 2;

1 row updated.

SQL> delete from takes where ID = 12345 and course_id = 'CS-190'
  2  select * from takes where ID = 12345 and sec_id = 2;
select * from takes where ID = 12345 and sec_id = 2
*
ERROR at line 2:
ORA-00933: SQL command not properly ended


SQL> select * from log_change_Takes;

TIME_OF_C ID    COURSE_I SEC_ID   SEMEST       YEAR GR
--------- ----- -------- -------- ------ ---------- --
13-MAR-24 12345 CS-190   2        Spring       2009 A

SQL> ROLLBACK;

Rollback complete.


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

--OUTPUT--

SQL> create table Old_Data_Instructor (
  2      ID VARCHAR(5),
  3      name VARCHAR(20),
  4      dept_name VARCHAR(20),
  5      salary NUMERIC(8,2),
  6      PRIMARY KEY (ID));
create table Old_Data_Instructor (
             *
ERROR at line 1:
ORA-00955: name is already used by an existing object


SQL>
SQL> create or replace trigger logSalary
  2  before update of salary ON instructor
  3  for each row
  4  begin
  5  insert into Old_Data_Instructor VALUES (:OLD.ID, :OLD.name, :OLD.dept_name, :OLD.salary);
  6  end;
  7  /

Trigger created.

SQL>
SQL> COMMIT;

Commit complete.

SQL> select * from instructor where ID = 12121;

ID    NAME                 DEPT_NAME                SALARY
----- -------------------- -------------------- ----------
12121 Wu                   Finance                   90000

SQL> update instructor SET salary = salary * 1.5 where ID = 12121;

1 row updated.

SQL> select * from instructor where ID = 12121;

ID    NAME                 DEPT_NAME                SALARY
----- -------------------- -------------------- ----------
12121 Wu                   Finance                  135000

SQL> select * from Old_Data_Instructor;

ID    NAME                 DEPT_NAME                SALARY
----- -------------------- -------------------- ----------
12121 Wu                   Finance                   90000

SQL> ROLLBACK;

Rollback complete.

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

--OUTPUT--

SQL> create or replace trigger instrinsert
  2  before insert ON instructor
  3  for each row
  4  DECLARE
  5  sal NUMBER;
  6  budg NUMBER;
  7  begin
  8  IF LENGTH(TRIM(TRANSLATE(:NEW.name, 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', ' '))) > 0 then
  9      RAISE_APPLICATION_ERRor(-20100,'Name must contain only alphabets');
 10  ELSE
 11      IF :NEW.salary < 1 then
 12          RAISE_APPLICATION_ERRor(-20100,'Salary must be greater than 0');
 13      ELSE
 14          select SUM(salary) into sal from instructor where dept_name = :NEW.dept_name;
 15          select budget into budg from department where dept_name = :NEW.dept_name;
 16          IF sal + :NEW.salary > budg then
 17              RAISE_APPLICATION_ERRor(-20100,'Not enough department budget');
 18          end IF;
 19      end IF;
 20  end IF;
 21  end;
 22  /

Trigger created.

SQL>
SQL> COMMIT;

Commit complete.

SQL> select * from instructor;

ID    NAME                 DEPT_NAME                SALARY
----- -------------------- -------------------- ----------
10101 Srinivasan           Comp. Sci.                65000
12121 Wu                   Finance                   90000
15151 Mozart               Music                     40000
22222 Einstein             Physics                   95000
32343 El Said              History                   60000
33456 Gold                 Physics                   87000
45565 Katz                 Comp. Sci.                75000
58583 Califieri            History                   62000
76543 Singh                Finance                   80000
76766 Crick                Biology                   72000
83821 Brandt               Comp. Sci.                92000

ID    NAME                 DEPT_NAME                SALARY
----- -------------------- -------------------- ----------
98345 Kim                  Elec. Eng.                80000

12 rows selected.

SQL> insert into instructor VALUES('12345','NewInstructor','Comp. Sci.',50000);
insert into instructor VALUES('12345','NewInstructor','Comp. Sci.',50000)
            *
ERROR at line 1:
ORA-20100: Not enough department budget
ORA-06512: at "A45.INSTRINSERT", line 14
ORA-04088: error during execution of trigger 'A45.INSTRINSERT'


SQL> insert into instructor VALUES('12345','NewInstructor12','Music',20000);
insert into instructor VALUES('12345','NewInstructor12','Music',20000)
            *
ERROR at line 1:
ORA-20100: Name must contain only alphabets
ORA-06512: at "A45.INSTRINSERT", line 6
ORA-04088: error during execution of trigger 'A45.INSTRINSERT'


SQL> insert into instructor VALUES('12345','NewInstructor','Music',30000);

1 row created.

SQL> select * from instructor;

ID    NAME                 DEPT_NAME                SALARY
----- -------------------- -------------------- ----------
10101 Srinivasan           Comp. Sci.                65000
12121 Wu                   Finance                   90000
15151 Mozart               Music                     40000
22222 Einstein             Physics                   95000
32343 El Said              History                   60000
33456 Gold                 Physics                   87000
45565 Katz                 Comp. Sci.                75000
58583 Califieri            History                   62000
76543 Singh                Finance                   80000
76766 Crick                Biology                   72000
83821 Brandt               Comp. Sci.                92000

ID    NAME                 DEPT_NAME                SALARY
----- -------------------- -------------------- ----------
98345 Kim                  Elec. Eng.                80000
12345 NewInstructor        Music                     30000

13 rows selected.

SQL> ROLLBACK;

Rollback complete.


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

--OUTPUT--

SQL> create table Client_master (
  2      client_no NUMBER,
  3      name VARCHAR(20),
  4      address VARCHAR(50),
  5      bal_due NUMBER,
  6      PRIMARY KEY (client_no));
create table Client_master (
             *
ERROR at line 1:
ORA-00955: name is already used by an existing object


SQL>
SQL> insert into Client_master VALUES (1,'Client1','Addr1',20000);
insert into Client_master VALUES (1,'Client1','Addr1',20000)
*
ERROR at line 1:
ORA-00001: unique constraint (A45.SYS_C0071699) violated


SQL> insert into Client_master VALUES (2,'Client2','Addr2',10000);
insert into Client_master VALUES (2,'Client2','Addr2',10000)
*
ERROR at line 1:
ORA-00001: unique constraint (A45.SYS_C0071699) violated


SQL> insert into Client_master VALUES (3,'Client3','Addr3',50000);
insert into Client_master VALUES (3,'Client3','Addr3',50000)
*
ERROR at line 1:
ORA-00001: unique constraint (A45.SYS_C0071699) violated


SQL> insert into Client_master VALUES (4,'Client4','Addr4',80000);
insert into Client_master VALUES (4,'Client4','Addr4',80000)
*
ERROR at line 1:
ORA-00001: unique constraint (A45.SYS_C0071699) violated


SQL>
SQL> create table auditclient (
  2      client_no NUMBER,
  3      name VARCHAR(20),
  4      bal_due NUMBER,
  5      operation VARCHAR(20),
  6      userid NUMBER,
  7      opdate DATE);
create table auditclient (
             *
ERROR at line 1:
ORA-00955: name is already used by an existing object


SQL>
SQL> create or replace trigger auditLog
  2  before update of bal_due or delete ON Client_master
  3  for each row
  4  begin
  5  case
  6  when updating then
  7      insert into auditClient VALUES (:OLD.client_no, :OLD.name, :OLD.bal_due, 'update', 1440, SYSDATE);
  8  when deleting then
  9      insert into auditClient VALUES (:OLD.client_no, :OLD.name, :OLD.bal_due, 'delete', 1440, SYSDATE);
 10  end case;
 11  end;
 12  /

Trigger created.

SQL>
SQL>
SQL> COMMIT;

Commit complete.

SQL> select * from Client_master;

 CLIENT_NO NAME
---------- --------------------
ADDRESS                                               BAL_DUE
-------------------------------------------------- ----------
         1 Client1
Addr1                                                   20000

         2 Client2
Addr2                                                   10000

         3 Client3
Addr3                                                   50000


 CLIENT_NO NAME
---------- --------------------
ADDRESS                                               BAL_DUE
-------------------------------------------------- ----------
         4 Client4
Addr4                                                   80000


SQL> update Client_master SET bal_due = 10000 where client_no = 1;

1 row updated.

SQL> delete from Client_master where client_no = 2;

1 row deleted.

SQL> select * from auditClient;

 CLIENT_NO NAME                    BAL_DUE OPERATION                USERID
---------- -------------------- ---------- -------------------- ----------
OPDATE
---------
         1 Client1                   20000 update                     1440
13-MAR-24

         2 Client2                   10000 delete                     1440
13-MAR-24


SQL> ROLLBACK;

Rollback complete.

/* 5. Based on the University database Schema in Lab 2, create a view Advisor_Student which is a natural join on Advisor, Student and Instructor tables. 
create an INSTEAD of trigger on Advisor_Student to enable the user to delete the corresponding entries in Advisor table. */

 DROP VIEW Advisor_Student;

CREATE VIEW Advisor_Student AS 
SELECT Advisor.S_ID, Advisor.I_ID, Student.name S_NAME, Instructor.name I_NAME
FROM Advisor, Student, Instructor WHERE Advisor.S_ID = Student.ID AND Advisor.I_ID = Instructor.ID;

CREATE OR REPLACE TRIGGER delAdvisor
INSTEAD OF DELETE ON Advisor_Student
BEGIN 
    DELETE FROM Advisor WHERE S_ID = :OLD.S_ID AND I_ID = :OLD.I_ID;
END;
/

COMMIT; 
--To have a save to rollback to
SELECT * FROM Advisor; 
SELECT * FROM Advisor_Student; 
--View old
DELETE FROM Advisor_Student WHERE S_ID = 98765 AND I_ID = 98345;
--Delete
SELECT * FROM Advisor; 
--View new
ROLLBACK; 
--Rollback to original data


--OUTPUT--


SQL>  DROP VIEW Advisor_Student;

View dropped.

SQL>
SQL> CREATE VIEW Advisor_Student AS
  2  SELECT Advisor.S_ID, Advisor.I_ID, Student.name S_NAME, Instructor.name I_NAME
  3  FROM Advisor, Student, Instructor WHERE Advisor.S_ID = Student.ID AND Advisor.I_ID = Instructor.ID;

View created.

SQL>
SQL> CREATE OR REPLACE TRIGGER delAdvisor
  2  INSTEAD OF DELETE ON Advisor_Student
  3  BEGIN
  4      DELETE FROM Advisor WHERE S_ID = :OLD.S_ID AND I_ID = :OLD.I_ID;
  5  END;
  6  /

Trigger created.

SQL>
SQL> COMMIT;

Commit complete.

SQL> --To have a save to rollback to
SQL> SELECT * FROM Advisor;

S_ID  I_ID
----- -----
00128 45565
12345 10101
23121 76543
44553 22222
45678 22222
76543 45565
76653 98345
98765 98345
98988 76766

9 rows selected.

SQL> SELECT * FROM Advisor_Student;

S_ID  I_ID  S_NAME               I_NAME
----- ----- -------------------- --------------------
00128 45565 Zhang                Katz
12345 10101 Shankar              Srinivasan
23121 76543 Chavez               Singh
44553 22222 Peltier              Einstein
45678 22222 Levy                 Einstein
76543 45565 Brown                Katz
76653 98345 Aoi                  Kim
98765 98345 Bourikas             Kim
98988 76766 Tanaka               Crick

9 rows selected.

SQL> --View old
SQL> DELETE FROM Advisor_Student WHERE S_ID = 98765 AND I_ID = 98345;

1 row deleted.

SQL> --Delete
SQL> SELECT * FROM Advisor;

S_ID  I_ID
----- -----
00128 45565
12345 10101
23121 76543
44553 22222
45678 22222
76543 45565
76653 98345
98988 76766

8 rows selected.

SQL> --View new
SQL> ROLLBACK;

Rollback complete.

SQL> --Rollback to original data
