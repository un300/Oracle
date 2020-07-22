
/*
DML(DATA MANIPULATION LANGUAGE)


*/



/*
UPDATE
-���ڵ带 �����ϴ� ��, �׷��Ƿ� ���ڵ��� ���� �ٲ��� �ʴ´�.

UPDATE ���̺��̸�
SET Į���̸� = ������ ��
WHERE ����

>>WHERE ���� ������ ��� ���ڵ� ���� ���ŵǾ����

*/


UPDATE      department
SET         dept_name = '������ȹ��'  
WHERE       dept_id = '90';     

SELECT      *
FROM        department ;



/*
������ ���Ͽ� �������� ���
*/
UPDATE      employee
SET         job_id = (SELECT        job_id
                      FROM        employee
                      WHERE       emp_name = '���ر�'),
            salary = (SELECT        job_id
                      FROM        employee
                      WHERE       emp_name = '���ر�')
WHERE       emp_name = '���ϱ�' ;


/*
������ ���߿� �������� ���
*/

UPDATE      employee
SET         (job_id, salary) = (SELECT      job_id, salary
                                FROM        employee
                                WHERE       emp_name = '���ر�')
WHERE       emp_name = '���ϱ�';



SELECT      *
FROM        employee ;






/*
Ư�� ���� DEFAULT ������ �����ϰ��� �� �� : DEFAULT ���� �Է��ϴ� ���̾ƴ϶� DEFAULT�� �Է��ؾ���
*/

SELECT      *
FROM        employee ;

UPDATE      employee
SET         marriage = DEFAULT    ---  <<< 'N'�� �ƴ϶� DEFAULT �Է�
WHERE       emp_id = '210';

SELECT      *
FROM        employee ;



/*
WHERE �������� ���������� ���
*/


SELECT      *
FROM        employee ;


UPDATE      employee
SET         bonus_pct = 0.3
WHERE       dept_id = (SELECT      dept_id
                       FROM        department
                       WHERE       dept_name = '�ؿܿ���2��');


SELECT      bonus_pct, dept_id, dept_name
FROM        employee 
JOIN        department USING (dept_id)
WHERE       dept_name = '�ؿܿ���2��';


/*
�������� ���Ἲ

�θ��� �⺻Ű�� ������ �Ұ����ϴ�.
����, �θ��� �⺻Ű�� �����ϴ� �ڽ����̺����� ������ �Ұ����ϴ�.
>> ������ ���Ἲ�� ���ݵǾ����� �����̴�


�θ����̺� �������� �ʴ� ������ �ڽ� ���̺��� ����(����) �Ұ����ϴ�.
�θ����̺� �������� �ʴ� ������ ����(����)�Ϸ��� ���� �θ����̺��� PRIMARY KEY�� ���� �߰��ؾ��Ѵ�.

*/


SELECT      *
FROM        department ;

SELECT      *
FROM        employee ;


UPDATE      employee
SET         dept_id = '65'
WHERE       dept_id IS NULL ;
-- >> dept_id�� �θ����̺��� department �� PRIMARY KEY�̴�.
--      �̶�, department�� dept_id���� '65'��� ���� �����Ƿ�
--      ������ ���Ἲ�� ���ݵȴ�!







/*
INSERT
INSERT INTO ���̺��̸� [(Į��1, Į��2, ....)]
VALUES (��1, ��2, ....);




*/



INSERT INTO employee (emp_id, emp_no, emp_name,  email, phone, hire_date, job_id, salary, bonus_pct, marriage, mgr_id, dept_id)
VALUES ('900', '811126-1484710', '������', 'oyuh@vcc.com', '01012345678', '06/01/01', 'J7', 3000000, 0, 'N', '176', '90');


SELECT      *
FROM        employee ;

INSERT INTO employee
VALUES ('910', '�̺���', '781010-1443269', 'TK1@VCC.COM', '01077886655', '04/01/01', 'J7', 3500000, 0.1, 'N', '176', '90');


SELECT      *
FROM        employee ;





/*
���Ἲ

�Ϲ������� �ܷ�Ű INSERT�ÿ� �θ����̺��� �⺻Ű�� �ִ� ���̳� NULL���� �Է��� �� �ִ�.
������, NULL���� ���� �ε����� ���� �� �� ���� ������ ������ ���ϵǴ� ������ �ʷ� �� �� ����
�׷��� ���������� �ܷ�Ű�� NULL���� �������� �ʴ� �ɼ��� ������.
*/

