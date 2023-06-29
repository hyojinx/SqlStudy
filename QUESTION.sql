-- 1. 모든 사원의 이름(FIRST_NAME, LAST_NAME)을 조회하라.
SELECT FIRST_NAME,LAST_NAME FROM EMPLOYEES;
-- 2. 모든 사원의 모든 정보를 조회하라.
SELECT * FROM EMPLOYEES;
-- 3. 모든 도시 명을 조회하라.
SELECT CITY FROM LOCATIONS;
-- 4. 이름(FIRST_NAME)이 M 으로 시작하는 사원의 모든 정보를 조회하라.
SELECT * FROM EMPLOYEES WHERE FIRST_NAME LIKE 'M%';
-- 5. 이름(FIRST_NAME)의 두 번째 글자가 'a'인 사원의 이름(FIRST_NAME)과 연봉을 조회하라.
SELECT FIRST_NAME, SALARY FROM EMPLOYEES WHERE FIRST_NAME LIKE '_a%';
-- 6. 도시 명을 오름차순 정렬하라.
SELECT CITY FROM LOCATIONS ORDER BY CITY ASC;
-- 7. 부서 명을 내림차순 정렬하라.
SELECT DEPARTMENT_NAME FROM DEPARTMENTS ORDER BY DEPARTMENT_NAME DESC;
-- 8. 연봉이 7000 이상인 사원들의 모든 정보를 연봉순(오름차순)으로 정렬하라.
SELECT * FROM EMPLOYEES WHERE SALARY>=7000 ORDER BY SALARY;
-- 9. 인센티브(COMMISSION_PCT)를 받지 않는 사원들의 모든 정보를 조회하라.
SELECT * FROM EMPLOYEES WHERE COMMISSION_PCT IS NULL;
-- 10. 인센티브(COMMISSION_PCT)를 받는 사원들의 모든 정보를 조회하라.
SELECT * FROM EMPLOYEES WHERE COMMISSION_PCT IS NOT NULL;
-- 11. 2007년 06월 21일에 입사한 사원의 사원번호, 이름(FIRST_NAME, LAST_NAME) 
--      그리고 부서번호를 조회하라.
SELECT EMPLOYEE_ID,FIRST_NAME,LAST_NAME,DEPARTMENT_ID
FROM EMPLOYEES
WHERE HIRE_DATE=TO_DATE('20070621','YYYYMMDD');
-- 12. 2006년에 입사한 사원의 사원번호와 입사일을 조회하라.
SELECT EMPLOYEE_ID,HIRE_DATE
FROM EMPLOYEES
--WHERE HIRE_DATE>=TO_DATE('20060101','YYYYMMDD')
--AND HIRE_DATE<TO_DATE('20070101','YYYYMMDD');
WHERE HIRE_DATE BETWEEN TO_DATE('20060101','YYYYMMDD') 
AND TO_DATE('20061231','YYYYMMDD');
-- 13. 이름(FIRST_NAME)의 길이가 5글자 이상인 사원을 조회하라.
SELECT FIRST_NAME FROM EMPLOYEES
--WHERE LENGTH(FIRST_NAME)>=5;
WHERE FIRST_NAME LIKE '_____%';
-- 14. 부서번호별 사원수를 조회하라. (부서번호 오름차순 정렬)
SELECT DEPARTMENT_ID,COUNT(*)
FROM EMPLOYEES
GROUP BY DEPARTMENT_ID
ORDER BY DEPARTMENT_ID;
-- 15. 직무 아이디별 평균 연봉을 조회하라. (직무 아이디 내림차순 정렬)
SELECT JOB_ID, AVG(SALARY)
FROM EMPLOYEES
GROUP BY JOB_ID
ORDER BY JOB_ID DESC;
-- 16. 상사가 있는 사원들의 모든 정보를 조회하라.
SELECT * FROM EMPLOYEES WHERE MANAGER_ID IS NOT NULL;
-- 17. 상사가 없는 사원들의 모든 정보를 조회하라.
SELECT * FROM EMPLOYEES WHERE MANAGER_ID IS NULL;
-- 18. 모든 사원들의 사원번호, 이름(FIRST_NAME, LAST_NAME), 부서번호 
--   그리고 부서명을 조회하라.
SELECT E.EMPLOYEE_ID,E.FIRST_NAME,E.LAST_NAME,E.DEPARTMENT_ID,D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID=D.DEPARTMENT_ID;
-- 19. 모든 부서의 부서명과 도시명을 조회하라.
SELECT D.DEPARTMENT_NAME,L.CITY
FROM DEPARTMENTS D,LOCATIONS L
WHERE D.LOCATION_ID=L.LOCATION_ID;
-- 20. 모든 사원들의 사원번호, 부서명, 직무명을 조회하라.
SELECT E.EMPLOYEE_ID,D.DEPARTMENT_NAME,J.JOB_TITLE
FROM EMPLOYEES E, DEPARTMENTS D, JOBS J
WHERE E.DEPARTMENT_ID=D.DEPARTMENT_ID(+)
AND E.JOB_ID=J.JOB_ID;
-- 21. 모든 사원들의 사원번호, 부서명, 직무명, 도시명을 조회하라.
SELECT E.EMPLOYEE_ID,D.DEPARTMENT_NAME,J.JOB_TITLE,L.CITY
FROM EMPLOYEES E, DEPARTMENTS D, JOBS J,LOCATIONS L
WHERE E.DEPARTMENT_ID=D.DEPARTMENT_ID(+)
AND E.JOB_ID=J.JOB_ID
AND D.LOCATION_ID=L.LOCATION_ID;
-- 22. 10번, 20번, 30번 부서에서 근무하는 사원들의 모든 정보를 조회하라.
SELECT * FROM EMPLOYEES
--WHERE DEPARTMENT_ID =10
--OR DEPARTMENT_ID =20
--OR DEPARTMENT_ID =30;
WHERE DEPARTMENT_ID IN(10,20,30);
-- 23. 6인 미만의 사원이 근무하는 부서의 이름을 조회하라.
SELECT D.DEPARTMENT_NAME
FROM DEPARTMENTS D
WHERE DEPARTMENT_ID IN (
    SELECT DEPARTMENT_ID 
    FROM EMPLOYEES 
    GROUP BY DEPARTMENT_ID
    HAVING COUNT(*)<6
);
SELECT D.DEPARTMENT_NAME
FROM DEPARTMENTS D,EMPLOYEES E
WHERE D.DEPARTMENT_ID=E.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_NAME
HAVING COUNT(*)<6;
-- 24. 4인 미만의 사원이 근무하는 부서의 평균 연봉과 부서명을 조회하라.
SELECT AVG(SALARY),D.DEPARTMENT_NAME
FROM DEPARTMENTS D,EMPLOYEES E
WHERE D.DEPARTMENT_ID=E.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_NAME
HAVING COUNT(*)<4;
-- 25. IT 부서의 연봉 총합을 조회하라.
SELECT SUM(E.SALARY)
FROM EMPLOYEES E ,DEPARTMENTS D
WHERE E.DEPARTMENT_ID=D.DEPARTMENT_ID
AND D.DEPARTMENT_NAME='IT';
-- 26. 대륙명(REGIONS)별 도시의 개수를 조회하라.
SELECT R.REGION_NAME,COUNT(CITY)
FROM LOCATIONS L, COUNTRIES C, REGIONS R
WHERE L.COUNTRY_ID=C.COUNTRY_ID
AND C.REGION_ID=R.REGION_ID
GROUP BY R.REGION_NAME;
-- 27. 도시명 별 부서의 개수를 조회하라.
SELECT L.CITY,COUNT(*)
FROM LOCATIONS L,DEPARTMENTS D
WHERE L.LOCATION_ID=D.LOCATION_ID
GROUP BY L.CITY;
-- 28. 부서가 존재하지 않는 도시를 조회하라.
SELECT CITY
FROM LOCATIONS L
LEFT OUTER JOIN DEPARTMENTS D ON L.LOCATION_ID=D.LOCATION_ID
WHERE D.DEPARTMENT_ID IS NULL;

SELECT CITY
FROM LOCATIONS L
WHERE LOCATION_ID NOT IN(SELECT DISTINCT LOCATION_ID FROM DEPARTMENTS);
-- 29. 사원이 존재하지 않는 국가를 조회하라.
SELECT COUNTRY_NAME
FROM COUNTRIES
WHERE COUNTRY_ID NOT IN(SELECT DISTINCT L.COUNTRY_ID
                        FROM LOCATIONS L,DEPARTMENTS D,EMPLOYEES E
                        WHERE L.LOCATION_ID=D.LOCATION_ID
                        AND D.DEPARTMENT_ID=E.DEPARTMENT_ID
                        );
