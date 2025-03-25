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

--10
--1) userTbl과 buyTbl을 조인하고
--2) 같은 지역(addr)에 사는 사용자들 중 / 구매 총액이 /  지역별 평균 구매액 보다 /높은 /사용자(userID)를 조회/하는 SQL문을 작성하시오. (서브쿼리와 HAVING 사용)
-- 같은 지역(addr)에 사는 사용자들 중 구매 총액 >=  지역별 평균 구매액

    -- 같은 지역(addr)에 사는 사용자들 중 구매 총액(aa)
    select addr ,u.userid, sum(amount*price) as 총액
    from userTbl u
    join buyTbl b 
    on u.userid=b.userid
    group by addr,u.userid;
    -- JOIN
    --지역별 구매평균
    select addr,avg(amount*price) as 지역별평균
    from userTbl u
    join buyTbl b
    on u.userid=b.userid
    group by addr;
    
    -- WHERE 
    
select aa.addr,userid,총액,지역별평균
from 
(
    -- 같은 지역(addr)에 사는 사용자들 중 구매 총액
    select addr ,u.userid, sum(amount*price) as 총액
    from userTbl u
    join buyTbl b 
    on u.userid=b.userid
    group by addr,u.userid
) aa
join
(
    --지역별 구매평균
    select addr,avg(amount*price) as 지역별평균
    from userTbl u
    join buyTbl b
    on u.userid=b.userid
    group by addr
) bb
on aa.addr=bb.addr
where aa.총액>=bb.지역별평균;

-- ---------------------------
--함수의 개념 및 종류
--함수(Function)의 정의: 특정 작업을 수행하기 위해 미리 정의된 명령어
--단일행 함수(Single-row Functions): 행별로 하나의 결과를 반환
--다중행 함수(Multi-row Functions): 여러 행의 값을 입력받아 하나의 결과를 반환

--예시 : 
-- 단일행 함수 예시 (UPPER: 각 행별로 처리)
SELECT userID, UPPER(name) AS upper_name FROM userTbl;

-- 다중행 함수 예시 (COUNT: 여러 행을 묶어서 처리)
SELECT addr, COUNT(*) AS user_count FROM userTbl GROUP BY addr;
-- ------------------------------------------
--단일행 함수-문자형 함수
--LOWER, UPPER, INITCAP: 대소문자 변환
--LENGTH, LENGTHB: 문자열 길이 반환
--SUBSTR: 문자열 일부 추출
--INSTR: 특정 문자 위치 찾기
--LPAD, RPAD: 문자열 채우기
--TRIM, LTRIM, RTRIM: 공백 제거
--REPLACE: 문자열 치환
--CONCAT: 문자열 연결

-- 대소문자 변환
SELECT userID,
       LOWER(userID) AS lower_id,         -- 소문자 변환
       UPPER(name) AS upper_name,         -- 대문자 변환
       INITCAP(LOWER(name)) AS init_cap   -- 첫 글자만 대문자로 변환
FROM userTbl;
-- ---------------------------
-- 문자열 길이
SELECT name, 
       LENGTH(name) AS name_length,       -- 이름의 문자 개수
       LENGTH(addr) AS addr_length        -- 주소의 문자 개수
FROM userTbl;
-- ---------------------------
-- 문자열 추출
SELECT name,
       SUBSTR(name, 1, 1) AS first_char,  -- 이름의 첫 글자
       SUBSTR(userID, 2) AS userid_part   -- userID의 두 번째 문자부터 끝까지
FROM userTbl;
-- ---------------------------
-- 문자 위치 찾기
SELECT name, 
       INSTR(name, '김') AS position_kim   -- '김'이 있는 위치 (없으면 0)
FROM userTbl;
-- ---------------------------
-- 문자열 채우기
SELECT userID,
       LPAD(userID, 10, '*') AS lpad_id,  -- userID 왼쪽을 *로 채워 10자리로
       RPAD(name, 10, '-') AS rpad_name   -- name 오른쪽을 -로 채워 10자리로
FROM userTbl;
-- ---------------------------
-- 공백 제거
SELECT TRIM(' SQL ') AS trim_result,      -- 양쪽 공백 제거: 'SQL'
       LTRIM(' SQL ') AS ltrim_result,    -- 왼쪽 공백 제거: 'SQL '
       RTRIM(' SQL ') AS rtrim_result     -- 오른쪽 공백 제거: ' SQL'
