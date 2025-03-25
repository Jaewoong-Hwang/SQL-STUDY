-- ����� ���� �Ѿ� ���
select userid, sum(price*amount)as �����Ѿ� 
from buytbl
group by userid;


select userid,count(*)as ����Ƚ��
from buytbl
group by userid;

-- ������ ����� �� ���
select addr, count(*) as ����ڼ�
from usertbl
group by addr;

-- ��ǰ �׷캰 �Ǹ� �ݾ� �հ�(!)
select * from buytbl;
select groupname, sum(price*amount) as �Ǹűݾ�
from buytbl
where groupname is not null -- where ���ǽ��� ������ ���� where ���� �� �ڷ� ���´ٸ� ������ ����!
group by groupname;

-- ����⵵ ���� ����� ��
select birthyear, count(*) as �ο���
from usertbl
group by birthyear
order by birthyear;

-- ODRE BY(�������� ����)
select name, mdate 
from usertbl
order by mdate;

select name, mdate 
from usertbl
order by name;

-- DESC(��������)
select name, mdate 
from usertbl
order by mdate desc;

-- ASC(����+����)
select name, height 
from usertbl 
order by height desc, name asc;  -- ������ ���� ���� ��� �� ��° ����(���⼭�� name)�� ����

-- ���� ����
select * from
(select rownum as RN,   -- �÷��� ���� ��ȣ�� ������� 
usertbl.*from usertbl) 
where RN = 2;  

select * from (select rownum as RN, usertbl.* from usertbl) where RN>=2 and RN<=4;

-- ----------------------------
-- ����
select addr, count(*) as ����ڼ�
from usertbl
group by addr;
-- ---------------------------
select userid, sum(price*amount)as �����Ѿ�
from buytbl
group by userid;
-- ---------------------------
SELECT NVL(groupName, '�̺з�') AS �׷��, SUM(amount) AS �Ǹż����հ� FROM buyTbl GROUP BY NVL(groupName, '�̺з�');

-- case - is null then
SELECT 
    case
    when groupName is null then '�̺з�! 
    else groupName
    end
    as ī�װ�,sum(amount)
    from buytbl
    group by groupName;

-- ---------------------------
SELECT 
    birthYear AS ����⵵,
    AVG(height) AS ���Ű
FROM 
    userTbl
GROUP BY 
    birthYear
ORDER BY 
    birthYear;
    
 -- ---------------------------   
SELECT 
    prodName AS ��ǰ��,
    COUNT(*) AS ����Ƚ��,
    SUM(price * amount) AS �ѱ��ž�
FROM 
    buyTbl
GROUP BY 
    prodName
ORDER BY 
    ����Ƚ�� DESC;
-- ---------------------------    
SELECT 
    NVL(mobile1, '���Է�') AS ��Ż�,
    COUNT(*) AS �����ڼ�
FROM 
    userTbl
GROUP BY 
    NVL(mobile1, '���Է�')
ORDER BY 
    �����ڼ� DESC;
 -- ---------------------------   
 select u.addr,sum(b.price*b.amount) as �ѱ��ž�
 from usertbl u
 join buytbl b
 on u.userid = b.userid
 group by u.addr;
 
 -- ---------------------------
 select userid,groupname, 
 count(groupname) 
 from buytbl 
 group by userid,groupname;
 -- ---------------------------
 
 select SUBSTR(mDate,1,2), 
 count(*) 
 from usertbl 
 group by SUBSTR(mDate,1,2)
 order by SUBSTR(mDate,1,2);
 -- -----------------------------
 select 2025-u.birthyear, sum(b.price * b.amount) 
 from buytbl b
 join usertbl u
 on b.userid=u.userid
group by floor(2025-u.birthyear/10);
-- ----------------------------------
 SELECT FLOOR((2025 - u.birthYear) / 10) * 10 AS ���ɴ�, 
       SUM(b.price * b.amount) AS �����Ѿ�
FROM userTbl u
JOIN buyTbl b ON u.userID = b.userID
GROUP BY FLOOR((2025 - u.birthYear) / 10) * 10
ORDER BY ���ɴ�;

-- ���� �ݾ� �հ谡 1000 �̻��� ����� ��ȸ
select userid, sum(price * amount) as �ѱ��ž�
from buytbl
group by userid
having sum(price * amount)>=1000;

-- ���Ű�� 175 �̻��� ���� ��ȸ
select addr, avg(height) as ���Ű
from usertbl
group by addr
having avg(height)>=175;

