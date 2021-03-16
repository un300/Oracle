/*
--NVL(����1, ��)
����1�� NULL ���̶�� '��'���� ġȯ�ض�

*/
SELECT emp_name, salary, NVL(bonus_pct, 0), bonus_pct
FROM   employee
WHERE  salary > 3500000;

SELECT emp_name,
       (salary*12) + ((salary*12)*bonus_pct),  --�Ļ��������� NULL���� ���ԵǾ������� ��°��� NULL����
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
(����Ŭ �����Լ�)
--DECODE(����, ����1, ���1, [����2, ���2, ..., ELSE])
SELECT �������� IF-ELSE ���� ���������� ������ ����Ŭ DBMS ���� �Լ�
*/

SELECT  emp_name,
        emp_no,
        SUBSTR(emp_no, -7, 1),
        DECODE(SUBSTR(emp_no, -7, 1), 
                1, '����', 
                2, '����') AS GENDER,
        DECODE(SUBSTR(emp_no, -7, 1), 
                1, '����', 
                3, '����', 
                '����') AS GENDER2
FROM    employee
WHERE   dept_id = '50' ;


SELECT  emp_name,
        mgr_id,
        DECODE(mgr_id, 
                NULL, '������', 
                '����') AS "��å"
FROM    employee
WHERE   job_id = 'J4' ;


/*
--NVL2(��, ����1, ����2)
���� NULL�� �ƴѰ�� ����1 NULL�ΰ�� ����2
*/
SELECT  emp_name,
        mgr_id,
        NVL2(mgr_id, '����', '������') AS "����"
FROM    employee
WHERE   job_id = 'J4' ;



SELECT  *
FROM    job ;

SELECT  *
FROM    employee;

/*
�λ�� ���� ���ϱ�
��� 20 J7 �븮 15 J6 ���� 10 J5
*/

SELECT  job_id,
        salary,
        DECODE(job_id, 
                'J7', salary*1.2, 
                'J6', salary*1.15, 
                'J5', salary*1.1, 
                salary) AS "�λ󿬺�"
FROM    employee;



--------------------------------------------------------------------------------------------
--CASE ���� WHEN ����1 THEN ���1 [WHEN ����2 THEN ���2 ..., ELSE ���������] END
--CASE WHEN ��������1 THEN ���1 [WHEN ��������2 THEN ���2 ..., ELSE ���������] END

SELECT  job_id,
        salary,
        CASE job_id
            WHEN 'J7' THEN salary*1.2
            WHEN 'J6' THEN salary*1.15
            WHEN 'J5' THEN salary*1.1
        END AS "�λ󿬺�"
FROM    employee ;


SELECT  job_id,
        salary,
        CASE
            WHEN job_id = 'J7' THEN salary*1.2
            WHEN job_id = 'J6' THEN salary*1.15
            WHEN job_id = 'J5' THEN salary*1.1
        END AS "�λ󿬺�"
FROM    employee ;


/*
������̺��� �޿��� �������� ����� �޿� ����� Ȯ���ϰ� �ʹ�
�޿��� 3000000 ���ϸ� �ʱް�����
�޿��� 4000000 ���ϸ� �߱ް�����
�޿��� 4000000 �ʰ��ϸ� ��ް����ڷ�
*/

SELECT  emp_id,
        emp_name,
        salary,
        CASE
            WHEN salary > 4000000 THEN '��ް�����'
            WHEN salary > 3000000 THEN '�߱ް�����'
            ELSE '�ʱް�����'
        END AS "�޿����"
FROM    employee ;

----------------------------------------------------------------------------------------------------------------

/*
�׷��Լ��� �׷����� ������ �־�� ����� �� �ִ�. ��, GROUP BY �� �Բ�����
�ֿ� �׷��Լ� > SUM, AVG, MIN, MAX, COUNT
--�׷� �Լ��� NULL���� ������� �ʴ´�.
*/

/*
--ORDER BY ����1 [DESC / ASC], [  ����2 [DESC / ASC] ... ]
ORDER BY�� ���� �Ǹ������� ���;���
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
--DESC�� �������� NULL�� ���� ������.
--DESC NULLS LAST�� NULL�� ���� �ڿ� ���� �� �� ����

--ORDER BY�� ��Ī, SELECT ���� ���� ���� �ε����� ����� �� �ִ�.

SELECT   emp_name AS "�̸�",
         hire_date AS "�Ի���",
         dept_id AS "�μ��ڵ�"
FROM     employee
WHERE    hire_date > TO_DATE('20030101', 'YYYYMMDD')
ORDER BY �μ��ڵ� DESC, �Ի���, �̸�;

SELECT   emp_name AS "�̸�",
         hire_date AS "�Ի���",
         dept_id AS "�μ��ڵ�"
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
������ ���� �޿� ���
*/


