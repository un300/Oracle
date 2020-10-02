
/*
DML(DATA MANIPULATION LANGUAGE)


*/



/*
UPDATE
-레코드를 수정하는 것, 그러므로 레코드의 수가 바뀌지 않는다.

UPDATE 테이블이름
SET 칼럼이름 = 갱신할 값
WHERE 조건

>>WHERE 적지 않으면 모든 레코드 값이 갱신되어버림

*/


UPDATE      department
SET         dept_name = '전략기획팀'  
WHERE       dept_id = '90';     

SELECT      *
FROM        department ;



/*
단일행 단일열 서브쿼리 사용
*/
UPDATE      employee
SET         job_id = (SELECT        job_id
                      FROM        employee
                      WHERE       emp_name = '성해교'),
            salary = (SELECT        job_id
                      FROM        employee
                      WHERE       emp_name = '성해교')
WHERE       emp_name = '심하균' ;


/*
단일행 다중열 서브쿼리 사용
*/

UPDATE      employee
SET         (job_id, salary) = (SELECT      job_id, salary
                                FROM        employee
                                WHERE       emp_name = '성해교')
WHERE       emp_name = '심하균';



SELECT      *
FROM        employee ;






/*
특정 값을 DEFAULT 값으로 갱신하고자 할 때 : DEFAULT 값을 입력하는 것이아니라 DEFAULT를 입력해야함
*/

SELECT      *
FROM        employee ;

UPDATE      employee
SET         marriage = DEFAULT    ---  <<< 'N'이 아니라 DEFAULT 입력
WHERE       emp_id = '210';

SELECT      *
FROM        employee ;



/*
WHERE 조건절에 서브쿼리를 사용
*/


SELECT      *
FROM        employee ;


UPDATE      employee
SET         bonus_pct = 0.3
WHERE       dept_id = (SELECT      dept_id
                       FROM        department
                       WHERE       dept_name = '해외영업2팀');


SELECT      bonus_pct, dept_id, dept_name
FROM        employee 
JOIN        department USING (dept_id)
WHERE       dept_name = '해외영업2팀';


/*
데이터의 무결성

부모의 기본키는 수정이 불가능하다.
또한, 부모의 기본키를 참조하는 자식테이블에서도 갱신이 불가능하다.
>> 데이터 무결성에 위반되어지기 때문이다


부모테이블에 존재하지 않는 값으로 자식 테이블의 갱신(삽입) 불가능하다.
부모테이블에 존재하지 않는 값으로 갱신(삽입)하려면 먼저 부모테이블의 PRIMARY KEY에 값을 추가해야한다.

*/


SELECT      *
FROM        department ;

SELECT      *
FROM        employee ;


UPDATE      employee
SET         dept_id = '65'
WHERE       dept_id IS NULL ;
-- >> dept_id는 부모테이블인 department 의 PRIMARY KEY이다.
--      이때, department의 dept_id에는 '65'라는 값이 없으므로
--      데이터 무결성에 위반된다!







/*
INSERT
INSERT INTO 테이블이름 [(칼럼1, 칼럼2, ....)]
VALUES (값1, 값2, ....);




*/



INSERT INTO employee (emp_id, emp_no, emp_name,  email, phone, hire_date, job_id, salary, bonus_pct, marriage, mgr_id, dept_id)
VALUES ('900', '811126-1484710', '오윤하', 'oyuh@vcc.com', '01012345678', '06/01/01', 'J7', 3000000, 0, 'N', '176', '90');


SELECT      *
FROM        employee ;

INSERT INTO employee
VALUES ('910', '이병언', '781010-1443269', 'TK1@VCC.COM', '01077886655', '04/01/01', 'J7', 3500000, 0.1, 'N', '176', '90');


SELECT      *
FROM        employee ;





/*
무결성

일반적으로 외래키 INSERT시에 부모태이블의 기본키에 있는 값이나 NULL값을 입력할 수 있다.
하지만, NULL값의 경우는 인덱스를 지정 할 수 없기 때문에 성능이 저하되는 현상을 초래 할 수 있음
그래서 현업에서는 외래키에 NULL값을 지정하지 않는 옵션을 지정함.
*/

/*
암시적(묵시적) NULL 입력 방법
> NULL값을 입력하고자 하는 칼럼을 명시하지 않고 입력함
*/

