/*
DDL(Data Definition Language)
테이블을 만드는 문법


*/


/*
테이블 생성 - naming rule
*/

CREATE TABLE test(
id     NUMBER(5),
name   CHAR(10),
address VARCHAR2(50)
);

SELECT      id, 
            name, 
            address
FROM        test;


/*
-테이블의 제약조건
NOT NULL : 널값을 포함하지 않음
UNIQUE : 값이 유일하도록
PRIMARY KEY : 각 행을 유일하게 식별할 수 있도록
REFERENCES TABLE(칼럼 이름) : 해당 칼럼이 참조하고 있는 테이블의 특정 칼럼 값들과 일치하거나 NULL 이되도록 보장함
CHECK : 해당 칼럼에 특정 조건을 항상 만족시키도록 함 (예 : 성별 칼럼이라면 '남', '여'만 입력되도록!)
*/


/*
CONSTRINT 절에 제약조건을 한번에 입력하는 방법도 있음
BUT... NOT NULL 조건은 CONSTRAINT 절에서 사용불가함
NOT NULL은 변수 뒤에서 선언해 주어야함
*/

/*
제약조건 - NOT NULL 사용 예
*/

CREATE TABLE table_notnull(
id     CHAR(3) NOT NULL,
sname  VARCHAR(20)
);
 
INSERT INTO table_notnull
VALUES('100', 'ORACLE');

INSERT INTO table_notnull
VALUES(NULL, 'MY_SQL');

SELECT      *
FROM        table_notnull ;

--주의!
/*
NOTNULL 제약조건은 CONSTRAINT 절에서 사용할 수 없음
*/
CREATE TABLE table_notnull(
id     CHAR(3),
sname  VARCHAR(20),
CONSTRAINT TN2_ID_NN NOT NULL(id)
);  --오류뜨는게 정상이에요
 



/*
PRIMARY KEY : UNIQUE + NOT NULL
*/


/*
잠깐! 변수이름을 만드는 여러방법
Pascal case : StudentEntity   > 클레스 정의할 때
Camel case : numberOfGrade   > 함수 정의할 때
Snake case : service_number_tbl   > 변수 정의할 때
*/

CREATE TABLE StudentEntity(
    ssn         VARCHAR2(50)    PRIMARY KEY,
    name        VARCHAR2(20)    NOT NULL,
    gender      CHAR(1),
    address     VARCHAR2(50),
    job         VARCHAR2(100)
);



--DML : 데이터조작어

/*
1. INSERT
*/

INSERT INTO 테이블명 ([칼럼지정, 칼럼, ...])
VALUES(값, 값, ....) ;


INSERT INTO StudentEntity
VALUES('830910-1XXXXXX', '섭섭해', 'M', 'SEOUL', 'INSTRUCTOR') ;


--명시적 null 삽입법
INSERT INTO StudentEntity 
VALUES(NULL, '섭섭해', 'M', 'SEOUL', 'INSTRUCTOR') ;


--묵시적 null 삽입법
INSERT INTO StudentEntity(name, gender, address, job)
VALUES('섭섭해', 'M', 'SEOUL', 'INSTRUCTOR') ;

--글자수가 달라도 입력이 안됨
INSERT INTO StudentEntity
VALUES('830910-1XXXXXX', '섭섭해', 'MALE', 'SEOUL', 'INSTRUCTOR') ;


SELECT      *
FROM        StudentEntity ;


DROP TABLE StudentEntity;

/*
 2. PRIMARY KEY
*/

--컴포짓 프라이머리 키 : 두개의칼럼을 조합한 기본키

CREATE TABLE StudentEntity(
    ssn         VARCHAR2(50),
    name        VARCHAR2(20),
    gender      CHAR(1),
    asddress    VARCHAR2(50),
    job         VARCHAR2(100),
    PRIMARY KEY(ssn, name)
) ;

INSERT INTO StudentEntity
VALUES('830910-1XXXXXX', '섭섭해', 'M', 'SEOUL', 'INSTRUCTOR') ;

INSERT INTO StudentEntity
VALUES('830910-2XXXXXX', '임섭순', 'M', 'SEOUL', 'INSTRUCTOR') ;

SELECT      *
FROM        StudentEntity ;



/*
3. FORIGN KEY : 외래키 (다른 테이블을 REFERRENCES를 통해 참조해야함)
외래키를 참조할 때는 참조하고자 하는 테이블의 기본키를 참조해야한다!
*/

CREATE TABLE table_fk(
    id      CHAR(3),
    sname   VARCHAR2(20),
    lid     CHAR(2) REFERENCES location (location_id) 
) ;

--위와 밑은 동일한 구문임

CREATE TABLE table_fk(
    id      CHAR(3),
    sname   VARCHAR2(20),
    lid     CHAR(2),
    FOREIGN KEY (lid) REFERENCES location (location_id)
) ;



