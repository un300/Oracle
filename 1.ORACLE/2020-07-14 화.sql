 /* 
 4. Additional SELECT
 */

--LENGTH
SELECT *
FROM   column_length ;

SELECT LENGTH(chartype),
       LENGTH(varchartype)
FROM   column_length ;

----------------------------------------------------------------------------------

--INSTR
/*
INSTR(����, ã�°�, [������], [���������κ��� ���° ����])
*/
SELECT *
FROM   employee;

SELECT email,
       INSTR(email, 'c', -1, 2) AS ��ġ
FROM   employee;

SELECT email,
       INSTR(email, 'c', INSTR(email, '.')-1) AS ��ġ
FROM   employee;

SELECT email,
       INSTR(email, 'c', -4) AS ��ġ
FROM   employee;


----------------------------------------------------------------------------------


-- LPAD / RPAD : �������� / ��������
/*
RPAD(����, ���ڿ���������, [�������ä�﹮��])
LPAD(����, ���ڿ���������, [�������ä�﹮��])
*/

SELECT email AS ����������,
       LENGTH(email) AS ��������,
       LPAD(email, 20, '.') AS LPAD������,
       RPAD(email, 20, '.') AS RPAD������,
       LENGTH(LPAD(email, 20, '.')) AS �������
FROM   employee;


----------------------------------------------------------------------------------


--LTRIM(����, �����Ϸ��¹���)
--RTIRM(����, �����Ϸ��¹���)

SELECT LTRIM('   tech') FROM DUAL;
SELECT LTRIM('   tech', ' ') FROM DUAL;
SELECT LTRIM('000123', '0') FROM DUAL;
SELECT LTRIM('123123tech', '123') FROM DUAL;
SELECT LTRIM('123123tech123', '123') FROM DUAL;
SELECT LTRIM('xyzxyyzzxxtech', 'xyz') FROM DUAL;
SELECT LTRIM('681526000487156tech', '0123456789') FROM DUAL;

SELECT RTRIM('tech    ') FROM DUAL;
SELECT RTRIM('tech1234500067849', '0123456789') FROM DUAL;
SELECT RTRIM('techzxczxcasdcxxzxczxc', 'zxcasd') FROM DUAL;
SELECT RTRIM('12345678900000', '0') FROM DUAL;


----------------------------------------------------------------------------------

--TRIM( [LEADING/TRAILING/BOTH], [��������ϴ¹���] FROM ���� )

SELECT TRIM('   tech   ') FROM DUAL;
SELECT TRIM('a' FROM 'aatechaa') FROM DUAL;
SELECT TRIM(LEADING '0' FROM '00012245456789') FROM DUAL;
SELECT TRIM(TRAILING '1' FROM '56478964651111') FROM DUAL;
SELECT TRIM(BOTH 'A' FROM 'AAAAAAAA1123564789321BBBAAAA') FROM DUAL;
SELECT TRIM(LEADING FROM '   tech   ') FROM DUAL;


----------------------------------------------------------------------------------

--SUBSTR(����, ��ġ, [�����ñ���])
/*
������ ��ġ���� ���������� ���ڿ��� �������� ���
*/

SELECT SUBSTR('This is a test', 6, 2) FROM DUAL;
SELECT SUBSTR('This is a test', 6) FROM DUAL;
SELECT SUBSTR('�̰��� �����Դϴ�.', 5, 2) FROM DUAL;
SELECT SUBSTR('TechOnTheNet', 1, 4) FROM DUAL;
SELECT SUBSTR('TechOnTheNet', -3, 3) FROM DUAL;
SELECT SUBSTR('TechOnTheNet', 5, 2) FROM DUAL;
SELECT SUBSTR('TechOnTheNet', 7, 3) FROM DUAL;
SELECT SUBSTR('TechOnTheNet', -8, 2) FROM DUAL;

------------------------------------------------------------------------------------

--����� ����!
SELECT *
FROM   employee;

/*
��� ���̺��� �Ի����Ͽ��� �Ի�⵵�� ����ϼ���!
*/
SELECT SUBSTR(hire_date, 1, 2) AS "�Ի�⵵"
FROM   employee;

/*
������̺��� ����� �̸��Ͽ��� ���Ͼ��̵� ����ϼ���!
*/

SELECT email AS "�̸���",
       SUBSTR(email, 1, INSTR(email, '@')-1) AS "���Ͼ��̵�"
