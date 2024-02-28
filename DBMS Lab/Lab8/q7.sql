declare
    cursor curs_1(a_id advisor.i_id%type,c_id takes.course_id%type) is
    select * from ((student s natural join takes t) inner join advisor a
    on (id=a.s_id)) where course_id = c_id and a_id=i_id;
    cursor curs_2 is select * from (instructor natural join teaches);
begin
    for ins_info in curs_2
        loop
            for info in curs_1(ins_info.id,ins_info.course_id)
                loop
                    dbms_output.put_line(info.name);
                end loop;
        end loop;
end;
/

-- OUTPUT
-- Shankar
-- Shankar
-- Shankar
-- Peltier
-- Zhang
-- Brown
-- Brown
-- Tanaka
-- Tanaka
-- Aoi

-- PL/SQL procedure successfully completed.
