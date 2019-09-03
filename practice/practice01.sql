-- practice01

-- 문제1
-- 사번이 10944인 사원의 이름은(전체 이름)
select concat(first_name," ",last_name) name
from employees
where emp_no = 10944;

select concat(first_name," ",last_name) "이름"
from employees;