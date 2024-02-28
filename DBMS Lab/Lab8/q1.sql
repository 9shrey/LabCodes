-- salary_raise(Instructor_Id, Raise_date, Raise_amt)
create table salary_raise(Instructor_Id numeric(3), Raise_date date, Raise_amt numeric(10,2));

declare
cursor raise_cursor is
select * from Instructor for update;
raise_amt numeric(8, 2);
begin
    for i in raise_cursor
    loop
		raise_amt := i.salary * 1.05;
		update Instructor
        set salary = salary * 1.05;
		insert into salary_raise values (i.ID, current_date, raise_amt);
	end loop;
end;
/

-- OUTPUT

-- INSTRUCTOR_ID RAISE_DAT  RAISE_AMT                                                               
-- ------------- --------- ----------                                                                       
-- 76766         28-FEB-24      75600