-- 30. 150번 사원보다 빨리 입사한 사원 중 가장 최신에 입사한 사원의 모든 정보를 조회하라.
SELECT ROWNUM,A.*
FROM(
SELECT *
FROM EMPLOYEES
WHERE HIRE_DATE<(SELECT HIRE_DATE FROM EMPLOYEES WHERE EMPLOYEE_ID=150)
ORDER BY HIRE_DATE DESC
) A
WHERE ROWNUM=1;

SELECT *
FROM EMPLOYEES
WHERE HIRE_DATE=(
    SELECT MAX(HIRE_DATE)
    FROM EMPLOYEES
    WHERE HIRE_DATE<(SELECT HIRE_DATE FROM EMPLOYEES WHERE EMPLOYEE_ID=150)
);
-- 31. 직무를 전환한 이력이 있는 사원의 모든 정보를 조회하라.
SELECT * FROM EMPLOYEES
WHERE EMPLOYEE_ID IN(SELECT EMPLOYEE_ID FROM JOB_HISTORY);
SELECT DISTINCT E.*
FROM EMPLOYEES E,JOB_HISTORY H
WHERE E.EMPLOYEE_ID=H.EMPLOYEE_ID;
-- 32. 부서의 메니저으로 있는 사원의 모든 정보와 부서명을 조회하라.
SELECT E.*,D.DEPARTMENT_NAME
FROM EMPLOYEES E,DEPARTMENTS D
WHERE E.DEPARTMENT_ID=D.DEPARTMENT_ID
AND E.EMPLOYEE_ID IN(SELECT MANAGER_ID FROM DEPARTMENTS
                    WHERE MANAGER_ID IS NOT NULL);
SELECT E.*,D.DEPARTMENT_NAME
FROM EMPLOYEES E,DEPARTMENTS D
WHERE E.EMPLOYEE_ID=D.MANAGER_ID;
-- 33. 다른 사원의 상사인 사원의 모든 정보를 조회하라.
SELECT *
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN(SELECT MANAGER_ID FROM EMPLOYEES);

SELECT DISTINCT MA.*
FROM EMPLOYEES MA,EMPLOYEES E
WHERE MA.EMPLOYEE_ID=E.MANAGER_ID;
-- 34. 이름(FIRST_NAME)이 C로 시작하고 s로 끝나는 
--    사원의 부서명, 직무명, 도시명, 국가명, 대륙명을 조회하라.
SELECT E.FIRST_NAME,D.DEPARTMENT_NAME
    ,J.JOB_TITLE,L.CITY,C.COUNTRY_NAME,R.REGION_NAME
FROM EMPLOYEES E, DEPARTMENTS D, JOBS J, LOCATIONS L, COUNTRIES C,REGIONS R
WHERE E.DEPARTMENT_ID=D.DEPARTMENT_ID
AND E.JOB_ID=J.JOB_ID
AND D.LOCATION_ID=L.LOCATION_ID
AND L.COUNTRY_ID=C.COUNTRY_ID
AND C.REGION_ID=R.REGION_ID
AND E.FIRST_NAME LIKE 'C%s';

SELECT FIRST_NAME,DEPARTMENT_NAME,JOB_TITLE,CITY,COUNTRY_NAME,REGION_NAME
FROM EMP_DETAILS_VIEW
WHERE FIRST_NAME LIKE 'C%s';
-- 35. 직무를 전환한 이력이 없는 사원의 모든 정보를 조회하라.
SELECT * FROM EMPLOYEES
WHERE EMPLOYEE_ID NOT IN(SELECT EMPLOYEE_ID FROM JOB_HISTORY);

SELECT E.*
FROM EMPLOYEES E,JOB_HISTORY H
WHERE E.EMPLOYEE_ID=H.EMPLOYEE_ID(+)
AND H.EMPLOYEE_ID IS NULL;
-- 36. 자신의 상사가 자신 보다 늦게 입사한 사원의 모든 정보를 조회하라.
SELECT E.*
FROM EMPLOYEES MA,EMPLOYEES E
WHERE MA.EMPLOYEE_ID=E.MANAGER_ID
AND E.HIRE_DATE<MA.HIRE_DATE;
-- 37. 100번 사원을 직속 상사로 두고 있는 사원들의 모든 정보를 조회하라.
SELECT * FROM EMPLOYEES WHERE MANAGER_ID=100;
-- 38. 100번 사원을 상사로 두고 있는 모든 사원들의 모든 정보를 조회하라.
SELECT LEVEL,E.*
FROM EMPLOYEES E
START WITH MANAGER_ID=100
CONNECT BY PRIOR E.EMPLOYEE_ID=E.MANAGER_ID;
-- 38-1. 112번 사원의 상사들을 모두 조회해라
SELECT LEVEL, E.*
FROM EMPLOYEES E
START WITH E.EMPLOYEE_ID=112
CONNECT BY PRIOR E.MANAGER_ID=E.EMPLOYEE_ID;

WITH EMP_FM( LVL, EMPID, FIRST_NAME, DID , MID ) AS (
    SELECT 1 AS LVL
         , A.EMPLOYEE_ID AS EMPID
         , A.FIRST_NAME 
         , A.DEPARTMENT_ID AS DID
         , A.MANAGER_ID AS MID
      FROM EMPLOYEES A 
     WHERE 1=1
       AND A.EMPLOYEE_ID = 112
     UNION ALL
    SELECT A.LVL + 1 AS LVL
         , B.EMPLOYEE_ID AS EMPID
         , B.FIRST_NAME 
         , B.DEPARTMENT_ID AS DID
         , B.MANAGER_ID AS MID
      FROM EMP_FM A
      	,EMPLOYEES B
     WHERE B.EMPLOYEE_ID(+) = A.MID
       AND B.EMPLOYEE_ID IS NOT NULL
)
SELECT E1.LVL
	, E1.EMPID
    , E1.FIRST_NAME
    , D.DEPARTMENT_NAME
FROM EMP_FM E1
  	,DEPARTMENTS D
WHERE E1.DID=D.DEPARTMENT_ID;
-- 38-2. 150번 사원의 모든 상사들의 이름과 부서명을 조회하라
SELECT LEVEL, E.FIRST_NAME,E.LAST_NAME,D.DEPARTMENT_NAME
FROM EMPLOYEES E,DEPARTMENTS D
WHERE E.DEPARTMENT_ID=D.DEPARTMENT_ID
START WITH E.EMPLOYEE_ID=150
CONNECT BY PRIOR E.MANAGER_ID=E.EMPLOYEE_ID;
-- 39. 사원수가 가장 많은 도시의 이름을 조회하라.
SELECT CITY
FROM(
    SELECT L.CITY,COUNT(*) COUNT
    FROM EMPLOYEES E,DEPARTMENTS D,LOCATIONS L
    WHERE E.DEPARTMENT_ID=D.DEPARTMENT_ID AND D.LOCATION_ID=L.LOCATION_ID
    GROUP BY L.CITY
    ORDER BY COUNT(*) DESC
)
WHERE ROWNUM=1;
WITH RANKER(T,CT) AS(
	    SELECT L.CITY,COUNT(*) CO
	    FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
	    WHERE E.DEPARTMENT_ID=D.DEPARTMENT_ID AND D.LOCATION_ID=L.LOCATION_ID
	    GROUP BY L.CITY
	    ORDER BY COUNT(*) DESC
)
SELECT CITY
FROM(
	SELECT T CITY,RANK() OVER(ORDER BY CT DESC) RANK
	FROM RANKER
)
WHERE RANK=1;
-- 40. 직무의 종류가 가장 많은 부서의 이름을 조회하라.
SELECT D.DEPARTMENT_NAME
FROM(
    SELECT E.DEPARTMENT_ID,COUNT(*) CO
    FROM EMPLOYEES E,JOBS J
    WHERE E.JOB_ID=J.JOB_ID
    GROUP BY E.DEPARTMENT_ID
    ORDER BY COUNT(*) DESC
    ) A
    ,DEPARTMENTS D
WHERE A.DEPARTMENT_ID=D.DEPARTMENT_ID
AND ROWNUM=1;
-- 41. 담당 직무의 최대 연봉을 받고 있는 사원들의 모든 정보를 조회하라.
SELECT E.* 
FROM EMPLOYEES E
    ,JOBS J
WHERE E.JOB_ID=J.JOB_ID
AND J.MAX_SALARY=E.SALARY;

SELECT J.JOB_TITLE,E.*
FROM EMPLOYEES E
    ,(SELECT JOB_ID , MAX(SALARY) MAXSAL
        FROM EMPLOYEES
        GROUP BY JOB_ID) A
    ,JOBS J
