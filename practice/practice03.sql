-- 문제1) 현재 급여가 많은 직원부터 직원의 사번, 이름, 그리고 연봉을 출력 하시오.
select a.emp_no, a.first_name, b.salary
from employees a, salaries b
where a.emp_no = b.emp_no
  and b.to_date = '9999-01-01'
order by b.salary;

-- 문제2) 전체 사원의 사번, 이름, 현재 직책을 이름 순서로 출력하세요.
select a.emp_no, a.first_name, b.title
from employees a, titles b
where a.emp_no = b.emp_no
  and b.to_date = '9999-01-01'
order by b.title;

-- 문제3) 전체 사원의 사번, 이름, 현재 부서를 이름 순서로 출력하세요.
select a.emp_no, a.first_name, c.dept_name
from employees a, dept_emp b, departments c
where a.emp_no = b.emp_no
  and b.dept_no = c.dept_no
  and b.to_date = '9999-01-01'
order by c.dept_name;


-- 문제4) 전체 사원의 사번, 이름, 연봉, 직책, 부서를 모두 이름 순서로 출력합니다.
select a.emp_no, a.first_name, a.last_name, c.salary, d.title, e.dept_name
from employees a, dept_emp b, salaries c, titles d, departments e
where a.emp_no = b.emp_no
  and a.emp_no = c.emp_no
  and a.emp_no = d.emp_no
  and b.dept_no = e.dept_no
  and b.to_date = '9999-01-01'
  and c.to_date = '9999-01-01'
  and d.to_date = '9999-01-01'
order by a.first_name;

-- 문제5) ‘Technique Leader’의 직책으로 과거에 근무한 적이 있는 모든 사원의
-- 사번과 이름을 출력하세요. (현재 ‘Technique Leader’의 직책(으로 근무하는
-- 사원은 고려하지 않습니다.) 이름은 first_name과 last_name을 합쳐 출력합니다.
select a.emp_no, concat(a.first_name, ' ', a.last_name)
from employees a, titles b
where a.emp_no = b.emp_no
  and b.title = 'Technique Leader'
  and not b.to_date = '9999-01-01';

-- 문제6) 직원 이름(last_name) 중에서 S(대문자)로 시작하는 직원들의 이름, 부서명, 직책을 조회하세요.
select a.first_name, a.last_name, d.dept_name, c.title
from employees a, dept_emp b, titles c, departments d
where a.emp_no = b.emp_no
  and a.emp_no = c.emp_no
  and b.dept_no = d.dept_no
  and b.to_date = '9999-01-01'
  and c.to_date = '9999-01-01'
  and a.last_name like 'S%';

-- 문제7) 현재, 직책이 Engineer인 사원 중에서 현재 급여가 40000 이상인 사원을 급여가
-- 큰 순서대로 출력하세요.
select a.emp_no, a.first_name, a.last_name, b.salary, c.title
from employees a, salaries b, titles c
where a.emp_no = b.emp_no
  and a.emp_no = c.emp_no  
  and b.to_date = '9999-01-01'
  and c.to_date = '9999-01-01'
  and c.title = 'Engineer'
  and b.salary >= 40000
order by b.salary desc;

-- 문제8) 현재 급여가 50000이 넘는 직책을 직책, 급여로 급여가 큰 순서대로 출력하시오.
select a.emp_no, a.first_name, a.last_name, b.salary, c.title
from employees a, salaries b, titles c
where a.emp_no = b.emp_no
  and a.emp_no = c.emp_no  
  and b.to_date = '9999-01-01'
  and c.to_date = '9999-01-01'
  and b.salary >= 50000
order by b.salary desc;

-- 문제9) 현재, 부서별 평균 연봉을 연봉이 큰 부서 순서대로 출력하세요.
select avg(c.salary), d.dept_no, d.dept_name
from employees a, dept_emp b, salaries c, departments d
where a.emp_no = b.emp_no
  and a.emp_no = c.emp_no
  and b.dept_no = d.dept_no
  and b.to_date = '9999-01-01'
  and c.to_date = '9999-01-01'
group by d.dept_no
order by avg(c.salary) desc;

-- 문제10) 현재, 직책별 평균 연봉을 연봉이 큰 직책 순서대로 출력하세요.
select avg(c.salary), b.title
from employees a, titles b, salaries c
where a.emp_no = b.emp_no
  and a.emp_no = c.emp_no
  and b.to_date = '9999-01-01'
  and c.to_date = '9999-01-01'
group by b.title
order by avg(c.salary) desc;