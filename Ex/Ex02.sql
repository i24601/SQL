SELECT
    email "EMAIL",
    initcap(email) "Email",
    initcap('aaaaaa') "Aaaaaa"
FROM employees;

SELECT
    initcap('bb')
FROM dual;
--가상테이블

SELECT
    email,
    initcap(email),
    department_id
FROM employees
WHERE department_id = 100;

SELECT
    lower('ABC'),
    upper('abc')
FROM dual;

SELECT
    first_name,
    upper(first_name),
    lower(first_name)
FROM employees
WHERE department_id = 100;

SELECT
    'old ' ||
    substr('qpalzm',2,3) "old pal"
FROM dual;

SELECT
    'old ' ||
    substr('qpalzm',-5,3) "old pal"
FROM dual;

SELECT
    first_name,
    substr(first_name,1,3),
    substr(first_name,-3,2)
FROM employees
where department_id=100;

SELECT
    substr('abcd임성수',3,3)
FROM dual;

SELECT
    lpad(first_name,10,'*') "영어",
    lpad('성수',10,'*') "한글"
FROM employees;
--영문 특문 숫자는 1바이트 한글은 2바이트라서?

SELECT
    first_name,
    replace(first_name,'a','!')
FROM employees
where department_id = 100;

SELECT
    replace('임성수',substr('임성수',2,2),'**')
FROM dual;

select 
    ltrim('              aaaaaa            ') || '----',
    rtrim('              bbbbbb            ') || '----',
    trim('              bbbbbb            ') || '----'
from dual;
--trim ltrim rtrim

--숫자함수
SELECT
    round(12.345,2),
    trunc(12.345,2),
    
    round(12.345,1),
    trunc(12.345,1),
    
    round(12.345,0),
    trunc(12.345,0),
    
    round(12.345,-1),
    trunc(12.345,-1)
    
FROM dual;
--반올림, 버림

SELECT    
    sysdate,
    MONTHS_BETWEEN(sysdate,'1993/05/19'),
    last_day(sysdate)
FROM dual;

SELECT
    to_char(salary*12,'999,999'),
    to_char(salary*12,'999,999,999.9'),
    to_char(salary*12,'09999999'),
    
    to_char(9876, '099999')
FROM employees
where department_id = 110;

SELECT
    to_char(sysdate,'YYYY-MM-DD HH24:MI:SS')
FROM dual;

SELECT
    nvl(commission_pct,1),
    nvl2(commission_pct,commission_pct,1),
    salary*commission_pct,
    salary*nvl(commission_pct,1)
FROM employees;