WHERE E.JOB_ID=A.JOB_ID
AND E.JOB_ID=J.JOB_ID
AND E.SALARY=A.MAXSAL;
-- 42. 담당 직무의 최소 연봉을 받고 있는 사원들의 모든 정보를 조회하라.
SELECT E.* 
FROM EMPLOYEES E
    ,JOBS J
WHERE E.JOB_ID=J.JOB_ID
AND J.MIN_SALARY=E.SALARY;

SELECT J.JOB_TITLE,E.*
FROM EMPLOYEES E
    ,(SELECT JOB_ID , MIN(SALARY) MINSAL
        FROM EMPLOYEES
        GROUP BY JOB_ID) A
    ,JOBS J
WHERE E.JOB_ID=A.JOB_ID
AND E.JOB_ID=J.JOB_ID
AND E.SALARY=A.MINSAL;
-- 43. 부서와 직무별 최대연봉, 최소연봉, 사원수를 조회하라.
SELECT D.DEPARTMENT_NAME 
    ,J.JOB_ID
    ,MAX(E.SALARY)AS MAXS
    ,MIN(E.SALARY)AS MINS
    ,COUNT(*) AS CNT
FROM EMPLOYEES E, JOBS J, DEPARTMENTS D
WHERE E.JOB_ID=J.JOB_ID AND E.DEPARTMENT_ID=D.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_NAME,J.JOB_ID
ORDER BY D.DEPARTMENT_NAME ;

SELECT (SELECT D2.DEPARTMENT_NAME 
        FROM DEPARTMENTS D2 
        WHERE D2.DEPARTMENT_ID=D.DEPARTMENT_ID)AS DNAME
    ,D.DEPARTMENT_ID 
    ,J.JOB_ID
    ,MAX(E.SALARY)AS MAXS
    ,MIN(E.SALARY)AS MINS
    ,COUNT(*) AS CNT
FROM EMPLOYEES E, JOBS J, DEPARTMENTS D
WHERE E.JOB_ID=J.JOB_ID AND E.DEPARTMENT_ID=D.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_ID,J.JOB_ID;
-- 44. 사원수가 가장 많은 도시에서 근무하는 모든 사원들의 연봉 총합을 조회하라.
SELECT L.CITY,SUM(E.SALARY)
FROM EMPLOYEES E ,DEPARTMENTS D ,LOCATIONS L
WHERE E.DEPARTMENT_ID=D.DEPARTMENT_ID AND D.LOCATION_ID=L.LOCATION_ID
AND L.CITY=(SELECT CITY
        FROM(
            SELECT L.CITY,COUNT(*)
            FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
            WHERE E.DEPARTMENT_ID=D.DEPARTMENT_ID AND D.LOCATION_ID=L.LOCATION_ID
            GROUP BY L.CITY
            ORDER BY COUNT(*) DESC
        )
        WHERE ROWNUM=1
    )
GROUP BY L.CITY;
-- 45. 사원수가 가장 많은 도시에서 근무하는 모든 사원들의 부서별 및 직무별 평균 연봉을 조회하라.
SELECT D.DEPARTMENT_NAME,J.JOB_TITLE,AVG(E.SALARY)
FROM EMPLOYEES E ,DEPARTMENTS D ,LOCATIONS L,JOBS J
WHERE E.DEPARTMENT_ID=D.DEPARTMENT_ID AND D.LOCATION_ID=L.LOCATION_ID
AND J.JOB_ID=E.JOB_ID
AND L.CITY=(SELECT CITY
        FROM(
            SELECT L.CITY,COUNT(*)
            FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
            WHERE E.DEPARTMENT_ID=D.DEPARTMENT_ID AND D.LOCATION_ID=L.LOCATION_ID
            GROUP BY L.CITY
            ORDER BY COUNT(*) DESC
        )
        WHERE ROWNUM=1
    )
GROUP BY D.DEPARTMENT_NAME,J.JOB_TITLE;

--날짜 시간 계산
SELECT SYSDATE 현재
    ,SYSDATE-1 어제 
    ,SYSDATE+1 내일 
    ,ADD_MONTHS(SYSDATE,1) 다음달 
    ,ADD_MONTHS(SYSDATE,-1) 이전달
    ,ADD_MONTHS(SYSDATE,-12) 일년전
    ,ADD_MONTHS(SYSDATE,12) 일년후
    ,SYSDATE-(1/24) 한시간전
    ,SYSDATE+(1/24) 한시간후
    ,SYSDATE-(1/24/60) 일분전
    ,SYSDATE-(1/24/60/60) 일초전
FROM DUAL;
-- 46. 입사일이 가장 오래된 사원을 조회하라.
SELECT * 
FROM EMPLOYEES
WHERE HIRE_DATE=(SELECT MIN(HIRE_DATE) FROM EMPLOYEES);
-- 47. 입사일이 가장 최근인 사원을 조회하라.
SELECT * 
FROM EMPLOYEES
WHERE HIRE_DATE=(SELECT MAX(HIRE_DATE) FROM EMPLOYEES);
-- 48. 가장 최근에 입사한 사원과 가장 오래전에 입사한 사원의 일차를 계산해 조회하라.
SELECT (MAX(HIRE_DATE)- MIN(HIRE_DATE))AS RESULT FROM EMPLOYEES;
-- 49. 가장 최근에 입사한 사원과 가장 오래전에 입사한 사원의 시간차를 계산해 조회하라.
SELECT (MAX(HIRE_DATE)-MIN(HIRE_DATE))*24 AS RESULT FROM EMPLOYEES;
-- 50. 연봉이 12000 이상되는 직원들의 LAST_NAME 및 연봉을 조회한다.
SELECT  LAST_NAME , SALARY
FROM    EMPLOYEES
WHERE   SALARY >= 12000;
-- 51. 사원번호가 176 인 사람의 LAST_NAME 과 부서 번호를 조회한다.
SELECT LAST_NAME,DEPARTMENT_ID
FROM EMPLOYEES
WHERE EMPLOYEE_ID=176;
-- 52. 연봉이 5000 에서 12000의 범위 이외인 사람들의 LAST_NAME 및 연봉을 조회힌다.
SELECT LAST_NAME,SALARY FROM EMPLOYEES
WHERE SALARY<5000 OR SALARY>12000;
-- 53. 2000/02/20 일부터 2010/05/01 사이에 고용된 사원들의 LAST_NAME 사번, 고용일자를 조회한다.
SELECT LAST_NAME, EMPLOYEE_ID, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE >= TO_DATE('2000/02/20')
AND HIRE_DATE <= TO_DATE('2010/05/01');
-- 54. 20 번 및 50 번 부서에서 근무하는 모든 사원들의 LAST_NAME 및 
--   부서 번호를 알파벳순으로 조회한다.
SELECT LAST_NAME,DEPARTMENT_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (20,50)
ORDER BY LAST_NAME ASC;
-- 55. 20 번 및 50 번 부서에 근무하며, 연봉이 5000 ~ 12,000 사이인 
--   사원들의 LAST_NAME 및 연봉을 조회한다.
SELECT LAST_NAME,SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (20,50)
AND SALARY BETWEEN 5000 AND 12000;
-- 56. 2005년도에 고용된 모든 사람들의 LAST_NAME 및 고용일을 조회한다.
SELECT LAST_NAME , HIRE_DATE
FROM EMPLOYEES
WHERE TO_CHAR(HIRE_DATE,'YYYY')='2005';
--WHERE HIRE_DATE BETWEEN '2005/01/01' AND '2005/12/31';
-- 57. 매니저가 없는 사람들의 LAST_NAME 및 JOB_ID 를 조회한다.
SELECT LAST_NAME, JOB_ID FROM EMPLOYEES
WHERE MANAGER_ID IS NULL
OR MANAGER_ID ='';
-- 58. 매니저가 있는 사람들의 LAST_NAME 및 JOB_ID 를 조회한다.
SELECT LAST_NAME, JOB_ID FROM EMPLOYEES
WHERE MANAGER_ID IS NOT NULL
OR MANAGER_ID<>'';
-- 59. 커미션을 버는 모든 사원들의 LAST_ANME, 연봉 및 커미션을 조회한다.
--    연봉 역순, 커미션 역순차로 정렬한다.
SELECT LAST_NAME,SALARY,COMMISSION_PCT
FROM EMPLOYEES
WHERE COMMISSION_PCT IS NOT NULL
ORDER BY SALARY DESC,COMMISSION_PCT DESC;
-- 60. LAST_NAME 의 네번째 글자가 a 인 사원들의 LAST_NAME 을 조회한다.
SELECT LAST_NAME
FROM EMPLOYEES
WHERE LAST_NAME LIKE '___a%';
-- 61. LAST_NAME 에 a 및(OR) e 글자가 있는 사원들의 LAST_NAME 을 조회한다.
SELECT LAST_NAME
FROM EMPLOYEES
WHERE LAST_NAME LIKE '%a%'
OR LAST_NAME LIKE '%e%';
-- 62. 연봉이 2,500, 3,500, 7000 이 아니며 
-- 직업이 SA_REP 이나 ST_CLERK 인 사람들을 조회한다.
SELECT LAST_NAME,JOB_ID,SALARY
FROM EMPLOYEES
WHERE SALARY NOT IN (2500,3500,7000)
AND JOB_ID IN ('SA_REP','ST_CLERK');
-- 63.  직업이 AD_PRESS 인 사람은 A 등급을, 
--  ST_MAN 인 사람은 B 등급을, IT_PROG 인 사람은 C 등급을,
--  SA_REP 인 사람은 D 등급을, ST_CLERK 인 사람은 E 등급을 
--  기타는 0 을 부여하여 조회한다.
SELECT LAST_NAME||FIRST_NAME FULLNAME
    , DECODE(JOB_ID
            ,'AD_PRESS','A'
            ,'ST_MAN','B'
            ,'IT_PROG','C'
            ,'SA_REP','D'
            ,'ST_CLERK','E'
            ,'0')AS JOB_GRADE
