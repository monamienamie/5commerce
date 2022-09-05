# 판다스에서 1차적으로 전처리 작업한 후, SQL로 2차 전처리 작업 진행
# <판다스에서 전처리 잘 되었는지 체크>
SELECT *
FROM articles
;

SELECT *
FROM articles
WHERE perceived_colour_master_name = 'Unknown'; -- 뭐지... 제대로 삭제가 안됨

# <1. Unknown, undefined 추가 삭제>
DELETE
FROM articles
WHERE perceived_colour_master_name = 'Unknown';

# <2. product_group 에서 패션과 관련 없는 컬럼 제외하기>
SELECT product_group_name
FROM articles
GROUP BY product_group_name;

DELETE
FROM articles
WHERE product_group_name NOT IN ('Accessories', 'Bags', 'Garment Upper body', 'Garment Lower body',
						'Garment Full body', 'Shoes', 'Socks&Tights', 'Underwear', 'Nightwear', 'Underwear/nightwear');
                        
# <3. product_type 정리>

-- A) Accessories Product_group 전처리
-- 1) Hair Accessories로 통합
#product_type_name을 'Hair Accessories'로 변경
UPDATE articles
SET product_type_name = 'Hair Accessories', product_type_no = 72
WHERE product_type_name IN ('Alice band', 'Hair clip', 'Hair string', 'Hair ties',
							'Hair/alice band', 'Hairband', 'Headband');
                            
-- 2) Hat로 통합
UPDATE articles
SET product_type_name = 'Hats', product_type_no = 69
WHERE product_type_name IN ('Beanie', 'Bucket hat', 'Cap', 'Cap/peaked', 'Felt hat',
							'Hat/beanie', 'Hat/brim', 'Straw hat');

-- 3) Jewerly로 통합
UPDATE articles
SET product_type_name = 'Jewerly', product_type_no = 68
WHERE product_type_name IN ('Bracelet', 'Earring', 'Earrings', 'Necklace', 'Ring');

-- 4) Accessories set, Baby Bib, Braces, Dog Wear, Giftbox, Soft Toys, Umbrella, Waterbottle, Eyeglasses 삭제
DELETE
FROM articles
WHERE product_type_name IN ('Accessories set', 'Baby Bib', 'Braces', 'Dog Wear', 'Giftbox', 'Soft Toys', 'Umbrella', 'Waterbottle', 'Eyeglasses');

-- B) Bags Product_group 전처리
-- 1) Bags로 분류되어 있던 컬럼들의 product_group_name, product_type_no, product_type_name 변경 (Accessories 하위 Bag으로 통합)
UPDATE articles
SET product_group_name = 'Accessories', product_type_no = 66, product_type_name = 'Bag'
WHERE product_group_name = 'Bags';
-- 잘 변경되었는지 확인
SELECT *
FROM articles
WHERE product_group_name = 'Bags'; -- 해당되는 row가 없어짐(출력되지 않음)

-- C) Shoes Product_group 전처리
-- 1) Bootie, Boots, Pre-walkers 통합
UPDATE articles
SET product_type_name = 'Boots', product_type_no = 87
WHERE product_type_name IN ('Bootie', 'Pre-walkers');

-- 2) Flat shoe, Flat shoes 통합
UPDATE articles
SET product_type_name = 'Flat shoes', product_type_no = 144
WHERE product_type_name IN ('Flat shoes', 'Flat shoe');

-- 체크
SELECT product_type_no, product_type_name
FROM articles
WHERE product_group_name = 'Accessories'
GROUP BY 1,2;

# <4. perceived_colour_master 컬럼명 변경>
ALTER TABLE articles RENAME COLUMN perceived_colour_master_id TO color_id;
ALTER TABLE articles RENAME COLUMN perceived_colour_master_name TO color_name;

