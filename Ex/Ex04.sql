SELECT
    em.first_name,
    de.department_name,
    em.job_id
FROM employees em, departments de
where em.department_id = de.department_id;

SELECT
    de.department_name,
    em.first_name,
    jb.job_title
FROM employees em, departments de, jobs jb
where em.department_id = de.department_id
and jb.job_id = em.job_id;

SELECT--106명만 나오는것 같은데?
    de.department_name,
    em.first_name,
    jb.job_title
FROM employees em, departments de, jobs jb
where em.department_id = de.department_id
and jb.job_id = em.job_id;
    
SELECT--몇명인지 count
    count(*)
FROM employees em, departments de, jobs jb
where em.department_id = de.department_id
and jb.job_id = em.job_id;

SELECT--em.department_id가 null이기 때문에 1명이 count되지 않았는지 확인
    count(*)
FROM employees em, departments de, jobs jb
where nvl2(em.department_id,em.department_id,270) = de.department_id--null을 임시로 170으로 치환 DEPARTMENTS (테이블 확인해서)
and jb.job_id = em.job_id;

SELECT--하지만 join문을 안다면 null도 출력가능
    count(*)
FROM 
    employees em 
    left outer join departments de on em.department_id = de.department_id
    left outer join jobs jb on jb.job_id = em.job_id;
    
SELECT--107명 출력
    de.department_name,
    em.first_name,
    jb.job_title
FROM 
    employees em
    left outer join departments de on em.department_id = de.department_id
    left outer join jobs jb on jb.job_id = em.job_id;
    
SELECT--안쓰는 부서도 출력
    de.department_name,
    em.first_name,
    jb.job_title
FROM 
    employees em
    full outer join departments de on em.department_id = de.department_id
    left outer join jobs jb on jb.job_id = em.job_id;

SELECT
    em.employee_id,
    em.first_name,
    em.salary,
    em.manager_id as "매니저 ID", 
    ma.first_name as "매니저 이름",
    ma.salary as "매니저 급여"
FROM employees em, employees ma
where em.manager_id=ma.employee_id;

