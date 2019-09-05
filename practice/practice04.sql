-- 문제1.
-- 현재 평균 연봉보다 많은 월급을 받는 직원은 몇 명이나 있습니까?
select count(*)
from salaries
where to_date = '9999-01-01'
  and salary > (select avg(salary)
				from salaries
				where to_date = '9999-01-01');

-- 문제2. 
-- 현재, 각 부서별로 최고의 급여를 받는 사원의 사번, 이름, 부서, 연봉을 조회하세요. 
-- 단 조회결과는 연봉의 내림차순으로 정렬되어 나타나야 합니다. 
select  a.emp_no, a.first_name, a.last_name, d.dept_name, b.salary
from employees a, salaries b, dept_emp c, departments d
where a.emp_no = b.emp_no
  and a.emp_no = c.emp_no
  and c.dept_no = d.dept_no
  and b.to_date = '9999-01-01'
  and c.to_date = '9999-01-01'
  and (b.salary, c.dept_no) in (select max(b.salary), c.dept_no 
								from employees a, salaries b, dept_emp c
								where a.emp_no = b.emp_no
								  and a.emp_no = c.emp_no
								  and b.to_date = '9999-01-01'
								  and c.to_date = '9999-01-01'
								group by c.dept_no)
order by b.salary desc;

-- 문제3.
-- 현재, 자신의 부서 평균 급여보다 연봉(salary)이 많은 사원의 사번, 이름과 연봉을 조회하세요.
select  a.emp_no, a.first_name, a.last_name, b.salary, c.dept_no
from employees a, salaries b, dept_emp c,
     (select avg(b.salary) as avg_salary, c.dept_no as dept_no
		from employees a, salaries b, dept_emp c
		where a.emp_no = b.emp_no
		  and a.emp_no = c.emp_no
		  and b.to_date = '9999-01-01'
		  and c.to_date = '9999-01-01'
		group by c.dept_no) t
where a.emp_no = b.emp_no
  and a.emp_no = c.emp_no
  and c.dept_no = t.dept_no
  and b.to_date = '9999-01-01'
  and c.to_date = '9999-01-01'
  and b.salary > t.avg_salary
order by c.dept_no;

-- 문제4.
-- 현재, 사원들의 사번, 이름, 매니저 이름, 부서 이름으로 출력해 보세요.
select a.emp_no, concat(a.first_name,' ', a.last_name), t.name, c.dept_name
from employees a, dept_emp b, departments c,
     (select a.emp_no as emp_no, concat(a.first_name,' ', a.last_name) as name, b.dept_no as dept_no
		from employees a, dept_manager b
		where a.emp_no = b.emp_no
		  and b.to_date = '9999-01-01') t
where a.emp_no = b.emp_no
  and b.dept_no = c.dept_no
  and c.dept_no = t.dept_no
  and b.to_date = '9999-01-01';

-- 문제5.
-- 현재, 평균연봉이 가장 높은 부서의 사원들의 사번, 이름, 직책, 연봉을 조회하고 연봉 순으로 출력하세요.
select a.emp_no, a.first_name, a.last_name, d.title, b.salary, c.dept_no
from employees a, salaries b, dept_emp c, titles d,
     (select avg(b.salary) as avg_salary, c.dept_no as dept_no
		from employees a, salaries b, dept_emp c
		where a.emp_no = b.emp_no
		  and a.emp_no = c.emp_no
		  and b.to_date = '9999-01-01'
		  and c.to_date = '9999-01-01'
		group by c.dept_no
		order by avg_salary desc
		limit 0, 1) t
where a.emp_no = b.emp_no
  and a.emp_no = c.emp_no
  and a.emp_no = d.emp_no
  and c.dept_no = t.dept_no
  and b.to_date = '9999-01-01'
  and c.to_date = '9999-01-01'
  and d.to_date = '9999-01-01';

-- 문제6.
-- 평균 연봉이 가장 높은 부서는? 
select a.dept_no, a.dept_name
from departments a, (select avg(b.salary) as avg_salary, c.dept_no as dept_no
		from employees a, salaries b, dept_emp c
		where a.emp_no = b.emp_no
		  and a.emp_no = c.emp_no
		  and b.to_date = '9999-01-01'
		  and c.to_date = '9999-01-01'
		group by c.dept_no
		order by avg_salary desc
		limit 0, 1) t
where a.dept_no = t.dept_no;

-- 문제7.
-- 평균 연봉이 가장 높은 직책?
select a.title
from titles a, (select avg(b.salary) as avg_salary, c.title as title
		from employees a, salaries b, titles c
		where a.emp_no = b.emp_no
		  and a.emp_no = c.emp_no
		  and b.to_date = '9999-01-01'
		  and c.to_date = '9999-01-01'
		group by c.title
		order by avg_salary desc
		limit 0, 1) t
where a.title = t.title
limit 0, 1;

-- 문제8.
-- 현재 자신의 매니저보다 높은 연봉을 받고 있는 직원은?
-- 부서이름, 사원이름, 연봉, 매니저 이름, 메니저 연봉 순으로 출력합니다.

select a.emp_no, b.salary, c.dept_no
from employees a, salaries b, dept_manager c
where a.emp_no = b.emp_no
  and a.emp_no = c.emp_no
  and b.to_date = '9999-01-01'
  and c.to_date = '9999-01-01';
  
select d.dept_name, a.emp_no, b.salary, t.name, t.salary
from employees a, salaries b, dept_emp c, departments d,
     (select a.emp_no as emp_no, concat(a.first_name,' ', a.last_name) as name, b.salary as salary, c.dept_no as dept_no
		from employees a, salaries b, dept_manager c
		where a.emp_no = b.emp_no
		  and a.emp_no = c.emp_no
		  and b.to_date = '9999-01-01'
		  and c.to_date = '9999-01-01') t
where a.emp_no = b.emp_no
  and a.emp_no = c.emp_no
  and c.dept_no = d.dept_no
  and c.dept_no = t.dept_no
  and b.to_date = '9999-01-01'
  and c.to_date = '9999-01-01'
  and b.salary > t.salary;