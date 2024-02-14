set serveroutput on
declare

stu_gpa numeric(3,2);
stu_rollno numeric(3) := 0;
max_gpa numeric(3,2) := 0;

begin
for i in 1..5 loop
dbms_output.put_line('Input Roll Number is : '||i);

select GPA into stu_gpa
from StudentTable
where RollNo = i;

if stu_gpa > max_gpa then
max_gpa := stu_gpa;
end if;

end loop;
dbms_output.put_line('Max GPA is :'||max_gpa);
end;
/

--OUTPUT:

-- Input Roll Number is : 1
-- Input Roll Number is : 2
-- Input Roll Number is : 3
-- Input Roll Number is : 4
-- Input Roll Number is : 5
-- Max GPA is :9.5

-- PL/SQL procedure successfully completed.