FROM dual;
-- ---------------------------
-- 문자열 치환
SELECT name,
       REPLACE(mobile1, null, '없음') AS replace_null,   -- NULL을 '없음'으로 대체
       REPLACE(addr, '서울', 'SEOUL') AS replace_addr   -- '서울'을 'SEOUL'로 대체
FROM userTbl;

-- 문자열 연결
SELECT name,
       CONCAT(mobile1, '-') AS part1,                    -- 휴대폰 국번과 '-' 연결
       CONCAT(CONCAT(mobile1, '-'), mobile2) AS mobile,  -- 국번-전화번호 형식으로 연결
       mobile1 || '-' || mobile2 AS phone_number        -- 연결 연산자 사용
FROM userTbl;
-- --------------------------
--단일행 함수-숫자형 함수
--ROUND: 반올림
--TRUNC: 절삭
--CEIL, FLOOR: 올림, 내림
--MOD: 나머지 구하기
--ABS: 절대값
--SIGN: 부호 확인
--POWER: 제곱
--SQRT: 제곱근
-- ---------------------
--예시코드:

-- buyTbl 테이블의 가격 데이터 활용
-- 반올림, 절삭
SELECT prodName, price,
       ROUND(price/1000, 2) AS round_thousands,    -- 천 단위로 나누고 소수점 2자리 반올림
       TRUNC(price/1000, 1) AS trunc_thousands     -- 천 단위로 나누고 소수점 1자리 절삭
FROM buyTbl;

-- 올림, 내림
SELECT prodName, price,
       CEIL(price/100) AS ceil_hundreds,           -- 백 단위로 나누고 올림
       FLOOR(price/100) AS floor_hundreds          -- 백 단위로 나누고 내림
FROM buyTbl;

-- 나머지, 절대값
SELECT prodName, price, amount,
       MOD(price, 100) AS remainder_100,           -- 가격을 100으로 나눈 나머지
       ABS(price - 500) AS abs_diff_500            -- 가격과 500의 차이의 절대값
FROM buyTbl;

-- 부호, 제곱, 제곱근
SELECT prodName, price,
       SIGN(price - 100) AS sign_price,            -- 가격이 100보다 크면 1, 같으면 0, 작으면 -1
       POWER(amount, 2) AS amount_squared,         -- 수량의 제곱
       SQRT(price) AS sqrt_price                   -- 가격의 제곱근
FROM buyTbl;

--단일행 함수-날짜형 함수
--SYSDATE, CURRENT_DATE: 현재 날짜
--ADD_MONTHS: 월 더하기
--MONTHS_BETWEEN: 월 차이 계산
--NEXT_DAY: 다음 요일 날짜
--LAST_DAY: 월의 마지막 날짜
--EXTRACT: 날짜 요소 추출
--TO_CHAR: 날짜를 문자로 변환
--TO_DATE: 문자를 날짜로 변환
-- ----------------------------
--예시코드 : 

-- 현재 날짜와 회원 가입일 활용
SELECT name, mDate,
       SYSDATE AS today,                             -- 현재 날짜/시간
       CURRENT_DATE AS current_date                  -- 현재 날짜
FROM userTbl;

-- 날짜 연산
SELECT name, mDate,
       mDate + 7 AS after_week,                      -- 가입일 1주일 후
       mDate - 7 AS before_week                      -- 가입일 1주일 전
FROM userTbl;

-- 월 관련 함수
SELECT name, mDate,
       ADD_MONTHS(mDate, 6) AS after_6months,        -- 가입일 6개월 후
       MONTHS_BETWEEN(SYSDATE, mDate) AS months_since_join  -- 가입 후 경과 월 수
FROM userTbl;

-- 요일, 말일 함수
SELECT name, mDate,
       NEXT_DAY(mDate, '금요일') AS next_friday,      -- 가입일 이후의 첫 금요일
       LAST_DAY(mDate) AS last_day_of_month          -- 가입월의 마지막 날짜
FROM userTbl;

-- 날짜 요소 추출
SELECT name, mDate,
       EXTRACT(YEAR FROM mDate) AS join_year,        -- 가입 연도
       EXTRACT(MONTH FROM mDate) AS join_month,      -- 가입 월
       EXTRACT(DAY FROM mDate) AS join_day           -- 가입 일
FROM userTbl;


