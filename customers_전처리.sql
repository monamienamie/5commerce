/*Customers*/
-- 1) FN, Active: NaN값 -> 0으로 변경
UPDATE customers SET FN = 0 WHERE FN is null;
UPDATE customers SET ACTIVE = 0 WHERE ACTIVE is null;

-- 2) FN, Active, Age: float 데이터타입 -> int로 변경
SELECT * FROM customers;
ALTER TABLE customers MODIFY FN int;
ALTER TABLE customers MODIFY ACTIVE int;
ALTER TABLE customers MODIFY age int;
-- 확인해보니 age는 float에서 바뀌지 않음 -> 안바꿔도 될듯

-- 3) fashion_news_frequency 'None' -> 'NONE'으로 통일
UPDATE customers SET fashion_news_frequency = UPPER(fashion_news_frequency) WHERE REGEXP LIKE(fashion_news_frequency, '[a-z]');
SELECT *
FROM customers
WHERE customer_id = "a79d9cbfaceb0d25a91caccfad167d4d6391fd5bb4292b95324ac982f9537509";
-- 안 바뀜 -> None인 값을 가진 행이 2개 뿐이라 그냥 엑셀로 수정함
SELECT fashion_news_frequency
FROM customers
GROUP BY fashion_news_frequency;

SELECT length(postal_code)
FROM customers;