FROM EMPLOYEES;
SELECT LAST_NAME||FIRST_NAME FULLNAME
    , CASE JOB_ID
        WHEN 'AD_PRESS' THEN 'A'
        WHEN 'ST_MAN' THEN 'B'
        WHEN 'IT_PROG' THEN 'C'
        WHEN 'SA_REP' THEN 'D'
        WHEN 'ST_CLERK' THEN 'E'
        ELSE '0'
    END JOB_GRADE
FROM EMPLOYEES;
-- 64. 모든 사원들의 LAST_NAME, 부서 이름 및 부서 번호을 조회한다.
SELECT  E.LAST_NAME, D.DEPARTMENT_NAME, D.DEPARTMENT_ID
FROM    EMPLOYEES E , DEPARTMENTS D
WHERE   E.DEPARTMENT_ID = D.DEPARTMENT_ID;
-- 65. 부서번호 30 내의 모든 직업들을 유일한 포맷으로 조회한다. 90 부서 또한 포함한다.
SELECT DISTINCT JOB_ID, D.DEPARTMENT_ID
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND D.DEPARTMENT_ID IN ( 30, 90 )
ORDER BY JOB_ID;
-- 66. 커미션을 버는 모든 사람들의 LAST_NAME, 부서 명, 지역 ID 및 도시 명을 조회한다.
SELECT E.LAST_NAME, D.DEPARTMENT_NAME, L.LOCATION_ID, L.CITY
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND D.LOCATION_ID = L.LOCATION_ID
AND E.COMMISSION_PCT IS NOT NULL;
-- 66-1. 시애틀에 사는 사람 중 커미션을 버는 모든 사람들의 LAST_NAME, 부서 명, 지역 ID 및 도시 명을 조회한다.
SELECT  E.LAST_NAME, D.DEPARTMENT_NAME, L.LOCATION_ID, L.CITY
FROM EMPLOYEES E
    , DEPARTMENTS D
    , LOCATIONS L
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND D.LOCATION_ID = L.LOCATION_ID
AND E.COMMISSION_PCT IS NOT NULL
AND L.LOCATION_ID = (SELECT  LOCATION_ID
                     FROM    LOCATIONS
                     WHERE   CITY = 'Seattle');
-- 67. LAST_NAME 이 DAVIES 인 사람보다 후에 고용된 사원들의 LAST_NAME 및 HIRE_DATE 을 조회한다.
SELECT LAST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE HIRE_DATE >= (SELECT HIRE_DATE
                    FROM EMPLOYEES
                    WHERE LAST_NAME = 'Davies')
ORDER BY HIRE_DATE;
-- 68. 자신의 매니저보다 먼저 고용된 사원들의 LAST_NAME 및 고용일을 조회한다.
SELECT E.LAST_NAME, E.HIRE_DATE
FROM EMPLOYEES E, EMPLOYEES M
WHERE E.MANAGER_ID = M.EMPLOYEE_ID
AND E.HIRE_DATE < M.HIRE_DATE
ORDER BY E.LAST_NAME;
-- 69. 회사 전체의 최대 연봉, 최소 연봉, 연봉 총 합 및 평균 연봉을 자연수로 포맷하여 조회한다.
SELECT MAX(SALARY), MIN(SALARY), SUM(SALARY)
    ,AVG(SALARY)
    ,ROUND(AVG(SALARY)),TRUNC(AVG(SALARY))
FROM EMPLOYEES;
-- 70. 각 JOB_ID 별, 최대 연봉, 최소 연봉, 연봉 총 합 및 평균 연봉을 자연수로 포맷하여 조회한다.
SELECT JOB_ID, MAX(SALARY), MIN(SALARY), SUM(SALARY) SUM
    ,AVG(SALARY)
    ,ROUND(AVG(SALARY)),TRUNC(AVG(SALARY))
FROM EMPLOYEES
GROUP BY JOB_ID;
-- 71. 동일한 직업을 가진 사원들의 총 수를 조회한다.
SELECT JOB_ID, COUNT(EMPLOYEE_ID)
FROM EMPLOYEES
GROUP BY JOB_ID;
-- 72. 매니저로 근무하는 사원들의 총 수를 조회한다.
SELECT COUNT(EMPLOYEE_ID)
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN(SELECT DISTINCT MANAGER_ID
                     FROM EMPLOYEES
                     WHERE MANAGER_ID IS NOT NULL);
SELECT COUNT(DISTINCT MANAGER_ID)
FROM EMPLOYEES;
-- 73. 사내의 최대 연봉 및 최소 연봉의 차이를 조회한다.
SELECT MAX(SALARY) - MIN(SALARY)
FROM EMPLOYEES;
-- 74. 매니저의 사번 및 그 매니저 밑 사원들 중 최소 연봉을 받는 사원의 연봉을 조회한다.
--     매니저가 없는 사람들은 제외한다.
--     최소 연봉이 6000 미만인 경우는 제외한다.
--     연봉 기준 역순으로 조회한다.
SELECT MANAGER_ID, MIN(SALARY)
FROM EMPLOYEES
WHERE MANAGER_ID IS NOT NULL
GROUP BY MANAGER_ID
HAVING MIN(SALARY) >= 6000
ORDER BY MIN(SALARY) DESC;
-- 75. 부서 명, 위치 ID, 각 부서 별 사원 총 수, 각 부서 별 평균 연봉을 조회한다.
--     평균 연봉은 소수점 2 자리까지만 표현한다.
SELECT D.DEPARTMENT_NAME, D.LOCATION_ID
    , COUNT(E.EMPLOYEE_ID)
    , ROUND(AVG(E.SALARY), 2) AVG_SALARY
    , TRUNC(AVG(E.SALARY), 2) AVG_SALARY2
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_NAME, L.LOCATION_ID
ORDER BY L.LOCATION_ID;
-- 76. 총 사원 수 및 2001, 2003, 2005, 2006 년도 별 고용된 사원들의 총 수를 다음과 같이 조회한다.
SELECT *
FROM(
    (SELECT '총 사원 수'AS GR,COUNT(*) AS CNT FROM EMPLOYEES)
    UNION ALL
    (SELECT '2001년 입사 사원',COUNT(*) FROM EMPLOYEES WHERE TO_CHAR(HIRE_DATE,'YY')='01')
    UNION ALL
    (SELECT '2003년 입사 사원',COUNT(*) FROM EMPLOYEES WHERE TO_CHAR(HIRE_DATE,'YY')='03')
    UNION ALL
    (SELECT '2005년 입사 사원',COUNT(*) FROM EMPLOYEES WHERE TO_CHAR(HIRE_DATE,'YY')='05')
    UNION ALL
    (SELECT '2006년 입사 사원',COUNT(*) FROM EMPLOYEES WHERE TO_CHAR(HIRE_DATE,'YY')='06')
)PIVOT( MAX(CNT) 
        FOR GR
        IN('총 사원 수','2001년 입사 사원','2003년 입사 사원','2005년 입사 사원','2006년 입사 사원')
);
SELECT (SELECT COUNT(*) FROM EMPLOYEES) AS ALLC
    ,(SELECT COUNT(*) FROM EMPLOYEES WHERE HIRE_DATE LIKE '01%')AS C2001
    ,(SELECT COUNT(*) FROM EMPLOYEES WHERE TO_CHAR(HIRE_DATE,'YY')='03')AS C2003
    ,(SELECT COUNT(*) FROM EMPLOYEES WHERE TO_CHAR(HIRE_DATE,'YY')='05')AS C2005
    ,(SELECT COUNT(*) FROM EMPLOYEES WHERE TO_CHAR(HIRE_DATE,'YY')='06')AS C2006