-- GROUP BY�� ����� Į���� SELECT�� ���ǵ� �� �ִ�
SELECT      DECODE(SUBSTR(emp_no, 8, 1), 
                    '1', '����', 
                    '2', '����') AS "����", 
            ROUND(AVG(salary)) AS "������ ���� ��ձ޿�",
            MAX(salary) AS "������ ���� �ִ�޿�",
            MIN(salary) AS "������ ���� �����޿�"
FROM        employee
GROUP BY    DECODE(SUBSTR(emp_no, 8, 1), 
                    '1', '����', 
                    '2', '����') ;

SELECT      dept_id,
            emp_name,
            COUNT(*)
FROM        employee
GROUP BY    dept_id, emp_name ;
                    
                    
                    
SELECT      dept_id,
            emp_name,
            COUNT(*)
FROM        employee
GROUP BY    ROLLUP(dept_id, emp_name) ; /* <-- ROLLUP�̶�?? �߰��߰� �Ұ踦 �������ִ� �Լ� */

-----------------------------------------------------------------------------------------------


SELECT      MAX(SUM(salary))
FROM        employee
GROUP BY    dept_id ;

---------------------------------------------------

/*
--HAVING : GRUOP BY�� ���� ����
--SELECT���� WHERE�� ���� �Ͱ� ���� ��ġ
> WHERE������ �����Լ�(SUM, MAX..)���� ����� �� ����!
*/

SELECT      dept_id, SUM(salary)
FROM        employee
GROUP BY    dept_id
HAVING      SUM(salary) > 9000000 ;

SELECT      dept_id, SUM(salary)
FROM        employee
WHERE       SUM(salary) > 9000000
GROUP BY    dept_id ;                           /*   <= ���� ���°� ���� */


----------------------------------------------------------------------
/*
--JOIN : ERD�� ������ ���� ���̺� ���� ����
ERD�� ������ �ִ� ���̺���� ���� : ������ ���̺� ����
ERD�� ������ ���� ���̺���� ���� : �� ������ ���̺� ����
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
USIING : ���踦 ���� ���̺� ������ ����(������ �÷��� �����Ҷ�)
ON : ���踦 ������ ���� ���� ���̺� ������ ����(������ �÷��� �������� ������)

LEFT / ROGHT / OUTER : 
CROSS JOIN : 

FROM    ���̺�1
JOIN    ���̺�2 USIING(������ Į���̸�)

FROM    ���̺�1
JOIN    ���̺�2 ON(�����ϰ��� �ϴ� ����)
*/



SELECT      emp_name,
            dept_name
FROM        employee E
JOIN        department D USING(dept_id) ;

/*
ANSI JOIN : ����Ŭ�Ӹ� �ƴ϶� SQL�� �ٷ�� ��� ���α׷����� ���Ǵ� ���� ��Ģ
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

/* ����Ŭ OUTER JOIN */

SELECT      emp_name,
            dept_name,
            D.dept_id
FROM        department D, employee E
WHERE       D.dept_id(+) = E.dept_id ;   /* (+)�� �ݴ��ʿ� �ִµ����Ͱ� ��� ����̵�! */
            
            
SELECT      emp_name,
            dept_name,
            D.dept_id
FROM        department D, employee E
WHERE       D.dept_id = E.dept_id(+) ;   /* (+)�� �ݴ��ʿ� �ִµ����Ͱ� ��� ����̵�! */

/* ���̺� ���ʿ� (+)�� ���̴� ���� ������� �ʴ´�. */




/* ANSI OUTER JOIN */
/*      ��� ����ϰ��� �ϴ� ���̺��� �ݴ� ���� ����
        ������ ���̺��� ����ϰ� �ʹ�! : LEFT JOIN
        ���� ���̺��� ����ϰ� �ʹ�! : RIGHT JOIN       */

/*
--LEFT JOIN
������ ���̺��� �� ������ּ���
*/
SELECT      emp_name,
            dept_name,
            dept_id
FROM        department D
LEFT JOIN   employee E USING(dept_id) ;


/*
--RIGHT JOIN
���� ���̺��� �� ������ּ���
*/
SELECT      emp_name,
            dept_name,
            dept_id
FROM        department D
RIGHT JOIN  employee E USING(dept_id) ;