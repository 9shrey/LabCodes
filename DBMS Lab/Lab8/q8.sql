declare
assigned_money department.budget%TYPE;
budget department.budget%TYPE;
begin
    Savepoint no_raise;
    update instructor set salary = 1.2*salary where dept_name='Biology';
    select sum(salary) into assigned_money from instructor where dept_name='Biology';
    select budget into budget from department where dept_name='Biology';
    if(assigned_money > budget) then
        Rollback to Savepoint no_raise;
    end if;
    commit;
end;
/

-- OUTPUT

-- PL/SQL procedure successfully completed.
