set serveroutput on
declare

stu_gpa numeric(3,2);
stu_rollno numeric(3);
stu_lettergrade varchar(3);

begin

stu_rollno := '&Roll_Number';
dbms_output.put_line('Input Roll Number is : '||stu_rollno);

select GPA into stu_gpa
from StudentTable
where RollNo = stu_rollno;

if(stu_gpa between 0 and 4) then
stu_lettergrade := 'F';
elsif(stu_gpa between 4 and 5) then
stu_lettergrade := 'E';
elsif(stu_gpa between 5 and 6) then
stu_lettergrade := 'D';
elsif(stu_gpa between 6 and 7) then
stu_lettergrade := 'C';
elsif(stu_gpa between 7 and 8) then
stu_lettergrade := 'B';
elsif(stu_gpa between 8 and 9) then
stu_lettergrade := 'A';
elsif(stu_gpa between 9 and 10) then
stu_lettergrade := 'A+';
end if;


dbms_output.put_line('Letter Grade is :'||stu_lettergrade);

end;
/

-- Enter value for roll_number: 3
-- old   9: stu_rollno := '&Roll_Number';
-- new   9: stu_rollno := '3';
-- Input Roll Number is : 3
-- Letter Grade is :F

-- PL/SQL procedure successfully completed.
