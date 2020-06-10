-- 문제1.
--평균 급여보다 적은 급여을 받는 직원은 몇명인지 구하시요.
--(56건)

 SELECT
     count(*)
 FROM employees
 where salary < 
    (
    SELECT
        avg(salary)
    FROM employees
    );

--문제2. 
--평균급여 이상, 최대급여 이하의 월급을 받는 사원의 
--직원번호(employee_id), 이름(first_name), 급여(salary), 평균급여, 최대급여를 급여의 오름차순으로 정렬하여 출력하세요 
--(51건)
 SELECT
     e.employee_id as "직원번호",
     e.first_name as "이름",
     e.salary as "급여",
     round(maav.av,0) as "평균급여",
     maav.ma as "최대급여"
 FROM employees e,
    (
    SELECT
        max(salary) ma,
        avg(salary) av
    FROM employees
    ) maav
where e.salary>=av and e.salary<=ma
order by e.salary;

--문제3.
--직원중 Steven(first_name) king(last_name)이 소속된 부서(departments)가 있는 곳의 주소를 알아보려고 한다.
--도시아이디(location_id), 거리명(street_address), 우편번호(postal_code), 도시명(city), 주(state_province), 나라아이디(country_id) 를 출력하세요
--(1건)
SELECT
    de.location_id,
    lo.street_address,
    lo.postal_code,
    lo.city,
    lo.state_province,
    lo.country_id
FROM employees em, departments de, locations lo
where em.department_id = de.department_id(+) and
      de.location_id = lo.location_id(+) and
      em.first_name = 'Steven' and
      em.last_name = 'King';

SELECT
    e.location_id,
    e.street_address,
    e.postal_code,
    e.city,
    e.state_province,
    e.country_id
FROM (
    SELECT
    em.first_name,
    em.last_name,
    de.location_id,
    lo.street_address,
    lo.postal_code,
    lo.city,
    lo.state_province,
    lo.country_id
    FROM employees em, departments de, locations lo
    where 
        em.department_id = de.department_id(+) and
        de.location_id = lo.location_id(+)) e
    where e.first_name='Steven' and
          e.last_name='King';
          
--문제4.
--job_id 가 'ST_MAN' 인 직원의 급여보다 작은 직원의 사번,이름,급여를 급여의 내림차순으로 출력하세요  -ANY연산자 사용
--(74건)
SELECT
    e.employee_id,
    e.first_name,
    e.salary
FROM employees e
where salary <any (SELECT
        e.salary
    FROM employees e
    where e.job_id='ST_MAN');
    
--문제5. 
--각 부서별로 최고의 급여를 받는 사원의 직원번호(employee_id), 이름(first_name)과 급여(salary) 부서번호(department_id)를 조회하세요 
--단 조회결과는 급여의 내림차순으로 정렬되어 나타나야 합니다. 
--조건절비교, 테이블조인 2가지 방법으로 작성하세요
--(11건)

SELECT
    em.employee_id,
    em.first_name,
    em.salary,
    em.department_id
FROM employees em,
    (SELECT
        department_id,
        max(salary) mSalary
    FROM employees
    group by department_id) em1
where 
    em.department_id=em1.department_id and
    em1.msalary = em.salary; 

--문제6.
--각 업무(job) 별로 연봉(salary)의 총합을 구하고자 합니다. 
--연봉 총합이 가장 높은 업무부터 업무명(job_title)과 연봉 총합을 조회하시오 
--(19건)
SELECT
    jb.job_title,
    em.sum1
FROM jobs jb,
    (SELECT
        job_id,
        sum(salary) sum1
    FROM employees
    group by job_id) em
where jb.job_id=em.job_id
order by em.sum1 desc;

--문제7.
--자신의 부서 평균 급여보다 연봉(salary)이 많은 직원의 직원번호(employee_id), 이름(first_name)과 급여(salary)을 조회하세요 
--(38건)
SELECT
    em.employee_id,
    em.first_name,
    em.salary
FROM employees em,
    (SELECT
        department_id,
        avg(salary) sal1
    FROM employees
    group by department_id) em1
where 
    em.department_id=em1.department_id and
    em.salary>em1.sal1;
    
--문제8.
--직원 입사일이 11번째에서 15번째의 직원의 사번, 이름, 급여, 입사일을 입사일 순서로 출력하세요
SELECT
    rn,
    em2.employee_id,
    em2.first_name,
    em2.salary,
    em2.hire_date
FROM(
    SELECT
        rownum rn,
        em1.employee_id,
        em1.first_name,
        em1.salary,
        em1.hire_date
    FROM
        (SELECT
            em.employee_id,
            em.first_name,
            em.salary,
            em.hire_date
        FROM employees em
        order by hire_date) em1) em2
where em2.rn<=15 and em2.rn>=11;