INSERT INTO table_fk
VALUES ('200', 'ORACLE', 'A1');

INSERT INTO table_fk
VALUES ('224', 'R', 'A2');

INSERT INTO table_fk
VALUES ('212', 'PYTHON', 'A3');

INSERT INTO table_fk
VALUES ('250', 'ORACLE', NULL) ;

INSERT INTO table_fk
VALUES ('250', 'ORACLE', 'C1') ;   -- 'C1' 같은 경우는 location테이블의 location_id에는 없는 범주이다
                                    -- 그러므로 삽입이 안된다.

SELECT      *
FROM        table_fk ;

SELECT      *
FROM        table_fk T
JOIN        location L ON (T.lid = L.location_id) ; 




/*
컴포짓 프라이머리 키 참조하기.
*/

CREATE TABLE StudentEntity(
    ssn         VARCHAR2(50),
    name        VARCHAR2(20),
    gender      CHAR(1),
    asddress    VARCHAR2(50),
    job         VARCHAR2(100),
    PRIMARY KEY(ssn, name)
) ;

CREATE TABLE StudentEntitySub(
    phone       VARCHAR2(13)    PRIMARY KEY,
    major       VARCHAR2(50),
    ssn         VARCHAR2(50),
    name        VARCHAR2(20),
    FOREIGN KEY (ssn, name) REFERENCES StudentEntity (ssn, name) 
);

INSERT INTO StudentEntity
VALUES ('940806-1XXXXXX', '아무게', 'M', '서울특별시 관악구 행운동', '백수');

INSERT INTO StudentEntitySub
VALUES ('010-4148-2833', 'stat', '940806-1XXXXXX', '아무게') ;

SELECT      *
FROM        StudentEntitySub ;

SELECT      *
FROM        StudentEntity ;



/*
테이블이 참조가 되어있는 상태일 때, 즉 부모 테이블과 자식테이블이 존재할 때
부모 테이블은 지울 수 없음
*/
DROP TABLE StudentEntity ;

/*
그래서 자식 테이블에서 부모테이블을 참조할 때 DELETE옵션을 통해서 삭제옵션을 따로 둘수 있음
BUT 디폴트 값이 삭제가 안되는 것이기에 DELETE옵션을 두는것은 추천하지 않음
*/








/*
4. CHECK : 지정한 데이터 타입만을 입력하세요
*/

CREATE TABLE table_check(
    emp_id      CHAR(3)     PRIMARY KEY,
    salary      NUMBER      CHECK (salary > 0),
    marriage    CHAR(1),
    CONSTRAINT  chk_mrg     CHECK ( marriage IN ('Y', 'N'))
);

INSERT INTO table_check
VALUES ('100', 500, 'Y') ;

INSERT INTO table_check
VALUES ('100', -100, 'Y') ;

INSERT INTO table_check
VALUES ('100', 500, '?') ;

SELECT      *
FROM        table_check ;


/*
SYSDATE 같은 경우 : 매시간마다 값이 변함
>> 이런 값은 CHECK 제약조건을 사용할 수 없음
*/

CREATE TABLE student(
    stu_id  NUMBER  PRIMARY KEY
);

CREATE TABLE subject(
    subject_id  NUMBER PRIMARY KEY
);

CREATE TABLE enroll(
    stu_id REFERENCES student (stu_id),
    subject_id REFERENCES subject (subject_id),
    PRIMARY KEY (stu_id, subject_id)
);






/*
서브쿼리를 활용한 테이블 생성 구문
*/


CREATE TABLE table_subquery2 (eid, ename, salary, dname, jtitle)
AS  SELECT      emp_id, emp_name, salary, dept_name, job_title
    FROM        employee
    LEFT JOIN   department USING (dept_id)
    LEFT JOIN   job USING (job_id) ;
    
SELECT      *
FROM        table_subquery2 ; 




/*
ALTER TABLE 테이블 명
ADD 칼럼을 추가하거나 새로운 제약조건을 추가
MODIFY 칼럼내용을 수정
DROP 칼럼을 제거
RENANE 칼럼 이름을 수정
*/

--PDF파일보고 공부하세요

CASCADE CONSTRAINTS






/*
뷰 : 물리적인 메모리 공간을 가지지 않는 것을 뜻함 EX) FROM절에 서브쿼리 쓰는것을 인라인뷰라고함
        논리적인 구조
    >>> 즉, 읽기 전용
    >>> 멀티 테이블에서 만들어진 뷰는 입력, 수정, 삭제 불가능함
*/

/*
뷰의 개념 
보안적인 측면에서 특정 칼럼(주민번호)를 제외하여 보여줄 수 있음
*/




