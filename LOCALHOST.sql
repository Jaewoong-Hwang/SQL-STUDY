-- ---------------------
-- where 절
-- ----------------------
desc usertbl;
select * from usertbl where name='김경호';

-- -------------------
-- 조건절 + 관계연산자
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

--SELECT * FROM userTbl WHERE addr IN('경남','전남','경북');
select * from userTbl where addr in('경남','전남','경북');
select * from userTbl;
select * from userTbl where mobile1 in ('010','011');

-- -------------------
-- LIKE %(모든문자,길이제한x) , _(모든문자, _ 만큼의 길이)
-- --------------------

select name,height from userTbl where name like '김%';
select name,height from userTbl where name like '_재범';

-- -------------------
-- NULL CHECK
-- --------------------

select * from  usertbl where mobile1 is null;
select * from  usertbl where mobile1 is not null;

-- -------------------
-- DISTINCT row 중 중복 row 제거
-- --------------------

select distinct addr from usertbl; 


-- -------------------
-- ALIAS 설정
-- --------------------

select name,addr,mobile1 || mobile2 as phone from usertbl; -- "||" 는 합친다는 뜻

select * from buytbl;
select * from buytbl where amount >= 5;
select userID,prodName from buytbl where price between 50 and 500;
select * from buytbl where amount>=10 or price>=100;
select * from buytbl where userID like 'K%';
select * from buytbl where groupname in ('서적','전자');
select * from buytbl where prodname= '책' or userid like '%W';
