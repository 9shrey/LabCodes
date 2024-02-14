drop table book_issue;

create table book_issue(issue_no numeric(3), date_of_issue date, date_of_return date);
insert into book_issue values(1,'20-Jan-2002', '4-Feb-2002');
insert into book_issue values(2,'15-May-2014', '15-Jun-2014');
insert into book_issue values(3,'20-Jan-2002', '4-Feb-2022');
insert into book_issue values(4,'20-Jan-2002', '21-Jan-2002');

set serveroutput on
declare

issueno numeric(3);
days numeric;
fine numeric(15);

begin

issueno := '&Issue_No';
dbms_output.put_line('Input Issue Number is : '||issueno);

select date_of_return - date_of_issue into days
from book_issue
where issue_no = issueno;

if(days between 0 and 7) then
fine := days * 0;
elsif(days between 8 and 15) then
fine := days * 1;
elsif(days between 16 and 29) then
fine := days * 2;
elsif(days>=30) then
fine := days * 5;
end if;


dbms_output.put_line('Fine is :'||fine);

end;
/

-- Enter value for issue_no: 3
-- old   9: issueno := '&Issue_No';
-- new   9: issueno := '3';
-- Input Issue Number is : 3
-- Fine is :36600

-- PL/SQL procedure successfully completed.