-- ������!! having �� where�� group by �� ��� �����ϴ� �� ����!!

select userid, count(*) as ����Ƚ��, sum(price*amount) as �ѱ��ž�
from buytbl
group by userid
having count(*)>=and sum(price*amount)>=100;

--inner join
select u.addr, nvl(b.groupname,'�̺з�'), sum(b.amount*b.price)
from usertbl u
join buytbl b
on u.userid=b.userid
group by u.addr, b.groupname
order by sum(b.amount*b.price) desc
;

select nvl(groupname,'�̺з�'),sum(price*amount)
from buytbl
group by rollup(groupname);
    
select groupname,prodname,sum(price*amount)
from buytbl
group by cube(groupname, prodname);

SELECT groupName, prodName, SUM(price * amount) AS �Ǹž�
FROM buyTbl
WHERE groupName IS NOT NULL
GROUP BY GROUPING SETS((groupName), (prodName), ());

-- -----------------------------------------------------
--1buyTbl���� �� ���ž��� 1,000 �̻��� �����(userID)�� ��ȸ�ϴ� SQL���� �ۼ��Ͻÿ�.
select userid, sum(price*amount)as �ѱ��ž�
from buytbl
group by userid
having sum(price*amount)>=1000;

--2userTbl���� ������ ���� 2�� �̻��� ����(addr)�� ��ȸ�ϴ� SQL���� �ۼ��Ͻÿ�.
select addr, count(*)as �����ڼ�
from usertbl
group by addr
having count(*)>=2
order by count(*) desc;
--3buyTbl���� ��� ���ž��� 100 �̻��� ��ǰ(prodName)�� ��ȸ�ϴ� SQL���� �ۼ��Ͻÿ�.

select prodname, avg(price*amount)as "��� ���ž�"
from buytbl
group by prodname
having avg(price*amount)>=100;

--4userTbl���� ��� Ű�� 175cm �̻��� ����⵵�� ��ȸ�ϴ� SQL���� �ۼ��Ͻÿ�.
select birthyear, avg(height)as ���Ű
from usertbl 
group by birthyear 
having avg(height)>=175;

--5buyTbl���� �ּ� 2�� �̻��� ��ǰ�� ������ �����(userID)�� ��ȸ�ϴ� SQL���� �ۼ��Ͻÿ�.
select userid, sum(amount)
from buytbl
group by userid
having sum(amount) >=2;

--6userTbl�� buyTbl�� �����Ͽ� ���� �Ѿ��� 200 �̻��� ����(addr)�� ��ȸ�ϴ� SQL���� �ۼ��Ͻÿ�.
select addr, sum(b.price*b.amount)as �����Ѿ�
from usertbl u
join buytbl b
on u.userid=b.userid
group by u.addr
having sum(b.price*b.amount)>=200;

--7buyTbl���� ���� Ƚ���� 3ȸ �̻��̰� �� ���ž��� 500 �̻��� �����(userID)�� ��ȸ�ϴ� SQL���� �ۼ��Ͻÿ�.
select userid, count(*)as ����Ƚ��, sum(amount*price)as �ѱ��ž�
from buytbl
group by userid
having count(*) >=3 and sum(amount*price)>-500;

--8userTbl���� ��� Ű�� ���� ū ����(addr)�� ��ȸ�ϴ� SQL���� �ۼ��Ͻÿ�. (���������� HAVING ���)
select *
from (select addr, avg(height) as ���Ű from usertbl group by addr)
where ���Ű=(select max(avg(height)) as ���Ű from usertbl group by addr);

SELECT addr, AVG(height) AS ���Ű
FROM userTbl
GROUP BY addr
HAVING AVG(height) = (
    SELECT MAX(AVG(height))
    FROM userTbl
    GROUP BY addr
);

--9buyTbl���� ���� �ݾ��� ��հ����� �� ���� �ݾ��� ����� �����(userID)�� ��ȸ�ϴ� SQL���� �ۼ��Ͻÿ�. (���������� HAVING ���)
select userid,avg(price*amount)
from buytbl
group by userid
having avg(price*amount)>= (select avg(price*amount) from buytbl);

--10userTbl�� buyTbl�� �����Ͽ� ���� ����(addr)�� ��� ����ڵ� �� ���� �Ѿ��� ������ ��� ���ž׺��� ���� �����(userID)�� ��ȸ�ϴ� SQL���� �ۼ��Ͻÿ�. (���������� HAVING ���)

