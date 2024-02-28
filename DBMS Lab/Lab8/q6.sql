declare
cursor curs(cid teaches.course_id%TYPE) is select * from instructor natural join teaches where course_id=cid;

begin
for temp in curs('CS-101')
loop
    dbms_output.put_line('Instructor ID:'||temp.id);
    dbms_output.put_line('Instructor Name:'||temp.name);
    dbms_output.put_line('---------------------------');
end loop;
end;
/

-- OUTPUT
-- Instructor ID:10101
-- Instructor Name:Srinivasan
-- ---------------------------
-- Instructor ID:45565
-- Instructor Name:Katz
-- ---------------------------

-- PL/SQL procedure successfully completed.