FROM DUAL;

-- 77.  각 부서별 각 직업 별 연봉 총 합 및 각 부서별 연봉 총 합을 조회한다. 
SELECT DEPARTMENT_ID, JOB_ID, SUM(SALARY)
    ,(SELECT SUM(SALARY)
      FROM EMPLOYEES E1
      WHERE E1.DEPARTMENT_ID = E.DEPARTMENT_ID
    ) SumAll
FROM EMPLOYEES E
GROUP BY DEPARTMENT_ID, JOB_ID
ORDER BY DEPARTMENT_ID, JOB_ID;

SELECT DEPARTMENT_ID, JOB_ID, SUM(SALARY)
FROM EMPLOYEES E
GROUP BY ROLLUP(DEPARTMENT_ID, JOB_ID);

SELECT DEPARTMENT_ID, JOB_ID, SUM(SALARY)
FROM EMPLOYEES E
GROUP BY CUBE(DEPARTMENT_ID, JOB_ID);

SELECT JOB_ID
    ,NVL(SUM(DECODE(DEPARTMENT_ID, 20, SALARY)), 0 )AS DEPT20
    ,NVL(SUM(DECODE(DEPARTMENT_ID, 30, SALARY)), 0 )AS DEPT30
    ,NVL(SUM(DECODE(DEPARTMENT_ID, 40, SALARY)), 0 )AS DEPT40
    ,NVL(SUM(DECODE(DEPARTMENT_ID, 50, SALARY)), 0 )AS DEPT50
    ,NVL(SUM(DECODE(DEPARTMENT_ID, 80, SALARY)), 0 )AS DEPT80
    ,NVL(SUM(DECODE(DEPARTMENT_ID, 90, SALARY)), 0 )AS DEPT90
    ,NVL(SUM(DECODE(DEPARTMENT_ID, 100, SALARY)), 0 )AS DEPT100
    ,NVL(SUM(SALARY), 0)AS TOTAL
FROM EMPLOYEES
GROUP BY JOB_ID;
-- 78. LAST_NAME 이 Zlotkey 와 동일한 부서에 근무하는 모든 사원들의 사번 및 고용날짜를 조회한다.
--     결과값에서 Zlotkey 는 제외한다.
SELECT EMPLOYEE_ID, HIRE_DATE
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN(SELECT DEPARTMENT_ID
                       FROM EMPLOYEES
                       WHERE LAST_NAME = 'Zlotkey')
AND LAST_NAME != 'Zlotkey';
-- 79. 회사 전체 평균 연봉보다 더 받는 사원들의 사번 및 LAST_NAME 을 조회한다.
SELECT EMPLOYEE_ID, LAST_NAME
FROM EMPLOYEES
WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES);
-- 80. LAST_NAME 에 u 가 포함되는 사원들과 동일 부서에 근무하는 사원들의 사번 및 LAST_NAME 을 조회한다.
SELECT EMPLOYEE_ID, LAST_NAME
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN(SELECT DEPARTMENT_ID FROM EMPLOYEES
                       WHERE LAST_NAME LIKE '%u%');
-- 81. (VIEW 이용) LAST_NAME 에 u 가 포함되는 사원들과 동일 부서에 근무하는 사원들의 사번 및 LAST_NAME 을 조회한다.
SELECT  E.EMPLOYEE_ID, E.LAST_NAME
FROM    (SELECT  DISTINCT DEPARTMENT_ID
          FROM    EMPLOYEES
          WHERE   LAST_NAME LIKE '%u%'
        ) A
        , EMPLOYEES E
WHERE   A.DEPARTMENT_ID = E.DEPARTMENT_ID;

WITH ULA_DEPT AS
(SELECT  DISTINCT DEPARTMENT_ID
          FROM    EMPLOYEES
          WHERE   LAST_NAME LIKE '%u%'
)
SELECT  E.EMPLOYEE_ID, E.LAST_NAME
FROM ULA_DEPT A, EMPLOYEES E
WHERE A.DEPARTMENT_ID = E.DEPARTMENT_ID;;
-- 82. 위치 ID 가 1700 인 부서에서 근무하는 사원들의 LAST_NAME, 부서 번호 및 JOB_ID 를 조회한다.
SELECT LAST_NAME, D.DEPARTMENT_ID, JOB_ID, D.LOCATION_ID
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND D.LOCATION_ID = 1700;
-- 83. (VIEW 이용)위치 ID 가 1700 인 부서에서 근무하는 사원들의 LAST_NAME, 부서 번호 및 JOB_ID 를 조회한다.
SELECT LAST_NAME, DEPARTMENT_ID, JOB_ID
FROM(SELECT EMPLOYEE_ID
     FROM EMPLOYEES E, DEPARTMENTS D
     WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
     AND D.LOCATION_ID = 1700
    ) EL
    , EMPLOYEES E
WHERE EL.EMPLOYEE_ID = E.EMPLOYEE_ID;
-- 84. King 을 매니저로 두고 있는 모든 사원들의 LAST_NAME 및 연봉을 조회한다.
SELECT LAST_NAME, SALARY, MANAGER_ID
FROM EMPLOYEES
WHERE MANAGER_ID IN(SELECT EMPLOYEE_ID
                    FROM EMPLOYEES
                    WHERE LAST_NAME = 'King');
-- 85. EXECUTIVE 부서에 근무하는 모든 사원들의 부서 번호, LAST_NAME, JOB_ID 를 조회한다.
SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME, E.LAST_NAME, E.JOB_ID
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND DEPARTMENT_NAME = 'Executive'
ORDER BY JOB_ID, LAST_NAME;
-- 86. 회사 전체 평균 연봉 보다 더 버는 사원들 중 LAST_NAME 에 u 가 있는 사원들이
--       근무하는 부서에서 근무하는 사원들의 사번, LAST_NAME 및 연봉을 조회한다.
SELECT EMPLOYEE_ID, LAST_NAME, SALARY
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN(SELECT DISTINCT DEPARTMENT_ID
                       FROM EMPLOYEES
                       WHERE LAST_NAME LIKE '%u%'
                       AND SALARY >= (SELECT  AVG(SALARY) FROM EMPLOYEES));
-- 87. (VIEW 이용)회사 전체 평균 연봉 보다 더 버는 사원들 중 LAST_NAME 에 u 가 있는 사원들이
--       근무하는 부서에서 근무하는 사원들의 사번, LAST_NAME 및 연봉을 조회한다.
SELECT  EMPLOYEE_ID, LAST_NAME, SALARY
FROM EMPLOYEES E
    ,(SELECT DISTINCT DEPARTMENT_ID
      FROM(SELECT EMPLOYEE_ID
           FROM EMPLOYEES
           WHERE SALARY > (SELECT AVG(SALARY) FROM EMPLOYEES)
           ) E2
           , EMPLOYEES E
      WHERE E2.EMPLOYEE_ID = E.EMPLOYEE_ID
      AND E.LAST_NAME LIKE '%u%'
    ) D
WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID;
-- 88. ST_CLERK 인 직업 ID 를 가진 사원이 없는 부서 ID 를 조회한다.
--       NULL 값은 제외한다. (NOT EXISTS 사용)
SELECT DISTINCT D.DEPARTMENT_ID
FROM EMPLOYEES E,DEPARTMENTS D
WHERE E.DEPARTMENT_ID(+)=D.DEPARTMENT_ID
AND NOT EXISTS(SELECT 'A'
               FROM EMPLOYEES E1
               WHERE E1.JOB_ID = 'ST_CLERK'
               AND E1.DEPARTMENT_ID = E.DEPARTMENT_ID)
AND D.DEPARTMENT_ID IS NOT NULL
ORDER BY D.DEPARTMENT_ID;
-- 89. ST_CLERK 인 직업 ID 를 가진 사원이 있는 부서 ID 를 조회한다.
--       NULL 값은 제외한다. (NOT EXISTS 사용)
SELECT DISTINCT E.DEPARTMENT_ID
FROM EMPLOYEES E
WHERE NOT EXISTS(SELECT 'A'
               FROM EMPLOYEES E1
               WHERE E1.JOB_ID != 'ST_CLERK'
               AND E1.EMPLOYEE_ID = E.EMPLOYEE_ID)