--10
--1) userTbl�� buyTbl�� �����ϰ�
--2) ���� ����(addr)�� ��� ����ڵ� �� / ���� �Ѿ��� /  ������ ��� ���ž� ���� /���� /�����(userID)�� ��ȸ/�ϴ� SQL���� �ۼ��Ͻÿ�. (���������� HAVING ���)
-- ���� ����(addr)�� ��� ����ڵ� �� ���� �Ѿ� >=  ������ ��� ���ž�

    -- ���� ����(addr)�� ��� ����ڵ� �� ���� �Ѿ�(aa)
    select addr ,u.userid, sum(amount*price) as �Ѿ�
    from userTbl u
    join buyTbl b 
    on u.userid=b.userid
    group by addr,u.userid;
    -- JOIN
    --������ �������
    select addr,avg(amount*price) as ���������
    from userTbl u
    join buyTbl b
    on u.userid=b.userid
    group by addr;
    
    -- WHERE 
    
select aa.addr,userid,�Ѿ�,���������
from 
(
    -- ���� ����(addr)�� ��� ����ڵ� �� ���� �Ѿ�
    select addr ,u.userid, sum(amount*price) as �Ѿ�
    from userTbl u
    join buyTbl b 
    on u.userid=b.userid
    group by addr,u.userid
) aa
join
(
    --������ �������
    select addr,avg(amount*price) as ���������
    from userTbl u
    join buyTbl b
    on u.userid=b.userid
    group by addr
) bb
on aa.addr=bb.addr
where aa.�Ѿ�>=bb.���������;

-- ---------------------------
--�Լ��� ���� �� ����
--�Լ�(Function)�� ����: Ư�� �۾��� �����ϱ� ���� �̸� ���ǵ� ��ɾ�
--������ �Լ�(Single-row Functions): �ະ�� �ϳ��� ����� ��ȯ
--������ �Լ�(Multi-row Functions): ���� ���� ���� �Է¹޾� �ϳ��� ����� ��ȯ

--���� : 
-- ������ �Լ� ���� (UPPER: �� �ະ�� ó��)
SELECT userID, UPPER(name) AS upper_name FROM userTbl;

-- ������ �Լ� ���� (COUNT: ���� ���� ��� ó��)
SELECT addr, COUNT(*) AS user_count FROM userTbl GROUP BY addr;
-- ------------------------------------------
--������ �Լ�-������ �Լ�
--LOWER, UPPER, INITCAP: ��ҹ��� ��ȯ
--LENGTH, LENGTHB: ���ڿ� ���� ��ȯ
--SUBSTR: ���ڿ� �Ϻ� ����
--INSTR: Ư�� ���� ��ġ ã��
--LPAD, RPAD: ���ڿ� ä���
--TRIM, LTRIM, RTRIM: ���� ����
--REPLACE: ���ڿ� ġȯ
--CONCAT: ���ڿ� ����

-- ��ҹ��� ��ȯ
SELECT userID,
       LOWER(userID) AS lower_id,         -- �ҹ��� ��ȯ
       UPPER(name) AS upper_name,         -- �빮�� ��ȯ
       INITCAP(LOWER(name)) AS init_cap   -- ù ���ڸ� �빮�ڷ� ��ȯ
FROM userTbl;
-- ---------------------------
-- ���ڿ� ����
SELECT name, 
       LENGTH(name) AS name_length,       -- �̸��� ���� ����
       LENGTH(addr) AS addr_length        -- �ּ��� ���� ����
FROM userTbl;
-- ---------------------------
-- ���ڿ� ����
SELECT name,
       SUBSTR(name, 1, 1) AS first_char,  -- �̸��� ù ����
       SUBSTR(userID, 2) AS userid_part   -- userID�� �� ��° ���ں��� ������
FROM userTbl;
-- ---------------------------
-- ���� ��ġ ã��
SELECT name, 
       INSTR(name, '��') AS position_kim   -- '��'�� �ִ� ��ġ (������ 0)
FROM userTbl;
-- ---------------------------
-- ���ڿ� ä���
SELECT userID,
       LPAD(userID, 10, '*') AS lpad_id,  -- userID ������ *�� ä�� 10�ڸ���
       RPAD(name, 10, '-') AS rpad_name   -- name �������� -�� ä�� 10�ڸ���
FROM userTbl;
-- ---------------------------
-- ���� ����
SELECT TRIM(' SQL ') AS trim_result,      -- ���� ���� ����: 'SQL'
       LTRIM(' SQL ') AS ltrim_result,    -- ���� ���� ����: 'SQL '
       RTRIM(' SQL ') AS rtrim_result     -- ������ ���� ����: ' SQL'
