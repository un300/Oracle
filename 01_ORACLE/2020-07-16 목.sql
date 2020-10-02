/*
ANSI JOIN!

USING은 테이블의 별칭을 사용할 수 없습니다
*/


/*
[INNER] JOIN : 그냥 JOIN만 쓴다면 INNER JOIN 임
*/

SELECT      emp_name, dept_name
FROM        employee
JOIN        department USING(dept_id)
WHERE       job_id = 'J6' ;

SELECT      emp_name , loc_id
FROM        employee2
JOIN        department USING(dept_id, loc_id) ;

SELECT      dept_name,
            loc_describe
FROM        department
JOIN        location ON(loc_id = location_id) ;


/*
LEFT / RIGHT / FULL [OUTER] JOIN : JOIN앞에 LEFT / RIGHT / FULL 붙여주면 OUTER JOIN
*/

SELECT      emp_name, dept_name
FROM        employee
FULL JOIN   department USING(dept_id) ;

SELECT      emp_name, dept_name
FROM        employee
LEFT JOIN   department USING(dept_id) ;

SELECT      emp_name, dept_name
FROM        employee
RIGHT JOIN  department USING(dept_id) ;



/*
Not Equiles Join
--ERD상에 관련이 없는 테이블끼리 JOIN할때, ON을 사용
근데 ON뒤에는 =(이퀄)이 아니라 조건이 오기 때문에 '낫 이퀄스 조인'이라고함
*/




/*
SELF JOIN
셀프 리커시브 릴레이션 조인
-- 자기 자신의 테이블을 조인하는 방법
자기 자신에 속하는 다른 칼럼을 비교 참조 하기 때문에 ON을 사용한다
*/

SELECT      E1.emp_name AS "직원",
            E2.emp_name AS "관리자"
FROM        employee E1
JOIN        employee E2 ON(E1.mgr_id = E2.emp_id)
ORDER BY    E1.emp_name ;

--위 결과는 15명의 직원이 출력됨

--모든 직원(22명)을 출력하려면?

SELECT      E1.emp_name AS "직원",
            E2.emp_name AS "관리자"
FROM        employee E1
LEFT JOIN   employee E2 ON(E1.mgr_id = E2.emp_id)
ORDER BY    E1.emp_name ;

-- 관리자의 관리자(임원)을 출력하세요

SELECT      E1.emp_name AS "직원",
            E2.emp_name AS "관리자",
            E3.emp_name AS "임원"
FROM        employee E1
JOIN        employee E2 ON(E1.mgr_id = E2.emp_id)
JOIN        employee E3 ON(E2.mgr_id = E3.emp_id)
ORDER BY    E1.emp_name ;


-- 위 결과를 모든 직원(22명)이 출력되도록 SQL구문을 작성 ㄱ

SELECT      E1.emp_name AS "직원",
            E2.emp_name AS "관리자",
            E3.emp_name AS "임원"
FROM        employee E1
LEFT JOIN   employee E2 ON(E1.mgr_id = E2.emp_id)
LEFT JOIN   employee E3 ON(E2.mgr_id = E3.emp_id)
ORDER BY    E1.emp_name ;





/*
강사님 문제 > 앞에 보이는 테이블을 출력하는 SQL구문 만들기
*/

SELECT      *
FROM        employee ;

SELECT      *
FROM        job ;

SELECT      *
FROM        department ; 

SELECT      emp_name,
            job_title,
            dept_name
FROM        employee E
JOIN        job J ON (E.job_id = J.job_id)      
JOIN        department D ON (E.dept_id = D.dept_id) ;





/*강사님 문제 > 앞에 보이는 테이블을 출력하는 SQL구문 만들기*/

/*
ERD상에서 관련이 있는 테이블부터 묶는 것이 정석임
관련이 없는 테이블 부터 묶게 되면 원하는 테이블이 나오지 않을 가능성이 농후
*/


/*
NULL 값이 포함된 데이터를 모두 출력해야 할때
> FULL JOIN으로 JOIN해나가면서 하나씩 LEFT / RIGHT 조인으로 바꾸어 본다.
*/

SELECT      C.country_name,
            L.loc_describe,
            D.dept_name,
            E.emp_name,
            J.job_title,
            S.slevel
FROM        country C
JOIN        location L          USING (country_id) 
JOIN        department D        ON (L.location_id = D.loc_id) 
RIGHT JOIN  employee E          USING (dept_id)
LEFT JOIN   job J               USING (job_id)
JOIN        sal_grade S         ON (E.salary BETWEEN S.lowest AND S.highest) 
ORDER BY    S.slevel ;



