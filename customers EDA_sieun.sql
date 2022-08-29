USE 5commerce;

# 1) age를 연령대별로 나누기
SELECT
	CASE WHEN age <= 19 THEN '10s'
		WHEN age <= 29 THEN '20s'
        WHEN age <= 39 THEN '30s'
        WHEN age <= 49 THEN '40s'
        WHEN age <= 59 THEN '50s'
        WHEN age <= 69 THEN '60s'
        WHEN age <= 79 THEN '70s'
        WHEN age <= 89 THEN '80s'
        WHEN age <= 99 THEN '90s'
        ELSE 'none'
	END AS age_group,
    COUNT(*) AS count, COU
FROM customers
GROUP BY age_group
ORDER BY 1;