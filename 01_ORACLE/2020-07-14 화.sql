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
INSTR(변수, 찾는값, [시작점], [시작점으로부터 몇번째 문자])
*/
SELECT *
FROM   employee;

SELECT email,
       INSTR(email, 'c', -1, 2) AS 위치
FROM   employee;

SELECT email,
       INSTR(email, 'c', INSTR(email, '.')-1) AS 위치
FROM   employee;

SELECT email,
       INSTR(email, 'c', -4) AS 위치
FROM   employee;


----------------------------------------------------------------------------------


-- LPAD / RPAD : 좌측정렬 / 우측정렬
/*
RPAD(변수, 문자열길이지정, [빈공간에채울문자])
LPAD(변수, 문자열길이지정, [빈공간에채울문자])
*/

SELECT email AS 원본데이터,
       LENGTH(email) AS 원본길이,
       LPAD(email, 20, '.') AS LPAD적용결과,
       RPAD(email, 20, '.') AS RPAD적용결과,
       LENGTH(LPAD(email, 20, '.')) AS 결과길이
FROM   employee;


----------------------------------------------------------------------------------


--LTRIM(변수, 제거하려는문자)
--RTIRM(변수, 제거하려는문자)

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

--TRIM( [LEADING/TRAILING/BOTH], [지우고자하는문자] FROM 변수 )

SELECT TRIM('   tech   ') FROM DUAL;
SELECT TRIM('a' FROM 'aatechaa') FROM DUAL;
SELECT TRIM(LEADING '0' FROM '00012245456789') FROM DUAL;
SELECT TRIM(TRAILING '1' FROM '56478964651111') FROM DUAL;
SELECT TRIM(BOTH 'A' FROM 'AAAAAAAA1123564789321BBBAAAA') FROM DUAL;
SELECT TRIM(LEADING FROM '   tech   ') FROM DUAL;


----------------------------------------------------------------------------------

--SUBSTR(변수, 위치, [가져올길이])
/*
지정한 위치에서 일정길이의 문자열을 가져오는 방법
*/

SELECT SUBSTR('This is a test', 6, 2) FROM DUAL;
SELECT SUBSTR('This is a test', 6) FROM DUAL;
SELECT SUBSTR('이것은 연습입니다.', 5, 2) FROM DUAL;
SELECT SUBSTR('TechOnTheNet', 1, 4) FROM DUAL;
SELECT SUBSTR('TechOnTheNet', -3, 3) FROM DUAL;
SELECT SUBSTR('TechOnTheNet', 5, 2) FROM DUAL;
SELECT SUBSTR('TechOnTheNet', 7, 3) FROM DUAL;
SELECT SUBSTR('TechOnTheNet', -8, 2) FROM DUAL;

------------------------------------------------------------------------------------

--강사님 문제!
SELECT *
FROM   employee;

/*
사원 테이블에서 입사년월일에서 입사년도만 출력하세요!
*/
SELECT SUBSTR(hire_date, 1, 2) AS "입사년도"
FROM   employee;

/*
사원테이블에서 사원의 이메일에서 메일아이디만 출력하세요!
*/

SELECT email AS "이메일",
       SUBSTR(email, 1, INSTR(email, '@')-1) AS "메일아이디"
FROM   employee;

/*
메일아이디 길이가 6이상인 레코드만 출력하세요!
*/

SELECT email AS "이메일",
       SUBSTR(email, 1, INSTR(email, '@')-1) AS "메일아이디"
FROM   employee
WHERE  LENGTH(SUBSTR(email, 1, INSTR(email, '@')-1)) >= 6;
------------------------------------------------------------------------------------

--ROUND(변수, [자릿수]) : 반올림하세요
SELECT ROUND(125.315) FROM DUAL;
SELECT ROUND(125.315, 0) FROM DUAL;
SELECT ROUND(125.315, 1) FROM DUAL;
SELECT ROUND(125.315, -1) FROM DUAL;
SELECT ROUND(125.315, 3) FROM DUAL;
SELECT ROUND(125.315, 2) FROM DUAL;
SELECT ROUND(125.315, -2) FROM DUAL;


-------------------------------------------------------------------------------------

--TRUNC(변수, [자릿수]) : 절삭하세요(내림하세요)
SELECT TRUNC(125.315) FROM DUAL;
SELECT TRUNC(125.315, 0) FROM DUAL;
SELECT TRUNC(125.315, 1) FROM DUAL;
SELECT TRUNC(125.315, -1) FROM DUAL;
SELECT TRUNC(-125.315, -3) FROM DUAL;
SELECT TRUNC(-125.315, -2) FROM DUAL;
SELECT TRUNC(125.315, 2) FROM DUAL;
SELECT TRUNC(125.315, 1) FROM DUAL;

------------------------------------------------------------------------------------------

-- 날짜함수

--SYSDATE
SELECT SYSDATE
FROM   DUAL;

-----------------------------------------------------------------------------------------

--ADD_MONTHS(날짜, 더해줄개월수)
/*
사원테이블에서 입사일을 기준으로 근무년수가 20년이 되는 일자 조회하세요!
*/

SELECT hire_date AS "고용 날짜",
       ADD_MONTHS(hire_date, 240) AS "20년 후 날짜"
FROM   employee;

-----------------------------------------------------------------------------------------

