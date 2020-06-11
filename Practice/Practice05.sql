--혼합 SQL 문제입니다.
--
--문제1.
--담당 매니저가 배정되어있으나 커미션비율이 없고, 월급이 3000초과인 직원의 
--이름, 매니저아이디, 커미션 비율, 월급 을 출력하세요.
--(45건)
--
--
SELECT
    first_name, 
    commission_pct,
    salary
FROM employees
where 
    manager_id is not null and
    commission_pct is null and
    salary>3000;
--
--
--문제2. 
--각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name), 급여(salary), 입사일(hire_date), 전화번호(phone_number), 부서번호(department_id) 를 조회하세요 
---조건절비교 방법으로 작성하세요
---급여의 내림차순으로 정렬하세요
---입사일은 2001-01-13 토요일 형식으로 출력합니다.
---전화번호는 515-123-4567 형식으로 출력합니다.
--(11건)
--
--
SELECT
    em.employee_id,
    em.first_name,
    em.salary,
    to_char(em.hire_date,'YYYY-MM-DD'),
    em.phone_number,
    em.department_id
FROM 
    employees em,
    (SELECT
        department_id,
        max(salary) sal
    FROM employees
    group by department_id) em1
where 
    em.salary=em1.sal and
    em.department_id=em1.department_id;
--
--
--문제3
--2005년 이후 입사자중 매니저별로 평균급여 최소급여 최대급여를 알아보려고 한다.
--출력은 관리자별로 평균급여가 5000이상 중에 
--매니저아이디, 매니저이름(first_name), 매니저별평균급여, 매니저별최소급여, 매니저별최대급여를 출력합니다.
--매니저별평균급여의 내림차순으로 정렬하고 매니저별평균급여는 소수점 첫째짜리에서 반올림 하여 출력합니다.
--(51건) 
--SELECT
--    em2.manager_id,
--    em3.first_name,
--    em1.sal2 "매니저별평균급여",
--    em1.sal3 "매니저별최소급여",
--    em1.sal1 "매니저별최대급여"
--FROM 
--    employees em2,
--    employees em3,
--    (SELECT
--        em.manager_id,
--        max(em.salary) sal1,
--        round(avg(em.salary),0) sal2,
--        min(em.salary) sal3
--    FROM employees em
--    where hire_date>='2005/01/01'
--    group by em.manager_id) em1
--where
--    em2.manager_id=em3.employee_id and
--    em1.sal2>=5000 and
--    em1.manager_id=em2.manager_id
--order by em1.sal2;

--
--문제3
--2005년 이후 입사자들의 매니저들의 평균급여 최소급여 최대급여를 알아보려고 한다.
--출력은 관리자별로 평균급여가 5000이상 중에 
--매니저아이디, 매니저이름(first_name), 매니저별평균급여, 매니저별최소급여, 매니저별최대급여를 출력합니다.
--매니저별평균급여의 내림차순으로 정렬하고 매니저별평균급여는 소수점 첫째짜리에서 반올림 하여 출력합니다.
--(51건) 
--
SELECT
    em2.employee_id,
    em2.first_name,
    em1.sal2,
    em1.sal3,
    em1.sal1
FROM 
    employees em2,
    (SELECT
        em.manager_id,
        max(em.salary) sal1,
        round(avg(em.salary),0) sal2,
        min(em.salary) sal3
    FROM employees em
    where hire_date>='2005/01/01'
    group by em.manager_id) em1
where
    em1.sal2>=5000 and
    em2.employee_id=em1.manager_id;
    
--문제4.
--각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 부서명(department_name), 매니저(manager)의 이름(first_name)을 조회하세요.
--부서가 없는 직원(Kimberely)도 표시합니다.
--(106명)
--
SELECT
    em.employee_id,
    em.first_name,
    de.department_name,
    em1.first_name
FROM 
    employees em,
    employees em1,
    departments de
where 
    em.department_id=de.department_id(+) and
    em.manager_id=em1.employee_id;
--
--
--
--문제5.
--2005년 이후 입사한 직원중에 입사일이 11번째에서 20번째의 직원의 
--사번, 이름, 부서명, 급여, 입사일을 입사일 순서로 출력하세요
--
SELECT
    em2.rn,
    em2.employee_id,
    em2.first_name,
    em2.department_name,
    em2.salary,
    em2.hire_date