AND E.DEPARTMENT_ID IS NOT NULL
ORDER BY E.DEPARTMENT_ID;
-- 90. 위치한 부서가 없는 국가 ID 및 국가 이름을 조회힌다.(NOT EXISTS 사용)
SELECT COUNTRY_ID, COUNTRY_NAME
FROM COUNTRIES C
WHERE NOT EXISTS(SELECT 1
                 FROM LOCATIONS L
                 WHERE L.COUNTRY_ID = C.COUNTRY_ID
                 AND L.LOCATION_ID NOT IN(SELECT DISTINCT LOCATION_ID FROM DEPARTMENTS))
ORDER BY COUNTRY_ID;
-- 91. 위치한 부서가 있는 국가 ID 및 국가 이름을 조회힌다.(EXISTS 사용)
SELECT COUNTRY_ID,COUNTRY_NAME
FROM COUNTRIES C
WHERE EXISTS(SELECT 1--L2.LOCATION_ID
            FROM LOCATIONS L2,DEPARTMENTS D2
            WHERE L2.LOCATION_ID=D2.LOCATION_ID
            AND C.COUNTRY_ID=L2.COUNTRY_ID);
-- 92. 기존의 직업을 여전히 가지고 있는 사원들의 사번 및 JOB_ID 를 조회한다.
SELECT E.EMPLOYEE_ID, E.JOB_ID
FROM EMPLOYEES E
WHERE E.EMPLOYEE_ID NOT IN(SELECT EMPLOYEE_ID
                           FROM JOB_HISTORY J
                           WHERE E.EMPLOYEE_ID = J.EMPLOYEE_ID);
-- 93. 커미션을 버는 사원들의 부서와 연봉이 동일한 사원들의 LAST_NAME, 부서 번호 및 연봉을 조회한다.
SELECT LAST_NAME, DEPARTMENT_ID, SALARY, COMMISSION_PCT
FROM EMPLOYEES
WHERE (DEPARTMENT_ID, SALARY) IN(SELECT DEPARTMENT_ID, SALARY
                                 FROM EMPLOYEES
                                 WHERE COMMISSION_PCT IS NOT NULL);
-- 94. 위치 ID 가 1700 인 사원들의 연봉과 커미션이 동일한 사원들의 LAST_NAME, 부서 번호 및 연봉을 조회한다.
SELECT LAST_NAME, DEPARTMENT_ID, SALARY
FROM EMPLOYEES E
WHERE (SALARY, NVL(COMMISSION_PCT,0)) IN(SELECT SALARY, NVL(COMMISSION_PCT, 0)
                                       FROM EMPLOYEES E2, DEPARTMENTS D2
                                       WHERE E2.DEPARTMENT_ID = D2.DEPARTMENT_ID
                                       AND LOCATION_ID = 1700)
ORDER BY E.LAST_NAME;

SELECT DISTINCT LAST_NAME, E.DEPARTMENT_ID, E.SALARY
FROM EMPLOYEES E
    ,(SELECT SALARY, NVL(COMMISSION_PCT, 0) NV
        FROM EMPLOYEES E2, DEPARTMENTS D2
        WHERE E2.DEPARTMENT_ID = D2.DEPARTMENT_ID
        AND LOCATION_ID = 1700
    ) S
WHERE S.SALARY=E.SALARY 
AND S.NV=NVL(E.COMMISSION_PCT,0)
ORDER BY E.LAST_NAME;
-- 95. LAST_NAME 이 'Kochhar' 인 사원과 동일한 연봉 및 커미션을 버는 사원들의 LAST_NAME, 부서 번호 및 연봉을 조회한다.
SELECT LAST_NAME, DEPARTMENT_ID, SALARY, COMMISSION_PCT
FROM EMPLOYEES
WHERE (SALARY, NVL(COMMISSION_PCT,0)) IN(SELECT  SALARY, NVL(COMMISSION_PCT, 0)
                                        FROM EMPLOYEES E2
                                        WHERE LAST_NAME = 'Kochhar');
-- 96. 직업 ID 가 SA_MAN 인 사원들이 받을 수 있는 최대 연봉 보다 높게 받는 사원들의 LAST_NAME, JOB_ID 및 연봉을 조회한다.
SELECT LAST_NAME,JOB_ID,SALARY
FROM EMPLOYEES
WHERE SALARY >(SELECT MAX_SALARY FROM JOBS WHERE JOB_ID='SA_MAN');
-- 97. 도시 이름이 T 로 시작하는 지역에 사는 사원들의 사번, LAST_NAME 및 부서 번호를 조회한다.
SELECT EMPLOYEE_ID, LAST_NAME, D.DEPARTMENT_ID, CITY
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID AND D.LOCATION_ID = L.LOCATION_ID
AND CITY LIKE 'T%';
-- 98.  각 부서별 평균 연봉보다 더 받는 동일부서 근무사원들의
--      LAST_NAME, 연봉, 부서번호 및 해당 부서의 평균 연봉을 조회한다.
--      결과는 부서별 연봉을 기준으로 정렬한다.
SELECT  E.LAST_NAME, E.SALARY, E.DEPARTMENT_ID, DA.D_AVG
FROM EMPLOYEES E
    ,(SELECT DEPARTMENT_ID, ROUND( AVG(SALARY), 0 ) D_AVG
      FROM EMPLOYEES
      GROUP BY DEPARTMENT_ID) DA
WHERE E.DEPARTMENT_ID = DA.DEPARTMENT_ID
AND E.SALARY > DA.D_AVG
ORDER BY DA.D_AVG;
-- 99. 소속부서의 평균 연봉보다 적게 버는 사원들의 last_name 을 조회한다.
SELECT LAST_NAME, SALARY, E.DEPARTMENT_ID, DV.AVG_SALARY
FROM EMPLOYEES E
    ,(SELECT DEPARTMENT_ID, ROUND(AVG(SALARY),0) AVG_SALARY
      FROM EMPLOYEES
      GROUP BY DEPARTMENT_ID
    ) DV
WHERE E.DEPARTMENT_ID = DV.DEPARTMENT_ID
AND E.SALARY < DV.AVG_SALARY
ORDER BY DV.AVG_SALARY, E.SALARY;
-- 100. 각 사원 별 소속부서에서 자신보다 늦게 고용되었으나 보다 많은 연봉을 받는 사원이 존재하는 모든 사원들의 last_name 을 조회한다.
SELECT DISTINCT E.LAST_NAME, E.DEPARTMENT_ID
FROM EMPLOYEES E, EMPLOYEES E2
WHERE E.DEPARTMENT_ID = E2.DEPARTMENT_ID
AND E.HIRE_DATE < E2.HIRE_DATE
AND E.SALARY < E2.SALARY;
--101. 직책(Job Title)이 Sales Manager인 사원들의 입사년도와 입사년도(hire_date)별 평균 급여를 출력하시오. 
--   출력 시 년도를 기준으로 오름차순 정렬하시오. 
SELECT TO_CHAR(E.HIRE_DATE, 'YYYY') , AVG(E.SALARY)
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_ID 
AND J.JOB_TITLE = 'Sales Manager' 
GROUP BY TO_CHAR(E.HIRE_DATE,'YYYY')
ORDER BY TO_CHAR(E.HIRE_DATE,'YYYY') ASC;
--102. 각 도시(city)에 있는 모든 부서 직원들의 평균급여를 조회하고자 한다. 
--   평균급여가 가장 낮은 도시부터 도시명(city)과 평균연봉, 해당 도시의 직원수를 출력하시오. 
--   단, 도시에 근 무하는 직원이 10명 이상인 곳은 제외하고 조회하시오.
SELECT L.CITY,AVG(E.SALARY),COUNT(*)
FROM EMPLOYEES E, LOCATIONS L, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID 
AND D.LOCATION_ID = L.LOCATION_ID
GROUP BY L.CITY
HAVING COUNT(*) < 10
ORDER BY AVG(E.SALARY) ASC;
--103. ‘Public  Accountant’의 직책(job_title)으로 과거에 근무한 적이 있는 모든 사원의 사번과 이름을 출력하시오. 
--   (현재 ‘Public Accountant’의 직책(job_title)으로 근무하는 사원은 고려 하지 않는다.)      
--   이름은 first_name, last_name을 아래의 실행결과와 같이 출력한다.
SELECT E.EMPLOYEE_ID, E.FIRST_NAME||' '||E.LAST_NAME FULLNAME 
FROM EMPLOYEES E, JOBS J, JOB_HISTORY JH
WHERE J.JOB_TITLE = 'Public Accountant' 
AND JH.JOB_ID = J.JOB_ID 
AND E.EMPLOYEE_ID = JH.EMPLOYEE_ID;
--104. 자신의 매니저보다 연봉(salary)를 많이 받는 직원들의 성(last_name)과 연봉(salary)를 출 력하시오. 
SELECT E.LAST_NAME, E.SALARY
FROM EMPLOYEES E, EMPLOYEES M
WHERE E.MANAGER_ID = M.EMPLOYEE_ID 
AND E.SALARY > M.SALARY;   
--105. 2007년에 입사(hire_date)한 직원들의 사번(employee_id), 이름(first_name), 성(last_name), 
--   부서명(department_name)을 조회합니다.  
--   이때, 부서에 배치되지 않은 직원의 경우, ‘<Not Assigned>’로 출력하시오. 
SELECT E.EMPLOYEE_ID , E.LAST_NAME , E.FIRST_NAME 
    ,NVL(D.DEPARTMENT_NAME, '<Not Assigned>')
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
AND TO_CHAR(E.HIRE_DATE, 'YYYY') = '2007'
ORDER BY E.EMPLOYEE_ID ASC;
--106. 업무명(job_title)이 ‘Sales Representative’인 직원 중에서 연봉(salary)이 9,000이상, 10,000 이하인 
--   직원들의 이름(first_name), 성(last_name)과 연봉(salary)를 출력하시오
SELECT E.FIRST_NAME, E.LAST_NAME, E.SALARY
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_ID 
AND E.SALARY BETWEEN 9000 AND 10000 
AND J.JOB_TITLE='Sales Representative';
--107. 부서별로 가장 적은 급여를 받고 있는 직원의 이름, 부서이름, 급여를 출력하시오. 
--   이름은 last_name만 출력하며, 부서이름으로 오름차순 정렬하고, 
--   부서가 같은 경우 이름을 기준 으로 오름차순 정렬하여 출력합니다. 
SELECT E1.LAST_NAME, A.*
FROM EMPLOYEES E1
    ,(SELECT D.DEPARTMENT_NAME, MIN(E2.SALARY) AS MINSAL
      FROM EMPLOYEES E2, DEPARTMENTS D 
      WHERE E2.DEPARTMENT_ID = D.DEPARTMENT_ID 
      GROUP BY D.DEPARTMENT_NAME
    ) A