CREATE [or REPLACE] VIEW 테이블이름
AS (서브쿼리) ;     --논리적인 구조를 만듬 (테이블을 물리적으로 저장하지 않음)

CREATE TABLE 테이블이름 (칼럼1, 칼럼2 ...)
AS (서브쿼리) ;      --물리적인 테이블을 만듬(만든 테이블을 물리적으로 저장함)





CREATE VIEW v_emp
AS SELECT   emp_name, dept_id
    FROM    employee
    WHERE   dept_id = '90' ;
    
SELECT      *
FROM        v_emp ; 




CREATE OR REPLACE VIEW v_emp_dept_job
AS  SELECT      emp_name,
                dept_name,
                job_title
    FROM        employee
    LEFT JOIN   department USING (dept_id)
    LEFT JOIN   job USING (job_id)
    WHERE       job_title = '사원' ;


SELECT      *
FROM        v_emp_dept_job ;


CREATE OR REPLACE VIEW v_emp AS
SELECT      emp_name,
            DECODE(SUBSTR(emp_no, 8, 1), '1', '남자', '3', '남자', '여자'),
            ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)/12, 0)
FROM        employee ;



/*
VIEW의 칼럼 명
--VIEW에서 함수를 사용하여 칼럼을 만든다면, 칼럼이름을 꼭 지정해주어야함
안그러면 오류난당 ㅠ
*/

CREATE OR REPLACE VIEW v_emp AS
SELECT      emp_name,
            DECODE(SUBSTR(emp_no, 8, 1), '1', '남자', '3', '남자', '여자'),
            ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)/12, 0)
FROM        employee ;   --오류날꺼임

CREATE OR REPLACE VIEW v_emp ("Enm", "Gender", "Years") AS
SELECT      emp_name,
            DECODE(SUBSTR(emp_no, 8, 1), '1', '남자', '3', '남자', '여자'),
            ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)/12, 0)
FROM        employee ;


/*
뷰 삭제
DROP VIEW
*/




/*
인라인 뷰 개념
*/


CREATE OR REPLACE VIEW v_dept_salavg("did", "davg") AS
SELECT      NVL(dept_id, 'N/A'),
            ROUND(AVG(salary), -3)
FROM        employee
GROUP BY    dept_id ;

SELECT      emp_name,
            salary
FROM        employee
JOIN        v_dept_salavg ON (NVL(dept_id, 'N/A') = "did")
WHERE       salary > "davg"
ORDER BY    2 DESC;





/*
*******************많이 어렵다..********************

인라인뷰를 활용한
TOP N개
*/

SELECT      ROWNUM, emp_name, salary
FROM        (SELECT     NVL(dept_id, 'N/A') AS "did",
                        ROUND(AVG(salary), -3) AS "davg"
             FROM       employee
             GROUP BY   dept_id) INLV
JOIN        employee ON (NVL(dept_id, 'N/A') = INLV."did")
WHERE       salary > INLV."davg"
AND         ROWNUM <= 5;   ---이렇게 하면 원하는 것처럼 TOP 5못뽑음 


/*
그럼 어떻게??

인라인뷰로 전체 salary를 정렬하고,
select를 활용해서 rownum을 부여하여 top n개를 추출해 낼 수 있다.
*/


SELECT      ROWNUM, emp_name, salary
FROM        (SELECT     ROWNUM, emp_name, salary
             FROM       (SELECT     NVL(dept_id, 'N/A') AS "did",
                                    ROUND(AVG(salary), -3) AS "davg"
                         FROM       employee
                         GROUP BY   dept_id) INLV
             JOIN        employee ON (NVL(dept_id, 'N/A') = INLV."did")
             WHERE       salary > INLV."davg"
             ORDER BY    salary DESC)
WHERE       ROWNUM <= 5;





/*
시퀀스 SEQUENCE
> 중복되는 값을 넘기지 않기 때문에 기본키를 만드는 용도로 사용된다
ex) 게시판에 글을 남길때 글번호를 부여해야 한다.
이때, NEXTVAL을 이용하여 글번호를 부여한다.
*/


CREATE SEQUENCE test_seq ;
-- NEXTVAL
-- CURRVAL
SELECT  test_seq.NEXTVAL    --중복되는 값을 제외하고 출력
FROM    DUAL ;

SELECT  test_seq.CURRVAL    --현재 값을 출력 
FROM    DUAL ;



/*
시퀀스 옵션
*/

-------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------


/*
결합하는 테이블의 순서가 중요함. 

-NESTED LOOP JOIN
> 레이블의 크기가 작은 테이블 부터 조인을 시작, 그래야 빠름
> 인덱스가 반드시 있어야함 , 그래야 빠름
*/


/*
코릴레이선 서브쿼리
*/



/*
셀렉트 리스트 스칼라 서브쿼리
*/





















