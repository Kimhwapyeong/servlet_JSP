/*
    <PL/SQL 실행부(EXECUTABLE SECTION)>
        1) 선택문
          1-1) 단일 IF 구문
            [표현법]
                IF 조건식 THEN
                    실행 문장
                END IF;
*/
-- 사번을 입력받은 후 해당 사원의 사번, 이름, 급여, 보너스를 출력
-- 단, 보너스를 받지 않는 사원은 보너스 출력 전에 
-- '보너스를 지급받지 않는 사원입니다.'라는 문구를 출력한다.
DECLARE
    e EMP%ROWTYPE;
BEGIN
    SELECT  EMP_ID, EMP_NAME, SALARY, BONUS
    INTO    e.EMP_ID, e.EMP_NAME, e.SALARY, e.BONUS
    FROM    EMP
    WHERE   EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || e.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || e.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || e.SALARY);
        IF e.BONUS IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다.');
        END IF;
    -- 유효하지 않은 정수부의 숫자를 출력
    DBMS_OUTPUT.PUT_LINE('보너스 : ' || TRIM(TO_CHAR(NVL(e.BONUS, '0.0'), 0)));
END;
/

/*
    1-2) IF ~ ELSE 구문
      [표현법]
        IF 조건식 THEN
            실행 문장
        ELSE 
            실행 문장
        END IF;
*/
DECLARE
    e EMP%ROWTYPE;
