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
-- ---------------------------
select userid, sum(price*amount)as 구매총액
from buytbl
group by userid;
-- ---------------------------
SELECT NVL(groupName, '미분류') AS 그룹명, SUM(amount) AS 판매수량합계 FROM buyTbl GROUP BY NVL(groupName, '미분류');

-- case - is null then
SELECT 
    case
    when groupName is null then '미분류! 
    else groupName
    end
    as 카테고리,sum(amount)
    from buytbl
    group by groupName;

-- ---------------------------
SELECT 
    birthYear AS 출생년도,
    AVG(height) AS 평균키
FROM 
    userTbl
GROUP BY 
    birthYear
ORDER BY 
    birthYear;
    
 -- ---------------------------   
SELECT 
    prodName AS 제품명,
    COUNT(*) AS 구매횟수,
    SUM(price * amount) AS 총구매액
FROM 
    buyTbl
GROUP BY 
    prodName
ORDER BY 
    구매횟수 DESC;
-- ---------------------------    
SELECT 
    NVL(mobile1, '미입력') AS 통신사,
    COUNT(*) AS 가입자수
FROM 
    userTbl
GROUP BY 
    NVL(mobile1, '미입력')
ORDER BY 
    가입자수 DESC;
 -- ---------------------------   
 select u.addr,sum(b.price*b.amount) as 총구매액
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
 SELECT FLOOR((2025 - u.birthYear) / 10) * 10 AS 연령대, 
       SUM(b.price * b.amount) AS 구매총액
FROM userTbl u
JOIN buyTbl b ON u.userID = b.userID
GROUP BY FLOOR((2025 - u.birthYear) / 10) * 10
ORDER BY 연령대;

-- 구매 금액 합계가 1000 이상인 사용자 조회
select userid, sum(price * amount) as 총구매액
from buytbl
group by userid
having sum(price * amount)>=1000;

-- 평균키가 175 이상인 지역 조회
select addr, avg(height) as 평균키
from usertbl
group by addr
having avg(height)>=175;

-- 주의점!! having 과 where이 group by 의 어디에 들어가야하는 지 유의!!

select userid, count(*) as 구매횟수, sum(price*amount) as 총구매액
from buytbl
group by userid
having count(*)>=and sum(price*amount)>=100;

--inner join
select u.addr, nvl(b.groupname,'미분류'), sum(b.amount*b.price)
from usertbl u
join buytbl b
on u.userid=b.userid
group by u.addr, b.groupname
order by sum(b.amount*b.price) desc
;

select nvl(groupname,'미분류'),sum(price*amount)
from buytbl
group by rollup(groupname);
    
select groupname,prodname,sum(price*amount)
from buytbl
group by cube(groupname, prodname);

SELECT groupName, prodName, SUM(price * amount) AS 판매액
FROM buyTbl
WHERE groupName IS NOT NULL
GROUP BY GROUPING SETS((groupName), (prodName), ());

-- -----------------------------------------------------
--1buyTbl에서 총 구매액이 1,000 이상인 사용자(userID)만 조회하는 SQL문을 작성하시오.
select userid, sum(price*amount)as 총구매액
from buytbl
group by userid
having sum(price*amount)>=1000;

--2userTbl에서 가입자 수가 2명 이상인 지역(addr)만 조회하는 SQL문을 작성하시오.
select addr, count(*)as 가입자수
from usertbl
group by addr
having count(*)>=2
order by count(*) desc;
--3buyTbl에서 평균 구매액이 100 이상인 제품(prodName)만 조회하는 SQL문을 작성하시오.

select prodname, avg(price*amount)as "평균 구매액"
from buytbl
group by prodname
having avg(price*amount)>=100;

--4userTbl에서 평균 키가 175cm 이상인 출생년도를 조회하는 SQL문을 작성하시오.
select birthyear, avg(height)as 평균키
from usertbl 
group by birthyear 
having avg(height)>=175;

--5buyTbl에서 최소 2개 이상의 제품을 구매한 사용자(userID)를 조회하는 SQL문을 작성하시오.
select userid, sum(amount)
from buytbl
group by userid
having sum(amount) >=2;

--6userTbl과 buyTbl을 조인하여 구매 총액이 200 이상인 지역(addr)만 조회하는 SQL문을 작성하시오.
select addr, sum(b.price*b.amount)as 구매총액
from usertbl u
join buytbl b
on u.userid=b.userid
group by u.addr
having sum(b.price*b.amount)>=200;

--7buyTbl에서 구매 횟수가 3회 이상이고 총 구매액이 500 이상인 사용자(userID)를 조회하는 SQL문을 작성하시오.
select userid, count(*)as 구매횟수, sum(amount*price)as 총구매액
from buytbl
group by userid
having count(*) >=3 and sum(amount*price)>-500;

--8userTbl에서 평균 키가 가장 큰 지역(addr)을 조회하는 SQL문을 작성하시오. (서브쿼리와 HAVING 사용)
select *
from (select addr, avg(height) as 평균키 from usertbl group by addr)
where 평균키=(select max(avg(height)) as 평균키 from usertbl group by addr);

SELECT addr, AVG(height) AS 평균키
FROM userTbl
GROUP BY addr
HAVING AVG(height) = (
    SELECT MAX(AVG(height))
    FROM userTbl
    GROUP BY addr
);

--9buyTbl에서 구매 금액의 평균값보다 더 많은 금액을 사용한 사용자(userID)를 조회하는 SQL문을 작성하시오. (서브쿼리와 HAVING 사용)
select userid,avg(price*amount)
from buytbl
group by userid
having avg(price*amount)>= (select avg(price*amount) from buytbl);

--10userTbl과 buyTbl을 조인하여 같은 지역(addr)에 사는 사용자들 중 구매 총액이 지역별 평균 구매액보다 높은 사용자(userID)를 조회하는 SQL문을 작성하시오. (서브쿼리와 HAVING 사용)

-- 사용자별 구매 총액 
select u.userid,sum(amount*price)
from usertbl u
join buytbl b
on u.userid=b.userid
group by u.userid;

-- 지역별 평균 구매액
select addr,avg(amount*price)
from usertbl u
join buytbl b
on u.userid=b.userid
group by addr;