/*
�Ͻ���(������) NULL �Է� ���
> NULL���� �Է��ϰ��� �ϴ� Į���� ������� �ʰ� �Է���
*/

INSERT INTO employee (emp_id, emp_no, emp_name, phone, hire_date, job_id, salary, bonus_pct, marriage)
VALUES ('880', '860412-2377610', '��ä��',  '0193382662', '06/01/01', 'J7', 3000000, 0, 'N');

SELECT      *
FROM        employee ;




/*
INSERT
����� NULL �Է� ���
*/


INSERT INTO employee
VALUES ('840', '������', '870115-2253408', 'ju_ha@vcc.com', NULL, '07/06/15', 'J7', NULL, NULL, 'N', '', '');

SELECT      *
FROM        employee ;


/*
INSERT
DEFAULT �� �Է�
*/


INSERT INTO employee (emp_id, emp_no, emp_name, salary, marriage)
VALUES ('860', '810429-2165344', '������', DEFAULT, DEFAULT);

SELECT      *
FROM        employee 
WHERE       emp_name = '������';






/*
INSERT + �������� ���

CREATE TABLE�� �������� ���� AS�� ����Ͽ��� ������
INSERT�� AS�� ���� �ʴ´�.
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
INSERT ���� ���Ἲ
*/
INSERT INTO employee (emp_id, emp_no, emp_name, dept_id)
VALUES ('990', '810116-2154219', '������', '45');  --  >> �θ����̺��� dept_id�� 45��� ���� ���⿡
                                                    --   ���� ���Ἲ�� �߻���, �׷��Ƿ� ����!








/*
DELETE
>> ��(���ڵ�)�� �����ض� (���̾ƴϴ� ��)


DELETE [FROM] (���̺��)
[WHERE ����];

DROP TABLE >> ������ Ÿ���� ������ ���̺� ��ü�� ���������ڴ���
DELETE�� ������ Ÿ���� �ΰ�(���̺��� ������ ���ܵΰ�) ��(���̺�)�� ������

*/

DELETE FROM department
WHERE       loc_id NOT LIKE 'A%' ;
-- loc_id�� location ���̺��� country_id�� �ܷ�Ű�� (�̸��� �ٸ���)
-- ���� department ���̺��� loc_id�� employee ���̺��� �θ� ��������
-- �׷��� �������Ἲ�� �Ͼ!

SELECT      *
FROM        department ;






/*

TRUNCATE : ���̺��� ������ �ΰ� ��� ���̺��� ������..

- DELETE���� ����ӵ��� ������.
- ���̺� ��ü �����͸� �����ϴ� ��쿡�� ��� ����.
- �ѹ��� �Ұ��� �ϴ�!!!!!!!
- ���������� �ִ� ��� ��� �Ұ���

*/



DELETE FROM job
WHERE job_id = 'J2' ;


DELETE FROM employee
WHERE emp_id = '141'; 
--  �̰͵� �������Ἲ�� �����
--  emp_id�� �ڱ��ڽ� ���̺� mgr_id�� ���� ��Ŀ�ú�� �������Ǿ� ����
--  �׷��Ƿ� ���� ���Ἲ!










/*
Ʈ������
> �������� �ϰ����� ������Ű���� �������� ����ϴ� �������� ������ �۾����� ����
*/

/*
Ʈ������ ����
ù��° MDL ������ ����� �� ���۵�

�巣���� ����
- COMMIT, ROLLBACK ����� ����ɶ� ����
- DDL ������ ����Ǹ� �ڵ����� COMMIT (Auto COMMIT)  >>>  �����ϼ���!!!!!!!!!! �ѹ��� �ȵ� �Ф�..


*/




/*

SAVEPOINT ���̺�����Ʈ�̸�1;
ROLLBACK TO ���̺�����Ʈ�̸�1;
*/





/*
����

����� 1�� A������ ��Ʈ�� �������϶� (UPDATE, DELETE ��..) ������ �����2, �����3,... ���� A������ �¿�
�������� ���Ѵ�.
���� �����1�� �����ͼ� A�� ������϶� �ٸ� ����ڰ� UPDATE, DELETE�� �Ѵٸ�,,
�۵��� ���߰�
�����1�� ROLLBACK�̳� COMMIT�� �����ϰԵǸ�, �ٸ� ������� UPDATE, DELETE�� ����ȴ�

�̰��� �����̶�� ��
*/