FROM 
    (SELECT
        ROWNUM rn,
        em1.employee_id,
        em1.first_name,
        em1.department_name,
        em1.salary,
        em1.hire_date
    FROM
        (SELECT
            em.employee_id,
            em.first_name,
            de.department_name,
            em.salary,
            em.hire_date
        FROM employees em, departments de
        where
            em.department_id=de.department_id and
            hire_date>='2005/01/01'
        order by hire_date) em1) em2
where 
    rn<=20 and
    rn>=11;
--
--
--문제6.
--가장 늦게 입사한 직원의 이름(first_name last_name)과 연봉(salary)과 근무하는 부서 이름(department_name)은?
-- 
--
SELECT
    first_name || ' ' || last_name,
    salary,
    de.department_name,
    em.hire_date
FROM EMPLOYEES em, departments de
where hire_date=
    to_date((SELECT
        max(to_number(to_char(hire_date,'YYYYMMDD')))
    FROM employees),'YYYY/MM/DD') and
    em.department_id=de.department_id;
--
--
--문제7.
--평균연봉(salary)이 가장 높은 부서 직원들의 직원번호(employee_id), 이름(firt_name), 성(last_name)과  업무(job_title), 연봉(salary)을 조회하시오.
-- 
--
--
SELECT
    em2.employee_id,
    em2.first_name,
    em2.last_name,
    jb3.job_title,
    em2.salary
FROM employees em2,
     jobs jb3,
    (SELECT
        em.department_id,
        round(avg(em.salary),0) av
    FROM employees em
    group by em.department_id) em1
where
    em2.job_id=jb3.job_id and
    em2.department_id=em1.department_id and
    em2.department_id=em1.department_id and
    em1.av = (
                (SELECT
                max(av1)
                FROM 
                    (SELECT
                    em4.department_id,
                    round(avg(em4.salary),0) av1
                    FROM employees em4
                    group by em4.department_id)
            )
);


--
--
--
--문제8.
--평균 급여(salary)가 가장 높은 부서는? 
-- 
--
SELECT
    DISTINCT de.department_name
FROM employees em, departments de,
(
SELECT
    em1.department_id,
    avg(em1.salary) av1
FROM employees em1
group by em1.department_id) em3
where
    em.department_id=de.department_id and
    em.department_id=em3.department_id and
    em3.av1=
    
    (
    SELECT
        max(emav.av2)
    FROM
    (
    SELECT
        avg(em2.salary) av2
    FROM employees em2
    GROUP by em2.department_id
    ) emav
    )
    ;
    
SELECT
    DISTINCT de.department_name
FROM employees em, departments de,
(
SELECT
    em1.department_id,
    avg(em1.salary) av1
FROM employees em1
group by em1.department_id) em3
where
    em.department_id=de.department_id and
    em.department_id=em3.department_id and
    em3.av1=
    
    (
    SELECT
        max(emav.av2)
    FROM
    (
    SELECT
        avg(em2.salary) av2
    FROM employees em2
    GROUP by em2.department_id
    ) emav
    )
    ;
--
--
--
--문제9.
--평균 급여(salary)가 가장 높은 지역은? 
-- 
--
SELECT
    tb2.region_name
FROM    ( 
        SELECT
            ROWNUM rn,
            tb1.region_name
        FROM
            (
            SELECT
                re.region_name,
                avg(em.salary) av
            FROM employees em, departments de, locations lo, countries co, regions re
            where em.department_id = de.department_id and
            de.location_id=lo.location_id and
            lo.country_id=co.country_id and
            co.region_id = re.region_id
            group by re.region_name
            ) tb1
            ) tb2
where rn=1;
        
--
--
--문제10.
--평균 급여(salary)가 가장 높은 업무는? 
-- 
--
SELECT
    tb2.ti
FROM
    (SELECT
        rownum rn,
        tb1.ti,
        tb1.av
    FROM(
        SELECT
            jb.job_title ti,
            avg(em.salary) av
        FROM employees em, jobs jb
        where em.job_id=jb.job_id
        group by jb.job_title
        order by av desc)tb1
        )tb2
where rn=1;
