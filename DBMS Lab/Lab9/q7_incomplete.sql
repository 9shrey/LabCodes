--7
--a

create or replace package body seven as
procedure listInst (deptName Instructor.dept_name%type) is
cursor curseInst (deptName Instructor.dept_name%type) is
select name from Instructor WHERE dept_name = deptName;
begin
    dbms_output.put_line('-- Instructors --');
    for row in curseInst (deptName)
    loop
        dbms_output.put_line(' '||row.name);
    end loop;
end;
/

--b

create or replace package body seven as
function maxsal (deptName Instructor.dept_name%type) is
cursor curseInst (deptName Instructor.dept_name%type) is
select max(salary) from Instructor WHERE dept_name = deptName;
begin
    dbms_output.put_line('--Max Salary --');
    for row in curseInst (deptName)
    loop
        dbms_output.put_line(' '||row.name);
    end loop;
end;
/

--c

declare
begin
dbms_output.put_line('Instr Names of dep:' ||seven.listInst('Physics') || 'Max Salary is:'|| seven.
