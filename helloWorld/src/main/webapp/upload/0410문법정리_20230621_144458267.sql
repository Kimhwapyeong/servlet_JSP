-- ���̺� ����
create table book2(
    bookno number unique not null,
    title varchar2(200) not null,
    author varchar2(20) not null,
    rentYN char(1) default 'N' check(rentYN in('Y','N'))
);

-- ���̺� ����
drop table book2;

-- ���̺� �ִ� �������� �� ��ȸ
select count(*) from book2;

-- ���̺��� �÷� ��ȸ(��������)
desc book2;

-- ��ü �÷� ���� �Է��Ͽ� ������ �߰�
insert into book2 values (1, '', '', '');

-- �÷� ���� ���������� �Է��Ͽ� ������ �߰�
insert into book2 (bookno, title, author) values (1, '', '');

-- ������ ����
delete book2
where bookno = 1;

-- ������ ����
update book2
set isret = 'Y'
where bookno = 2;

-- �÷��� �����Ͽ� ������ ��ȸ
select * from book2
where bookno = 2;

-- �÷��� ������ �����Ͽ� ������ ��ȸ
select * from book2
where bookno = 2 and isrent = 'Y';

-- Ŀ��Ʈ �Է�
comment on column book2.title is 'å����';

-- ���� ū ���� ��ȯ
select max(bookno) from book2;

-- �������� ����
select * from book2 order by bookno;