/*
조인된 테이블에서 조건된 레이블을 출력하고 싶을때
> 일반테이블에서 하던거 처럼 WHERE함수로 조건 추가하면 됨
*/

SELECT      emp_name,
            dept_name
FROM        employee
JOIN        job J           USING (job_id)
JOIN        department D    USING (dept_id)
JOIN        location L      ON(D.loc_id = L.location_id)
WHERE       job_title = '대리'
AND         loc_describe LIKE '아시아%' ;



/*
SET Operator
-두 개 이상의 퀴리 결과를 하나로 결합시키는 연산자
-SELECT 절에 기술하는 칼럼 개수와 데이터 타입은 모든 쿼리에서 동일해야 함
*/



/*
employee_role : 4건
role_history : 22건
*/


--UNION : 합집합(25건)
SELECT      emp_id,
            role_name
FROM        employee_role      
UNION
SELECT      emp_id,
            role_name
FROM        role_history;     


--UNION ALL : 중복이 허용된 합집합(26건)
SELECT      emp_id,
            role_name
FROM        employee_role      
UNION ALL
SELECT      emp_id,
            role_name
FROM        role_history;       


--INTERSECT : 교집합(1건)
SELECT      emp_id,
            role_name
FROM        employee_role      
INTERSECT
SELECT      emp_id,
            role_name
FROM        role_history;  


--MINUS : 차집합(21건)
SELECT      emp_id,
            role_name
FROM        employee_role      
MINUS
SELECT      emp_id,
            role_name
FROM        role_history;  


/*
위아래 SELECT 구문의 변수 개수를 같도록
*/

SELECT      emp_name ,
            job_id ,
            hire_date
FROM        employee
WHERE       dept_id = '20'
UNION
SELECT      dept_name,
            dept_id,
            NULL
FROM        department
WHERE       dept_id = '20' ;


/* 
위아래 SELECT 구문에서 변수의 형식은 같도록!
ORDER BY는 맨 밑에 작성
*/

SELECT      emp_name,
            salary
FROM        employee
WHERE       dept_id = '20'
UNION
SELECT      dept_name,
            TO_NUMBER(dept_id)
FROM        department
WHERE       dept_id = '20' 
ORDER BY    salary;




SELECT      emp_id,
            emp_name,
            '관리자' AS 구분
FROM        employee
WHERE       emp_id = '141'
AND         dept_id = '50'
UNION
SELECT      emp_id,
            emp_name,
            '직원' AS 구분
FROM        employee
WHERE       dept_id = '50'
AND         emp_id != '141' ;

/*
위 구문 DECODE 사용하기
*/

SELECT      emp_id,
            emp_name,
            DECODE(emp_id, '141', '관리자', '직원')
FROM        employee
WHERE       dept_id = '50'
UNION
SELECT      emp_id,
            emp_name,
            DECODE(emp_id, '141', '관리자', '직원')
FROM        employee
WHERE       dept_id = '50' ;


--------------------------------------------------------------------------------------------
SELECT      emp_name,
            job_title AS 직급
FROM        employee
JOIN        job USING (job_id)
WHERE       job_title IN ('대리', '사원')
ORDER BY    2, 1 ;


SELECT      emp_name, 
            '사원' AS 직급
FROM        employee
JOIN        job USING (job_id)
WHERE       job_title = '사원'
UNION
SELECT      emp_name,
            '대리'
FROM        employee
JOIN        job USING (job_id)
WHERE       job_title = '대리'
ORDER BY    2, 1 ;


-----------------------------------------------------------------------------------------
/*
서브쿼리 : 조건절에 사용되는 쿼리를 말함.

-단일 행 서브쿼리 : 서브쿼리에서 반환되는 행의 개수가 한 개 (단일 행 비교연산자 =, >=, <=, <> 사용가능)
-다중 행 서브쿼리 : 서브쿼리에서 반환되는 행의 개수가 두 개 이상 (다중 행 비교연산자 IN, ANY, ALL 사용가능)
>> 서브쿼리에 GROUP BY가 들어간다? : 다중행 서브쿼리임
*/



--단일 행 서브쿼리
SELECT      emp_name,
            job_id,
            salary
FROM        employee
WHERE       job_id = (  SELECT      JOB_ID
                        FROM        employee
                        WHERE       emp_name = '나승원')
AND         salary > (  SELECT      salary
                        FROM        employee
                        WHERE       emp_name = '나승원') ;



SELECT      emp_name,
            job_id,
            salary
