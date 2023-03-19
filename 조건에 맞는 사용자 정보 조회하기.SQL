SELECT DISTINCT b.USER_ID, b.NICKNAME, 
CONCAT(CITY, " ", STREET_ADDRESS1, " ", STREET_ADDRESS2) AS 전체주소, 
CONCAT(LEFT(TLNO, 3), "-", MID(TLNO,4,4), "-", RIGHT(TLNO,4)) AS 전화번호
FROM USED_GOODS_BOARD a
JOIN USED_GOODS_USER b
ON a.WRITER_ID = b.USER_ID
WHERE b.USER_ID IN (
    SELECT WRITER_ID
    FROM USED_GOODS_BOARD
    GROUP BY WRITER_ID
    HAVING COUNT(*) >= 3
)
ORDER BY b.USER_ID DESC


# LEFT
# 문자열을 받아서 왼쪽부터 원하는 길이만큼 자르는 함수.
# LEFT(문자열, 가져올 길이)

# MID
# 문자열을 받아서 시작위치부터 가져올 갯수를 가져오는 함수
# LEFT(문자, 시작 위치, 가져올 갯수)
# SELECT MID('abcdefg', 2, 4);  =>  bcde

# RIGHT
# 문자열을 받아서 왼쪽부터 원하는 길이만큼 자르는 함수.
# RIGHT(문자열, 가져올 길이)

# SUBSTRING
# 문자열을 받아서 일정한 영역만큼 잘라낸 후 리턴하는 기능.
# SUBSTRING(문자열, 시작자리번호, 자를 문자수)
