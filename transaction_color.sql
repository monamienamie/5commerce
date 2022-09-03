-- [1. 어떤 컬러의 상품이 가장 많이 팔렸는지? --> 컬러별 비중 따라서 매출 금액 달라질 수 있음]
-- 1) 7월달 가장 많이 팔린 컬러: Black-White-Blue-Beige-Pink-Grey-Red-Khaki green-Yellow-Orange-Brown-Green-Metal-Mole-Turquoise-Lilac Purple-Yellowish Green
SELECT A.color_name, COUNT(A.color_name)
FROM transactions T
	INNER JOIN articles A
	ON T.article_id = A.article_id
WHERE MONTH(T.date) = 7
GROUP BY A.color_name
ORDER BY COUNT(A.color_name) DESC;

-- 2) 8월달 가장 많이 팔린 컬러: Black-White-Blue-Beige-Grey--Red-Brown-Khaki green-Yellow-Green-Orange-Metal-Mole-Turquoise-Lilac Purple-Yellowish Green
SELECT A.color_name, COUNT(A.color_name)
FROM transactions T
	INNER JOIN articles A
	ON T.article_id = A.article_id
WHERE MONTH(T.date) = 8
GROUP BY A.color_name
ORDER BY COUNT(A.color_name) DESC;

-- 3) 9월달 가장 많이 팔린 컬러: Black-Blue-White-Beige-Grey-Brown-Red-Pink-Green-Yellow-Khaki green-Orange-Mole-Turquoise-Metal-Lilac Purple-Yellowish Green
SELECT A.color_name, COUNT(A.color_name)
FROM transactions T
	INNER JOIN articles A
	ON T.article_id = A.article_id
WHERE MONTH(T.date) = 9
GROUP BY A.color_name
ORDER BY COUNT(A.color_name) DESC;

-- 4) 10월달 가장 많이 팔린 컬러: Black-Blue-White-Beige-Grey-Red-Brown-Green-Pink-Khaki green-Yellow-Orange-Mole-Turquoise-Metal-Lilac Purple
SELECT A.color_name, COUNT(A.color_name)
FROM transactions T
	INNER JOIN articles A
	ON T.article_id = A.article_id
WHERE MONTH(T.date) = 10
GROUP BY A.color_name
ORDER BY COUNT(A.color_name) DESC;

-- 5) 11월달 가장 많이 팔린 컬러: Black-Blue-White-Red-Grey-Beige-Green-Brown-Pink-Khaki green-Mole-Yellow-Orange-Metal-Turquoise-Lilac Purple
SELECT A.color_name, COUNT(A.color_name)
FROM transactions T
	INNER JOIN articles A
	ON T.article_id = A.article_id
WHERE MONTH(T.date) = 11
GROUP BY A.color_name
ORDER BY COUNT(A.color_name) DESC;

-- 6) 12월달 가장 많이 팔린 컬러: Black-Blue-White-Grey-Red-Beige-Pink-Brown-Green-Khaki green-Mole-Metal-Yellow-Orange-Turquoise-Lilac Purple-Yellowish Green
SELECT A.color_name, COUNT(A.color_name)
FROM transactions T
	INNER JOIN articles A
	ON T.article_id = A.article_id
WHERE MONTH(T.date) = 12
GROUP BY A.color_name
ORDER BY COUNT(A.color_name) DESC;

-- [2. 연령대별로 선호하는 컬러가 있을까?]
-- *연령대 별 사람 수, 백분율 테이블 만들기 : 만들었긴 한데 쓸 줄을 모르겠네요..
CREATE TEMPORARY TABLE generation AS
SELECT (CASE
			WHEN customers.age>=0 AND customers.age<=19 THEN '10대'
            WHEN customers.age>=20 AND customers.age<=29 THEN '20대'
	        WHEN customers.age>=30 AND customers.age<=39 THEN '30대'
			WHEN customers.age>=40 AND customers.age<=49 THEN '40대'
            WHEN customers.age>=50 AND customers.age<=59 THEN '50대'
            WHEN customers.age>=60 AND customers.age<=69 THEN '60대'
            WHEN customers.age>=70 AND customers.age<=100 THEN '70대 이상'
            
            ELSE '연령 미확인'
            END
			) AS generation, COUNT(age), ROUND((COUNT(customer_id)/(SELECT COUNT(customer_id) 
														FROM customers)*100),1) As '백분율'
FROM customers
GROUP BY generation
ORDER BY generation;