FROM   employee;

/*
���Ͼ��̵� ���̰� 6�̻��� ���ڵ常 ����ϼ���!
*/

SELECT email AS "�̸���",
       SUBSTR(email, 1, INSTR(email, '@')-1) AS "���Ͼ��̵�"
FROM   employee
WHERE  LENGTH(SUBSTR(email, 1, INSTR(email, '@')-1)) >= 6;
------------------------------------------------------------------------------------

--ROUND(����, [�ڸ���]) : �ݿø��ϼ���
SELECT ROUND(125.315) FROM DUAL;
SELECT ROUND(125.315, 0) FROM DUAL;
SELECT ROUND(125.315, 1) FROM DUAL;
SELECT ROUND(125.315, -1) FROM DUAL;
SELECT ROUND(125.315, 3) FROM DUAL;
SELECT ROUND(125.315, 2) FROM DUAL;
SELECT ROUND(125.315, -2) FROM DUAL;


-------------------------------------------------------------------------------------

--TRUNC(����, [�ڸ���]) : �����ϼ���(�����ϼ���)
SELECT TRUNC(125.315) FROM DUAL;
SELECT TRUNC(125.315, 0) FROM DUAL;
SELECT TRUNC(125.315, 1) FROM DUAL;
SELECT TRUNC(125.315, -1) FROM DUAL;
SELECT TRUNC(-125.315, -3) FROM DUAL;
SELECT TRUNC(-125.315, -2) FROM DUAL;
SELECT TRUNC(125.315, 2) FROM DUAL;
SELECT TRUNC(125.315, 1) FROM DUAL;

------------------------------------------------------------------------------------------

-- ��¥�Լ�

--SYSDATE
SELECT SYSDATE
FROM   DUAL;

-----------------------------------------------------------------------------------------

--ADD_MONTHS(��¥, �����ٰ�����)
/*
������̺��� �Ի����� �������� �ٹ������ 20���� �Ǵ� ���� ��ȸ�ϼ���!
*/

SELECT hire_date AS "��� ��¥",
       ADD_MONTHS(hire_date, 240) AS "20�� �� ��¥"
FROM   employee;

-----------------------------------------------------------------------------------------

--MONTHS_BETWEEN(��¥1, ��¥2) : ��¥1�� ��¥2�� ������ ���̸� ������
/*
���� ��¥�� �������� �ټӳ���� 20�� �̻��� ����� �̸�, �Ի���, �ټӳ���� ��ȸ�ϼ���!!
*/

SELECT emp_name AS �̸�,
       hire_date AS �Ի���,
       TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)/12) AS �ټӳ��
FROM   employee
WHERE  MONTHS_BETWEEN(SYSDATE, hire_date) >= 240;

---------------------------------------------------------------------------------------

/*
�Ͻ��� ����ȯ vs ����� ����ȯ
*/

SELECT *
FROM employee;

SELECT  SUBSTR(emp_no, 1, INSTR(emp_no, '-') - 1) AS "���ڸ�",
        SUBSTR(emp_no, INSTR(emp_no, '-') + 1) AS "���ڸ�",
        SUBSTR(emp_no, 1, INSTR(emp_no, '-') - 1) + SUBSTR(emp_no, INSTR(emp_no, '-') + 1) AS "�Ͻ��� ��ȯ",
        TO_NUMBER(SUBSTR(emp_no, 1, INSTR(emp_no, '-') - 1)) + TO_NUMBER(SUBSTR(emp_no, INSTR(emp_no, '-') + 1)) AS "����� ��ȯ"
FROM    employee;


/*
������̺��� ���ڻ�� ����� �̸�, �ֹι�ȣ, ������ ��ȸ�ϼ���!!
*/
SELECT *
FROM   employee;

SELECT emp_name AS "�̸�",
       emp_no AS "�ֹι�ȣ",
       'Female' AS "����"
FROM   employee
WHERE  TO_NUMBER(SUBSTR(emp_no, INSTR(emp_no, '-') + 1, 1)) = 2;


