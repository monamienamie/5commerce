/*1. 데이터 분석*/
-- [1-1. index_name 분류 수]
SELECT DISTINCT index_name
FROM articles; -- Divided는 뭐지?

-- [1-2. department_name 분류 수]
SELECT DISTINCT department_name
FROM articles; 

-- [1-3. index_group_name 분류 수]
SELECT DISTINCT index_group_name
FROM articles; -- index_group > index

-- [1-4. section_name 분류 수]
SELECT DISTINCT section_name
FROM articles; 

-- [1-5. prod_name 분류 수]
SELECT DISTINCT prod_name
FROM articles; -- (1)이 있는 것과 없는 것의 차이점: graphical_appearance와 colour가 다름

-- [1-6. graphical_appearance_name 분류 수]
SELECT DISTINCT graphical_appearance_name
FROM articles;

-- [1-7. 가장 많은 컬러]
SELECT DISTINCT(perceived_colour_master_name), COUNT(perceived_colour_master_name)
, ROUND((COUNT(perceived_colour_master_name)/(SELECT COUNT(perceived_colour_master_name) 
														FROM articles)*100),3) As '%'
FROM articles
GROUP BY perceived_colour_master_name
ORDER BY COUNT(perceived_colour_master_name) DESC;
-- undefined 값은 진짜 정의되지 않은 컬러: 이미지를 찾아보니 처음 undefined된 제품은 하얀색 스니커즈로 색상 구별이 어렵지 않았음
-- 685개로 하나하나 색상 찾아 적용하기 어려울 듯. 0.65%차지하므로 무시할 수 있지 않을까..
-- unknown은 colour그룹과 perceived_coulour로 유추할 수 있을 것 같음

/*2. 데이터 전처리*/
-- [2-1. 너무 세분화된 데이터는 좀더 포괄적인 그룹으로 합치기]
-- [2-1-1. 컬러코드 분류 줄이기 및 통일: 컬러 코드, 컬러 명도id, 컬러 코드(대분류)->하나로]
-- 1) 컬러코드 대분류 없애기
-- 2) 컬러 명도, 컬러 코드 네임에서 중복되는 단어 없애기
SELECT article_id, colour_group_name, perceived_colour_value_name
FROM articles
WHERE colour_group_name LIKE '%Light%'
	AND perceived_colour_value_name LIKE '%Light%'; -- Light Pink & Dusty Light => Dusty Light Pink로 바꾸기
    
SELECT article_id, colour_group_name, perceived_colour_value_name
FROM articles
WHERE colour_group_name LIKE '%Dark%'
	AND perceived_colour_value_name LIKE '%Dark%'; -- colour_value_name이 dark인 경우는 그냥 colour_group_name 써도 됨