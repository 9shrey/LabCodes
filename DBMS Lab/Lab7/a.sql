//create table book(ISSN numeric(5) not null, title varchar(20), Published date, subject varchar(20));



set serveroutput on 

declare 

bk_count number;
bk_subject varchar(50);

begin

bk_subject := '&Subject';
dbms_output.put_line('Input Subject is : '||bk_subject);

select count(*) into bk_count
from book
where subject = bk_subject;

dbms_output.put_line('Number of books is :'||bk_count);

end;
/