-- TO_CHAR(����, [����(�޷�ǥ�ð�����)])
SELECT TO_CHAR(1234, '99999') FROM DUAL;
SELECT TO_CHAR(1234, '09999') FROM DUAL;
SELECT TO_CHAR(1234, 'L9999') FROM DUAL;
SELECT TO_CHAR(1234, '$99,99') FROM DUAL;
SELECT TO_CHAR(1234, '99,999') FROM DUAL;
SELECT TO_CHAR(1234, '09,999') FROM DUAL;
SELECT TO_CHAR(1234, '999') FROM DUAL;


SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'MON DY, YYYY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-fmMM-DD DAY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-fmDD DAY') FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'Year, Q') FROM DUAL;

SELECT emp_name AS "�̸�",
       TO_CHAR(hire_date, 'YYYY-MM-DD') AS "�Ի���"
FROM   employee
WHERE  job_id = 'J7';

SELECT emp_name AS "�̸�",
       TO_CHAR(hire_date, 'YYYY"��" MM"��" DD"��"') AS "�Ի���"
FROM   employee
WHERE  job_id = 'J7';

SELECT emp_name AS "�̸�",
       SUBSTR(hire_date, 1, 2) || '�� ' || 
       SUBSTR(hire_date, 4, 2) || '�� ' ||
       SUBSTR(hire_date, 7, 2) || '�� ' AS "�Ի���"
FROM   employee
WHERE  job_id = 'J7';


----------------------------------------------------------------------------------------

SELECT emp_name AS "�̸�",
       hire_date AS "�⺻�Ի���",
       TO_CHAR(hire_date, 'YYYY/MM/DD HH24:MI:SS') AS "���Ի���"
FROM   employee
WHERE  job_id IN ('J1', 'J2');

SELECT emp_name
FROM   employee
WHERE  hire_date = '04/04/30';   /*  <-- �ð������� ���Ե��� ���� ����� ��ȸ�Ҷ�  */

SELECT emp_name
FROM   employee
WHERE  hire_date = '90/04/01';  /*  <-- �ð������� ���Ե��� ���� ����� ��ȸ�Ҷ��� �����?  */

SELECT emp_name,
       hire_date
FROM   employee
WHERE  hire_date = '90/04/01';  /*  <-- �ð������� ���Ե��� ���� ����� ��ȸ�Ҷ��� �����?  �ΰ��� ����� ����  */



/*
-- ù��° ���
�� ����� �������� ������ ��ġ�� �ʴ� ����̶� ��õ��
*/
SELECT emp_name,
       hire_date
FROM   employee
WHERE  hire_date = TO_DATE('900401 133030', 'YYMMDD HH24MISS');
/*
-- �ι�° ���

*/
SELECT emp_name,
       hire_date
FROM   employee
WHERE  TO_CHAR(hire_date, 'YY/MM/DD') = '90/04/01';


SELECT TO_DATE('20100101', 'YYYYMMDD') FROM DUAL;
SELECT TO_DATE('20100101', 'YYYY, MON') FROM DUAL;  /* <-- �������°� �¾ƿ� */
SELECT TO_CHAR(TO_DATE('20100101', 'YYYYMMDD'), 'YYYY, MON') FROM DUAL;
SELECT TO_DATE('041030 143000', 'YYMMDD HH24MISS') FROM DUAL;
SELECT TO_CHAR(TO_DATE('041030 143000', 'YYMMDD HH24MISS'), 'DD-MON-YY HH:MI:SS PM') FROM DUAL;
SELECT TO_DATE('980630', 'YYMMDD') FROM DUAL;
SELECT TO_CHAR(TO_DATE('980630', 'YYMMDD'), 'YYYY.MM.DD') FROM DUAL;

---- �⵵���� YY vs RR
/*
RR������ TO_CHAR�� �ƴ϶� TO_DATE���� �����ؾ��Ѵ�! > �̰��� �ٽ�
*/

SELECT '2009/10/14' AS "����",
       '95/10/27' AS "�Է�",
       TO_CHAR(TO_DATE('95/10/27', 'YY/MM/DD'), 'YYYY/MM/DD') AS YY����1,
       TO_CHAR(TO_DATE('95/10/27', 'YY/MM/DD'), 'RRRR/MM/DD') AS YY����2,
       TO_CHAR(TO_DATE('95/10/27', 'RR/MM/DD'), 'YYYY/MM/DD') AS RR����1,
       TO_CHAR(TO_DATE('95/10/27', 'RR/MM/DD'), 'RRRR/MM/DD') AS RR����2
FROM   DUAL;




