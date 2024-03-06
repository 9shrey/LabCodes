
--TUTORIAL

set serveroutput on
create or replace
procedure display_hello(nam varchar) is
pl_name varchar(20);
begin
pl_name :=nam;
dbms_output.put_line('Hello '||pl_name);
end;
/

set serveroutput on
declare
begin
display_hello('&name');
end;
/


create or replace
function count_book(bk_subject varchar)
return number as
bk_count number;

begin
select count(*) into bk_count
from book
where subject = bk_subject;
return bk_count;

end;
/
begin
dbms_output.put_line('No of books is' || count_book('&Subject')
end;
/

show errors;

--Lab Questions
--1

set serveroutput on
create or replace
procedure display_gdty() is
begin
dbms_output.put_line('Good Day to You');
end;
/

set serveroutput on
declare
begin
display_gdty();
end;
/

--2

set serveroutput on
create or replace
procedure listInst (deptName Instructor.dept_name%type) is
cursor curseInst (deptName Instructor.dept_name%type) is
select name from Instructor WHERE dept_name = deptName;
cursor curseCourses (deptName Instructor.dept_name%type) is
select course_id from Course WHERE dept_name = deptName;
begin
    dbms_output.put_line('...........................');
    dbms_output.put_line('-- Instructors --');
    for row in curseInst (deptName)
    loop
        dbms_output.put_line(' '||row.name);
    end loop;
    dbms_output.put_line('...........................');
    dbms_output.put_line('-- Courses --');
    for row in curseCourses (deptName) 
    loop
        dbms_output.put_line(' ' || row.course_id);
    end loop;
end;
/

declare
begin
listInst('Physics');
end;
/

--3

set serveroutput on
create or replace procedure course_popular IS
cursor curs is
with studentenroll as (select course_id,count(distinct ID) as student_count from takes group by course_id),
studenmod as (select course_id,student_count,dept_name from studentenroll natural join course),
deptmax as (select max(student_count) as dept_high,dept_name from course natural join studenmod group by dept_name)
select dept_high,course_id,dept_name from studenmod natural join deptmax where student_count=dept_high;
begin
    for row in curs loop
        dbms_output.put_line('Department name : '||row.dept_name);
        dbms_output.put_line(' Course ID : ' || row.course_id);
        dbms_output.put_line('Number of student enrolled : '||row.dept_high);
        dbms_output.put_line('---------------------------------------------------');
    end loop;
end;
/

declare
begin
    dbms_output.put_line('----- ALL DEPARTMENTS HIGHEST ENROLLED COURSES ------');
    course_popular;
end;
/

--4

set serveroutput on
create or replace
procedure listInst (deptName student.dept_name%type) is
cursor curseInst (deptName student.dept_name%type) is
select name from student WHERE dept_name = deptName;
cursor curseCourses (deptName student.dept_name%type) is
select course_id from Course WHERE dept_name = deptName;
begin
    dbms_output.put_line('...........................');
    dbms_output.put_line('-- Students --');
    for row in curseInst (deptName)
    loop
        dbms_output.put_line(' '||row.name);
    end loop;
    dbms_output.put_line('...........................');
    dbms_output.put_line('-- Courses --');
    for row in curseCourses (deptName) 
    loop
        dbms_output.put_line(' ' || row.course_id);
    end loop;
end;
/

declare
begin
listInst('Physics');
end;
/

--5

set serveroutput on
create or replace function square (x number)
return number as s number;
begin
    s := x * x;
    return s;
end;
/

declare
begin
    dbms_output.put_line('5 ^ 2 = '||square(5));
end;
/

--6

create or replace
function department_highest (dName Department.dept_name%type)
return Instructor.salary%type as sal Instructor.salary%type;
begin
    select max(salary) into sal
    from Instructor group by Instructor.dept_name having Instructor.dept_name in 
	(select dept_name 
	 from Instructor 
 	 where dept_name = dName);
    return sal;
end;
/

declare
    maxs Instructor.salary%type;
    cursor c1 is select distinct dept_name from department;
begin
    for dn in c1 loop
        maxs := department_highest(dn.dept_name);
        dbms_output.put_line('Highest paid salary in '||dn.dept_name||' is : ' || maxs);
    end loop;
end;
/
