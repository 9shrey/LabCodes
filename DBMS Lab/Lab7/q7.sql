set serveroutput on
declare

stu_gpa numeric(3,2);
stu_rollno numeric(3) := 0;

begin
loop
stu_rollno := stu_rollno + 1;
if stu_rollno > 5 then goto last_statement;
end if;
dbms_output.put_line('Input Roll Number is : '||stu_rollno);

select GPA into stu_gpa
from StudentTable
where RollNo = stu_rollno;

dbms_output.put_line('GPA is :'||stu_gpa);
end loop;
<<last_statement>>
dbms_output.put_line('Loop Exited');
end;
/


--OUTPUT:

--Input Roll Number is : 1
--GPA is :5.8
--Input Roll Number is : 2
--GPA is :6.5
--Input Roll Number is : 3
--GPA is :3.4
--Input Roll Number is : 4
--GPA is :7.8
--Input Roll Number is : 5
--GPA is :9.5

--PL/SQL procedure successfully completed.