INSERT INTO employee (emp_id, emp_no, emp_name, phone, hire_date, job_id, salary, bonus_pct, marriage)
VALUES ('880', '860412-2377610', '한채연',  '0193382662', '06/01/01', 'J7', 3000000, 0, 'N');

SELECT      *
FROM        employee ;




/*
INSERT
명시적 NULL 입력 방법
*/


INSERT INTO employee
VALUES ('840', '하지언', '870115-2253408', 'ju_ha@vcc.com', NULL, '07/06/15', 'J7', NULL, NULL, 'N', '', '');

SELECT      *
FROM        employee ;


/*
INSERT
DEFAULT 값 입력
*/


INSERT INTO employee (emp_id, emp_no, emp_name, salary, marriage)
VALUES ('860', '810429-2165344', '선예진', DEFAULT, DEFAULT);

SELECT      *
FROM        employee 
WHERE       emp_name = '선예진';






/*
INSERT + 서브쿼리 사용

CREATE TABLE는 서브쿼리 사용시 AS를 사용하여야 하지만
INSERT는 AS를 쓰지 않는다.
*/

CREATE TABLE emp(
    emp_id          CHAR(3),
    emp_name        VARCHAR2(20),
    dept_name       VARCHAR2(20)
);


INSERT INTO emp(
    SELECT      emp_id, emp_name, dept_name
    FROM        employee
    LEFT JOIN   department USING (dept_id) 
);

SELECT      *
FROM        employee  ;


SELECT      *
FROM        employee 
LEFT JOIN   department USING (dept_id)
WHERE       dept_name IS NULL ;

SELECT      *
FROM        emp ;







/*
INSERT 참조 무결성
*/
INSERT INTO employee (emp_id, emp_no, emp_name, dept_id)
VALUES ('990', '810116-2154219', '김태휘', '45');  --  >> 부모테이블의 dept_id에 45라는 값이 없기에
                                                    --   참조 무결성이 발생함, 그러므로 에러!








/*
DELETE
>> 행(레코드)을 삭제해라 (열이아니다 ㅎ)


DELETE [FROM] (테이블명)
[WHERE 조건];

DROP TABLE >> 데이터 타입을 포함한 테이블 자체를 날려버리겠다임
DELETE는 데이터 타입을 두고(테이블의 구조를 남겨두고) 행(레이블)만 날린다

*/

DELETE FROM department
WHERE       loc_id NOT LIKE 'A%' ;
-- loc_id는 location 테이블의 country_id의 외래키임 (이름만 다를뿐)
-- 또한 department 테이블의 loc_id는 employee 테이블의 부모 역할을함
-- 그래서 참조무결성이 일어남!

SELECT      *
FROM        department ;






/*

TRUNCATE : 테이블의 구조를 두고 모든 레이블을 날린다..

- DELETE보다 수행속도가 빠르다.
- 테이블 전체 데이터를 삭제하는 경우에만 사용 가능.
- 롤백이 불가능 하다!!!!!!!
- 제약조건이 있는 경우 사용 불가함

*/



DELETE FROM job
WHERE job_id = 'J2' ;


DELETE FROM employee
WHERE emp_id = '141'; 
--  이것도 참조무결성에 위배됨
--  emp_id는 자기자신 테이블에 mgr_id로 셀프 리커시브로 참조가되어 있음
--  그러므로 참조 무결성!










/*
트렌젝션
> 데이터의 일관성을 유지시키려는 목적으로 사용하는 논리적으로 연관된 작업들의 집합
*/

/*
트랜젝션 시작
첫번째 MDL 구문이 실행될 때 시작됨

드랜젝션 종료
- COMMIT, ROLLBACK 명령이 실행될때 종료
- DDL 구문이 실행되면 자동으로 COMMIT (Auto COMMIT)  >>>  주의하세요!!!!!!!!!! 롤백이 안됨 ㅠㅠ..


*/




/*

SAVEPOINT 세이브포인트이름1;
ROLLBACK TO 세이브포인트이름1;
*/





/*
락인

사용자 1이 A데이터 셋트에 접근중일때 (UPDATE, DELETE 등..) 나머지 사용자2, 사용자3,... 등은 A데이터 셋에
접근하지 못한다.
만약 사용자1이 데이터셋 A를 사용중일때 다른 사용자가 UPDATE, DELETE를 한다면,,
작동이 멈추고
사용자1이 ROLLBACK이나 COMMIT을 시행하게되면, 다른 사용자의 UPDATE, DELETE가 실행된다

이것을 락인이라고 함
*/




