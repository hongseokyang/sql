-- 단일행 연산

-- ex) 현재 Fai Bale이 근무하는 부서에서 근무하는 직원의 사번, 전체 이름을 출력해보세요. 

-- sol1-1)
select a.dept_no
from dept_emp a, employees b
where a.emp_no = b.emp_no
  and to_date = '9999-01-01'
  and concat(b.first_name, ' ', b.last_name) = 'Fai Bale';
  
-- sol1-2)
select b.emp_no, concat(b.first_name, ' ', b.last_name)
from dept_emp a, employees b
where a.emp_no = b.emp_no
  and to_date = '9999-01-01'
  and a.dept_no = 'b004';

-- sol2 subquery 사용)
select b.emp_no, concat(b.first_name, ' ', b.last_name)
from dept_emp a, employees b
where a.emp_no = b.emp_no
  and to_date = '9999-01-01'
  and a.dept_no = (select a.dept_no
					from dept_emp a, employees b
					where a.emp_no = b.emp_no
					  and to_date = '9999-01-01'
					  and concat(b.first_name, ' ', b.last_name) = 'Fai Bale'
);

-- 서브쿼리는 괄호로 묶여야 함
-- 서브쿼리 내에 order by 금지
-- group by 절 외에 거의 모든 절에서 사용가능(특히 from, where 절에 많이 사용)
-- where 절인 경우,
--   1) 단일행 연산자 : =, >, <, >=, <=, <>

--  실습문제1) 현재 전체사원의 평균 연봉보다 적은 급여를 받는 사원의  이름, 급여를 나타내세요.
select a.first_name, s.salary
from employees a, salaries s
where a.emp_no = s.emp_no
  and s.to_date = '9999-01-01'
  and s.salary < (select avg(salary)
					from salaries
					where s.to_date = '9999-01-01');

-- 실습문제2) 현재 가장적은 평균 급여를 받고 있는 직책에서  평균 급여를 구하세요.
-- 방법1: Top-k 를 사용
select b.title, avg(a.salary)
    from salaries a, titles b
   where a.emp_no = b.emp_no
     and a.to_date = '9999-01-01'
     and b.to_date = '9999-01-01'
group by b.title
  having round(avg(a.salary)) = (  select round(avg(a.salary))
                                     from salaries a, titles b
                                    where a.emp_no = b.emp_no
                                      and a.to_date = '9999-01-01'
                                      and b.to_date = '9999-01-01'
                                 group by b.title
                                 order by avg(a.salary) asc
                                    limit 0, 1);

-- 방법2: from절 subquery 및 집계함수 사용
  select b.title, avg(a.salary)
    from salaries a, titles b
   where a.emp_no = b.emp_no
     and a.to_date = '9999-01-01'
     and b.to_date = '9999-01-01'
group by b.title
  having round(avg(a.salary)) = (select min(a.avg_salary)
								   from ( select round(avg(a.salary)) as avg_salary
                                            from salaries a, titles b
                                           where a.emp_no = b.emp_no
                                             and a.to_date = '9999-01-01'
                                             and b.to_date = '9999-01-01'
                                          group by b.title) a );

-- 방법3 : join으로만 풀기 (굳이 서브쿼리를 쓸 필요가 없다)
select b.title, avg(a.salary)
 from salaries a, titles b
where a.emp_no = b.emp_no
  and a.to_date = '9999-01-01'
  and b.to_date = '9999-01-01'
group by b.title
order by avg(a.salary) asc
limit 0, 1;

-- where 절인 경우,
--   2) 다중(복수)행 연산자 : in, =any, =all, not in
-- 		2-1) any 사용법
-- 			 1. =any : in 과 동일
-- 			 2. >any, >=any : 최솟값
-- 			 3. <any, <=any : 최댓값
-- 			 4. <>any, !=any : !=all 과 동일
-- 		2-2) all 사용법
-- 			 1. =all
-- 			 2. >all, >=all : 최댓값
-- 			 3. <all, <=all : 최솟값

-- 1) 현재 급여가 50000 이상인 직원 이름 출력

-- 방법1 : join
select b.first_name, a.salary
from salaries a, employees b
where a.emp_no = b.emp_no
  and a.to_date = '9999-01-01'
  and a.salary > 50000;

-- 방법2 : in
select first_name
from employees
where emp_no in (select emp_no
				 from salaries
				 where to_date = '9999-01-01'
				   and salary > 50000);

-- 방법3 : any
select first_name
from employees
where emp_no =any (select emp_no
				 from salaries
				 where to_date = '9999-01-01'
				   and salary > 50000);

-- 2) 각 부서별로 최고 월급을 받는 직원의 이름과 월급을 출려
-- 	  dept_no, first_name, max_salary, 

select c.dept_no, max(b.salary) as max_salary
from employees a, salaries b, dept_emp c
where a.emp_no = b.emp_no
  and a.emp_no = c.emp_no
  and b.to_date = '9999-01-01'
  and c.to_date = '9999-01-01'
group by c.dept_no;

-- 방법1: where 절에 서브쿼리 사용
select a.first_name, c.dept_no, b.salary
from employees a, salaries b, dept_emp c
where a.emp_no = b.emp_no
  and a.emp_no = c.emp_no
  and b.to_date = '9999-01-01'
  and c.to_date = '9999-01-01'
  and (c.dept_no, b.salary) =any (select c.dept_no, max(b.salary) as max_salary
								from employees a, salaries b, dept_emp c
								where a.emp_no = b.emp_no
								  and a.emp_no = c.emp_no
								  and b.to_date = '9999-01-01'
								  and c.to_date = '9999-01-01'
								group by c.dept_no);

-- 방법2: from 절에 서브쿼리 사용
select a.first_name, c.dept_no, b.salary
from employees a, salaries b, dept_emp c
   , (select c.dept_no, max(b.salary) as max_salary
		from employees a, salaries b, dept_emp c
		where a.emp_no = b.emp_no
		  and a.emp_no = c.emp_no
		  and b.to_date = '9999-01-01'
		  and c.to_date = '9999-01-01'
		group by c.dept_no) d
where a.emp_no = b.emp_no
  and a.emp_no = c.emp_no
  and c.dept_no = d.dept_no
  and b.salary = d.max_salary
  and b.to_date = '9999-01-01'
  and c.to_date = '9999-01-01';