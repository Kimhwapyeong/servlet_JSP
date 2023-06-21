/*
<DML(Data Manipulation Language)>
    ������ ���� ���� ���̺� ����
    ����(INSERT), ����(UPDATE), ����(DELETE)�ϴ� �����̴�.
    
    <INSERT> 
    [ǥ����]
        1) insert into ���̺�� values(��, ��, ��.. ��);
            ���̺� ��� �÷��� ���� �Է��� �� ���
        2) insert into ���̺��(�÷���, �÷���.... �÷���) values(��, ��, ��.. ��); 
            ���� ������ �÷��� ���� ���� �Է��� �� ���
            
    <UPDATE>
    [ǥ����]
        update ���̺��
        set �÷��� = �����Ϸ��� ��
            �÷��� = �����Ϸ��� ��, ...
        [where ����];
        
    *** where���� �����ϰ� �Ǹ� ���̺��� ������� ����, �����ȴ�.
        
    <where>���ǹ�
    �÷��� = ã�� ��
*/
desc book;
insert into book values (5, 'Ÿ��Ʋ5', '�۰�5', 'N', sysdate, null);
commit;
select * from book;
-- ����ڰ� å�� �뿩�� ��� isRent = Y, editdate = ����ð���¥
-- 3�� å�� �뿩�մϴ�.
update book
set isrent = 'Y', editdate = sysdate
where no = 3;

-- ����, �����ϱ� �� �������� ���� Ȯ�� �� ������ ���� �մϴ�.
select count(*)
from book
where no = 3;

/*
    <DELETE>
*/