USE 5commerce;

SELECT *
FROM articles
LIMIT 5;

# 1)article_id와 product_code가 unique값인지 알아보자
SELECT COUNT(article_id),COUNT(DISTINCT article_id)
FROM articles; -- 중복 없음

SELECT COUNT(product_code),COUNT(DISTINCT product_code)
FROM articles; -- 중복 있음. 같은 상품이지만 옵션에 따라 artilce이 나뉘어짐

# 2)product_type이 어떻게 분류되어 있는지 알아보자
SELECT product_type_no, product_type_name
FROM articles
GROUP BY 1,2
ORDER BY 1;

SELECT COUNT(DISTINCT product_type_no)
FROM articles;
-- 미분류된 article을 살펴보자.
SELECT *
FROM articles
WHERE product_type_no = -1;

# 3)product_group이 어떻게 분류되어 있는지 알아보자
SELECT product_group_name, COUNT(DISTINCT product_type_name) cnt_prod_types, COUNT(*) AS cnt_articles, COUNT(DISTINCT product_code) cnt_prod
FROM articles
GROUP BY 1
ORDER BY 3 DESC;

-- 옵션 종류가 가장 많은 상품 그룹은 어디일까?
SELECT product_group_name, COUNT(DISTINCT product_type_name) cnt_prod_types, COUNT(*) AS cnt_articles, COUNT(DISTINCT product_code) cnt_prod, 
	ROUND((COUNT(*) / COUNT(DISTINCT product_code)),1) avg_options
FROM articles
GROUP BY 1
ORDER BY 5 DESC;

-- product_type이 product_group의 세부 카테고리일까?
SELECT SUM(A.cnt) AS sum_of_type_no
FROM (SELECT product_group_name, COUNT(DISTINCT product_type_no) AS cnt
		FROM articles
		GROUP BY 1 ) A;
        
SELECT COUNT(DISTINCT product_type_no) AS cnt_of_type_no
FROM articles;     

# 4)product_group이 어떻게 분류되어 있는지 알아보자
SELECT product_type_name, COUNT(*) AS cnt_articles, COUNT(DISTINCT product_code) cnt_prod
FROM articles
WHERE product_group_name IN ('Accessories', 'Garment Upper Body', 'Garment Lower Body', 'Garment Full Body')
GROUP BY 1
ORDER BY 3 DESC;
  

# 5)graphical_appearance의 종류를 살펴보자
SELECT graphical_appearance_no, graphical_appearance_name, COUNT(*)
FROM articles
GROUP BY 1, 2
ORDER BY 1;

# 6) colour 살펴보기
-- colou_group 종류 알아보기
SELECT colour_group_code, colour_group_name, COUNT(*)
FROM articles
GROUP BY 1,2
ORDER BY 3 DESC;
-- colour_group별로 비중 알아보기
SELECT colour_group_code, colour_group_name, ROUND((COUNT(*)/105542*100),1) AS ratio,
	ROUND((SUM(COUNT(*)/105542*100) OVER(ORDER BY(COUNT(*)/105542*100) DESC ROWS UNBOUNDED PRECEDING)),1) AS cumulative_ratio
FROM articles
GROUP BY 1,2
ORDER BY 3 DESC;

-- perceived_colour_value 종류 알아보기
SELECT DISTINCT perceived_colour_value_id, perceived_colour_value_name, COUNT(*)
FROM articles
GROUP BY 1,2
ORDER BY 1;
-- perceived_colour_master 종류 알아보기
SELECT DISTINCT perceived_colour_master_id, perceived_colour_master_name, COUNT(*)
FROM articles
GROUP BY 1,2
ORDER BY 1;

SELECT colour_group_code, colour_group_name, COUNT(DISTINCT perceived_colour_value_name) AS cnt_perceived_val,
	COUNT(DISTINCT perceived_colour_master_name) AS cnt_perceived_mas
FROM articles
GROUP BY 1, 2
ORDER BY 3 DESC, 4 DESC;

# 7) department 알아보기
SELECT DISTINCT department_no, department_name, COUNT(*)
FROM articles
GROUP BY 1,2
ORDER BY 3 DESC;
