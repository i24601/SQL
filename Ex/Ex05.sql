SELECT
    salary
FROM employees
where first_name = 'Den';

SELECT
    first_name,
    salary
FROM employees
where 
    salary > 
    (SELECT salary 
    FROM employees 
    where first_name = 'Den')
order by salary;

SELECT
    first_name,
    salary,
    employee_id
FROM employees
where 
    salary = 
    (SELECT min(salary)
    FROM employees )
order by salary;

SELECT
    first_name,
    salary,
    employee_id
FROM employees
where 
    salary < 
    (SELECT avg(salary)
    FROM employees )
order by salary;

SELECT
    first_name,
    salary
FROM employees
where salary in 
    (SELECT salary
    FROM employees
    where department_id = 110);
    
SELECT
    first_name,
    employee_id,
    salary,
    department_id
FROM employees
where (nvl(department_id,0), salary) in 
    (SELECT
    nvl(department_id,0),
    max(salary)
    FROM employees
    group by department_id, nvl(department_id,0));
    
SELECT
    first_name,
    employee_id,
    salary,
    department_id
FROM employees
WHERE salary in (SELECT
    max(salary)
FROM employees
GROUP by department_id);

select first_name, salary
from employees
where salary >any (select salary
                    from employees
                    where department_id = 110);
                
select first_name, salary
from employees
where salary >all (select salary
                    from employees
                    where department_id = 110);
                    
SELECT
    em.department_id,
    em.first_name,
    em1.salary1
FROM employees em, 
(SELECT
    department_id,
    max(salary) salary1
FROM employees
group by department_id) em1
where nvl(em.department_id,0)=nvl(em1.department_id,0)
and em.salary=em1.salary1
order by em1.salary1 desc;

SELECT
    *
FROM (
    SELECT
        ROWNUM rn,
        salary,
        first_name
    FROM 
        (
        SELECT
        rownum rn1,
        first_name,
        salary
        FROM employees
        order by salary desc)
    )
where rn<=5
and rn>=3;
SELECT
    rn.first_name,
    rn.salary,
    rn.hire_date
FROM(
    SELECT
        rownum rn,
        orderS.first_name,
        orderS.hire_date,
        orderS.salary
    FROM(
        SELECT
            first_name,
            hire_date,
            salary
        FROM employees
        where hire_date like '07%'
        order by salary desc
        ) orderS
    ) rn
    where rn >= 3 and rn<=7;