-- JOIN

select * from employee;
select * from department;

-- 1. 데이터 넣기
insert into department values(null, '영업팀');
insert into department values(null, '인사팀');
insert into department values(null, '개발팀');
insert into department values(null, '총무팀');


insert into employee values(null, '둘리', 1);
insert into employee values(null, '마이콜', 2);
insert into employee values(null, '또치', 3);
insert into employee values(null, '진국', null);

-- ▣ inner join

-- 1. 조심: cartesian products(m * n)
select *
from employee, department;

-- 2. equijoin
select e.no, e.name, d.name
from employee e, department d
where e.department_no = d.no;

-- 3. join ~ on (ANSI SQL 1999)
select e.no, e.name, d.name
from employee e
join department d
on e.department_no = d.no;

-- 4. natural join


-- ▣ outter join

-- 1. left join
select e.no, e.name, d.name, ifnull(d.name, '사장님')
from employee e
left join department d
on e.department_no = d.no;

-- 2. right join
select e.no, e.name, ifnull(e.name, '채용요망'), d.name
from employee e
right join department d
on e.department_no = d.no;

-- 3. full join
-- 	  mysql/mariadb 지원안함
-- select e.no, e.name, d.name
-- from employee e
-- full join department d
-- on e.department_no = d.no;