FROM        employee
WHERE       salary = (SELECT    MIN(salary)
                      FROM      employee    ) ;
                      

SELECT      emp_name,
            job_id,
            salary
FROM        employee
WHERE       salary > (  SELECT  AVG(salary)
                        FROM    employee    ) ;
                      
SELECT      emp_name,
            job_id,
            salary
FROM        employee
WHERE       salary = (  SELECT  MAX(salary)
                        FROM    employee    ) ;


SELECT      dept_name,
            SUM(salary)
FROM        employee
LEFT JOIN   department USING (dept_id)
GROUP BY    dept_id, dept_name 
HAVING      SUM(salary) = ( SELECT      MAX(SUM(salary))
                            FROM        employee
                            GROUP BY    dept_id ) ;
                            


--다중 행 서브쿼리

SELECT      emp_id,
            emp_name,
            '관리자' AS 구분
FROM        employee
WHERE       emp_id IN (SELECT mgr_id FROM employee)
UNION
SELECT      emp_id,
            emp_name,
            '직원' AS 구분
FROM        employee
WHERE       emp_id NOT IN (SELECT   mgr_id FROM employee
                           WHERE    mgr_id IS NOT NULL)
ORDER BY    3, 1 ;


/*
employee 명단에서 각각의 임직원들이 직원인지 관리자인지 구분하라
*/


--CASE WHEN THEN 사용
SELECT      emp_id,
            emp_name,
            CASE
                WHEN emp_id IN (SELECT mgr_id FROM employee) THEN '관리자'
                ELSE '직원'
            END AS "구분"
FROM        employee 
ORDER BY    "구분", emp_id ;

--DECODE 사용
SELECT      emp_id,
            emp_name,
            DECODE(mgr_id, 
                        NULL , '관리자', 
                        '직원') AS "구분"
FROM        employee
ORDER BY    "구분", emp_id ;



/*
ANY

 > ANY (LIST) : (LIST)의 최소값 보다 큰 거
 < ANY (LIST) : (LIST)의 최대값 보다 작은 거

*/
 
SELECT      emp_name,
            salary
FROM        employee
JOIN        job USING(job_id)
WHERE       job_title = '대리'
AND         salary > ANY (SELECT    salary
                          FROM      employee
                          JOIN      job USING(job_id)
                          WHERE     job_title = '과장') ;
           
           
SELECT      emp_name,
            salary
FROM        employee
JOIN        job USING(job_id)
WHERE       job_title = '대리'
AND         salary < ANY (SELECT    salary
                          FROM      employee
                          JOIN      job USING(job_id)
                          WHERE     job_title = '과장') ;
                          
   
SELECT      E.emp_name,
            E.salary
FROM        employee E 
JOIN        job J USING(job_id)
WHERE       J.job_title = '대리' ;  
                          
                          
SELECT    salary
FROM      employee
JOIN      job USING(job_id)
WHERE     job_title = '과장';
                          
                          
                          

/* 
1. 직급별 평균급여를 구하라(계산의 편의를 위해 정수 5자리에서 절삭)
2. 평균급여 받는 사원의 이름, 직급, 급여를 조회하시오 !!
*/

-- 1.

SELECT      job_title AS "직급별",
            TRUNC(AVG(salary), -5) AS "평균급여"
FROM        employee 
JOIN        job J USING(job_id)
GROUP BY    J.job_title ;


-- 2. 다중 행, 다중 열 서브쿼리!
-- > 여러개의 행과 여러개의 열을 반환하는 서브쿼리

SELECT      E.emp_name AS "이름",
            J.job_title AS "직급",
            E.salary AS "급여"
FROM        employee E
JOIN        job J USING(job_id)
WHERE       (J.job_title, E.salary) IN (SELECT      J2.job_title,
                                                    TRUNC(AVG(E2.salary), -5)
                                        FROM        employee E2
                                        JOIN        job J2 USING(job_id)
                                        GROUP BY    J2.job_title )
ORDER BY    "직급", "이름" ;


/*
--인라인 뷰
FROM 절에 작성하는 서브쿼리를 '인라인 뷰'라함
*/

SELECT      E.emp_name AS "이름",
            J.job_title AS "직급",
            E.salary AS "월급"
FROM        ( SELECT     job_id,
                         TRUNC(AVG(salary), -5) AS job_avg
              FROM       employee
              GROUP BY   job_id ) V
JOIN        employee E ON( E.salary = V.job_avg AND E.job_id = V.job_id )
JOIN        job J ON(E.job_id = J.job_id)
ORDER BY    J.job_title ;