WHERE E1.SALARY=A.MINSAL
ORDER BY A.DEPARTMENT_NAME ASC, E1.LAST_NAME ASC;
--108. EMPLOYEES 테이블에서 급여를 많이 받는 순서대로 조회했을 때 결과처럼 6번째부터 10 번째까지 
--   5명의 last_name, first_name, salary를 조회하는 sql문장을 작성하시오.
SELECT *
FROM(SELECT RANK() OVER (ORDER BY SALARY DESC) AS RANKING
        ,LAST_NAME,FIRST_NAME,SALARY
    FROM EMPLOYEES 
    ORDER BY SALARY DESC)
WHERE RANKING BETWEEN 6 AND 10;
--109. 사원의 부서가 속한 도시(city)가 ‘Seattle’인 사원의 이름, 해당 사원의 매니저 이름, 사원 의 부서이름을 출력하시오. 
--   이때 사원의 매니저가 없을 경우 ‘<없음>’이라고 출력하시오. 이름은 last_name만 출력하며, 
--   사원의 이름을 오름차순으로 정렬하시오. 
SELECT ET.E_NAME, DECODE(ET.M_NAME,' ','<없음>',ET.M_NAME) AS M_NAME, D.DEPARTMENT_NAME
FROM(
    SELECT E.FIRST_NAME||' '||E.LAST_NAME AS E_NAME
        , M.FIRST_NAME||' '||M.LAST_NAME AS M_NAME
        , E.DEPARTMENT_ID 
         FROM EMPLOYEES E,EMPLOYEES M
         WHERE E.MANAGER_ID = M.EMPLOYEE_ID(+)
    ) ET, DEPARTMENTS D, LOCATIONS L
WHERE ET.DEPARTMENT_ID = D.DEPARTMENT_ID 
AND D.LOCATION_ID = L.LOCATION_ID
AND L.CITY = 'Seattle' 
ORDER BY ET.E_NAME ASC;
--110. 각 업무(job) 별로 연봉(salary)의 총합을 구하고자 한다. 연봉 총합이 가장 높은 업무부터 
--    업무명(job_title)과 연봉 총합을 조회하시오. 단 연봉총합이 30,000보다 큰 업무만 출력하시오. 
SELECT J.JOB_TITLE, SUM(E.SALARY)AS SALSUM
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_ID
GROUP BY J.JOB_TITLE
HAVING SUM(E.SALARY) > 30000
ORDER BY SALSUM DESC;
--111. 각 사원(employee)에 대해서 사번(employee_id), 이름(first_name), 업무명(job_title), 
--    부서 명(department_name)을 조회하시오. 
--    단 도시명(city)이 ‘Seattle’인 지역(location)의 부서 (department)에 근무하는 직원을 사원번호 오름차순순으로 출력하시오.
SELECT E.EMPLOYEE_ID, E.FIRST_NAME, J.JOB_TITLE, D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, JOBS J
WHERE J.JOB_ID = E.JOB_ID 
AND E.DEPARTMENT_ID = D.DEPARTMENT_ID 
AND D.LOCATION_ID = L.LOCATION_ID
AND L.CITY = 'Seattle' 
ORDER BY E.EMPLOYEE_ID ASC;
--112. 2001~20003년사이에 입사한 직원의 이름(first_name), 입사일(hire_date), 관리자사번 (employee_id), 
--    관리자 이름(fist_name)을 조회합니다. 단, 관리자가 없는 사원정보도 출력 결과에 포함시켜 출력한다.
SELECT E.FIRST_NAME
    ,TO_CHAR(E.HIRE_DATE, 'YYYY-MM-DD AM HH12:MI:SS') AS HIRE_DATE
    ,E.MANAGER_ID, M.FIRST_NAME
FROM EMPLOYEES E, EMPLOYEES M
WHERE E.MANAGER_ID = M.EMPLOYEE_ID(+)
AND TO_CHAR(E.HIRE_DATE, 'YYYY') BETWEEN '2001' AND '2003';
--113. ‘Sales’ 부서에 속한 직원의 이름(first_name), 급여(salary), 부서이름(department_name)을 조회하시오. 
--    단, 급여는 100번 부서의 평균보다 적게 받는 직원 정보만 출력되어야 한다. 
SELECT E.FIRST_NAME, E.SALARY, D.DEPARTMENT_NAME 
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID 
AND D.DEPARTMENT_NAME = 'Sales'
AND E.SALARY < (SELECT AVG(SALARY) FROM EMPLOYEES WHERE DEPARTMENT_ID = 100); 
--114. Employees 테이블에서 입사한달(hire_date)별로 인원수를 조회하시오.
SELECT TO_CHAR(E.HIRE_DATE, 'MM'), COUNT(*)
FROM EMPLOYEES E
GROUP BY TO_CHAR(E.HIRE_DATE, 'MM')
ORDER BY TO_CHAR(E.HIRE_DATE, 'MM') ASC;
--115. 부서별 직원들의 최대, 최소, 평균급여를 조회하되, 
--    평균급여가 ‘IT’ 부서의 평균급여보다 많고, ‘Sales’ 부서의 평균보다 적은 부서 정보만 출력하시오. 
SELECT D.DEPARTMENT_NAME, MAX(E.SALARY), MIN(E.SALARY), AVG(E.SALARY)
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
GROUP BY D.DEPARTMENT_NAME
HAVING AVG(E.SALARY) > (SELECT AVG(E.SALARY)
                        FROM EMPLOYEES E, DEPARTMENTS D
                        WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID
                        AND D.DEPARTMENT_NAME = 'IT')
AND AVG(E.SALARY) < (SELECT AVG(E.SALARY)
                     FROM EMPLOYEES E, DEPARTMENTS D
                     WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID
                     AND D.DEPARTMENT_NAME = 'Sales');
--116. 각 부서별로 직원이 한명만 있는 부서만 조회하시오. 
--    단, 직원이 없는 부서에 대해서는 ‘<신생부서>’라는 문자열이 출력되도록 하고,
--    출력결과는 다음과 같이 부서명이 내림차순 으로 정렬되어야한다. 
SELECT NVL(D.DEPARTMENT_NAME, '<신생부서>') AS DEPT_NAME, COUNT(*)
FROM EMPLOYEES E ,DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
GROUP BY D.DEPARTMENT_NAME
HAVING COUNT(*) = 1
ORDER BY D.DEPARTMENT_NAME DESC;
--117. 부서별 입사월별 직원수를 출력하시오. 
--    단, 직원수가 5명 이상인 부서만 출력되어야 하며 출력결과는 부서이름 순으로 한다.
SELECT D.DEPARTMENT_NAME
    ,TO_CHAR(E.HIRE_DATE, 'MON') AS HIRE_MONTH
    ,COUNT(*)
