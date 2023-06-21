-- 테이블 생성
create table book2(
    bookno number unique not null,
    title varchar2(200) not null,
    author varchar2(20) not null,
    rentYN char(1) default 'N' check(rentYN in('Y','N'))
);

-- 테이블 삭제
drop table book2;

-- 테이블에 있는 데이터의 수 조회
select count(*) from book2;

-- 테이블의 컬럼 조회(제약조건)
desc book2;

-- 전체 컬럼 값을 입력하여 데이터 추가
insert into book2 values (1, '', '', '');

-- 컬럼 값을 선택적으로 입력하여 데이터 추가
insert into book2 (bookno, title, author) values (1, '', '');

-- 데이터 삭제
delete book2
where bookno = 1;

-- 데이터 수정
update book2
set isret = 'Y'
where bookno = 2;

-- 컬럼을 선택하여 데이터 조회
select * from book2
where bookno = 2;

-- 컬럼을 여러개 선택하여 데이터 조회
select * from book2
where bookno = 2 and isrent = 'Y';

-- 커멘트 입력
comment on column book2.title is '책제목';

-- 가장 큰 값을 반환
select max(bookno) from book2;

-- 오름차순 정렬
select * from book2 order by bookno;