--MONTHS_BETWEEN(날짜1, 날짜2) : 날짜1과 날짜2의 개월수 차이를 구해줌
/*
현재 날짜를 기준으로 근속년수가 20년 이상인 사원의 이름, 입사일, 근속년수를 조회하세요!!
*/

SELECT emp_name AS 이름,
       hire_date AS 입사일,
       TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)/12) AS 근속년수
FROM   employee
WHERE  MONTHS_BETWEEN(SYSDATE, hire_date) >= 240;

---------------------------------------------------------------------------------------

/*
암시적 형변환 vs 명시적 형변환
*/

SELECT *
FROM employee;

SELECT  SUBSTR(emp_no, 1, INSTR(emp_no, '-') - 1) AS "앞자리",
        SUBSTR(emp_no, INSTR(emp_no, '-') + 1) AS "뒷자리",
        SUBSTR(emp_no, 1, INSTR(emp_no, '-') - 1) + SUBSTR(emp_no, INSTR(emp_no, '-') + 1) AS "암시적 변환",
        TO_NUMBER(SUBSTR(emp_no, 1, INSTR(emp_no, '-') - 1)) + TO_NUMBER(SUBSTR(emp_no, INSTR(emp_no, '-') + 1)) AS "명시적 변환"
FROM    employee;


/*
사원테이블에서 여자사원 사원의 이름, 주민번호, 성별을 조회하세요!!
*/
SELECT *
FROM   employee;

SELECT emp_name AS "이름",
       emp_no AS "주민번호",
       'Female' AS "성별"
FROM   employee
WHERE  TO_NUMBER(SUBSTR(emp_no, INSTR(emp_no, '-') + 1, 1)) = 2;


-- TO_CHAR(변수, [포맷(달러표시같은거)])
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

SELECT emp_name AS "이름",
       TO_CHAR(hire_date, 'YYYY-MM-DD') AS "입사일"
FROM   employee
WHERE  job_id = 'J7';

SELECT emp_name AS "이름",
       TO_CHAR(hire_date, 'YYYY"년" MM"월" DD"일"') AS "입사일"
FROM   employee
WHERE  job_id = 'J7';

SELECT emp_name AS "이름",
       SUBSTR(hire_date, 1, 2) || '년 ' || 
       SUBSTR(hire_date, 4, 2) || '월 ' ||
       SUBSTR(hire_date, 7, 2) || '일 ' AS "입사일"
FROM   employee
WHERE  job_id = 'J7';


----------------------------------------------------------------------------------------

SELECT emp_name AS "이름",
       hire_date AS "기본입사일",
       TO_CHAR(hire_date, 'YYYY/MM/DD HH24:MI:SS') AS "상세입사일"
FROM   employee
WHERE  job_id IN ('J1', 'J2');

SELECT emp_name
FROM   employee
WHERE  hire_date = '04/04/30';   /*  <-- 시간정보가 포함되지 않은 사람을 조회할때  */

SELECT emp_name
FROM   employee
WHERE  hire_date = '90/04/01';  /*  <-- 시간정보가 포함되지 않은 사람을 조회할때는 어떻게함?  */

SELECT emp_name,
       hire_date
FROM   employee
WHERE  hire_date = '90/04/01';  /*  <-- 시간정보가 포함되지 않은 사람을 조회할때는 어떻게함?  두가지 방법이 있음  */



/*
-- 첫번째 방법
이 방법이 데이터의 본질을 해치지 않는 방법이라 추천됨
*/
SELECT emp_name,
       hire_date
FROM   employee
WHERE  hire_date = TO_DATE('900401 133030', 'YYMMDD HH24MISS');
/*
-- 두번째 방법

*/
SELECT emp_name,
       hire_date
FROM   employee
WHERE  TO_CHAR(hire_date, 'YY/MM/DD') = '90/04/01';


SELECT TO_DATE('20100101', 'YYYYMMDD') FROM DUAL;
SELECT TO_DATE('20100101', 'YYYY, MON') FROM DUAL;  /* <-- 오류나는게 맞아요 */
SELECT TO_CHAR(TO_DATE('20100101', 'YYYYMMDD'), 'YYYY, MON') FROM DUAL;
SELECT TO_DATE('041030 143000', 'YYMMDD HH24MISS') FROM DUAL;
SELECT TO_CHAR(TO_DATE('041030 143000', 'YYMMDD HH24MISS'), 'DD-MON-YY HH:MI:SS PM') FROM DUAL;
SELECT TO_DATE('980630', 'YYMMDD') FROM DUAL;
SELECT TO_CHAR(TO_DATE('980630', 'YYMMDD'), 'YYYY.MM.DD') FROM DUAL;

---- 년도형식 YY vs RR
/*
RR적용은 TO_CHAR가 아니라 TO_DATE에서 적용해야한다! > 이것이 핵심
*/

SELECT '2009/10/14' AS "현재",
       '95/10/27' AS "입력",
       TO_CHAR(TO_DATE('95/10/27', 'YY/MM/DD'), 'YYYY/MM/DD') AS YY형식1,
       TO_CHAR(TO_DATE('95/10/27', 'YY/MM/DD'), 'RRRR/MM/DD') AS YY형식2,
       TO_CHAR(TO_DATE('95/10/27', 'RR/MM/DD'), 'YYYY/MM/DD') AS RR형식1,
       TO_CHAR(TO_DATE('95/10/27', 'RR/MM/DD'), 'RRRR/MM/DD') AS RR형식2
FROM   DUAL;




