declare
    cursor c is with 
    stud as (select * from (student natural join takes natural join section)),
    ins as (select * from (instructor natural join teaches natural join section))
    select course_id,title,ins.dept_name,credits,ins.name,ins.building,ins.room_number,ins.time_slot_id,count(*)
    as no_of_students from stud inner join ins using(course_id,sec_id,semester,year) natural join course
    group by (course_id,title,ins.dept_name,credits,ins.name,ins.building,ins.room_number,ins.time_slot_id);
begin
    for tuple in c
        loop
            dbms_output.put_line('Course ID : '|| tuple.course_id);
            dbms_output.put_line('Title : '|| tuple.title);
            dbms_output.put_line('Department : '|| tuple.dept_name);
            dbms_output.put_line('Credits : '|| tuple.credits);
            dbms_output.put_line('Instructor Name : '|| tuple.name);
            dbms_output.put_line('Building : '|| tuple.building);
            dbms_output.put_line('Room Number : '|| tuple.room_number);
            dbms_output.put_line('Time Slot ID : '|| tuple.time_slot_id);
            dbms_output.put_line('Total Students : '|| tuple.no_of_students);
        end loop;
end;
/

-- OUTPUT
-- Course ID : HIS-351
-- Title : World History
-- Department : History
-- Credits : 3
-- Instructor Name : El Said
-- Building : Painter
-- Room Number : 514
-- Time Slot ID : C
-- Total Students : 1
-- PL/SQL procedure successfully completed.