BEGIN
    SELECT  EMP_ID, EMP_NAME, SALARY, BONUS
    INTO    e.EMP_ID, e.EMP_NAME, e.SALARY, e.BONUS
    FROM    EMP
    WHERE   EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || e.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || e.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('급여 : ' || e.SALARY);
    IF e.BONUS IS NULL THEN
        DBMS_OUTPUT.PUT_LINE('보너스를 지급받지 않는 사원입니다.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('보너스 : ' || TRIM(TO_CHAR(e.BONUS, '0.0')));
    END IF;
    
END;
/

/*
    1-3) IF ~ ELSIF ~ ELSE 구문
      [표현법]
        IF 조건식 THEN
            실행 문장
        ELSIF 조건식 THEN
            실행 문장
        ...
        [ELSE
            실행 문장]
        END IF;
*/
-- 사용자에게 점수를 입력받아 SCORE 변수에 저장한 후 학점은 입력된 점수에 따라 GRADE 변수에 저장한다.
--  90점 이상은 'A'
--  80점 이상은 'B'
--  70점 이상은 'C'
--  60점 이상은 'D'
--  60점 미만은 'F'
-- 출력은 '당신의 점수는 95점이고, 학점은 A학점입니다.'와 같이 출력한다.
DECLARE
    score number;
    grade char(1);
BEGIN
    score := &점수;
    IF  score >= 90 THEN
        DBMS_OUTPUT.PUT_LINE('당신의 점수는 ' || score || '점 이고, 학점은 ' ||'A 학점입니다.');
    ELSIF score >= 80 THEN
        DBMS_OUTPUT.PUT_LINE('당신의 점수는 ' || score || '점 이고, 학점은 ' ||'B 학점입니다.');
    ELSIF score >= 70 THEN
        DBMS_OUTPUT.PUT_LINE('당신의 점수는 ' || score || '점 이고, 학점은 ' ||'C 학점입니다.');
    ELSIF score >= 60 THEN
        DBMS_OUTPUT.PUT_LINE('당신의 점수는 ' || score || '점 이고, 학점은 ' ||'D 학점입니다.');
    ELSIF score < 60 THEN
        DBMS_OUTPUT.PUT_LINE('당신의 점수는 ' || score || '점 이고, 학점은 ' ||'F 학점입니다.');
    END IF;
END;                    --// 굉장히 무식하게 했다.
/

DECLARE
    score number;
    grade char(1);
BEGIN
    score := &점수;
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
DBMS_OUTPUT.PUT_LINE('당신의 점수는 ' || score || 
                        '점 이고, 학점은 ' || grade || '학점입니다.');
    
END;
/

-- 사원의 번호를 입력 받아서
-- 사번, 이름, 급여를 출력
/*
    급여가 200만원 이상 ~ 300만원 미만이면 E 등급
    급여가 300만원 이상 ~ 400만원 미만이면 D 등급
    급여가 400만원 이상 ~ 500만원 미만이면 C 등급
    급여가 500만원 이상 ~ 600만원 미만이면 B 등급
    급여가 600만원 이상이면 A등급
*/
DECLARE
    -- 변수 선언
    e EMP%ROWTYPE;
BEGIN
    SELECT  *
    INTO    e
    FROM    EMP
    WHERE   EMP_ID = &사번;
    
    DBMS_OUTPUT.PUT_LINE('eid : ' || e.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('ename : ' || e.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('salary : ' || e.SALARY);
END;
/

DECLARE
    -- 변수 선언
    eid EMP.EMP_ID%TYPE;
    ename EMP.EMP_NAME%TYPE;
    sal EMP.SALARY%TYPE;
    grade CHAR(1);
BEGIN
    
    -- 조회 결과를 변수에 담기
    SELECT  EMP_ID, EMP_NAME, SALARY
    INTO    eid, ename, sal
    FROM    EMP
    WHERE   EMP_ID = &사번;
    
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
    DBMS_OUTPUT.PUT_LINE('garde : ' || grade || '등급');
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        INSERT INTO TB_ERR 
            VALUES ('PROC_GET_SALARY_GRADE', 'E001', eid || '사원번호를 확인해주세요', SYSDATE);
        DBMS_OUTPUT.PUT_LINE('사원번호를 확인해주세요.');
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
    1-4) CASE 구문
      [표현법]
        CASE 비교 대상
             WHEN 비교값1 THEN 결과값1
             WHEN 비교값2 THEN 결과값2
             ...
             [ELSE 결과값]
        END;
*/
-- 사번을 입력받은 후에 사원의 모든 컬럼 데이터를 EMP에 대입하고 
-- DEPT_CODE에 따라 알맞는 부서를 출력한다.
DECLARE
    e EMP%ROWTYPE;
    dname DEPT.DEPT_TITLE%TYPE;
BEGIN
    SELECT  *
    INTO    e
    FROM    EMP
    WHERE   EMP_ID = '&사번';
    
    -- 3교대 근무 D 123 오전, D 456 오후, D 789 야간
    
    dname := CASE
                WHEN e.DEPT_CODE IN ('D1','D2','D3') THEN '오전부서'
                WHEN e.DEPT_CODE IN ('D4','D5','D6') THEN '오후부서'
                WHEN e.DEPT_CODE IN ('D7','D8','D9') THEN '야간부서'
            END;                
        
        /*
        dname := CASE e.DEPT_CODE
                WHEN 'D1' THEN '인사관리부'
                WHEN 'D2' THEN '회계관리부'
                WHEN 'D3' THEN '마케팅부'
                WHEN 'D4' THEN '국내영업부'
                WHEN 'D5' THEN '해외영업1부'
                WHEN 'D6' THEN '해외영업2부'
                WHEN 'D7' THEN '해외영업3부'
                WHEN 'D8' THEN '기술지원부'
                WHEN 'D9' THEN '총무부'
            END;
            */
    DBMS_OUTPUT.PUT_LINE('사번 : ' || e.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || e.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('부서코드 : ' || e.DEPT_CODE);
    DBMS_OUTPUT.PUT_LINE('부서명 : ' || dname);
END;
/

/*
    2) 반복문
      2-1) BASIC LOOP
        [표현법]
            LOOP
                반복적으로 실행시킬 구문
                
                [반복문을 빠져나갈 조건문 작성]
                    1) IF 조건식 THEN 
                          EXIT;
                       END IF
                       
                    2) EXIT WHEN 조건식;
            END LOOP;
*/
-- 1 ~ 5까지 순차적으로 1씩 증가하는 값을 출력
-- 숫자타입의 변수를 생성 num = 1
DECLARE
    num NUMBER := 1;
BEGIN

    -- 반복문
    LOOP
        DBMS_OUTPUT.PUT_LINE(num);
        num := num + 1;
        
        IF num > 5 THEN 
            -- 반복 종료
            EXIT;
        END IF;
        
    END LOOP;
END;
/

/*
    2-2) WHILE LOOP
      [표현법]
        WHILE 조건식
        LOOP
            반복적으로 실행할 구문;
        END LOOP;
*/
-- 1 ~ 5까지 순차적으로 1씩 증가하는 값을 출력
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

-- 2단 출력
DECLARE
    num NUMBER := 1;
BEGIN
    WHILE num <= 9
    LOOP
        DBMS_OUTPUT.PUT_LINE(2 * num);
        -- num 값을 증가 시켜주어 반복문을 탈출 합니다.
        num := num+1;
    END LOOP;
END;
/

-- 구구단 출력
DECLARE
    num NUMBER := 1;
    dan NUMBER := 2;
BEGIN
    WHILE dan <= 9
    LOOP
    DBMS_OUTPUT.PUT_LINE(dan || '단');
        WHILE num <= 9
        LOOP
            DBMS_OUTPUT.PUT_LINE(dan || ' * ' || num || ' = ' || dan * num);
            num := num+1;
        END LOOP;
        -- num을 초기화 해야 구구단이 모두 출력된다.
        num := 1;
        -- 값을 증가 시켜주지 않으면 반복문을 탈출할 수가 없어 무한반복으로 오류 발생
        dan := dan+1;     
    END LOOP;
END;
/

/*
    3) FOR LOOP
      [표현법]
        FOR 변수 IN [REVERSE] 초기값..최종값
        LOOP
            반복적으로 실행할 구문;
        END LOOP;
*/
-- 1 ~ 5까지 순차적으로 1씩 증가하는 값을 출력

BEGIN
    -- REVERSE : 최고값부터 시작하여 역순으로 출력
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
-- 테스트 테이블에 10개의 데이터를 삽입
BEGIN
    FOR num IN 1..10
    LOOP
        INSERT INTO TEST VALUES (num, SYSDATE);
    END LOOP;
END;
/
-- 짝수일 때만 데이터 삽입
BEGIN
    FOR num IN 1..10
    LOOP
        /*
        -- MOD 나머지를 구하는 함수
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
    타입 변수 선언
        레코드 타입의 변수 선언과 초기화
        변수 값 출력
    레코드 타입 선언
        TYPE [타입이름] IS RECORD (컬럼명 타입, 컬럼명 타입,......)
*/
-- 사번, 이름, 부서명, 직급명을 조회 해봅시다
SELECT  EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
FROM    EMP, DEPT, JOB
WHERE   DEPT_ID = DEPT_CODE(+)
AND     EMP.JOB_CODE = JOB.JOB_CODE
AND     EMP_NAME = '&사원명';

DECLARE
    -- 레코드 타입을 선언
    TYPE EMP_RECORD_TYPE IS RECORD(
        EMP_ID EMP.EMP_ID%TYPE
        , EMP_NAME EMP.EMP_NAME%TYPE
        , DEPT_TITLE DEPT.DEPT_TITLE%TYPE
        , JOB_NAME JOB.JOB_NAME%TYPE
        );
    
    -- 변수의 타입을 레코드 타입으로 지정
    EMP_RECORD EMP_RECORD_TYPE;
BEGIN
    SELECT  EMP_ID, EMP_NAME, DEPT_TITLE, JOB_NAME
    INTO    EMP_RECORD
    FROM    EMP, DEPT, JOB
    WHERE   DEPT_ID(+) = DEPT_CODE
    AND     EMP.JOB_CODE = JOB.JOB_CODE
    AND     EMP_NAME = '&사원명';
    
    DBMS_OUTPUT.PUT_LINE('사번 : ' || EMP_RECORD.EMP_ID);
    DBMS_OUTPUT.PUT_LINE('이름 : ' || EMP_RECORD.EMP_NAME);
    DBMS_OUTPUT.PUT_LINE('부서 : ' || EMP_RECORD.DEPT_TITLE);
    DBMS_OUTPUT.PUT_LINE('직급 : ' || EMP_RECORD.JOB_NAME);
END;
/

/*
    <PL/SQL 예외처리부(EXCEPTION SECTION)>
        예외란 실행 중 발생하는 오류를 뜻하고 PL/SQL 문에서 발생한 예외를 예외처리부에서 코드적으로 처리가 가능하다.

        [표현법]
            DECLARE
                ...
            BEGIN
                ...
            EXCEPTION
                WHEN 예외명 1 THEN 예외처리구문 1;
                WHEN 예외명 2 THEN 예외처리구문 2;
                ...
                WHEN OTHERS THEN 예외처리구문;
                
        * 오라클에서 미리 정의되어 있는 예외
          - NO_DATA_FOUND : SELECT 문의 수행 결과가 한 행도 없을 경우에 발생한다.
          - TOO_MANY_ROWS : 한 행이 리턴되어야 하는데 SELECT 문에서 여러 개의 행을 리턴할 때 발생한다. 
          - ZERO_DIVIDE   : 숫자를 0으로 나눌 때 발생한다.
          - DUP_VAL_ON_INDEX : UNIQUE 제약 조건을 가진 컬럼에 중복된 데이터가 INSERT 될 때 발생한다.
*/
-- 사용자가 입력한 수로 나눗셈 연산
DECLARE
    result NUMBER;
BEGIN
    result := 10 / &숫자;
    --// 숫자 0을 넣으면 오류 발생
    DBMS_OUTPUT.PUT_LINE('결과 : ' || result);
EXCEPTION
    WHEN ZERO_DIVIDE THEN DBMS_OUTPUT.PUT_LINE('나누기 연산시 0으로 나눌 수 없습니다.');
END;
/




