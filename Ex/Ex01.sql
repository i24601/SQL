SELECT  employee_id "emp NO",
        first_name "E-Name",
        salary "급여"
from employees;

--column명 바꿈
--대소문자, 공백, 특수문자를 사용가능

SELECT  employee_id as mpNO,
        first_name as EName,
        salary as 급여
from employees;

--column명 바꿈
--대문자로만 column명이 표시됨

SELECT  employee_id as 사원번호,

--        column 합치기 ||
        first_name  || ' ' ||
        last_name  || ' 의 급여는 ' ||
        salary "그의 급여는..?",
        phone_number as 전화번호,
        email as 이메일,
        hire_date as 입사일
from employees;

select  first_name "이름",
        salary as 급여,
        salary*12 as 연봉
from employees;

SELECT  first_name || ' ' || last_name "성명",
        salary as 급여,
        salary*12 "연봉",
        salary*12+5000 as 연봉2,
        phone_number "전화번호"
FROM employees;

SELECT  first_name "이름",
        salary "연봉"
FROM employees
WHERE first_name='Lex'; 

SELECT  first_name "이름",
        hire_date "입사일"
FROM employees
where hire_date>='07/01/01';

SELECT  first_name "이름",
        salary "연봉"
FROM employees
WHERE salary<=14000
or    salary>=17000; 

SELECT  first_name "이름",
        salary "연봉"
FROM employees
WHERE salary BETWEEN 14000 and 17000; 

SELECT  first_name "이름",
        hire_date "입사일"
FROM employees
where hire_date>='04/01/01'
and   hire_date<='05/12/31';

SELECT  first_name,
        last_name,
        salary
FROM employees
WHERE first_name in ('Neena','Lex','John');

SELECT  first_name,
        last_name,
        salary
FROM employees
WHERE salary in (2100,3100,4100,5100);

SELECT  first_name,
        last_name,
        salary
FROM employees
where first_name like '__a_';

SELECT  first_name,
        salary,
        commission_pct,
        salary*commission_pct
FROM employees
where salary between 13000 and 15000;

SELECT  first_name,
        salary,
        commission_pct,
        salary*commission_pct
FROM employees
where commission_pct is null;

SELECT  first_name,
        salary,
        commission_pct
FROM employees
where commission_pct is not null;

SELECT  first_name,
        commission_pct,
        salary*commission_pct
FROM employees
where manager_id is null
and commission_pct is null;

SELECT  first_name,
        salary,
        commission_pct
FROM employees
where commission_pct is not null
order by salary desc;

SELECT  first_name,
        salary,
        commission_pct
FROM employees
where commission_pct is not null
order by salary asc;
--이왕이면 default값이라도 생략하지말고 써주자(desc,asc)

SELECT  first_name,
        salary,
        commission_pct
FROM employees
where commission_pct is not null
order by salary;

SELECT  first_name,
        salary
FROM employees
where salary >=9000
order by salary desc, first_name asc;

SELECT  department_id,
        salary,
        first_name
FROM employees
where salary>=1000
order by department_id asc, salary desc;
--우선시 해서 정렬할것을 앞부터 부서번호->급여
--순서는 from->where->order by->select