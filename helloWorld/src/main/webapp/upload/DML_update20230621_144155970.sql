/*
<DML(Data Manipulation Language)>
    데이터 조작 언어로 테이블에 값을
    삽입(INSERT), 수정(UPDATE), 삭제(DELETE)하는 구문이다.
    
    <INSERT> 
    [표현법]
        1) insert into 테이블명 values(값, 값, 값.. 값);
            테이블에 모든 컬럼에 값을 입력할 때 사용
        2) insert into 테이블명(컬럼명, 컬럼명.... 컬럼명) values(값, 값, 값.. 값); 
            내가 선택한 컬럼에 대한 값만 입력할 때 사용
            
    <UPDATE>
    [표현법]
        update 테이블명
        set 컬럼명 = 변경하려는 값
            컬럼명 = 변경하려는 값, ...
        [where 조건];
        
    *** where절을 생략하게 되면 테이블의 모든행이 수정, 삭제된다.
        
    <where>조건문
    컬럼명 = 찾는 값
*/
desc book;
insert into book values (5, '타이틀5', '작가5', 'N', sysdate, null);
commit;
select * from book;
-- 사용자가 책을 대여할 경우 isRent = Y, editdate = 현재시간날짜
-- 3번 책을 대여합니다.
update book
set isrent = 'Y', editdate = sysdate
where no = 3;

-- 수정, 삭제하기 전 데이터의 수를 확인 후 쿼리를 실행 합니다.
select count(*)
from book
where no = 3;

/*
    <DELETE>
*/