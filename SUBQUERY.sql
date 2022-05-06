-- ��������(�ڽ�����) *****
-- SELECT �ȿ� �Ǵٸ� SELECT�� ���Ե� ����
-- : �������� (1�Ǹ� ���ؾ���)
-- ����) SELECT �÷�����Ʈ
--       FROM ���̺��
--       WHERE �÷��� = (SELECT��)

-- ��) SCOTT�� ������ �μ����� �ٹ��ϴ� ��� ����ϱ�
-- = �������� : ������ 1�Ǹ� ���ؾ���
SELECT ENAME, DNO
FROM EMPLOYEE
WHERE DNO = (SELECT DNO 
FROM EMPLOYEE
WHERE ENAME = 'SCOTT'); -- �������� (�Ұ�ȣ �ʿ�)

-- ������ �μ� �˻�
SELECT DNO 
FROM EMPLOYEE
WHERE ENAME = 'SCOTT'; -- �μ���ȣ = 20

-- ����1) �ּ� �޿��� �޴� ����� �̸�, ������, �޿����.
SELECT ENAME,JOB,SALARY 
FROM EMPLOYEE 
WHERE SALARY = (SELECT MIN(SALARY) FROM EMPLOYEE);

-- ���� ������ HAVING �� ����ϱ�
SELECT DNO, MIN(SALARY) AS �ּұ޿�
FROM EMPLOYEE
GROUP BY DNO
HAVING MIN(SALARY) > ( SELECT MIN(SALARY) FROM EMPLOYEE WHERE DNO = 30 );

-- ������ ��������(SUBQUERY)
-- IN / EXIST ������ ��
-- ���� : EXIST �˻� �ӵ��� �ξ� ����
-- IN : ���������� �� ������ ���� ������ ��� �߿��� �ϳ��� ��ġ�ϸ� ��
-- (��ȸ���� : �������� ���� ���� -> �������� �����ϸ鼭 ���� �� )
-- EXIST : �������� �� ������ ���� ������ ��� �߿��� 
-- �����ϴ� ���� �ϳ��� �����ϸ� �� 
-- (��ȸ���� : �������� ���� ���� -> ���������� ���� ���ϴٰ� �����ϸ� BREAK ��������)

-- ���� �� ��������
-- ��)
SELECT ENO, ENAME
FROM EMPLOYEE
WHERE SALARY IN ( SELECT MIN(SALARY) FROM EMPLOYEE GROUP BY DNO);

SELECT MIN(SALARY) FROM EMPLOYEE GROUP BY DNO;

-- EXIST ��뿹) IN���� ��ȸ �ӵ��� ����
SELECT ENO, ENAME
FROM EMPLOYEE A
WHERE EXISTS ( SELECT 1 FROM EMPLOYEE  GROUP BY DNO HAVING A.SALARY = MIN(SALARY));

-- ���� 1) �����ȣ�� 7788�� ����� ��� ������ ���� ����� ǥ���Ͻÿ�.
-- ��Ʈ : = ��������
-- ��� ���� : JOB
-- ��� ���̺� : EMPLOYEE
SELECT ENO, ENAME ,JOB
FROM EMPLOYEE
WHERE ENO IN ( SELECT ENO FROM EMPLOYEE WHERE ENO = 7788);


-- ���� 2) �ּ� �޿��� �޴� ����� �̸�, ��� ���� �� �޿��� ǥ���Ͻÿ�.
-- (�׷��Լ� ���)
-- �޿� �÷� : SALARY
-- ��� ���̺� : EMPLOYEE

SELECT ENAME, JOB, SALARY
FROM EMPLOYEE
WHERE SALARY IN ( SELECT MIN(SALARY) FROM EMPLOYEE );

-- ���� 3) ��� �޿��� ���� ���� ����� ��� ������ ã�� ���ް� ��� �޿� ǥ���Ͻÿ�.
-- ����� ����
-- ��� ���� �÷� : JOB
-- ��� ���̺� : EMPLOYEE

SELECT JOB ,ROUND(AVG(SALARY))
FROM EMPLOYEE
GROUP BY JOB
HAVING ROUND(AVG(SALARY), 1) = (SELECT MIN(ROUND(AVG(SALARY), 1)) FROM EMPLOYEE GROUP BY JOB);
-- ���� 5) �� �μ��� �ּ� �޿��� �޴� ����� �̸�, �޿�, �μ���ȣ�� ǥ���Ͻÿ�.
-- ��Ʈ : IN ��������
SELECT ENAME, SALARY, DNO 
FROM EMPLOYEE
WHERE SALARY IN (SELECT MIN(SALARY) FROM EMPLOYEE);

-- ���� 6) ���������� ���� ����� �̸��� ǥ���Ͻÿ�.
SELECT * FROM EMPLOYEE;
SELECT ENAME
FROM EMPLOYEE
WHERE ENO IN ( SELECT ENO FROM EMPLOYEE WHERE MANAGER IS NULL);

-- ���� 7) ���������� �ִ� ����� �̸��� ǥ���Ͻÿ�.
SELECT ENAME
FROM EMPLOYEE
WHERE ENO IN ( SELECT ENO FROM EMPLOYEE WHERE MANAGER IS NOT NULL);

-- ���� 8) BLAKE�� ������ �μ��� ���� ����� �̸��� �Ի����� ǥ���ϴ� ���Ǹ�
-- �ۼ��Ͻÿ�.( ��, BLAKE�� �����Ͻÿ�. )

SELECT ENAME, HIREDATE
FROM EMPLOYEE
WHERE DNO = (SELECT DNO FROM EMPLOYEE WHERE ENAME = 'BLAKE')
AND ENAME <> 'BLAKE';

















