FROM dual;
-- ---------------------------
-- ���ڿ� ġȯ
SELECT name,
       REPLACE(mobile1, null, '����') AS replace_null,   -- NULL�� '����'���� ��ü
       REPLACE(addr, '����', 'SEOUL') AS replace_addr   -- '����'�� 'SEOUL'�� ��ü
FROM userTbl;

-- ���ڿ� ����
SELECT name,
       CONCAT(mobile1, '-') AS part1,                    -- �޴��� ������ '-' ����
       CONCAT(CONCAT(mobile1, '-'), mobile2) AS mobile,  -- ����-��ȭ��ȣ �������� ����
       mobile1 || '-' || mobile2 AS phone_number        -- ���� ������ ���
FROM userTbl;
-- --------------------------
--������ �Լ�-������ �Լ�
--ROUND: �ݿø�
--TRUNC: ����
--CEIL, FLOOR: �ø�, ����
--MOD: ������ ���ϱ�
--ABS: ���밪
--SIGN: ��ȣ Ȯ��
--POWER: ����
--SQRT: ������
-- ---------------------
--�����ڵ�:

-- buyTbl ���̺��� ���� ������ Ȱ��
-- �ݿø�, ����
SELECT prodName, price,
       ROUND(price/1000, 2) AS round_thousands,    -- õ ������ ������ �Ҽ��� 2�ڸ� �ݿø�
       TRUNC(price/1000, 1) AS trunc_thousands     -- õ ������ ������ �Ҽ��� 1�ڸ� ����
FROM buyTbl;

-- �ø�, ����
SELECT prodName, price,
       CEIL(price/100) AS ceil_hundreds,           -- �� ������ ������ �ø�
       FLOOR(price/100) AS floor_hundreds          -- �� ������ ������ ����
FROM buyTbl;

-- ������, ���밪
SELECT prodName, price, amount,
       MOD(price, 100) AS remainder_100,           -- ������ 100���� ���� ������
       ABS(price - 500) AS abs_diff_500            -- ���ݰ� 500�� ������ ���밪
FROM buyTbl;

-- ��ȣ, ����, ������
SELECT prodName, price,
       SIGN(price - 100) AS sign_price,            -- ������ 100���� ũ�� 1, ������ 0, ������ -1
       POWER(amount, 2) AS amount_squared,         -- ������ ����
       SQRT(price) AS sqrt_price                   -- ������ ������
FROM buyTbl;

--������ �Լ�-��¥�� �Լ�
--SYSDATE, CURRENT_DATE: ���� ��¥
--ADD_MONTHS: �� ���ϱ�
--MONTHS_BETWEEN: �� ���� ���
--NEXT_DAY: ���� ���� ��¥
--LAST_DAY: ���� ������ ��¥
--EXTRACT: ��¥ ��� ����
--TO_CHAR: ��¥�� ���ڷ� ��ȯ
--TO_DATE: ���ڸ� ��¥�� ��ȯ
-- ----------------------------
--�����ڵ� : 

-- ���� ��¥�� ȸ�� ������ Ȱ��
SELECT name, mDate,
       SYSDATE AS today,                             -- ���� ��¥/�ð�
       CURRENT_DATE AS current_date                  -- ���� ��¥
FROM userTbl;

-- ��¥ ����
SELECT name, mDate,
       mDate + 7 AS after_week,                      -- ������ 1���� ��
       mDate - 7 AS before_week                      -- ������ 1���� ��
FROM userTbl;

-- �� ���� �Լ�
SELECT name, mDate,
       ADD_MONTHS(mDate, 6) AS after_6months,        -- ������ 6���� ��
       MONTHS_BETWEEN(SYSDATE, mDate) AS months_since_join  -- ���� �� ��� �� ��
FROM userTbl;

-- ����, ���� �Լ�
SELECT name, mDate,
       NEXT_DAY(mDate, '�ݿ���') AS next_friday,      -- ������ ������ ù �ݿ���
       LAST_DAY(mDate) AS last_day_of_month          -- ���Կ��� ������ ��¥
FROM userTbl;

-- ��¥ ��� ����
SELECT name, mDate,
       EXTRACT(YEAR FROM mDate) AS join_year,        -- ���� ����
       EXTRACT(MONTH FROM mDate) AS join_month,      -- ���� ��
       EXTRACT(DAY FROM mDate) AS join_day           -- ���� ��
FROM userTbl;