-- *연령대 별 선호 컬러: 틀린 것 같아요..
SELECT (CASE
			WHEN C.age>=0 AND C.age<=19 THEN '10대'
            WHEN C.age>=20 AND C.age<=29 THEN '20대'
	        WHEN C.age>=30 AND C.age<=39 THEN '30대'
			WHEN C.age>=40 AND C.age<=49 THEN '40대'
            WHEN C.age>=50 AND C.age<=59 THEN '50대'
            WHEN C.age>=60 AND C.age<=69 THEN '60대'
            WHEN C.age>=70 AND C.age<=100 THEN '70대 이상'
            
            ELSE '연령 미확인'
            END
			) AS generation, COUNT(age)
		, A.color_name, Count(DISTINCT A.color_name)
FROM transactions T
	INNER JOIN articles A
    ON T.article_id = A.article_id
    INNER JOIN customers C
    ON T.customer_id = C.customer_id
WHERE MONTH(date) = 7 
	AND DAY(date) = 1
GROUP BY generation
ORDER BY generation;

-- 1-7월) 10대에게 7월 1일 가장 많이 팔리는 컬러 = Black-White-Blue
SELECT color_name, COUNT(color_name)
FROM  transactions T
	INNER JOIN articles A
    ON T.article_id = A.article_id
    INNER JOIN customers C
    ON T.customer_id = C.customer_id
WHERE C.age >= 0 AND C.age <= 19
	AND MONTH(date) = 7 AND DAY(date) = 1
GROUP BY color_name
ORDER BY COUNT(color_name) DESC;

-- 1-8월) 10대에게 8월 1일 가장 많이 팔리는 컬러 = Black-White-Blue
SELECT color_name, COUNT(color_name)
FROM  transactions T
	INNER JOIN articles A
    ON T.article_id = A.article_id
    INNER JOIN customers C
    ON T.customer_id = C.customer_id
WHERE C.age >= 0 AND C.age <= 19
	AND MONTH(date) = 8 AND DAY(date) = 1
GROUP BY color_name
ORDER BY COUNT(color_name) DESC;

-- 1-9월) 10대에게 9월 1일 가장 많이 팔리는 컬러 = Black-White-Blue
SELECT color_name, COUNT(color_name)
FROM  transactions T
	INNER JOIN articles A
    ON T.article_id = A.article_id
    INNER JOIN customers C
    ON T.customer_id = C.customer_id
WHERE C.age >= 0 AND C.age <= 19
	AND MONTH(date) = 9 AND DAY(date) = 1
GROUP BY color_name
ORDER BY COUNT(color_name) DESC;

-- 1-10월) 10대에게 10월 1일 가장 많이 팔리는 컬러 = Black-White-Blue
SELECT color_name, COUNT(color_name)
FROM  transactions T
	INNER JOIN articles A
    ON T.article_id = A.article_id
    INNER JOIN customers C
    ON T.customer_id = C.customer_id
WHERE C.age >= 0 AND C.age <= 19
	AND MONTH(date) = 10 AND DAY(date) = 1
GROUP BY color_name
ORDER BY COUNT(color_name) DESC;

-- 1-11월) 10대에게 11월 1일 가장 많이 팔리는 컬러 = Black-White-Blue
SELECT color_name, COUNT(color_name)
FROM  transactions T
	INNER JOIN articles A
    ON T.article_id = A.article_id
    INNER JOIN customers C
    ON T.customer_id = C.customer_id
WHERE C.age >= 0 AND C.age <= 19
	AND MONTH(date) = 11 AND DAY(date) = 1
GROUP BY color_name
ORDER BY COUNT(color_name) DESC;

-- 1-12월) 10대에게 12월 1일 가장 많이 팔리는 컬러 = Black-Grey-Blue -> 12월엔 Grey색이 Blue보다 더 많이 팔렸다
SELECT color_name, COUNT(color_name)
FROM  transactions T
	INNER JOIN articles A
    ON T.article_id = A.article_id
    INNER JOIN customers C
    ON T.customer_id = C.customer_id
WHERE C.age >= 0 AND C.age <= 19
	AND MONTH(date) = 12 AND DAY(date) = 1
GROUP BY color_name
ORDER BY COUNT(color_name) DESC;

-- 1-8월) 10대에게 8월 1일 가장 많이 팔리는 컬러 = Black-White-Blue
SELECT color_name, COUNT(color_name)
FROM  transactions T
	INNER JOIN articles A
    ON T.article_id = A.article_id
    INNER JOIN customers C
    ON T.customer_id = C.customer_id
