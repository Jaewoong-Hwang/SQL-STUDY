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

select userid, sum(price*amount)as �����Ѿ�
from buytbl
group by userid;

SELECT NVL(groupName, '�̺з�') AS �׷��, SUM(amount) AS �Ǹż����հ� FROM buyTbl GROUP BY NVL(groupName, '�̺з�');

SELECT 
    birthYear AS ����⵵,
    AVG(height) AS ���Ű
FROM 
    userTbl
GROUP BY 
    birthYear
ORDER BY 
    birthYear;
    
SELECT 
    prodName AS ��ǰ��,
    COUNT(*) AS ����Ƚ��,
    SUM(price * amount) AS �ѱ��ž�
FROM 
    buyTbl
GROUP BY 
    prodName
ORDER BY 
    COUNT(*) DESC;
    
SELECT 
    NVL(mobile1, '���Է�') AS ��Ż�,
    COUNT(*) AS �����ڼ�
FROM 
    userTbl
GROUP BY 
    NVL(mobile1, '���Է�')
ORDER BY 
    �����ڼ� DESC;
    
    SELECT 
    u.addr AS ����,
    SUM(b.price * b.amount) AS �ѱ��ž�
FROM 
    userTbl u
JOIN 
    buyTbl b ON u.userID = b.userID
GROUP BY 
    u.addr
ORDER BY 
    �ѱ��ž� DESC;

    




