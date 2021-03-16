/*
--NVL(변수1, 값)
변수1이 NULL 값이라면 '값'으로 치환해라

*/
SELECT emp_name, salary, NVL(bonus_pct, 0), bonus_pct
FROM   employee
WHERE  salary > 3500000;

SELECT emp_name,
       (salary*12) + ((salary*12)*bonus_pct),  --파생변수에서 NULL값이 포함되어있으면 출력값도 NULL값임
       bonus_pct
FROM   employee
WHERE  salary > 3500000;

SELECT emp_name,
       (salary*12) + 
       ((salary*12)*NVL(bonus_pct, 0)),
       bonus_pct
FROM   employee
WHERE  salary > 3500000;


/*
(오라클 전용함수)
--DECODE(변수, 조건1, 결과1, [조건2, 결과2, ..., ELSE])
SELECT 구문으로 IF-ELSE 논리를 제한적으로 구현한 오라클 DBMS 전용 함수
*/

SELECT  emp_name,
        emp_no,
        SUBSTR(emp_no, -7, 1),
        DECODE(SUBSTR(emp_no, -7, 1), 
                1, '남자', 
                2, '여자') AS GENDER,
        DECODE(SUBSTR(emp_no, -7, 1), 
                1, '남자', 
                3, '남자', 
                '여자') AS GENDER2
FROM    employee
WHERE   dept_id = '50' ;


SELECT  emp_name,
        mgr_id,
        DECODE(mgr_id, 
                NULL, '관리자', 
                '직원') AS "직책"
FROM    employee
WHERE   job_id = 'J4' ;


/*
--NVL2(값, 지정1, 지정2)
값이 NULL이 아닌경우 지정1 NULL인경우 지정2
*/
SELECT  emp_name,
        mgr_id,
        NVL2(mgr_id, '직원', '관리자') AS "구분"
FROM    employee
WHERE   job_id = 'J4' ;



SELECT  *
FROM    job ;

SELECT  *
FROM    employee;

/*
인상된 연봉 구하기
사원 20 J7 대리 15 J6 과장 10 J5
*/

SELECT  job_id,
        salary,
        DECODE(job_id, 
                'J7', salary*1.2, 
                'J6', salary*1.15, 
                'J5', salary*1.1, 
                salary) AS "인상연봉"
FROM    employee;



--------------------------------------------------------------------------------------------
--CASE 변수 WHEN 조건1 THEN 결과1 [WHEN 조건2 THEN 결과2 ..., ELSE 나머지결과] END
--CASE WHEN 변수조건1 THEN 결과1 [WHEN 변수조건2 THEN 결과2 ..., ELSE 나머지결과] END

SELECT  job_id,
        salary,
        CASE job_id
            WHEN 'J7' THEN salary*1.2
            WHEN 'J6' THEN salary*1.15
            WHEN 'J5' THEN salary*1.1
        END AS "인상연봉"
FROM    employee ;


SELECT  job_id,
        salary,
        CASE
            WHEN job_id = 'J7' THEN salary*1.2
            WHEN job_id = 'J6' THEN salary*1.15
            WHEN job_id = 'J5' THEN salary*1.1
        END AS "인상연봉"
FROM    employee ;


/*
사원테이블에서 급여를 지군으로 사원의 급여 등급을 확인하고 싶다
급여가 3000000 이하면 초급개발자
급여가 4000000 이하면 중급개발자
급여가 4000000 초과하면 고급개발자로
*/

SELECT  emp_id,
        emp_name,
        salary,
        CASE
            WHEN salary > 4000000 THEN '고급개발자'
            WHEN salary > 3000000 THEN '중급개발자'
            ELSE '초급개발자'
        END AS "급여등급"
FROM    employee ;

----------------------------------------------------------------------------------------------------------------

/*
그룹함수는 그룹으로 지어져 있어야 사용할 수 있다. 즉, GROUP BY 와 함께쓰임
주요 그룹함수 > SUM, AVG, MIN, MAX, COUNT
--그룹 함수는 NULL값을 계산하지 않는다.
*/

/*
--ORDER BY 기준1 [DESC / ASC], [  기준2 [DESC / ASC] ... ]
ORDER BY는 문장 맨마지막에 나와야함
*/

SELECT   emp_name,
         salary
FROM     employee
WHERE    dept_id = '50'
OR       dept_id IS NULL
ORDER BY salary DESC;

SELECT  emp_name, hire_date, dept_id
FROM    employee
WHERE   hire_date > TO_DATE('20030101', 'YYYYMMDD')
ORDER BY dept_id DESC NULLS LAST, hire_date, emp_name;
--DESC는 내림차순 NULL이 가장 위에옴.
--DESC NULLS LAST는 NULL이 가장 뒤에 오게 할 수 있음

--ORDER BY는 별칭, SELECT 문제 적힌 순서 인덱스를 사용할 수 있다.

SELECT   emp_name AS "이름",
         hire_date AS "입사일",
         dept_id AS "부서코드"
FROM     employee
WHERE    hire_date > TO_DATE('20030101', 'YYYYMMDD')
ORDER BY 부서코드 DESC, 입사일, 이름;

SELECT   emp_name AS "이름",
         hire_date AS "입사일",
         dept_id AS "부서코드"
FROM     employee
WHERE    hire_date > TO_DATE('20030101', 'YYYYMMDD')
ORDER BY 3 DESC, 2, 1;


/*
--GROUP BY
*/


SELECT      SUM(salary)
FROM        employee ;


SELECT      dept_id,
            SUM(salary)
