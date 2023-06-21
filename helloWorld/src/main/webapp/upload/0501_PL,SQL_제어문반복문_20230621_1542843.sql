/*
    <PL/SQL �����(EXECUTABLE SECTION)>
        1) ���ù�
          1-1) ���� IF ����
            [ǥ����]
                IF ���ǽ� THEN
                    ���� ����
                END IF;
*/
-- ����� �Է¹��� �� �ش� ����� ���, �̸�, �޿�, ���ʽ��� ���
-- ��, ���ʽ��� ���� �ʴ� ����� ���ʽ� ��� ���� 
-- '���ʽ��� ���޹��� �ʴ� ����Դϴ�.'��� ������ ����Ѵ�.
DECLARE
    e EMP%ROWTYPE;
BEGIN
    SELECT  EMP_ID, EMP_NAME, SALARY, BONUS
    INTO    e.EMP_ID, e.EMP_NAME, e.SALARY, e.BONUS
    FROM    EMP
    WHERE   EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || e.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || e.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || e.SALARY);
        IF e.BONUS IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�.');
        END IF;
    -- ��ȿ���� ���� �������� ���ڸ� ���
    DBMS_OUTPUT.PUT_LINE('���ʽ� : ' || TRIM(TO_CHAR(NVL(e.BONUS, '0.0'), 0)));
END;
/

/*
    1-2) IF ~ ELSE ����
      [ǥ����]
        IF ���ǽ� THEN
            ���� ����
        ELSE 
            ���� ����
        END IF;
*/
DECLARE
    e EMP%ROWTYPE;
