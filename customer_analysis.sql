/*1. 데이터 분석*/
-- [1-1. FN 구독 여부 비율]
SELECT DISTINCT FN, ROUND((COUNT(customer_id)/(SELECT COUNT(customer_id) 
														FROM customers)*100),2) As '%'
FROM customers
GROUP BY FN;
-- 34.76%만이 구독

-- 1) 연령 별 FN 구독 여부: 어떻게 하는지 잘 모르겠어요..
SELECT CASE 
			WHEN age BETWEEN 0 AND 19 THEN '10대'
			WHEN age BETWEEN 20 AND 29 THEN '20대'
			WHEN age BETWEEN 30 AND 39 THEN '30대'
			WHEN age BETWEEN 40 AND 49 THEN '40대'
			WHEN age BETWEEN 50 AND 59 THEN '50대'
			WHEN age BETWEEN 60 AND 69 THEN '60대'
			WHEN age BETWEEN 70 AND 79 THEN '70대'
			WHEN age BETWEEN 80 AND 89 THEN '80대'
			WHEN age BETWEEN 90 AND 99 THEN '90대'
END as ageband, (SELECT COUNT(FN) FROM customers WHERE FN = 1)
FROM customers
GROUP BY ageband;

-- [1-2. ACTIVE]
SELECT DISTINCT Active, COUNT(Active), COUNT(customer_id)
FROM customers
GROUP BY Active;
-- active: 464,404명 / non-active: 443,172명


-- [1-3. customer의 club_member_satus 분류 수]
SELECT DISTINCT club_member_status, COUNT(club_member_status)
FROM customers
GROUP BY club_member_status;
-- PRE-CREATE 그룹의 고객들을 ACTIVE로 끌어들이기 위한 전략이 필요하다.

-- [1-4. customer의 fashion_news_frequency 분류 수]
SELECT DISTINCT fashion_news_frequency, COUNT(fashion_news_frequency)
FROM customers
GROUP BY fashion_news_frequency;
-- NONE값 즉 패션 뉴스 알람주기가 없는 사람들이 절반 이상을 차지한다. -> 알람 주기를 못해도 MONTHLY로 끌어들일 수 있는 방법이 없을까?

-- [1-5. 가장 높은, 낮은 연령]
SELECT MAX(age)
FROM customers; -- 99살: 맞는 정보일지? 의문
SELECT MIN(age)
FROM customers; -- 16살

-- [1-6. customer 연령 별 비율 테이블]
SELECT CASE 
			WHEN age BETWEEN 0 AND 19 THEN '10대'
			WHEN age BETWEEN 20 AND 29 THEN '20대'
			WHEN age BETWEEN 30 AND 39 THEN '30대'
			WHEN age BETWEEN 40 AND 49 THEN '40대'
			WHEN age BETWEEN 50 AND 59 THEN '50대'
			WHEN age BETWEEN 60 AND 69 THEN '60대'
			WHEN age BETWEEN 70 AND 79 THEN '70대'
			WHEN age BETWEEN 80 AND 89 THEN '80대'
			WHEN age BETWEEN 90 AND 99 THEN '90대'
END as ageband, COUNT(age), ROUND((COUNT(customer_id)/(SELECT COUNT(customer_id) 
														FROM customers)*100),2) As '%'
FROM customers
GROUP BY ageband
ORDER BY COUNT(age) DESC;
-- 20대 ~ 40대 비중이 50%가 넘는다
-- 나이대 별 분석을 사용하고자 하면 null값을 버리고 사용하기

-- [1-7. fashion_news_frequency 분류 별]
SELECT fashion_news_frequency, count(customer_id)
FROM customers
GROUP BY fashion_news_frequency;
-- NONE값과 NULL값을 동일하게 볼 수도 있을 것 같음.
