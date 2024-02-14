set serveroutput on
declare

same_name Exception;
no_name Exception;
inst_name varchar(20);
counter_var numeric(3);

begin
inst_name := '&Instructor_Name';
dbms_output.put_line('Entered Instructors Name : '|| inst_name);

select count(Name) into counter_var
from instructor
where Name = inst_name;

if counter_var>1 then
raise same_name;
elsif counter_var=0 then
raise no_name;
elsif counter_var=1 then 
dbms_output.put_line('Appears only once');
end if;

Exception
when same_name then
dbms_output.put_line('Appears multiple times');
when no_name then
dbms_output.put_line('Does not Appear');

end;
/

--OUTPUT:

-- Enter value for instructor_name: Ga
-- old   9: inst_name := '&Instructor_Name';
-- new   9: inst_name := 'Ga';
-- Entered Instructors Name : Ga
-- Does not Appear

-- PL/SQL procedure successfully completed.