BEGIN
    SELECT  EMP_ID, EMP_NAME, SALARY, BONUS
    INTO    e.EMP_ID, e.EMP_NAME, e.SALARY, e.BONUS
    FROM    EMP
    WHERE   EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || e.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || e.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�޿� : ' || e.SALARY);
    IF e.BONUS IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('���ʽ��� ���޹��� �ʴ� ����Դϴ�.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('���ʽ� : ' || TRIM(TO_CHAR(e.BONUS, '0.0')));
    END IF;
    
END;
/

/*
    1-3) IF ~ ELSIF ~ ELSE ����
      [ǥ����]
        IF ���ǽ� THEN
            ���� ����
        ELSIF ���ǽ� THEN
            ���� ����
        ...
        [ELSE
            ���� ����]
        END IF;
*/
-- ����ڿ��� ������ �Է¹޾� SCORE ������ ������ �� ������ �Էµ� ������ ���� GRADE ������ �����Ѵ�.
--  90�� �̻��� 'A'
--  80�� �̻��� 'B'
--  70�� �̻��� 'C'
--  60�� �̻��� 'D'
--  60�� �̸��� 'F'
-- ����� '����� ������ 95���̰�, ������ A�����Դϴ�.'�� ���� ����Ѵ�.
DECLARE
    score number;
    grade char(1);
BEGIN
    score := &����;
    IF  score >= 90 THEN
        DBMS_OUTPUT.PUT_LINE('����� ������ ' || score || '�� �̰�, ������ ' ||'A �����Դϴ�.');
    ELSIF score >= 80 THEN
        DBMS_OUTPUT.PUT_LINE('����� ������ ' || score || '�� �̰�, ������ ' ||'B �����Դϴ�.');
    ELSIF score >= 70 THEN
        DBMS_OUTPUT.PUT_LINE('����� ������ ' || score || '�� �̰�, ������ ' ||'C �����Դϴ�.');
    ELSIF score >= 60 THEN
        DBMS_OUTPUT.PUT_LINE('����� ������ ' || score || '�� �̰�, ������ ' ||'D �����Դϴ�.');
    ELSIF score < 60 THEN
        DBMS_OUTPUT.PUT_LINE('����� ������ ' || score || '�� �̰�, ������ ' ||'F �����Դϴ�.');
    END IF;
END;                    --// ������ �����ϰ� �ߴ�.
/

DECLARE
    score number;
    grade char(1);
BEGIN
    score := &����;
    IF  score >= 90 THEN
        grade := 'A';
    ELSIF score >= 80 THEN
        grade := 'B';
    ELSIF score >= 70 THEN
        grade := 'C';
    ELSIF score >= 60 THEN
        grade := 'D';
    ELSE
        grade := 'F';
    END IF;
DBMS_OUTPUT.PUT_LINE('����� ������ ' || score || 
                        '�� �̰�, ������ ' || grade || '�����Դϴ�.');
    
END;
/

-- ����� ��ȣ�� �Է� �޾Ƽ�
-- ���, �̸�, �޿��� ���
/*
    �޿��� 200���� �̻� ~ 300���� �̸��̸� E ���
    �޿��� 300���� �̻� ~ 400���� �̸��̸� D ���
    �޿��� 400���� �̻� ~ 500���� �̸��̸� C ���
    �޿��� 500���� �̻� ~ 600���� �̸��̸� B ���
    �޿��� 600���� �̻��̸� A���
*/
DECLARE
    -- ���� ����
    e EMP%ROWTYPE;
BEGIN
    SELECT  *
    INTO    e
    FROM    EMP
    WHERE   EMP_ID = &���;
    
    DBMS_OUTPUT.PUT_LINE('eid : ' || e.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('ename : ' || e.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('salary : ' || e.SALARY);
END;
/

DECLARE
    -- ���� ����
    eid EMP.EMP_ID%TYPE;
    ename EMP.EMP_NAME%TYPE;
    sal EMP.SALARY%TYPE;
    grade CHAR(1);
BEGIN
    
    -- ��ȸ ����� ������ ���
    SELECT  EMP_ID, EMP_NAME, SALARY
    INTO    eid, ename, sal
    FROM    EMP
    WHERE   EMP_ID = &���;
    
    IF sal >= 6000000 THEN
        grade := 'A';
    ELSIF sal BETWEEN 5000000 AND 5999999 THEN
        grade := 'B';
    ELSIF sal >= 4000000 THEN
        grade := 'C';
    ELSIF sal >= 3000000 THEN
        grade := 'D';
    ELSE
        grade := 'E';
    END IF;
    
    DBMS_OUTPUT.PUT_LINE('eid : ' || eid);
    DBMS_OUTPUT.PUT_LINE('ename : ' || ename);
    DBMS_OUTPUT.PUT_LINE('salary : ' || sal);
    DBMS_OUTPUT.PUT_LINE('garde : ' || grade || '���');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        INSERT INTO TB_ERR 
            VALUES ('PROC_GET_SALARY_GRADE', 'E001', eid || '�����ȣ�� Ȯ�����ּ���', SYSDATE);
        DBMS_OUTPUT.PUT_LINE('�����ȣ�� Ȯ�����ּ���.');
END;
/

CREATE TABLE TB_ERR(
    PLSQL_NAME      VARCHAR2(100)
    , ERR_CODE      CHAR(4)
    , ERR_MSG       VARCHAR2(4000)
    , REG_DATE      DATE
);
SELECT * FROM TB_ERR;

/*
    1-4) CASE ����
      [ǥ����]
        CASE �� ���
             WHEN �񱳰�1 THEN �����1
             WHEN �񱳰�2 THEN �����2
             ...
             [ELSE �����]
        END;
*/
-- ����� �Է¹��� �Ŀ� ����� ��� �÷� �����͸� EMP�� �����ϰ� 
-- DEPT_CODE�� ���� �˸´� �μ��� ����Ѵ�.
DECLARE
    e EMP%ROWTYPE;
    dname DEPT.DEPT_TITLE%TYPE;
BEGIN
    SELECT  *
    INTO    e
    FROM    EMP
    WHERE   EMP_ID = '&���';
    
    -- 3���� �ٹ� D 123 ����, D 456 ����, D 789 �߰�
    
    dname := CASE
                WHEN e.DEPT_CODE IN ('D1','D2','D3') THEN '�����μ�'
                WHEN e.DEPT_CODE IN ('D4','D5','D6') THEN '���ĺμ�'
                WHEN e.DEPT_CODE IN ('D7','D8','D9') THEN '�߰��μ�'
            END;                
        
        /*
        dname := CASE e.DEPT_CODE
                WHEN 'D1' THEN '�λ������'
                WHEN 'D2' THEN 'ȸ�������'
                WHEN 'D3' THEN '�����ú�'
                WHEN 'D4' THEN '����������'
                WHEN 'D5' THEN '�ؿܿ���1��'
                WHEN 'D6' THEN '�ؿܿ���2��'
                WHEN 'D7' THEN '�ؿܿ���3��'
                WHEN 'D8' THEN '���������'
                WHEN 'D9' THEN '�ѹ���'
            END;
            */
    DBMS_OUTPUT.PUT_LINE('��� : ' || e.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || e.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�μ��ڵ� : ' || e.DEPT_CODE);
    DBMS_OUTPUT.PUT_LINE('�μ��� : ' || dname);
END;
/

/*
    2) �ݺ���
      2-1) BASIC LOOP
        [ǥ����]
            LOOP
                �ݺ������� �����ų ����
                
                [�ݺ����� �������� ���ǹ� �ۼ�]
                    1) IF ���ǽ� THEN 
                          EXIT;
                       END IF
                       
                    2) EXIT WHEN ���ǽ�;
            END LOOP;
*/
-- 1 ~ 5���� ���������� 1�� �����ϴ� ���� ���
-- ����Ÿ���� ������ ���� num = 1
DECLARE
    num NUMBER := 1;
BEGIN

    -- �ݺ���
    LOOP
        DBMS_OUTPUT.PUT_LINE(num);
        num := num + 1;
        
        IF num > 5 THEN 
            -- �ݺ� ����
            EXIT;
        END IF;
        
    END LOOP;
END;
/

/*
    2-2) WHILE LOOP
      [ǥ����]
        WHILE ���ǽ�
        LOOP
            �ݺ������� ������ ����;
        END LOOP;
*/
-- 1 ~ 5���� ���������� 1�� �����ϴ� ���� ���
DECLARE
    num NUMBER := 1;
BEGIN
    WHILE num <= 5
    LOOP
        DBMS_OUTPUT.PUT_LINE(num);
        num := num+1;
    END LOOP;
END;
/

-- 2�� ���
DECLARE
    num NUMBER := 1;
BEGIN
    WHILE num <= 9
    LOOP
        DBMS_OUTPUT.PUT_LINE(2 * num);
        -- num ���� ���� �����־� �ݺ����� Ż�� �մϴ�.
        num := num+1;
    END LOOP;
END;
/

-- ������ ���
DECLARE
    num NUMBER := 1;
    dan NUMBER := 2;
BEGIN
    WHILE dan <= 9
    LOOP
    DBMS_OUTPUT.PUT_LINE(dan || '��');
        WHILE num <= 9
        LOOP
            DBMS_OUTPUT.PUT_LINE(dan || ' * ' || num || ' = ' || dan * num);
            num := num+1;
        END LOOP;
        -- num�� �ʱ�ȭ �ؾ� �������� ��� ��µȴ�.
        num := 1;
        -- ���� ���� �������� ������ �ݺ����� Ż���� ���� ���� ���ѹݺ����� ���� �߻�
        dan := dan+1;     
    END LOOP;
END;
/

/*
    3) FOR LOOP
      [ǥ����]
        FOR ���� IN [REVERSE] �ʱⰪ..������
        LOOP
            �ݺ������� ������ ����;
        END LOOP;
*/
-- 1 ~ 5���� ���������� 1�� �����ϴ� ���� ���

BEGIN
    -- REVERSE : �ְ����� �����Ͽ� �������� ���
    FOR num IN REVERSE 1..5
    LOOP
        DBMS_OUTPUT.PUT_LINE(num);
    END LOOP;
END;
/

CREATE TABLE TEST(
    NUM NUMBER
    , REG_DATE DATE
);
DROP TABLE TEST;
-- �׽�Ʈ ���̺� 10���� �����͸� ����
BEGIN
    FOR num IN 1..10
    LOOP
        INSERT INTO TEST VALUES (num, SYSDATE);
    END LOOP;
END;
/
-- ¦���� ���� ������ ����
BEGIN
    FOR num IN 1..10
    LOOP
        /*
        -- MOD �������� ���ϴ� �Լ�
        IF MOD(num, 2) != 1 THEN 
            INSERT INTO TEST VALUES (num, SYSDATE);
        END IF;
        */
        INSERT INTO TEST VALUES (num, SYSDATE);
        
        IF MOD(NUM,2) = 0 THEN
            COMMIT;
        ELSE
            ROLLBACK;
        END IF;
        
    END LOOP;
END;
/
SELECT * FROM TEST;
ROLLBACK;

/*
    Ÿ�� ���� ����
        ���ڵ� Ÿ���� ���� ����� �ʱ�ȭ
        ���� �� ���
    ���ڵ� Ÿ�� ����
        TYPE [Ÿ���̸�] IS RECORD (�÷��� Ÿ��, �÷��� Ÿ��,......)
*/
-- ���, �̸�, �μ���, ���޸��� ��ȸ �غ��ô�
SELECT  EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM    EMP, DEPT, JOB
WHERE   DEPT_ID = DEPT_CODE(+)
AND     EMP.JOB_CODE = JOB.JOB_CODE
AND     EMP_NAME = '&�����';

DECLARE
    -- ���ڵ� Ÿ���� ����
    TYPE EMP_RECORD_TYPE IS RECORD(
        EMP_ID EMP.EMP_ID%TYPE
        , EMP_NAME EMP.EMP_NAME%TYPE
        , DEPT_TITLE DEPT.DEPT_TITLE%TYPE
        , JOB_NAME JOB.JOB_NAME%TYPE
        );
    
    -- ������ Ÿ���� ���ڵ� Ÿ������ ����
    EMP_RECORD EMP_RECORD_TYPE;
BEGIN
    SELECT  EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
    INTO    EMP_RECORD
    FROM    EMP, DEPT, JOB
    WHERE   DEPT_ID(+) = DEPT_CODE
    AND     EMP.JOB_CODE = JOB.JOB_CODE
    AND     EMP_NAME = '&�����';
    
    DBMS_OUTPUT.PUT_LINE('��� : ' || EMP_RECORD.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('�̸� : ' || EMP_RECORD.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('�μ� : ' || EMP_RECORD.DEPT_TITLE);
    DBMS_OUTPUT.PUT_LINE('���� : ' || EMP_RECORD.JOB_NAME);
END;
/

/*
    <PL/SQL ����ó����(EXCEPTION SECTION)>
        ���ܶ� ���� �� �߻��ϴ� ������ ���ϰ� PL/SQL ������ �߻��� ���ܸ� ����ó���ο��� �ڵ������� ó���� �����ϴ�.

        [ǥ����]
            DECLARE
                ...
            BEGIN
                ...
            EXCEPTION
                WHEN ���ܸ� 1 THEN ����ó������ 1;
                WHEN ���ܸ� 2 THEN ����ó������ 2;
                ...
                WHEN OTHERS THEN ����ó������;
                
        * ����Ŭ���� �̸� ���ǵǾ� �ִ� ����
          - NO_DATA_FOUND : SELECT ���� ���� ����� �� �൵ ���� ��쿡 �߻��Ѵ�.
          - TOO_MANY_ROWS : �� ���� ���ϵǾ�� �ϴµ� SELECT ������ ���� ���� ���� ������ �� �߻��Ѵ�. 
          - ZERO_DIVIDE   : ���ڸ� 0���� ���� �� �߻��Ѵ�.
          - DUP_VAL_ON_INDEX : UNIQUE ���� ������ ���� �÷��� �ߺ��� �����Ͱ� INSERT �� �� �߻��Ѵ�.
*/
-- ����ڰ� �Է��� ���� ������ ����
DECLARE
    result NUMBER;
BEGIN
    result := 10 / &����;
    --// ���� 0�� ������ ���� �߻�
    DBMS_OUTPUT.PUT_LINE('��� : ' || result);
EXCEPTION
    WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('������ ����� 0���� ���� �� �����ϴ�.');
END;
/




