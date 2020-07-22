SELECT *
FROM employee;

-- Singleline comment
/*
Multiline comment
*/


SELECT *
FROM   sal_grade;

SELECT slevel
FROM   sal_grade;

SELECT lowest, 
       highest
FROM   sal_grade;


---가독성! 밑에꺼는 가독성이 없음. 현업에가면 사수가 뭐라 할꺼임 ㅎ;
SELECT job_id,
       job_title,
       min_sal,
       max_sal
FROM   job ;

SELECT *
FROM   job ;

--------------------------------------------------------------------

--기본키
SELECT job_id
FROM   job ;

--외래키
SELECT job_id
FROM   employee ;


--------------------------------------------------------------------

SELECT *
FROM   department ;

SELECT job_id, 
       dept_id
FROM   employee ;

------------------------------------------------------------------
-- 파생변수와 변수의 가칭(AS)
SELECT emp_name,
       salary * 12,
       (salary + (salary * bonus_pct)) * 12
FROM   employee ;

SELECT emp_name AS "이름",
       salary * 12 AS "1년 급여",
       (salary + (salary*bonus_pct)) * 12 AS "총 소득"
FROM   employee ;

SELECT emp_name "이름",
       salary * 12 "1년 급여",
       (salary + (salary * bonus_pct)) * 12 "총 소득(원)"
FROM   employee ;

-------------------------------------SELECT 리터럴
SELECT emp_id,
       emp_name,
       '재직' AS 근무여부
FROM   employee ;


SELECT  emp_id,
        emp_name
FROM    employee ;


---------------------------------SELECT DISTINCT
SELECT DISTINCT dept_id
FROM   employee ;

SELECT DISTINCT job_id, dept_id
FROM   employee ;

SELECT DISTINCT job_id
FROM   employee ;



--------------------------WHERE
SELECT  *
FROM    employee
WHERE   dept_id = 90 AND salary >= 5500000 ;


----- 사원테이블에서 90번 부서나 20번 부서에 소속된 사원의 이름, 부서코드, 급여를 조회하세요.
----- 논리합 OR 연산자 사용

SELECT  emp_name AS "이름",
        dept_id AS "부서코드",
        salary AS "급여"
FROM    employee
WHERE   dept_id='20'
OR      dept_id='90'
AND     salary >= 3000000;

-----연산자(AND, OR)의 우선순위 : AND가 OR보다 우선임
-- 근데 그런거 따지지말고 괄호쳐서 연산자의 우선순위를 정해주면 됨 ㅎ
-- 연산자의 우선순위... 중요하지 않다! -20년 강사님 피셜

SELECT  emp_name AS "이름",
        dept_id AS "부서코드",
        salary AS "급여"
FROM    employee
WHERE   (dept_id='90' OR dept_id='20')
AND     salary >= 3000000;


---------------------연결 연산자 (||)
--칼럼과 칼럼을 연결한 경우
SELECT emp_id || emp_name || salary
FROM   employee;


--칼럼과 리터럴을 연결한 경우
SELECT emp_name || '의 월급은' || salary || '원 입니다.' AS 급여
FROM   employee;

----------------------논리 연산자

SELECT emp_name,
       salary
FROM employee
WHERE salary BETWEEN 3500000 AND 5500000;

SELECT emp_name,
       salary
FROM   employee
WHERE  salary >= 3500000
AND    salary <= 5500000;

--- LIKE 구문
SELECT emp_name, salary
FROM   employee
WHERE  emp_name LIKE '김%';

SELECT emp_name, phone
FROM   employee
WHERE  phone LIKE '___9_______';


---- ESCAPE : 참조할 데이터가 '_'이 포함된 문자라면! 자릿수를 나타내는 '_'과 참조를 할 문장인 '_'이 겹침
--              그래서 자릿수 '_'이랑 잠조할 '_'를 분리
SELECT emp_name,
       email
FROM   employee
WHERE  email LIKE '___\_%' ESCAPE '\' ;


------- NOT
SELECT emp_name,
       salary
FROM   employee
WHERE  emp_name NOT LIKE '김%';

SELECT emp_name,
       salary
FROM   employee
WHERE  NOT emp_name LIKE '김%';

---- IS NULL : NULL 값만 뽑아내
SELECT emp_name, mgr_id, dept_id
FROM   employee
WHERE  mgr_id IS NULL
AND    dept_id IS NULL;

SELECT emp_name, dept_id, bonus_pct
FROM   employee
WHERE  dept_id IS NULL
AND    bonus_pct IS NOT NULL;

SELECT emp_name "이름",
       salary * 12 "1년 급여",
       (salary + (salary * bonus_pct)) * 12 "총 소득(원)"
FROM   employee
WHERE  bonus_pct IS NOT NULL ;















