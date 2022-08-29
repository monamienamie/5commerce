# customers 데이터 EDA

# 1. 연령대(age) 분포
select (case
			when customers.age>=0 && customers.age<=19 then '10대'
            when customers.age>=20 && customers.age<=29 then '20대'
	        when customers.age>=30 && customers.age<=39 then '30대'
			when customers.age>=40 && customers.age<=49 then '40대'
            when customers.age>=50 && customers.age<=59 then '50대'
            when customers.age>=60 && customers.age<=69 then '60대'
            when customers.age>=70 && customers.age<=100 then '70대 이상'
            
            else '연령 미확인'
            end
			) As generation, round((count(customer_id)/(select count(customer_id) 
														from 5commerce.customers)*100),1) As '백분율'
from 5commerce.customers
group by generation
order by generation;

# 1-1 연령대별 집계를 위한 임시테이블 만들기; age 칼럼 간소화 임시 테이블
with TEMP_AGE_CUS as(
						select *, (case
									when customers.age>=0 && customers.age<=19 then '10s'
									when customers.age>=20 && customers.age<=29 then '20s'
									when customers.age>=30 && customers.age<=39 then '30s'
									when customers.age>=40 && customers.age<=49 then '40s'
									when customers.age>=50 && customers.age<=59 then '50s'
									when customers.age>=60 && customers.age<=69 then '60s'
									when customers.age>=70 && customers.age<=100 then '70s_over'
									else 'NUll'
									end) As 'generation'
						from 5commerce.customers 
						order by customers.customer_id
					)
select *
from TEMP_AGE_CUS
where generation='10s';

# 2. 뉴스레터 관련 데이터(fashion_news_frequency) 

#2-1 뉴스레터 value 조회
select distinct c.fashion_news_frequency
from 5commerce.customers c;

#2-2 뉴스레터 value별 행 개수 구하기 ; 'Monthly' 값을 가진 데이터가 매우 적음, 'Regularly' 위주로 분석 필요
select c.fashion_news_frequency, count(customer_id)
from 5commerce.customers c
group by c.fashion_news_frequency;

# 2-2-1 'Regulary' 값을 가지고 있는 데이터만 불러오는 임시 테이블 구축

with nl_regular as(
					select * 
                    from 5commerce.customers c
                    where c.fashion_news_frequency ='Regularly'
                    )
select n.customer_id, n.age, n.postal_code
from nl_regular n;


# 3. 회원 상태 조회
select distinct c.club_member_status, 
round((count(c.club_member_status)/(select count(*) from 5commerce.customers)*100),1) As '상태별 인원수 비율'
from 5commerce.customers c
group by c.club_member_status;



# 패션 뉴스 구독한 customer의 데이터만 조회하는 임시 테이블
with TEMP_FN_CUS as(
					select *
					from 5commerce.customers
					where customers.FN= '1'
					
					)
select *
from TEMP_FN_CUS
where TEMP_FN_CUS.age='20';




