declare
	cursor c is select * from student order by tot_cred;
	stud_name student.name%type;
	stud_id student.id%type;
	stud_dept_name student.dept_name%type;
	stud_cred student.tot_cred%type;
begin
	open c;
	loop
   	exit when (c%rowcount > 9) OR (c%notfound);
   	fetch c into stud_id, stud_name, stud_dept_name, stud_cred;
   	dbms_output.put_line(stud_id || ' ' || stud_name || ' ' || stud_dept_name
   	|| ' ' || stud_cred);
   	end loop;
   	close c;
end;
/

-- OUTPUT
-- 70557 Snow Physics 0
-- 12345 Shankar Comp. Sci. 32
-- 55739 Sanchez Music 38
-- 45678 Levy Physics 46
-- 54321 Williams Comp. Sci. 54
-- 44553 Peltier Physics 56
-- 76543 Brown Comp. Sci. 58
-- 76653 Aoi Elec. Eng. 60
-- 19991 Brandt History 80
-- 98765 Bourikas Elec. Eng. 98

-- PL/SQL procedure successfully completed.
