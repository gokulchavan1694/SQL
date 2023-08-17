---Subqueries

select * from employee;

-----
select * from employee
where salary=(
select DISTINCT(max(salary)) from employee);
---
2nd highest salary

select max(salary) from employee 
where salary !=(
select DISTINCT(max(salary)) from employee);


select * from employee
where salary=(
select max(salary) from employee 
where salary !=(
select DISTINCT(max(salary)) from employee));

-----
select * from employee;

-----
select * from employee
where salary=(
select DISTINCT(max(salary)) from employee);
---
---2nd highest salary

select max(salary) from employee 
where salary !=(
select DISTINCT(max(salary)) from employee);


select * from employee
where salary=(
select max(salary) from employee 
where salary !=(
select DISTINCT(max(salary)) from employee));

select dept_name,count(*) from employee group by dept_name;

select * from employee
where dept_name in(
select dept_name from employee group by dept_name having count(*)<5)order by salary;


select * from employee
where dept_name in(
select dept_name from employee group by dept_name having count(*)>=5);