WHERE C.age >= 0 AND C.age <= 19
	AND MONTH(date) = 8 AND DAY(date) = 1
GROUP BY color_name
ORDER BY COUNT(color_name) DESC;

-- 1-9월) 10대에게 9월 1일 가장 많이 팔리는 컬러 = Black-White-Blue
SELECT color_name, COUNT(color_name)
FROM  transactions T
	INNER JOIN articles A
    ON T.article_id = A.article_id
    INNER JOIN customers C
    ON T.customer_id = C.customer_id
WHERE C.age >= 0 AND C.age <= 19
	AND MONTH(date) = 9 AND DAY(date) = 1
GROUP BY color_name
ORDER BY COUNT(color_name) DESC;

-- 1-10월) 10대에게 10월 1일 가장 많이 팔리는 컬러 = Black-White-Blue
SELECT color_name, COUNT(color_name)
FROM  transactions T
	INNER JOIN articles A
    ON T.article_id = A.article_id
    INNER JOIN customers C
    ON T.customer_id = C.customer_id
WHERE C.age >= 0 AND C.age <= 19
	AND MONTH(date) = 10 AND DAY(date) = 1
GROUP BY color_name
ORDER BY COUNT(color_name) DESC;

-- 1-11월) 10대에게 11월 1일 가장 많이 팔리는 컬러 = Black-White-Blue
SELECT color_name, COUNT(color_name)
FROM  transactions T
	INNER JOIN articles A
    ON T.article_id = A.article_id
    INNER JOIN customers C
    ON T.customer_id = C.customer_id
WHERE C.age >= 0 AND C.age <= 19
	AND MONTH(date) = 11 AND DAY(date) = 1
GROUP BY color_name
ORDER BY COUNT(color_name) DESC;

-- 1-12월) 10대에게 12월 1일 가장 많이 팔리는 컬러 = Black-Grey-Blue -> 12월엔 Grey색이 Blue보다 더 많이 팔렸다
SELECT color_name, COUNT(color_name)
FROM  transactions T
	INNER JOIN articles A
    ON T.article_id = A.article_id
    INNER JOIN customers C
    ON T.customer_id = C.customer_id
WHERE C.age >= 0 AND C.age <= 19
	AND MONTH(date) = 12 AND DAY(date) = 1
GROUP BY color_name
ORDER BY COUNT(color_name) DESC;

-- 2-7월) 20대에게 7월 1일 가장 많이 팔리는 컬러 = Black-White-Blue
SELECT color_name, COUNT(color_name)
FROM  transactions T
	INNER JOIN articles A
    ON T.article_id = A.article_id
    INNER JOIN customers C
    ON T.customer_id = C.customer_id
WHERE C.age >= 20 AND C.age <= 29
	AND MONTH(date) = 7 AND DAY(date) = 1
GROUP BY color_name
ORDER BY COUNT(color_name) DESC;

-- 3-7월) 30대에게 7월 1일 가장 많이 팔리는 컬러 = Black-White-Blue
SELECT color_name, COUNT(color_name)
FROM  transactions T
	INNER JOIN articles A
    ON T.article_id = A.article_id
    INNER JOIN customers C
    ON T.customer_id = C.customer_id
WHERE C.age >= 30 AND C.age <= 39
	AND MONTH(date) = 7 AND DAY(date) = 1
GROUP BY color_name
ORDER BY COUNT(color_name) DESC;

-- 4-7월) 40대에게 7월 1일 가장 많이 팔리는 컬러 = Black-White-Blue
SELECT color_name, COUNT(color_name)
FROM  transactions T
	INNER JOIN articles A
    ON T.article_id = A.article_id
    INNER JOIN customers C
    ON T.customer_id = C.customer_id
WHERE C.age >= 40 AND C.age <= 49
	AND MONTH(date) = 7 AND DAY(date) = 1
GROUP BY color_name
ORDER BY COUNT(color_name) DESC;

-- 5-7월) 50대에게 7월 1일 가장 많이 팔리는 컬러 = Black-White-Blue
SELECT color_name, COUNT(color_name)
FROM  transactions T
	INNER JOIN articles A
    ON T.article_id = A.article_id
    INNER JOIN customers C
    ON T.customer_id = C.customer_id
WHERE C.age >= 50 AND C.age <= 59
	AND MONTH(date) = 7 AND DAY(date) = 1
GROUP BY color_name
ORDER BY COUNT(color_name) DESC;

