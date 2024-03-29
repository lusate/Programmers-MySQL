SELECT HISTORY_ID, 
    round(DAILY_FEE * (DATEDIFF(B.END_DATE,B.START_DATE)+1)
    * (CASE 
    WHEN DATEDIFF(END_DATE,START_DATE)+1 < 7 THEN 1
    WHEN DATEDIFF(END_DATE,START_DATE)+1 < 30 THEN 0.95
    WHEN DATEDIFF(END_DATE,START_DATE)+1 < 90 THEN 0.92
    ELSE 0.85 END)) AS FEE
    -- 트럭이 조건이므로 트럭일 때 할인율만 알아내면 된다.
    -- 7일 이상일 때 5%, 
     
FROM CAR_RENTAL_COMPANY_CAR AS A
JOIN CAR_RENTAL_COMPANY_RENTAL_HISTORY AS B
ON A.CAR_ID = B.CAR_ID
JOIN CAR_RENTAL_COMPANY_DISCOUNT_PLAN AS C
ON A.CAR_TYPE = C.CAR_TYPE

WHERE A.CAR_TYPE = '트럭'
GROUP BY HISTORY_ID
ORDER BY FEE DESC, HISTORY_ID DESC


-- ////////////////////////////////////////////////////////////////////////////////////////


-- WITH ~ AS () : 새로운 가상 테이블을 만듦.
WITH RENT_INFO AS (
    SELECT HISTORY_ID, DATEDIFF(END_DATE, START_DATE) + 1 AS RENT_DAYS, DAILY_FEE, CAR_TYPE,
       CASE
           WHEN DATEDIFF(END_DATE, START_DATE) + 1 >= 90 THEN '90일 이상'
           WHEN DATEDIFF(END_DATE, START_DATE) + 1 >= 30 THEN '30일 이상'
           WHEN DATEDIFF(END_DATE, START_DATE) + 1 >= 7 THEN '7일 이상'
       ELSE '' END AS DURATION_TYPE
    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY H JOIN CAR_RENTAL_COMPANY_CAR C ON H.CAR_ID = C.CAR_ID
    WHERE CAR_TYPE = '트럭'
)

SELECT RENT_INFO.HISTORY_ID, 
       ROUND(RENT_INFO.DAILY_FEE * RENT_INFO.RENT_DAYS * (100 - IFNULL(PLAN.DISCOUNT_RATE, 0)) / 100) AS FEE
FROM RENT_INFO RIGHT JOIN CAR_RENTAL_COMPANY_DISCOUNT_PLAN AS PLAN
    ON PLAN.DURATION_TYPE = RENT_INFO.DURATION_TYPE AND PLAN.CAR_TYPE = RENT_INFO.CAR_TYPE
ORDER BY FEE DESC, HISTORY_ID DESC;