FROM        employee 
GROUP BY    dept_id
ORDER BY    SUM(salary) ;


SELECT      job_id,
            ROUND(AVG(salary))
FROM        employee
GROUP BY    job_id
ORDER BY    job_id;


/*
성별에 따른 급여 평균
*/


-- GROUP BY에 적용된 칼럼은 SELECT에 정의될 수 있다
SELECT      DECODE(SUBSTR(emp_no, 8, 1), 
                    '1', '남자', 
                    '2', '여자') AS "성별", 
            ROUND(AVG(salary)) AS "성별에 따른 평균급여",
            MAX(salary) AS "성별에 따른 최대급여",
            MIN(salary) AS "성별에 따른 최저급여"
FROM        employee
GROUP BY    DECODE(SUBSTR(emp_no, 8, 1), 
                    '1', '남자', 
                    '2', '여자') ;

SELECT      dept_id,
            emp_name,
            COUNT(*)
FROM        employee
GROUP BY    dept_id, emp_name ;
                    
                    
                    
SELECT      dept_id,
            emp_name,
            COUNT(*)
FROM        employee
GROUP BY    ROLLUP(dept_id, emp_name) ; /* <-- ROLLUP이란?? 중간중간 소계를 삽입해주는 함수 */

-----------------------------------------------------------------------------------------------


SELECT      MAX(SUM(salary))
FROM        employee
GROUP BY    dept_id ;

---------------------------------------------------

/*
--HAVING : GRUOP BY에 대한 조건
--SELECT에서 WHERE을 쓰는 것과 같은 이치
> WHERE절에는 집계함수(SUM, MAX..)등을 사용할 수 없다!
*/

SELECT      dept_id, SUM(salary)
FROM        employee
GROUP BY    dept_id
HAVING      SUM(salary) > 9000000 ;

SELECT      dept_id, SUM(salary)
FROM        employee
WHERE       SUM(salary) > 9000000
GROUP BY    dept_id ;                           /*   <= 오류 나는거 맞음 */


----------------------------------------------------------------------
/*
--JOIN : ERD상에 관련이 없는 테이블도 조인 가능
ERD상 관련이 있는 테이블과의 조인 : 이퀄스 테이블 조인
ERD상 관련이 없는 테이블과의 조인 : 낫 이퀄스 테이블 조인
*/


SELECT      emp_name,
            dept_name
FROM        employee E, department D 
WHERE       E.dept_id = D.dept_id;


SELECT      *
FROM        sal_grade;

SELECT      *
FROM        employee;

SELECT      *
FROM        job;

SELECT      *
FROM        department;

SELECT      E.emp_name, 
            E.salary,
            S.slevel
FROM        employee E, sal_grade S
WHERE       E.salary BETWEEN S.lowest AND S.highest ;

SELECT      E.emp_name, 
            E.salary,
            S.slevel,
            J.job_title,
            D.dept_name
FROM        employee E, sal_grade S, job J, department D
WHERE       E.salary BETWEEN S.lowest AND S.highest 
AND         E.job_id = J.job_id 
AND         E.dept_id = D.dept_id ;
     

/*
USIING : 관계를 가진 테이블 사이의 조인(공통의 컬럼이 존재할때)
ON : 관계를 가지고 있지 않은 테이블 사이의 조인(공통의 컬럼이 존재하지 않을때)

LEFT / ROGHT / OUTER : 
CROSS JOIN : 

FROM    테이블1
JOIN    테이블2 USIING(동일한 칼럼이름)

FROM    테이블1
JOIN    테이블2 ON(결합하고자 하는 조건)
*/



SELECT      emp_name,
            dept_name
FROM        employee E
JOIN        department D USING(dept_id) ;

/*
ANSI JOIN : 오라클뿐만 아니라 SQL을 다루는 모든 프로그램에서 통용되는 조인 법칙
*/


SELECT      dept_name,
            loc_describe
FROM        location L
JOIN        department D ON(location_id = loc_id) ;

SELECT      emp_name, 
            salary,
            slevel
FROM        employee E
JOIN        sal_grade S ON(salary BETWEEN lowest AND highest) ;


SELECT      *
FROM        employee ;

SELECT      *
FROM        department ;

/* 오라클 OUTER JOIN */

SELECT      emp_name,
            dept_name,
            D.dept_id
FROM        department D, employee E
WHERE       D.dept_id(+) = E.dept_id ;   /* (+)의 반대쪽에 있는데이터가 모두 출력이됨! */
            
            
SELECT      emp_name,
            dept_name,
            D.dept_id
FROM        department D, employee E
WHERE       D.dept_id = E.dept_id(+) ;   /* (+)의 반대쪽에 있는데이터가 모두 출력이됨! */

/* 테이블 양쪽에 (+)를 붙이는 경우는 허용하지 않는다. */




/* ANSI OUTER JOIN */
/*      모두 출력하고자 하는 테이블의 반대 쪽을 적자
        오른쪽 테이블을 출력하고 싶다! : LEFT JOIN
        왼쪽 테이블을 출력하고 싶다! : RIGHT JOIN       */

/*
--LEFT JOIN
오른쪽 테이블을 다 출력해주세요
*/
SELECT      emp_name,
            dept_name,
            dept_id
FROM        department D
LEFT JOIN   employee E USING(dept_id) ;


/*
--RIGHT JOIN
왼쪽 테이블을 다 출력해주세요
*/
SELECT      emp_name,
            dept_name,
            dept_id
FROM        department D
RIGHT JOIN  employee E USING(dept_id) ;