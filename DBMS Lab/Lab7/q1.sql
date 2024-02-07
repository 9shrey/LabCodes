create table StudentTable(RollNo numeric(3), GPA numeric(3,2), primary key(RollNo));

insert into StudentTable values(1,5.8);
insert into StudentTable values(2,6.5);
insert into StudentTable values(3,3.4);
insert into StudentTable values(4,7.8);
insert into StudentTable values(5,9.5);

set serveroutput on
declare

stu_gpa numeric(3,2);
stu_rollno numeric(3);

begin

stu_rollno := '&Roll_Number';
dbms_output.put_line('Input Roll Number is : '||stu_rollno);

select GPA into stu_gpa
from StudentTable
where RollNo = stu_rollno;

dbms_output.put_line('GPA is :'||stu_gpa);

end;
/