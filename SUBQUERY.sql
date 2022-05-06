-- 서브쿼리(자식쿼리) *****
-- SELECT 안에 또다른 SELECT가 포함된 형태
-- : 서브쿼리 (1건만 비교해야함)
-- 문법) SELECT 컬럼리스트
--       FROM 테이블명
--       WHERE 컬럼명 = (SELECT문)

-- 예) SCOTT와 동일한 부서에서 근무하는 사원 출력하기
-- = 서브쿼리 : 데이터 1건만 비교해야함
SELECT ENAME, DNO
FROM EMPLOYEE
WHERE DNO = (SELECT DNO 
FROM EMPLOYEE
WHERE ENAME = 'SCOTT'); -- 서브쿼리 (소괄호 필요)

-- 동일한 부서 검색
SELECT DNO 
FROM EMPLOYEE
WHERE ENAME = 'SCOTT'; -- 부서번호 = 20

-- 문제1) 최소 급여를 받는 사원의 이름, 담당업무, 급여출력.
SELECT ENAME,JOB,SALARY 
FROM EMPLOYEE 
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);

-- 메인 쿼리에 HAVING 절 사용하기
SELECT DNO, MIN(SALARY) AS 최소급여
FROM EMPLOYEE
GROUP BY DNO
HAVING MIN(SALARY) > ( SELECT MIN(SALARY) FROM EMPLOYEE WHERE DNO = 30 );

-- 여러건 서브쿼리(SUBQUERY)
-- IN / EXIST 연산자 비교
-- 성능 : EXIST 검색 속도가 훨씬 좋음
-- IN : 메인쿼리의 비교 조건이 서브 쿼리의 결과 중에서 하나라도 일치하면 참
-- (조회순서 : 서브쿼리 먼저 실행 -> 메인쿼리 실행하면서 조건 비교 )
-- EXIST : 메인쿼리 비교 조건이 서브 쿼리의 결과 중에서 
-- 만족하는 값이 하나라도 존재하면 참 
-- (조회순서 : 메인쿼리 먼저 실행 -> 서브쿼리를 조건 비교하다가 만족하면 BREAK 빠져나옴)

-- 다중 행 서브쿼리
-- 예)
SELECT ENO, ENAME
FROM EMPLOYEE
WHERE SALARY IN ( SELECT MIN(SALARY) FROM EMPLOYEE GROUP BY DNO);

SELECT MIN(SALARY) FROM EMPLOYEE GROUP BY DNO;

-- EXIST 사용예) IN보다 조회 속도가 빠름
SELECT ENO, ENAME
FROM EMPLOYEE A
WHERE EXISTS ( SELECT 1 FROM EMPLOYEE  GROUP BY DNO HAVING A.SALARY = MIN(SALARY));

-- 문제 1) 사원번호가 7788인 사원과 담당 업무가 같은 사원을 표시하시오.
-- 힌트 : = 서브쿼리
-- 담당 업무 : JOB
-- 대상 테이블 : EMPLOYEE
SELECT ENO, ENAME ,JOB
FROM EMPLOYEE
WHERE ENO IN ( SELECT ENO FROM EMPLOYEE WHERE ENO = 7788);


-- 문제 2) 최소 급여를 받는 사원의 이름, 담당 업무 및 급여를 표시하시오.
-- (그룹함수 사용)
-- 급여 컬럼 : SALARY
-- 대상 테이블 : EMPLOYEE

SELECT ENAME, JOB, SALARY
FROM EMPLOYEE
WHERE SALARY IN ( SELECT MIN(SALARY) FROM EMPLOYEE );

-- 문제 3) 평균 급여가 가장 적은 사원의 담당 업무를 찾아 직급과 평균 급여 표시하시오.
-- 어려운 문제
-- 담당 업무 컬럼 : JOB
-- 대상 테이블 : EMPLOYEE

SELECT JOB ,ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY JOB
HAVING ROUND(AVG(SALARY), 1) = (SELECT MIN(ROUND(AVG(SALARY), 1)) FROM EMPLOYEE GROUP BY JOB);
-- 문제 5) 각 부서의 최소 급여를 받는 사원의 이름, 급여, 부서번호를 표기하시오.
-- 힌트 : IN 서브쿼리
SELECT ENAME, SALARY, DNO 
FROM EMPLOYEE
WHERE SALARY IN (SELECT MIN(SALARY) FROM EMPLOYEE);

-- 문제 6) 부하직원이 없는 사원의 이름을 표기하시오.
SELECT * FROM EMPLOYEE;
SELECT ENAME
FROM EMPLOYEE
WHERE ENO IN ( SELECT ENO FROM EMPLOYEE WHERE MANAGER IS NULL);

-- 문제 7) 부하직원이 있는 사원의 이름을 표기하시오.
SELECT ENAME
FROM EMPLOYEE
WHERE ENO IN ( SELECT ENO FROM EMPLOYEE WHERE MANAGER IS NOT NULL);

-- 문제 8) BLAKE와 동일한 부서에 속한 사원의 이름과 입사일을 표기하는 질의를
-- 작성하시오.( 단, BLAKE는 제외하시오. )

SELECT ENAME, HIREDATE
FROM EMPLOYEE
WHERE DNO = (SELECT DNO FROM EMPLOYEE WHERE ENAME = 'BLAKE')
AND ENAME <> 'BLAKE';

















































