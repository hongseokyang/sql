-- upper
-- 1. 자바 upperCase 보다 DB의 upper() 함수가 훨씬 빠르다.
-- 2. 웬만하면 DB에서 문자열 처리뿐만 아니라 가능한 포맷팅 처리등을 다 해주고
-- 		자바에서 출력만 해결한다.
-- 3. 자바 코드가 간결해서 좋다.
select upper('SeouL'), ucase('seoul');
select upper(first_name) from employees;

-- lower
select lower('SEouL'), lcase('SEOUL');

-- substring()
select substring('Happy Day', 3, 2);

-- substring_index()
select substring_index('itcen.co.kr', '.', 2);
select substring_index('itcen.co.kr', '.', -2);

-- right()
select right('itcen.co.kr', 2);

-- left()
select left('itcen.co.kr', 5);

select first_name as '이름', substring(hire_date, 1, 4) as '입사년도'
from employees;

-- length()
select length('아이티센');

-- char_length()
select char_length('아이티센');

-- cast()
select cast(1234 as char);
select cast('1992-11-17' as date);

-- locate()
select locate('co', 'itcen.co.kr');

-- lpad, rpad : 정렬
select lpad('1234', 10, '-');
select rpad('1234', 10, '-');

-- salaries 테이블에서 2001년 급여가 70000불 이하의 직원만 사번, 급여로 출력하되 급여는 10자리로 부족한 자리수는 *로 표시
select emp_no, lpad(cast(salary as char), 10, '*') as '급여'
from salaries
where from_date like '2001%'
  and salary < 70000;

-- ltrim, rtrim, trim
select concat('-----', ltrim('    hello    '), '---') as 'LTRIM';
select concat('-----', rtrim('    hello    '), '---') as 'RTRIM';
select concat('-----', trim('    hello    '), '---') as 'TRIM';
select concat('-----', trim(both 'x' from 'xxxxxhelloxxxx'), '---') as 'TRIM';
select concat('-----', trim(leading 'x' from 'xxxxxhelloxxxx'), '---') as 'TRIM';
select concat('-----', trim(trailing 'x' from 'xxxxxhelloxxxx'), '---') as 'TRIM';

-- salaries 테이블에 대한 LPAD 예제의 결과를 *생략하여 표시
select emp_no, trim(both '*' from lpad(cast(salary as char), 10, '*')) as '급여'
from salaries
where from_date like '2001%'
  and salary < 70000;
  
-- reverse()
select reverse(title)
from titles
where emp_no = 10001;

-- replace()
select replace("yang hong seok", "hong seok", "홍석");