-- 6-7월) 60대에게 7월 1일 가장 많이 팔리는 컬러 = Black-White-Blue
SELECT color_name, COUNT(color_name)
FROM  transactions T
	INNER JOIN articles A
    ON T.article_id = A.article_id
    INNER JOIN customers C
    ON T.customer_id = C.customer_id
WHERE C.age >= 60 AND C.age <= 69
	AND MONTH(date) = 7 AND DAY(date) = 1
GROUP BY color_name
ORDER BY COUNT(color_name) DESC;

-- 7-7월) 70대 이상에게 7월 1일 가장 많이 팔리는 컬러 = White-Black-Blue -> 다른 연령대에 비해 밝은 색상의 수요가 더 많다
SELECT color_name, COUNT(color_name)
FROM  transactions T
	INNER JOIN articles A
    ON T.article_id = A.article_id
    INNER JOIN customers C
    ON T.customer_id = C.customer_id
WHERE C.age >= 70 AND C.age <= 100
	AND MONTH(date) = 7 AND DAY(date) = 1
GROUP BY color_name
ORDER BY COUNT(color_name) DESC;

-- 2-12월) 20대에게 12월 1일 가장 많이 팔리는 컬러
SELECT color_name, COUNT(color_name)
FROM  transactions T
	INNER JOIN articles A
    ON T.article_id = A.article_id
    INNER JOIN customers C
    ON T.customer_id = C.customer_id
WHERE C.age >= 20 AND C.age <= 29
	AND MONTH(date) = 12 AND DAY(date) = 1
GROUP BY color_name
ORDER BY COUNT(color_name) DESC;

-- 3-12월) 30대에게 12월 1일 가장 많이 팔리는 컬러
SELECT color_name, COUNT(color_name)
FROM  transactions T
	INNER JOIN articles A
    ON T.article_id = A.article_id
    INNER JOIN customers C
    ON T.customer_id = C.customer_id
WHERE C.age >= 30 AND C.age <= 39
	AND MONTH(date) = 12 AND DAY(date) = 1
GROUP BY color_name
ORDER BY COUNT(color_name) DESC;

-- 4-12월) 40대에게 12월 1일 가장 많이 팔리는 컬러
SELECT color_name, COUNT(color_name)
FROM  transactions T
	INNER JOIN articles A
    ON T.article_id = A.article_id
    INNER JOIN customers C
    ON T.customer_id = C.customer_id
WHERE C.age >= 40 AND C.age <= 49
	AND MONTH(date) = 12 AND DAY(date) = 1
GROUP BY color_name
ORDER BY COUNT(color_name) DESC;

-- 5-12월) 50대에게 12월 1일 가장 많이 팔리는 컬러
SELECT color_name, COUNT(color_name)
FROM  transactions T
	INNER JOIN articles A
    ON T.article_id = A.article_id
    INNER JOIN customers C
    ON T.customer_id = C.customer_id
WHERE C.age >= 50 AND C.age <= 59
	AND MONTH(date) = 12 AND DAY(date) = 1
GROUP BY color_name
ORDER BY COUNT(color_name) DESC;

-- 6-12월) 60대에게 12월 1일 가장 많이 팔리는 컬러
SELECT color_name, COUNT(color_name)
FROM  transactions T
	INNER JOIN articles A
    ON T.article_id = A.article_id
    INNER JOIN customers C
    ON T.customer_id = C.customer_id
WHERE C.age >= 60 AND C.age <= 69
	AND MONTH(date) = 12 AND DAY(date) = 1
GROUP BY color_name
ORDER BY COUNT(color_name) DESC;

-- 7-12월) 70대 이상에게 12월 1일 가장 많이 팔리는 컬러
SELECT color_name, COUNT(color_name)
FROM  transactions T
	INNER JOIN articles A
    ON T.article_id = A.article_id
    INNER JOIN customers C
    ON T.customer_id = C.customer_id
WHERE C.age >= 70 AND C.age <= 100
	AND MONTH(date) = 12 AND DAY(date) = 1
GROUP BY color_name
ORDER BY COUNT(color_name) DESC;

-- *7월 거래 일자 unique값: 하루에 평균 5만건의 거래가 이뤄지고 있음 -> 하루 건수도 많은데 조인까지 해서 월별 연령별로 인기 많은 컬러 도출 불가능..
SELECT DISTINCT(date),COUNT(DISTINCT transaction_id)
FROM transactions
WHERE MONTH(date) = 7
GROUP BY date;

-- *7월 가장 많이 팔린 컬러 값
SELECT A.color_name, COUNT(A.color_name)
FROM transactions T
INNER JOIN articles A
ON T.article_id = A.article_id
WHERE MONTH(date) = 7
GROUP BY A.color_name
ORDER BY COUNT(A.color_name) DESC
LIMIT 1;

