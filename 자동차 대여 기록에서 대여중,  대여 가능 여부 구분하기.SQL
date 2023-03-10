SELECT CAR_ID,
MAX(CASE WHEN '2022-10-16' BETWEEN DATE_FORMAT(START_DATE, '%Y-%m-%d') AND DATE_FORMAT(END_DATE, '%Y-%m-%d')
THEN '대여중'
ELSE '대여 가능'
END) AS 'AVAILABILITY'
FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
GROUP BY CAR_ID
ORDER BY CAR_ID DESC

# ----------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT CAR_ID,
(CASE WHEN CAR_ID IN (
    SELECT CAR_ID
    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
    # '2022-10-16' 이 날짜가 정해준 날짜 사이에 있으면 '대여중'
    WHERE '2022-10-16' BETWEEN DATE_FORMAT(START_DATE, '%Y-%m-%d') AND DATE_FORMAT(END_DATE, '%Y-%m-%d'))
THEN '대여중'
ELSE '대여 가능'
END) AS 'AVAILABILITY'
# CASE WHEN 사용했으면 반드시 END로 마무리

FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY
GROUP BY CAR_ID
ORDER BY CAR_ID DESC