FROM DEPARTMENTS D, EMPLOYEES E
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID 
GROUP BY D.DEPARTMENT_NAME, TO_CHAR(E.HIRE_DATE, 'MON')
HAVING COUNT (*) >= 5
ORDER BY D.DEPARTMENT_NAME ASC;
--118. 국가(country_name) 별 도시(city)별 직원수를 조회하시오. 
--    단, 부서에 속해있지 않은 직원 이 있기 때문에 106명의 직원만 출력이 된다. 
--    부서정보가 없는 직원은 국가명과 도시명 대신에 ‘<부서없음>’이 출력되도록 하여 107명 모두 출력되게 한다.
SELECT NVL(C.COUNTRY_NAME, '<부서없음>') AS COUNTRY_NAME
    , NVL(L.CITY, '<부서없음>') AS CITY
    , COUNT(*)
FROM EMPLOYEES E 
LEFT JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID 
LEFT JOIN LOCATIONS L ON D.LOCATION_ID = L.LOCATION_ID
LEFT JOIN COUNTRIES C ON L.COUNTRY_ID = C.COUNTRY_ID 
GROUP BY COUNTRY_NAME, CITY
ORDER BY COUNTRY_NAME ASC, CITY ASC;

SELECT NVL(C.COUNTRY_NAME, '<부서없음>') AS COUNTRY_NAME
    , NVL(L.CITY, '<부서없음>') AS CITY
    , COUNT(*)
FROM EMPLOYEES E,DEPARTMENTS D,LOCATIONS L,COUNTRIES C
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
AND D.LOCATION_ID = L.LOCATION_ID(+)
AND L.COUNTRY_ID = C.COUNTRY_ID(+) 
GROUP BY COUNTRY_NAME, CITY
ORDER BY COUNTRY_NAME ASC, CITY ASC;
--119. 각 부서별 최대 급여자의 아이디(employee_id), 이름(first_name), 급여(salary)를 출력하시오. 
--    단, 최대 급여자가 속한 부서의 평균급여를 마지막으로 출력하여 평균급여와 비교할 수 있게 할 것.
SELECT A.DNAME,E.EMPLOYEE_ID, E.FIRST_NAME, A.SALARY, A.AVG
FROM EMPLOYEES E
    ,(SELECT E.DEPARTMENT_ID,MAX(D.DEPARTMENT_NAME)AS DNAME
        ,MAX(E.SALARY) AS SALARY
        ,AVG(E.SALARY)AS AVG
      FROM EMPLOYEES E, DEPARTMENTS D
      WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
      GROUP BY E.DEPARTMENT_ID
    ) A
 WHERE E.SALARY = A.SALARY 
 AND E.DEPARTMENT_ID = A.DEPARTMENT_ID;
--120. 커미션(commission_pct)별 직원수를 조회하시오. 
--    커미션은 아래실행결과처럼 0.2, 0.25는 모두 .2로, 0.3, 0.35는 .3 형태로 출력되어야 한다. 
--    단, 커미션 정보가 없는 직원들도 있는 데 커미션이 없는 직원 그룹은 ‘<커미션 없음>’이 출력되게 한다.
SELECT TO_CHAR(0),TO_CHAR(0.23) FROM DUAL;
SELECT NVL(TO_CHAR(TRUNC(E.COMMISSION_PCT,1)), '<커미션없음>') AS COMMISSION, COUNT(*)
FROM EMPLOYEES E 
GROUP BY NVL(TO_CHAR(TRUNC(E.COMMISSION_PCT,1)), '<커미션없음>');
--121. 커미션(commission_pct)을 가장 많이 받은 상위 4명의 부서명(department_name), 
--    직원명 (first_name), 급여(salary), 커미션(commission_pct) 정보를 조회하시오. 
--    출력결과는 커미션 을 많이 받는 순서로 출력하되 동일한 커미션에 대해서는 급여가 높은 직원이 먼저 출력 되게 한다.
SELECT * 
FROM(SELECT D.DEPARTMENT_NAME, E.FIRST_NAME, E.SALARY, E.COMMISSION_PCT
     FROM EMPLOYEES E, DEPARTMENTS D
     WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
     AND E.COMMISSION_PCT IS NOT NULL
     ORDER BY E.COMMISSION_PCT DESC NULLS LAST, E.SALARY DESC)
WHERE ROWNUM <= 4;
--Q1 부서명, 직원명(first_name),급여,커미션 컬럼을 갖는 뷰를 작성하시요.
--단 커미션 포인트가 없을 경우 0으로 반환
CREATE OR REPLACE VIEW TEST1 AS
SELECT D.DEPARTMENT_NAME,E.FIRST_NAME,E.SALARY,
NVL(E.COMMISSION_PCT,0)AS COMMISSION_PCT
FROM EMPLOYEES E,DEPARTMENTS D
WHERE E.DEPARTMENT_ID=D.DEPARTMENT_ID;

--Q2 부서명, 직책, 직원명, 입사일을 갖는 뷰를 작성하시오.

CREATE OR REPLACE VIEW TEST2 AS
SELECT D.DEPARTMENT_NAME,J.JOB_TITLE,E.FIRST_NAME,E.HIRE_DATE
FROM EMPLOYEES E, DEPARTMENTS D, JOBS J
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID
AND E.JOB_ID = J.JOB_ID;

--Q3 부서테이블을 복사하여 새 테이블을 만들고 그 테이블에 직원수 컬럼을 추가하고 초기값을 셋팅한 후 
--직원의 입사 및 퇴사시 직원수 컬럼을 조정하는 트리거를 작성하시오
CREATE TABLE DEPT_TEST 
AS SELECT D.*,NVL(A.EMP_CNT,0) AS EMP_CNT
FROM DEPARTMENTS D,(
    SELECT D1.DEPARTMENT_ID, COUNT(*) AS EMP_CNT
    FROM EMPLOYEES E, DEPARTMENTS D1
    WHERE E.DEPARTMENT_ID=D1.DEPARTMENT_ID
    GROUP BY D1.DEPARTMENT_ID
) A
WHERE D.DEPARTMENT_ID=A.DEPARTMENT_ID;

SELECT * FROM DEPT_TEST;

CREATE OR REPLACE TRIGGER TRIG_TEST
AFTER INSERT OR DELETE OR UPDATE ON EMPLOYEES
FOR EACH ROW 
BEGIN
    IF INSERTING THEN
        UPDATE DEPT_TEST
        SET EMP_CNT=EMP_CNT+1
        WHERE DEPARTMENT_ID = :NEW.DEPARTMENT_ID;
    ELSIF UPDATING THEN
        IF :OLD.DEPARTMENT_ID <> :NEW.DEPARTMENT_ID THEN
            UPDATE DEPT_TEST
            SET EMP_CNT=EMP_CNT+1
            WHERE DEPARTMENT_ID = :NEW.DEPARTMENT_ID;
            UPDATE DEPT_TEST
            SET EMP_CNT=EMP_CNT-1
            WHERE DEPARTMENT_ID = :OLD.DEPARTMENT_ID;
        END IF;    
    ELSIF DELETING THEN
        UPDATE DEPT_TEST
        SET EMP_CNT=EMP_CNT-1
        WHERE DEPARTMENT_ID = :OLD.DEPARTMENT_ID;
    END IF;
END;  
--Q4 부서ID를 입력하면 부서명을 반환하는 함수를 작성하시오.
CREATE OR REPLACE FUNCTION FN_GET_DEPT_NAME(P_DEPT_ID IN NUMBER)
RETURN VARCHAR2
IS
    V_DEPT_NAME DEPARTMENTS.DEPARTMENT_NAME%TYPE;
BEGIN
    SELECT DEPARTMENT_NAME INTO V_DEPT_NAME
    FROM DEPARTMENTS
    WHERE DEPARTMENT_ID=P_DEPT_ID;
    RETURN V_DEPT_NAME;
END;
SELECT FN_GET_DEPT_NAME(10) FROM DUAL;


--Q5 부서ID를 입력하면 해당 부서의 직원 목록을 출력하는 프로시저를 작성하시오.
CREATE OR REPLACE PROCEDURE PROC_TEST(P_DEPT_ID IN NUMBER)
IS
BEGIN
    FOR EMP IN(SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID=P_DEPT_ID)
    LOOP
        DBMS_OUTPUT.PUT_LINE(EMP.EMPLOYEE_ID||' '||EMP.FIRST_NAME||'...')
    END LOOP;
END PROC_TEST;
