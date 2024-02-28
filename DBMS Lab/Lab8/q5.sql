declare
cursor curs is select * from StudentTable for update;
begin
    for stud in curs
    loop
    if stud.gpa between 0 and 4 then
        update StudentTable set LetterGrade='F' where current of curs;
    elsif stud.gpa between 4 and 5 then
        update StudentTable set LetterGrade='E' where current of curs;
    elsif stud.gpa between 5 and 6 then
        update StudentTable set LetterGrade='D' where current of curs;
    elsif stud.gpa between 6 and 7 then
        update StudentTable set LetterGrade='C' where current of curs;
    elsif stud.gpa between 7 and 8 then
        update StudentTable set LetterGrade='B' where current of curs;
    elsif stud.gpa between 8 and 9 then
        update StudentTable set LetterGrade='A' where current of curs;
    else
        update StudentTable set LetterGrade='A+' where current of curs;
    end if;
    end loop;
end;
/

-- OUTPUT

-- PL/SQL procedure successfully completed.

