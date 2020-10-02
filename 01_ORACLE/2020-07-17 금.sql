/*
DDL(Data Definition Language)
���̺��� ����� ����


*/


/*
���̺� ���� - naming rule
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
-���̺��� ��������
NOT NULL : �ΰ��� �������� ����
UNIQUE : ���� �����ϵ���
PRIMARY KEY : �� ���� �����ϰ� �ĺ��� �� �ֵ���
REFERENCES TABLE(Į�� �̸�) : �ش� Į���� �����ϰ� �ִ� ���̺��� Ư�� Į�� ����� ��ġ�ϰų� NULL �̵ǵ��� ������
CHECK : �ش� Į���� Ư�� ������ �׻� ������Ű���� �� (�� : ���� Į���̶�� '��', '��'�� �Էµǵ���!)
*/


/*
CONSTRINT ���� ���������� �ѹ��� �Է��ϴ� ����� ����
BUT... NOT NULL ������ CONSTRAINT ������ ���Ұ���
NOT NULL�� ���� �ڿ��� ������ �־����
*/

/*
�������� - NOT NULL ��� ��
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

--����!
/*
NOTNULL ���������� CONSTRAINT ������ ����� �� ����
*/
CREATE TABLE table_notnull(
id     CHAR(3),
sname  VARCHAR(20),
CONSTRAINT TN2_ID_NN NOT NULL(id)
);  --�����ߴ°� �����̿���
 



/*
PRIMARY KEY : UNIQUE + NOT NULL
*/


/*
���! �����̸��� ����� �������
Pascal case : StudentEntity   > Ŭ���� ������ ��
Camel case : numberOfGrade   > �Լ� ������ ��
Snake case : service_number_tbl   > ���� ������ ��
*/

CREATE TABLE StudentEntity(
    ssn         VARCHAR2(50)    PRIMARY KEY,
    name        VARCHAR2(20)    NOT NULL,
    gender      CHAR(1),
    address     VARCHAR2(50),
    job         VARCHAR2(100)
);



--DML : ���������۾�

/*
1. INSERT
*/

INSERT INTO ���̺�� ([Į������, Į��, ...])
VALUES(��, ��, ....) ;


INSERT INTO StudentEntity
VALUES('830910-1XXXXXX', '������', 'M', 'SEOUL', 'INSTRUCTOR') ;


--����� null ���Թ�
INSERT INTO StudentEntity 
VALUES(NULL, '������', 'M', 'SEOUL', 'INSTRUCTOR') ;


--������ null ���Թ�
INSERT INTO StudentEntity(name, gender, address, job)
VALUES('������', 'M', 'SEOUL', 'INSTRUCTOR') ;

--���ڼ��� �޶� �Է��� �ȵ�
INSERT INTO StudentEntity
VALUES('830910-1XXXXXX', '������', 'MALE', 'SEOUL', 'INSTRUCTOR') ;


SELECT      *
FROM        StudentEntity ;


DROP TABLE StudentEntity;

/*
 2. PRIMARY KEY
*/

--������ �����̸Ӹ� Ű : �ΰ���Į���� ������ �⺻Ű

CREATE TABLE StudentEntity(
    ssn         VARCHAR2(50),
    name        VARCHAR2(20),
    gender      CHAR(1),
    asddress    VARCHAR2(50),
    job         VARCHAR2(100),
    PRIMARY KEY(ssn, name)
) ;

INSERT INTO StudentEntity
VALUES('830910-1XXXXXX', '������', 'M', 'SEOUL', 'INSTRUCTOR') ;

INSERT INTO StudentEntity
VALUES('830910-2XXXXXX', '�Ӽ���', 'M', 'SEOUL', 'INSTRUCTOR') ;

SELECT      *
FROM        StudentEntity ;



/*
3. FORIGN KEY : �ܷ�Ű (�ٸ� ���̺��� REFERRENCES�� ���� �����ؾ���)
�ܷ�Ű�� ������ ���� �����ϰ��� �ϴ� ���̺��� �⺻Ű�� �����ؾ��Ѵ�!
*/

CREATE TABLE table_fk(
    id      CHAR(3),
    sname   VARCHAR2(20),
    lid     CHAR(2) REFERENCES location (location_id) 
) ;

--���� ���� ������ ������

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
VALUES ('250', 'ORACLE', 'C1') ;   -- 'C1' ���� ���� location���̺��� location_id���� ���� �����̴�
                                    -- �׷��Ƿ� ������ �ȵȴ�.

SELECT      *
FROM        table_fk ;

SELECT      *
FROM        table_fk T
JOIN        location L ON (T.lid = L.location_id) ; 




/*
������ �����̸Ӹ� Ű �����ϱ�.
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
VALUES ('940806-1XXXXXX', '�ƹ���', 'M', '����Ư���� ���Ǳ� ��', '���');

INSERT INTO StudentEntitySub
VALUES ('010-4148-2833', 'stat', '940806-1XXXXXX', '�ƹ���') ;

SELECT      *
FROM        StudentEntitySub ;

SELECT      *
FROM        StudentEntity ;



/*
���̺��� ������ �Ǿ��ִ� ������ ��, �� �θ� ���̺�� �ڽ����̺��� ������ ��
�θ� ���̺��� ���� �� ����
*/
DROP TABLE StudentEntity ;

