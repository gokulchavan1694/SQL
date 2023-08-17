select * from cars;

select model,brand ,count(*) as count
from cars 
group by  model,brand
having count(*) >1;

select model,brand ,count(*),max(id)
from cars 
group by  model,brand
having count(*) >1;

delete from cars
where id in(
select max(id)
from cars 
group by  model,brand
having count(*) >1);