set serveroutput on
declare
    cursor c is select * from teaches;
    n number;
    iname instructor.name%TYPE;
    cursor c2 is select * from course;
    courseRow course%ROWTYPE;
    cursor c3 is select * from section;
    sectionRow section%ROWTYPE;
begin
    for i in c
    loop
        begin
            select count(*) into n from takes group by course_id, sec_id, semester, year 
            having course_id = I.course_id and sec_id = I.sec_id and semester = I.semester and year = I.year;
            exception
                when no_data_found then n := 0;
            end;
            select name into iname from instructor where id = i.id;

            for courseRec in c2 loop
                if courseRec.course_id = i.course_id then
                    courseRow := courseRec;
                    exit; 
                end if;
            end loop;

            for sectionRec in c3 loop
                if sectionRec.course_id = i.course_id and sectionRec.sec_id = i.sec_id 
                    and sectionRec.semester = i.semester and sectionRec.year = i.year then
                    sectionRow := sectionRec;
                    exit; 
                end if;
            end loop;

            DBMS_OUTPUT.PUT_LINE('Course ID: ' || I.course_id || ' Title: ' || courseRow.title || ' Dept name: ' || courseRow.dept_name || ' Credits: ' || courseRow.credits || 
        ' Instructor name: ' || iname || ' Building: ' || sectionRow.building || ' Room number: ' || sectionRow.room_number || ' Time slot id: ' || sectionRow.time_slot_id || ' Total students enrolled: ' || n);
    end loop;
end;
/
