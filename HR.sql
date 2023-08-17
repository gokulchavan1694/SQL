select * from employee;

select  max(salary),dept_name from employee group by dept_name;


select * from
(select e.*,
row_number()over(partition by dept_name order by salary desc) as rn
from employee e)
where rn=1;

select * from
(select e.*,
row_number()over(partition by dept_name order by salary desc) as rn
from employee e)
where rn=2;

select * from
(select e.*,
row_number()over(partition by dept_name order by salary desc) as rn
from employee e)
where rn=3;


select e.*,
row_number()over(partition by dept_name order by salary) as rn,
rank()over(partition by dept_name order by salary ) as rnk,
dense_rank()over(partition by dept_name order by salary) as dens
from employee e;

select e1.* from employee e1
where 1-1=(select count(distinct salary)
            from employee e2
            where e2.salary>e1.salary);
            
            
select salary,emp_name,dept_name from employee e1
where 0=(select count(distinct salary)
            from employee e2
            where e2.salary>e1.salary);    

select * from             
(select e.*,
row_number()over(partition by dept_name order by salary desc) as rn
from employee e)
where rn<4;

select * from (
select e.*,
rank()over(partition by dept_name order by salary desc) as rnk
from employee e)
where rnk<=2 ;

select * from (
select e.*,
dense_rank()over(partition by dept_name order by salary desc) as dnsrnk
from employee e)
where dnsrnk<=2 ;


select * from employee;
select distinct count(*) from employee;

delete from employee
where rowid not in
(select min(rowid) from employee group by emp_id);