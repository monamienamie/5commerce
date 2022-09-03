-- transactions file 확인
SELECT * FROM transactions LIMIT 5;

SELECT distinct sales_channel_id
FROM transactions;

-- 패션 클럽 가입자와 가입 하지 않은 고객의 평균 매출 차이는?

-- 패션 클럽 회원 상태
SELECT distinct club_member_status as status
FROM customers;

-- 전체 customers number
SELECT COUNT(*)
FROM customers;

-- 패션 클럽 활성화(active거나 pre-create 상태) 회원의 수
SELECT count(*) as n_members
FROM customers
WHERE club_member_status = 'ACTIVE' OR 'PRE-CREATE';

-- 패션 클럽을 탈퇴한 회원의 수
SELECT count(*) as left_members
FROM customers
WHERE club_member_status = 'LEFT CLUB';

-- 탈퇴한 멤버의 수
SELECT
(SELECT count(*)
FROM customers
WHERE club_member_status = 'LEFT CLUB') / (SELECT count(*)
FROM customers
WHERE club_member_status = 'ACTIVE' OR 'PRE-CREATE') as left_memebers_rate
FROM customers
GROUP BY 1;

-- 패션 클럽 가입자와 가입 하지 않는 그룹의 평균 매출 차이는?




-- 클럽 멤버 상황 별 price의 평균: pre-create 가 가장 높음 
SELECT c.club_member_status, AVG(price) OVER(PARTITION BY c.club_member_status) average
FROM customers c
JOIN transactions as t
ON c.customer_id = t.customer_id
GROUP BY 1
ORDER BY 2 DESC;

-- 패션 뉴스 관련

-- Fashion News 구독자와 비구독자 사이에 매출 차이가 있을까?
-- FN 데이터 살펴보기
SELECT distinct FN
FROM customers;

-- 패션 뉴스를 구독하는 사람과 아닌 사람의 매출 합계
SELECT FN, SUM(t.price)
FROM customers as c
JOIN transactions as t 
ON c.customer_id = t.customer_id
GROUP BY 1;

-- 패션 뉴스를 구독하는 사람과 아닌 사람의 비중은?
SELECT FN, COUNT(*)
FROM customers as c
GROUP BY 1;

-- 패션 뉴스를 구독하는 사람과 아닌 사람의 매출 평균
SELECT FN, AVG(t.price)
FROM customers as c
JOIN transactions as t 
ON c.customer_id = t.customer_id
GROUP BY 1;

-- 패션 뉴스를 구독하고 Active인 회원의 수
SELECT FN, club_member_status, count(*)
FROM customers
WHERE FN = 1 AND (club_member_status = 'ACTIVE' OR 'PRE-CREATE')
GROUP BY 1,2;

-- 하나의 테이블로 만들어버렷
SELECT(
SELECT count(*)
FROM customers
WHERE FN = 1 AND (club_member_status = 'ACTIVE' OR 'PRE-CREATE')
GROUP BY FN, club_member_status) as 'FN=1, ACTIVE',
(
SELECT count(*)
FROM customers
WHERE FN = 0 AND (club_member_status = 'ACTIVE' OR 'PRE-CREATE')
GROUP BY FN, club_member_status) as 'FN=0, ACTIVE',
(SELECT count(*)
FROM customers
WHERE FN = 1 AND (club_member_status = 'LEFT CLUB')
GROUP BY FN, club_member_status) as 'FN=1, LEFT',
(SELECT count(*)
FROM customers
WHERE FN = 0 AND (club_member_status = 'LEFT CLUB')
GROUP BY FN, club_member_status) as 'FN=0, LEFT'
FROM customers
GROUP BY 1;

WITH T1 as (
SELECT(
SELECT count(*)
FROM customers
WHERE FN = 1 AND (club_member_status = 'ACTIVE' OR 'PRE-CREATE')
GROUP BY FN, club_member_status) as 'FN=1, ACTIVE',
(
SELECT count(*)
FROM customers
WHERE FN = 0 AND (club_member_status = 'ACTIVE' OR 'PRE-CREATE')
GROUP BY FN, club_member_status) as 'FN=0, ACTIVE',
(SELECT count(*)
FROM customers
WHERE FN = 1 AND (club_member_status = 'LEFT CLUB')
GROUP BY FN, club_member_status) as 'FN=1, LEFT',
(SELECT count(*)
FROM customers
WHERE FN = 0 AND (club_member_status = 'LEFT CLUB')
GROUP BY FN, club_member_status) as 'FN=0, LEFT'
FROM customers
GROUP BY 1
)
SELECT *
FROM T1
;

-- fashion news frenquency의 값
SELECT distinct fashion_news_frequency
FROM customers
;

-- frequency 그룹별 매출과 연관성~
SELECT fashion_news_frequency, AVG(price) as average
FROM customers as c
JOIN transactions as t
ON c.customer_id = t.customer_id
GROUP BY 1
ORDER BY 2;

SELECT fashion_news_frequency, AVG(price) as average
FROM customers as c
JOIN transactions as t
ON c.customer_id = t.customer_id
WHERE (SELECT COUNT(DISTINCT customer_id) FROM transactions) >= 2
GROUP BY 1
ORDER BY 2; -- 결과 똑같음 흠.. 

-- 연령대별 FN, club_member_status 가입 인원을 뽑아봅시다.
-- 연령대별 패션 뉴스를 구독하는 사람
SELECT FN, FLOOR(age/10)*10 ageband, COUNT(*) cnt
FROM customers
GROUP BY 1, 2
ORDER BY 1, 2;

-- 많은 순서대로 보겠습니다.
SELECT FN, FLOOR(age/10)*10 ageband, COUNT(*) cnt
FROM customers
GROUP BY 1, 2
HAVING FN = 1
ORDER BY 3 desc;

-- club member status는?
SELECT club_member_status, FLOOR(age/10)*10 ageband, COUNT(*) cnt
FROM customers
GROUP BY 1, 2
HAVING club_member_status IS NOT NULL
ORDER BY 1, 2;

-- 연령대별 매출 금액은?
SELECT FLOOR(age/10)*10 ageband, ROUND(SUM(price), 2)
FROM customers c
JOIN transactions t
ON c.customer_id = t.customer_id
GROUP BY ageband
ORDER BY ageband;

-- 연령대별 매출 금액의 평균은?
SELECT FLOOR(age/10)*10 ageband, ROUND(AVG(price), 2) average
FROM customers c
JOIN transactions t
ON c.customer_id = t.customer_id
GROUP BY ageband
ORDER BY ageband;

-- 연령별 Fashion News 구독률
SELECT FLOOR(age/10)*10 ageband, ROUND(AVG(price), 2) average
FROM customers c
JOIN transactions t
ON c.customer_id = t.customer_id
GROUP BY ageband
ORDER BY ageband;

-- 