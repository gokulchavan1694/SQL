show tables;
select count(*) from EMPLOYEES;
select * from employee;
---using row number
select emp_name,dept_name,salary from
(select e.*,
row_number()over(partition by dept_name order by salary desc) as max_salary_rank
from employee e)
where max_salary_rank=1;

select emp_name,dept_name,salary from
(select e.*,
row_number()over(partition by dept_name order by salary asc) as max_salary_rank
from employee e)
where max_salary_rank=1;

---using dense rank

select emp_name,dept_name,salary from
(select e.*,
dense_rank()over(partition by dept_name order by salary desc) as max_salary_rank
from employee e)
where max_salary_rank=1 and dept_name='HR' or
      max_salary_rank=1 and dept_name='IT' or
     max_salary_rank=1 and dept_name='Admin' or
     max_salary_rank=1 and dept_name='Finance';
     
     
select emp_name,dept_name,salary from 
(SELECT emp_name,dept_name,salary,
ROW_NUMBER () OVER(PARTITION BY dept_name order by salary desc ) as ro_num
from employee)
where ro_num=1;

select emp_name,dept_name,salary,
DENSE_RANK () OVER(PARTITION BY dept_name order by salary) as dr
from employee;

select emp_name,dept_name,salary from (
select emp_name,dept_name,salary,
DENSE_RANK () OVER(PARTITION BY dept_name order by salary desc) as dr
from employee)
where dr=1 and dept_name='HR' or dr=1 and dept_name='IT' or dr=1 and dept_name='Admin' or dr=1 and dept_name='Finance';

with cte as
(select dept_name,avg(salary)  as avg_salary from employee group by dept_name order by dept_name asc)
select max(avg_salary) from  cte;

select * from departments;

---nth highest salary
select salary,emp_name,dept_name from employee e1
where 0=(select count(distinct salary)
            from employee e2
            where e2.salary>e1.salary);

---highest salary from each dept

select emp_name,dept_name,salary from
(select e.*, 
row_number()over(partition by dept_name order by salary desc)as rn
from employee e)
where rn=1;

--- hifhes salary in each dept with repetative
select emp_name,dept_name,salary from
(select e.*,
dense_rank()over(partition by dept_name order by salary desc) as dens_rnk
from employee e)
where dens_rnk=1;

---top 3 highest salary from table
select * from (
select e.* ,
row_number()over(partition by dept_name order by salary desc) rn
from employee e)t
where t.rn <=3;

---to dulete duplitcates 
delete from pract_emp
where ROWID not in(
select min(rowid) from pract_emp group by emp_id);

create table pract_emp_bkp as
select distinct * from pract_emp;
drop table pract_emp;
alter table pract_emp_bkp RENAME to pract_emp;
-------
select * from employee;
select count(*) from employee;
select  distinct (dept_name) from employee;
select count( distinct dept_name) from employee;
select count (distinct emp_name),dept_name from employee group by dept_name;
select * from employee where dept_name='IT';
---

delete from employee
where ROWID not in (
select min(rowid) from employee group by emp_id);

---
create table emp_bkp as
select distinct * from employee;

select * from emp_bkp;
drop table employee;
alter table emp_bkp rename to employee;

select * from employee;
-------
select * from employee e1
where 1-1=(
select count(distinct salary)
from employee e2
where e2.salary>e1.salary);

select * from employee e1
where 2-1=(
select count(distinct salary )
from employee e2
where e2.salary>e1.salary); 
-----
select max(salary),dept_name from employee group by dept_name;

select e.*,
max(salary)over(partition by dept_name order by salary desc) as rn
from employee e;

select e.*,
row_number()over(order by salary) as rn
from employee e;

select e.*,
row_number()over(partition by dept_name order by salary) as rn
from employee e;

select * from (
select e.*,
row_number()over(partition by dept_name order by salary desc) as rn
from employee e)
where rn=1;

select * from (
select e.*,
row_number()over(partition by dept_name order by salary desc) as rn
from employee e)
where rn=2;

select e.*,
rank()over(order by salary desc) as rnk
from employee e;

select e.*,
rank()over(partition by dept_name order by salary desc) as rnk
from employee e;


select * from 
(select e.*,
rank()over(partition by dept_name order by salary desc) as rnk
from employee e)
where rnk=1;

select e.*,
row_number()over(partition by dept_name order by salary desc) as rn,
rank()over(partition by dept_name order by salary desc) as rnk,
dense_rank()over(partition by dept_name order by salary desc) as dns_rnk
from employee e;

select * from (
select e.*,
dense_rank()over(partition by dept_name order by salary desc) as dns_rnk
from employee e)
where dns_rnk<=1;

select * from (
select e.*,
rank()over(partition by dept_name order by salary desc) as dns_rnk
from employee e)
where dns_rnk<=1;
---

