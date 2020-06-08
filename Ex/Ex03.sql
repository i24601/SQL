SELECT
    avg(salary) "평균급여",
    employee_id
FROM employees;

SELECT
    count(*),
    count(manager_id),
    count(commission_pct),
    avg(salary)
FROM employees;

SELECT
    count(nvl(commission_pct,0.2))--먼저 null->0.2
FROM employees
where commission_pct>0.1;--그 다음 where절 조건 판단 마치 select 다음 where절 처리하는것처럼

SELECT--commission_pct가 0이라도
    count(commission_pct)
FROM employees
where commission_pct >0;

SELECT--commission_pct가 0이라도
    count(commission_pct)
FROM employees
where commission_pct >0;

SELECT
    count(manager_id),
    COUNT(*)
FROM employees
where salary>16000;

SELECT
    sum(salary)
FROM employees;

SELECT
    avg(salary)
FROM employees
where salary>16000;

SELECT
    department_id,
    max(salary)
FROM employees
group by department_id
order by department_id asc;

select 
        department_id,
        job_id,
        count(*),
        sum(salary)
from employees
group by department_id, job_id
order by department_id;

SELECT
    department_id,
    count(*),
    sum(salary)
FROM employees
group by department_id
having sum(salary)>20000
and sum(salary)<300000
and count(*)>5;

SELECT
    *
FROM employees;

SELECT
    employee_id,
    job_id,
    salary,
    case when job_id = 'AC_ACCOUNT' then salary+salary*0.1
         when job_id = 'SA_REP' then salary+salary*0.2
         when job_id = 'ST_CLERK' then salary+salary*0.3
         else salary
    end realSalary
FROM employees
order by job_id;

SELECT
    employee_id,
    job_id,
    salary,
    case
--        when job_id = 'AC_ACCOUNT' then 0
        when salary >= 20000 then salary+salary*0.1--위에있는게 먼저 처리되고 아래는 처리 안됨
        when salary >= 10000 and salary<=20000 then salary+salary*0.2
        when salary < 15000 then salary+salary*0.3
        when job_id = 'AC_ACCOUNT' then 0 --처리안됨
        else salary
    end realSalary
FROM employees
order by job_id;

SELECT--select 문의 조건들은 from절에서 먼저 처리됨 
    first_name || ' ' ||  last_name as "이름",
    department_id,
    case 
        when department_id>=10 and department_id <=50 then 'A'
        when department_id>=60 and department_id <=100 then 'B'
        when department_id>=110 and department_id <=150 then 'C'
        else '없음'
        end team
FROM employees
order by team asc;
