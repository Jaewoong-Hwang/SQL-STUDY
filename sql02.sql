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

select groupname, sum(price*amount)
from buytbl
group by groupname;
    