-- [3. product_group_name 중 실제 팔리고 있는 product_group_name: 8개 카테고리만 남긴게 맞는지?](Socks/Tights, Swimwear 없음) 
-- 1) product_group_name 중 unique값
SELECT DISTINCT product_group_name
FROM articles;

-- 2) transactions 테이블에 조회되는 product_group_name: 행 수 같음 = 7월달에 안팔리고 있는 그룹 없음
SELECT DISTINCT product_group_name
FROM transactions T
	INNER JOIN articles A
    ON T.article_id = A.article_id
WHERE MONTH(date) = 7;

-- [4. product_group 별로 잘 팔리는 컬러가 있는가?] *12월까지는 데이터가 너무 많아 7월 한정함을 주의
-- 1) garment upper body에서 제일 잘 팔리는 컬러: White-Black-Blue-...-Lilac Purple-Metal-Yellowish Green
SELECT DISTINCT(color_name), COUNT(color_name)
FROM transactions T
	INNER JOIN articles A
    ON T.article_id = A.article_id
WHERE MONTH(T.date) = 7 AND product_group_name = 'garment upper body'
GROUP BY color_name
ORDER BY COUNT(color_name) DESC;

-- 2) Underwear: Black-White-Pink-...-Khaki green-Yellow-Brown
SELECT DISTINCT(color_name), COUNT(color_name)
FROM transactions T
	INNER JOIN articles A
    ON T.article_id = A.article_id
WHERE MONTH(T.date) = 7 AND product_group_name = 'Underwear'
GROUP BY color_name
ORDER BY COUNT(color_name) DESC;

-- 3) Garment Lower body: Black-Blue-White-...-Turquoise-Lilac Purple-Metal
SELECT DISTINCT(color_name), COUNT(color_name)
FROM transactions T
	INNER JOIN articles A
    ON T.article_id = A.article_id
WHERE MONTH(T.date) = 7 AND product_group_name = 'Garment Lower body'
GROUP BY color_name
ORDER BY COUNT(color_name) DESC;

-- 4) Accessories: Black-Metal-Beige-...-Khaki green-Turquoise-Lilac Purple
SELECT DISTINCT(color_name), COUNT(color_name)
FROM transactions T
	INNER JOIN articles A
    ON T.article_id = A.article_id
WHERE MONTH(T.date) = 7 AND product_group_name = 'Accessories'
GROUP BY color_name
ORDER BY COUNT(color_name) DESC;

-- 5) Nightwear: Blue-Black-Pink-...-Green-Yellow-Lilac Purple
SELECT DISTINCT(color_name), COUNT(color_name)
FROM transactions T
	INNER JOIN articles A
    ON T.article_id = A.article_id
WHERE MONTH(T.date) = 7 AND product_group_name = 'Nightwear'
GROUP BY color_name
ORDER BY COUNT(color_name) DESC;

-- *잘못 계산하고 있는지 맞게 계산하고 있는건지 확인: 맞게 계산하고 있음 
SELECT DISTINCT(color_name), COUNT(color_name)
FROM articles
WHERE product_group_name = 'Nightwear'
GROUP BY color_name
ORDER BY COUNT(color_name) DESC;

-- 6) Underwear/nightwear: Blue-Pink-White
SELECT DISTINCT(color_name), COUNT(color_name)
FROM transactions T
	INNER JOIN articles A
    ON T.article_id = A.article_id
WHERE MONTH(T.date) = 7 AND product_group_name = 'Underwear/nightwear'
GROUP BY color_name
ORDER BY COUNT(color_name) DESC;

-- 7) Shoes: Black-White-Beige-...-Mole-Turquoise-Lilac Purple
SELECT DISTINCT(color_name), COUNT(color_name)
FROM transactions T
	INNER JOIN articles A
    ON T.article_id = A.article_id
WHERE MONTH(T.date) = 7 AND product_group_name = 'Shoes'
GROUP BY color_name
ORDER BY COUNT(color_name) DESC;

-- 8) Garment Full body: Black-White-Blue-...-Mole-Lilac Purple-Metal
SELECT DISTINCT(color_name), COUNT(color_name)
FROM transactions T
	INNER JOIN articles A
    ON T.article_id = A.article_id
WHERE MONTH(T.date) = 7 AND product_group_name = 'Garment Full body'
GROUP BY color_name
ORDER BY COUNT(color_name) DESC;
