/*
ANSI JOIN!

USING�� ���̺��� ��Ī�� ����� �� �����ϴ�
*/


/*
[INNER] JOIN : �׳� JOIN�� ���ٸ� INNER JOIN ��
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
LEFT / RIGHT / FULL [OUTER] JOIN : JOIN�տ� LEFT / RIGHT / FULL �ٿ��ָ� OUTER JOIN
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
--ERD�� ������ ���� ���̺��� JOIN�Ҷ�, ON�� ���
�ٵ� ON�ڿ��� =(����)�� �ƴ϶� ������ ���� ������ '�� ������ ����'�̶����
*/




/*
SELF JOIN
���� ��Ŀ�ú� �����̼� ����
-- �ڱ� �ڽ��� ���̺��� �����ϴ� ���
�ڱ� �ڽſ� ���ϴ� �ٸ� Į���� �� ���� �ϱ� ������ ON�� ����Ѵ�
*/

SELECT      E1.emp_name AS "����",
            E2.emp_name AS "������"
FROM        employee E1
JOIN        employee E2 ON(E1.mgr_id = E2.emp_id)
ORDER BY    E1.emp_name ;

--�� ����� 15���� ������ ��µ�

--��� ����(22��)�� ����Ϸ���?

SELECT      E1.emp_name AS "����",
            E2.emp_name AS "������"
FROM        employee E1
LEFT JOIN   employee E2 ON(E1.mgr_id = E2.emp_id)
ORDER BY    E1.emp_name ;

-- �������� ������(�ӿ�)�� ����ϼ���

SELECT      E1.emp_name AS "����",
            E2.emp_name AS "������",
            E3.emp_name AS "�ӿ�"
FROM        employee E1
JOIN        employee E2 ON(E1.mgr_id = E2.emp_id)
JOIN        employee E3 ON(E2.mgr_id = E3.emp_id)
ORDER BY    E1.emp_name ;


-- �� ����� ��� ����(22��)�� ��µǵ��� SQL������ �ۼ� ��

SELECT      E1.emp_name AS "����",
            E2.emp_name AS "������",
            E3.emp_name AS "�ӿ�"
FROM        employee E1
LEFT JOIN   employee E2 ON(E1.mgr_id = E2.emp_id)
LEFT JOIN   employee E3 ON(E2.mgr_id = E3.emp_id)
ORDER BY    E1.emp_name ;





/*
����� ���� > �տ� ���̴� ���̺��� ����ϴ� SQL���� �����
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





/*����� ���� > �տ� ���̴� ���̺��� ����ϴ� SQL���� �����*/

/*
ERD�󿡼� ������ �ִ� ���̺���� ���� ���� ������
������ ���� ���̺� ���� ���� �Ǹ� ���ϴ� ���̺��� ������ ���� ���ɼ��� ����
*/


/*
NULL ���� ���Ե� �����͸� ��� ����ؾ� �Ҷ�
> FULL JOIN���� JOIN�س����鼭 �ϳ��� LEFT / RIGHT �������� �ٲپ� ����.
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
���ε� ���̺��� ���ǵ� ���̺��� ����ϰ� ������
> �Ϲ����̺��� �ϴ��� ó�� WHERE�Լ��� ���� �߰��ϸ� ��
*/

SELECT      emp_name,
            dept_name
FROM        employee
JOIN        job J           USING (job_id)
JOIN        department D    USING (dept_id)
JOIN        location L      ON(D.loc_id = L.location_id)
WHERE       job_title = '�븮'
AND         loc_describe LIKE '�ƽþ�%' ;



/*
SET Operator
-�� �� �̻��� ���� ����� �ϳ��� ���ս�Ű�� ������
-SELECT ���� ����ϴ� Į�� ������ ������ Ÿ���� ��� �������� �����ؾ� ��
*/



/*
employee_role : 4��
role_history : 22��
*/


--UNION : ������(25��)
SELECT      emp_id,
            role_name
FROM        employee_role      
UNION
SELECT      emp_id,
            role_name
FROM        role_history;     


--UNION ALL : �ߺ��� ���� ������(26��)
SELECT      emp_id,
            role_name
FROM        employee_role      
UNION ALL
SELECT      emp_id,
            role_name
FROM        role_history;       


--INTERSECT : ������(1��)
SELECT      emp_id,
            role_name
FROM        employee_role      
INTERSECT
SELECT      emp_id,
            role_name
FROM        role_history;  


--MINUS : ������(21��)
SELECT      emp_id,
            role_name
FROM        employee_role      
MINUS
SELECT      emp_id,
            role_name
FROM        role_history;  


/*
���Ʒ� SELECT ������ ���� ������ ������
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
���Ʒ� SELECT �������� ������ ������ ������!
ORDER BY�� �� �ؿ� �ۼ�
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
            '������' AS ����
FROM        employee
WHERE       emp_id = '141'
AND         dept_id = '50'
UNION
SELECT      emp_id,
            emp_name,
            '����' AS ����
FROM        employee
WHERE       dept_id = '50'
AND         emp_id != '141' ;

/*
�� ���� DECODE ����ϱ�
*/

SELECT      emp_id,
            emp_name,
            DECODE(emp_id, '141', '������', '����')
FROM        employee
WHERE       dept_id = '50'
UNION
SELECT      emp_id,
            emp_name,
            DECODE(emp_id, '141', '������', '����')
