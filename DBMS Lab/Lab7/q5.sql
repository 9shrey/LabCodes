alter table StudentTable add LetterGrade varchar(2);


set serveroutput on
declare

stu_gpa numeric(3,2);
stu_rollno numeric(3) := 0;
lettergrade varchar(2) := 'N';

begin
while stu_rollno < 5
loop
stu_rollno := stu_rollno + 1;
dbms_output.put_line('Input Roll Number is : '||stu_rollno);

select GPA into stu_gpa
from StudentTable
where RollNo = stu_rollno;

if(stu_gpa between 0 and 4) then
lettergrade := 'F';
elsif(stu_gpa between 4 and 5) then
lettergrade := 'E';
elsif(stu_gpa between 5 and 6) then
lettergrade := 'D';
elsif(stu_gpa between 6 and 7) then
lettergrade := 'C';
elsif(stu_gpa between 7 and 8) then
lettergrade := 'B';
elsif(stu_gpa between 8 and 9) then
lettergrade := 'A';
elsif(stu_gpa between 9 and 10) then
lettergrade := 'A+';
end if;

update StudentTable
set LetterGrade = lettergrade
where RollNo = stu_rollno;

dbms_output.put_line('GPA is :'||stu_gpa);
dbms_output.put_line('LetterGrade is :'||lettergrade);

end loop;
end;
/

--OUTPUT:

-- Input Roll Number is : 1
-- GPA is :5.8
-- LetterGrade is :D
-- Input Roll Number is : 2
-- GPA is :6.5
-- LetterGrade is :C
-- Input Roll Number is : 3
-- GPA is :3.4
-- LetterGrade is :F
-- Input Roll Number is : 4
-- GPA is :7.8
-- LetterGrade is :B
-- Input Roll Number is : 5
-- GPA is :9.5
-- LetterGrade is :A+

-- PL/SQL procedure successfully completed.