/*
�׷��� �ڽ� ���̺��� �θ����̺��� ������ �� DELETE�ɼ��� ���ؼ� �����ɼ��� ���� �Ѽ� ����
BUT ����Ʈ ���� ������ �ȵǴ� ���̱⿡ DELETE�ɼ��� �δ°��� ��õ���� ����
*/








/*
4. CHECK : ������ ������ Ÿ�Ը��� �Է��ϼ���
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
SYSDATE ���� ��� : �Žð����� ���� ����
>> �̷� ���� CHECK ���������� ����� �� ����
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
���������� Ȱ���� ���̺� ���� ����
*/


CREATE TABLE table_subquery2 (eid, ename, salary, dname, jtitle)
AS  SELECT      emp_id, emp_name, salary, dept_name, job_title
    FROM        employee
    LEFT JOIN   department USING (dept_id)
    LEFT JOIN   job USING (job_id) ;
    
SELECT      *
FROM        table_subquery2 ; 




/*
ALTER TABLE ���̺� ��
ADD Į���� �߰��ϰų� ���ο� ���������� �߰�
MODIFY Į�������� ����
DROP Į���� ����
RENANE Į�� �̸��� ����
*/

--PDF���Ϻ��� �����ϼ���

CASCADE CONSTRAINTS






/*
�� : �������� �޸� ������ ������ �ʴ� ���� ���� EX) FROM���� �������� ���°��� �ζ��κ�����
        ������ ����
    >>> ��, �б� ����
    >>> ��Ƽ ���̺��� ������� ��� �Է�, ����, ���� �Ұ�����
*/

/*
���� ���� 
�������� ���鿡�� Ư�� Į��(�ֹι�ȣ)�� �����Ͽ� ������ �� ����
*/




CREATE [or REPLACE] VIEW ���̺��̸�
AS (��������) ;     --������ ������ ���� (���̺��� ���������� �������� ����)

CREATE TABLE ���̺��̸� (Į��1, Į��2 ...)
AS (��������) ;      --�������� ���̺��� ����(���� ���̺��� ���������� ������)





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
    WHERE       job_title = '���' ;


SELECT      *
FROM        v_emp_dept_job ;


CREATE OR REPLACE VIEW v_emp AS
SELECT      emp_name,
            DECODE(SUBSTR(emp_no, 8, 1), '1', '����', '3', '����', '����'),
            ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)/12, 0)
FROM        employee ;



/*
VIEW�� Į�� ��
--VIEW���� �Լ��� ����Ͽ� Į���� ����ٸ�, Į���̸��� �� �������־����
�ȱ׷��� �������� ��
*/

CREATE OR REPLACE VIEW v_emp AS
SELECT      emp_name,
            DECODE(SUBSTR(emp_no, 8, 1), '1', '����', '3', '����', '����'),
            ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)/12, 0)
FROM        employee ;   --����������

CREATE OR REPLACE VIEW v_emp ("Enm", "Gender", "Years") AS
SELECT      emp_name,
            DECODE(SUBSTR(emp_no, 8, 1), '1', '����', '3', '����', '����'),
            ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)/12, 0)
FROM        employee ;


/*
�� ����
DROP VIEW
*/




/*
�ζ��� �� ����
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
*******************���� ��ƴ�..********************

�ζ��κ並 Ȱ����
TOP N��
*/

SELECT      ROWNUM, emp_name, salary
FROM        (SELECT     NVL(dept_id, 'N/A') AS "did",
                        ROUND(AVG(salary), -3) AS "davg"
             FROM       employee
             GROUP BY   dept_id) INLV
JOIN        employee ON (NVL(dept_id, 'N/A') = INLV."did")
WHERE       salary > INLV."davg"
AND         ROWNUM <= 5;   ---�̷��� �ϸ� ���ϴ� ��ó�� TOP 5������ 


/*
�׷� ���??

�ζ��κ�� ��ü salary�� �����ϰ�,
select�� Ȱ���ؼ� rownum�� �ο��Ͽ� top n���� ������ �� �� �ִ�.
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
������ SEQUENCE
> �ߺ��Ǵ� ���� �ѱ��� �ʱ� ������ �⺻Ű�� ����� �뵵�� ���ȴ�
ex) �Խ��ǿ� ���� ���涧 �۹�ȣ�� �ο��ؾ� �Ѵ�.
�̶�, NEXTVAL�� �̿��Ͽ� �۹�ȣ�� �ο��Ѵ�.
*/


CREATE SEQUENCE test_seq ;
-- NEXTVAL
-- CURRVAL
SELECT  test_seq.NEXTVAL    --�ߺ��Ǵ� ���� �����ϰ� ���
FROM    DUAL ;

SELECT  test_seq.CURRVAL    --���� ���� ��� 
FROM    DUAL ;



/*
������ �ɼ�
*/

-------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------


/*
�����ϴ� ���̺��� ������ �߿���. 

-NESTED LOOP JOIN
> ���̺��� ũ�Ⱑ ���� ���̺� ���� ������ ����, �׷��� ����
> �ε����� �ݵ�� �־���� , �׷��� ����
*/


/*
�ڸ����̼� ��������
*/



/*
����Ʈ ����Ʈ ��Į�� ��������
*/





















