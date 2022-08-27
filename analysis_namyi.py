import pandas as pd
import numpy as np
import os

import matplotlib.pyplot as plt
import seaborn as sns
import chart_studio.plotly as py

os.chdir(r'C:\Users\monam\Desktop\dataitgirls 6\SQL\2차프로젝트')

ls

articles = pd.read_csv('articles.csv')
articles.head()

article_cnt = articles.groupby(by=['product_group_name', 'product_type_name']).count()
article_cnt

article_cnt.product_group_name.unique()

article_dict = article_cnt.to_dict()

article_cnt.loc['Accessories'].reset_index()

articles['prod_name'].nunique()

## articles 분석 계획

# 1. product_type_name	카테고리명(소분류)
    
#     product_group_name	카테고리명(대분류)


# 2. perceived_colour_master_name	상품의 컬러(대분류)


# 3. graphical_appearance_name	상품의 패턴명


# 4. department_name	상품 라인 이름


# 5. index_name	상품 타겟 그룹 명
    
#     index_group_name	타겟에 따른 상품 카테고리
    

# 6. section_name	상품 무드(콘셉트)


# 7. garment_group_name	상품군 명

## customer  분석 계획

customers = pd.read_csv('customers.csv')
customers.head()

#전체 행의 개수 및 각 컬럼의 개수 파악
customers.count()

#클럽멤버상태의 unique값 뽑아보기
customers.club_member_status.unique()

#패션뉴스를 구독 컬럼의 unique값 뽑아보기
customers.fashion_news_frequency.unique()

#NONE과 None인 값만 가지고와서 작업할 데이터 프레임 만들기 (실행 규모를 줄이기 위함)
n_none=customers[(customers['fashion_news_frequency'] == 'NONE') | (customers['fashion_news_frequency'] == 'None')]
n_none

#value_counts()를 통해 None과 NONE의 개수를 파악
n_none.fashion_news_frequency.value_counts()

#깜빡하고 첨에 확인 안했는데, 원래는 값이 적은 None 을 가지고와서 NONE으로 바꿔줘도 되는지 데이터 살펴봐야함
n_none[n_none['fashion_news_frequency'] == 'None']

customers['fashion_news_frequency'][customers['fashion_news_frequency'] == 'None'] = 'NONE'
#None이면 NONE 으로 변경해주라

#변수 이름 약간 잘못 지었는데, 암튼 fashion frequency에서 각각의 항목이 얼만큼의 비중을 차지하는지 확인하기 위해 데이터 프레임 생성
#첨에는 데이터프레임 잘 만들어지나 확인하려고 단계적으로 변수에 넣어서 지정
#다음 코드에서는 한 줄에 그냥 나타내도 됨
vc_customers = customers.fashion_news_frequency.value_counts()

#데이터프레임 만들기
vc_customers = pd.DataFrame(vc_customers)

vc_customers

#percentage 컬럼 생성, 컬럼 정의 (백분율입니다)
vc_customers['percentage'] = round((vc_customers['fashion_news_frequency']*100) / sum(vc_customers['fashion_news_frequency'])).astype('str') + '%'
#반올림처리 후 데이터타입을 str으로 바꿔주고, % 기호를 추가하여 더 깔끔하게 보이도록 함

vc_customers
#잡지 구독하는 고객들 비중

#고객 상태는 그냥 한 번에 데이터프레임으로 만들어줌 (만약에 이렇게 확인할 수 있는 컬럼이 더 있었다면 함수로 만들어줬을듯)
status = pd.DataFrame(customers.club_member_status.value_counts())
status

status['percentage'] = round((status['club_member_status']*100) / sum(status['club_member_status'])).astype('str') + '%'

status.set_index(keys='index')

#customer의 평균 나이
print('cusotmer의 평균 나이: ', round(customers.age.mean(),2), '세')