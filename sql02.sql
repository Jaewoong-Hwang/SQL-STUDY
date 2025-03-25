-- 사용자 구매 총액 계산
select userid, sum(price*amount)as 구매총액 
from buytbl
group by userid;


select userid,count(*)as 구매횟수
from buytbl
group by userid;

-- 지역별 사용자 수 계산
select addr, count(*) as 사용자수
from usertbl
group by addr;

-- 제품 그룹별 판매 금액 합계(!)
select * from buytbl;
select groupname, sum(price*amount) as 판매금액
from buytbl
where groupname is not null -- where 조건식은 순서가 있음 where 절이 맨 뒤로 나온다면 오류가 생김!
group by groupname;

-- 출생년도 기준 사용자 수
select birthyear, count(*) as 인원수
from usertbl
group by birthyear
order by birthyear;

-- ODRE BY(오름차순 정렬)
select name, mdate 
from usertbl
order by mdate;

select name, mdate 
from usertbl
order by name;

-- DESC(내림차순)
select name, mdate 
from usertbl
order by mdate desc;

-- ASC(오름+내림)
select name, height 
from usertbl 
order by height desc, name asc;  -- 동일한 값을 가질 경우 두 번째 정렬(여기서는 name)에 따름

-- 서브 쿼리
select * from
(select rownum as RN,   -- 컬럼에 대한 번호를 만들어줌 
usertbl.*from usertbl) 
where RN = 2;  

select * from (select rownum as RN, usertbl.* from usertbl) where RN>=2 and RN<=4;

-- ----------------------------
-- 예제
select addr, count(*) as 사용자수
from usertbl
group by addr;

select userid, sum(price*amount)as 구매총액
from buytbl
group by userid;

SELECT NVL(groupName, '미분류') AS 그룹명, SUM(amount) AS 판매수량합계 FROM buyTbl GROUP BY NVL(groupName, '미분류');

SELECT 
    birthYear AS 출생년도,
    AVG(height) AS 평균키
FROM 
    userTbl
GROUP BY 
    birthYear
ORDER BY 
    birthYear;
    
SELECT 
    prodName AS 제품명,
    COUNT(*) AS 구매횟수,
    SUM(price * amount) AS 총구매액
FROM 
    buyTbl
GROUP BY 
    prodName
ORDER BY 
    COUNT(*) DESC;
    
SELECT 
    NVL(mobile1, '미입력') AS 통신사,
    COUNT(*) AS 가입자수
FROM 
    userTbl
GROUP BY 
    NVL(mobile1, '미입력')
ORDER BY 
    가입자수 DESC;
    
    SELECT 
    u.addr AS 지역,
    SUM(b.price * b.amount) AS 총구매액
FROM 
    userTbl u
JOIN 
    buyTbl b ON u.userID = b.userID
GROUP BY 
    u.addr
ORDER BY 
    총구매액 DESC;

    