FROM        employee
WHERE       dept_id = '50' ;


--------------------------------------------------------------------------------------------
SELECT      emp_name,
            job_title AS ����
FROM        employee
JOIN        job USING (job_id)
WHERE       job_title IN ('�븮', '���')
ORDER BY    2, 1 ;


SELECT      emp_name, 
            '���' AS ����
FROM        employee
JOIN        job USING (job_id)
WHERE       job_title = '���'
UNION
SELECT      emp_name,
            '�븮'
FROM        employee
JOIN        job USING (job_id)
WHERE       job_title = '�븮'
ORDER BY    2, 1 ;


-----------------------------------------------------------------------------------------
/*
�������� : �������� ���Ǵ� ������ ����.

-���� �� �������� : ������������ ��ȯ�Ǵ� ���� ������ �� �� (���� �� �񱳿����� =, >=, <=, <> ��밡��)
-���� �� �������� : ������������ ��ȯ�Ǵ� ���� ������ �� �� �̻� (���� �� �񱳿����� IN, ANY, ALL ��밡��)
>> ���������� GROUP BY�� ����? : ������ ����������
*/



--���� �� ��������
SELECT      emp_name,
            job_id,
            salary
FROM        employee
WHERE       job_id = (  SELECT      JOB_ID
                        FROM        employee
                        WHERE       emp_name = '���¿�')
AND         salary > (  SELECT      salary
                        FROM        employee
                        WHERE       emp_name = '���¿�') ;



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
                            


--���� �� ��������

SELECT      emp_id,
            emp_name,
            '������' AS ����
FROM        employee
WHERE       emp_id IN (SELECT mgr_id FROM employee)
UNION
SELECT      emp_id,
            emp_name,
            '����' AS ����
FROM        employee
WHERE       emp_id NOT IN (SELECT   mgr_id FROM employee
                           WHERE    mgr_id IS NOT NULL)
ORDER BY    3, 1 ;


/*
employee ��ܿ��� ������ ���������� �������� ���������� �����϶�
*/


--CASE WHEN THEN ���
SELECT      emp_id,
            emp_name,
            CASE
                WHEN emp_id IN (SELECT mgr_id FROM employee) THEN '������'
                ELSE '����'
            END AS "����"
FROM        employee 
ORDER BY    "����", emp_id ;

--DECODE ���
SELECT      emp_id,
            emp_name,
            DECODE(mgr_id, 
                        NULL , '������', 
                        '����') AS "����"
FROM        employee
ORDER BY    "����", emp_id ;



/*
ANY

 > ANY (LIST) : (LIST)�� �ּҰ� ���� ū ��
 < ANY (LIST) : (LIST)�� �ִ밪 ���� ���� ��

*/
 
SELECT      emp_name,
            salary
FROM        employee
JOIN        job USING(job_id)
WHERE       job_title = '�븮'
AND         salary > ANY (SELECT    salary
                          FROM      employee
                          JOIN      job USING(job_id)
                          WHERE     job_title = '����') ;
           
           
SELECT      emp_name,
            salary
FROM        employee
JOIN        job USING(job_id)
WHERE       job_title = '�븮'
AND         salary < ANY (SELECT    salary
                          FROM      employee
                          JOIN      job USING(job_id)
                          WHERE     job_title = '����') ;
                          
   
SELECT      E.emp_name,
            E.salary
FROM        employee E 
JOIN        job J USING(job_id)
WHERE       J.job_title = '�븮' ;  
                          
                          
SELECT    salary
FROM      employee
JOIN      job USING(job_id)
WHERE     job_title = '����';
                          
                          
                          

/* 
1. ���޺� ��ձ޿��� ���϶�(����� ���Ǹ� ���� ���� 5�ڸ����� ����)
2. ��ձ޿� �޴� ����� �̸�, ����, �޿��� ��ȸ�Ͻÿ� !!
*/

-- 1.

SELECT      job_title AS "���޺�",
            TRUNC(AVG(salary), -5) AS "��ձ޿�"
FROM        employee 
JOIN        job J USING(job_id)
GROUP BY    J.job_title ;


-- 2. ���� ��, ���� �� ��������!
-- > �������� ��� �������� ���� ��ȯ�ϴ� ��������

SELECT      E.emp_name AS "�̸�",
            J.job_title AS "����",
            E.salary AS "�޿�"
FROM        employee E
JOIN        job J USING(job_id)
WHERE       (J.job_title, E.salary) IN (SELECT      J2.job_title,
                                                    TRUNC(AVG(E2.salary), -5)
                                        FROM        employee E2
                                        JOIN        job J2 USING(job_id)
                                        GROUP BY    J2.job_title )
ORDER BY    "����", "�̸�" ;


/*
--�ζ��� ��
FROM ���� �ۼ��ϴ� ���������� '�ζ��� ��'����
*/

SELECT      E.emp_name AS "�̸�",
            J.job_title AS "����",
            E.salary AS "����"
FROM        ( SELECT     job_id,
                         TRUNC(AVG(salary), -5) AS job_avg
              FROM       employee
              GROUP BY   job_id ) V
JOIN        employee E ON( E.salary = V.job_avg AND E.job_id = V.job_id )
JOIN        job J ON(E.job_id = J.job_id)
ORDER BY    J.job_title ;
