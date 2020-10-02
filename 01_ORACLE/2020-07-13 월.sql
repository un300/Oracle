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


---������! �ؿ����� �������� ����. ���������� ����� ���� �Ҳ��� ��;
SELECT job_id,
       job_title,
       min_sal,
       max_sal
FROM   job ;

SELECT *
FROM   job ;

--------------------------------------------------------------------

--�⺻Ű
SELECT job_id
FROM   job ;

--�ܷ�Ű
SELECT job_id
FROM   employee ;


--------------------------------------------------------------------

SELECT *
FROM   department ;

SELECT job_id, 
       dept_id
FROM   employee ;

------------------------------------------------------------------
-- �Ļ������� ������ ��Ī(AS)
SELECT emp_name,
       salary * 12,
       (salary + (salary * bonus_pct)) * 12
FROM   employee ;

SELECT emp_name AS "�̸�",
       salary * 12 AS "1�� �޿�",
       (salary + (salary*bonus_pct)) * 12 AS "�� �ҵ�"
FROM   employee ;

SELECT emp_name "�̸�",
       salary * 12 "1�� �޿�",
       (salary + (salary * bonus_pct)) * 12 "�� �ҵ�(��)"
FROM   employee ;

-------------------------------------SELECT ���ͷ�
SELECT emp_id,
       emp_name,
       '����' AS �ٹ�����
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


----- ������̺��� 90�� �μ��� 20�� �μ��� �Ҽӵ� ����� �̸�, �μ��ڵ�, �޿��� ��ȸ�ϼ���.
----- ���� OR ������ ���

SELECT  emp_name AS "�̸�",
        dept_id AS "�μ��ڵ�",
        salary AS "�޿�"
FROM    employee
WHERE   dept_id='20'
OR      dept_id='90'
AND     salary >= 3000000;

-----������(AND, OR)�� �켱���� : AND�� OR���� �켱��
-- �ٵ� �׷��� ���������� ��ȣ�ļ� �������� �켱������ �����ָ� �� ��
-- �������� �켱����... �߿����� �ʴ�! -20�� ����� �Ǽ�

SELECT  emp_name AS "�̸�",
        dept_id AS "�μ��ڵ�",
        salary AS "�޿�"
FROM    employee
WHERE   (dept_id='90' OR dept_id='20')
AND     salary >= 3000000;


---------------------���� ������ (||)
--Į���� Į���� ������ ���
SELECT emp_id || emp_name || salary
FROM   employee;


--Į���� ���ͷ��� ������ ���
SELECT emp_name || '�� ������' || salary || '�� �Դϴ�.' AS �޿�
FROM   employee;

----------------------�� ������

SELECT emp_name,
       salary
FROM employee
WHERE salary BETWEEN 3500000 AND 5500000;

SELECT emp_name,
       salary
FROM   employee
WHERE  salary >= 3500000
AND    salary <= 5500000;

--- LIKE ����
SELECT emp_name, salary
FROM   employee
WHERE  emp_name LIKE '��%';

SELECT emp_name, phone
FROM   employee
WHERE  phone LIKE '___9_______';


---- ESCAPE : ������ �����Ͱ� '_'�� ���Ե� ���ڶ��! �ڸ����� ��Ÿ���� '_'�� ������ �� ������ '_'�� ��ħ
--              �׷��� �ڸ��� '_'�̶� ������ '_'�� �и�
SELECT emp_name,
       email
FROM   employee
WHERE  email LIKE '___\_%' ESCAPE '\' ;


------- NOT
SELECT emp_name,
       salary
FROM   employee
WHERE  emp_name NOT LIKE '��%';

SELECT emp_name,
       salary
FROM   employee
WHERE  NOT emp_name LIKE '��%';

---- IS NULL : NULL ���� �̾Ƴ�
SELECT emp_name, mgr_id, dept_id
FROM   employee
WHERE  mgr_id IS NULL
AND    dept_id IS NULL;

SELECT emp_name, dept_id, bonus_pct
FROM   employee
WHERE  dept_id IS NULL
AND    bonus_pct IS NOT NULL;

SELECT emp_name "�̸�",
       salary * 12 "1�� �޿�",
       (salary + (salary * bonus_pct)) * 12 "�� �ҵ�(��)"
FROM   employee
WHERE  bonus_pct IS NOT NULL ;















