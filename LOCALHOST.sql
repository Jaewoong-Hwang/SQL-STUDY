-- ---------------------
-- where ��
-- ----------------------
desc usertbl;
select * from usertbl where name='���ȣ';

-- -------------------
-- ������ + ���迬����
-- --------------------
select * from usertbl where birthyear >=1970 and height>=182;
select * from usertbl where birthyear >=1970 or height>=182;

-- -------------------

-- --------------------
select * from usertbl where birthyear >=1970 and birthyear<=1980;
select * from usertbl where birthyear between 1970 and 1980;

-- -------------------
-- IN
-- --------------------

--SELECT * FROM userTbl WHERE addr IN('�泲','����','���');
select * from userTbl where addr in('�泲','����','���');
select * from userTbl;
select * from userTbl where mobile1 in ('010','011');

-- -------------------
-- LIKE %(��繮��,��������x) , _(��繮��, _ ��ŭ�� ����)
-- --------------------

select name,height from userTbl where name like '��%';
select name,height from userTbl where name like '_���';

-- -------------------
-- NULL CHECK
-- --------------------

select * from  usertbl where mobile1 is null;
select * from  usertbl where mobile1 is not null;

-- -------------------
-- DISTINCT row �� �ߺ� row ����
-- --------------------

select distinct addr from usertbl; 


-- -------------------
-- ALIAS ����
-- --------------------

select name,addr,mobile1 || mobile2 as phone from usertbl; -- "||" �� ��ģ�ٴ� ��

select * from buytbl;
select * from buytbl where amount >= 5;
select userID,prodName from buytbl where price between 50 and 500;
select * from buytbl where amount>=10 or price>=100;
select * from buytbl where userID like 'K%';
select * from buytbl where groupname in ('����','����');
select * from buytbl where prodname= 'å' or userid like '%W';
