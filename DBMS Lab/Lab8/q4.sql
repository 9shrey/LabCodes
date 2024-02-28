declare
cursor curs is select * from Student natural join takes where course_id='CS-101' ;

begin
	for stud in curs
    loop
    if stud.tot_cred < 30 then
      delete from takes where id=stud.id and course_id='CS-101';
    end if;
    end loop;
end;
/

-- OUTPUT

-- PL/SQL procedure successfully completed.

