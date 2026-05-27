SELECT *
FROM buytbl b
INNER JOIN usertbl u
ON b.userID = u.userID;

SELECT *
FROM buytbl b
INNER JOIN usertbl u
ON b.userID = u.userID
WHERE b.userID = 'JYP';

SELECT
    u.userID,
    u.name,
    b.prodName,
    u.addr,
    CONCAT(u.mobile1, u.mobile2) as 연락처
FROM usertbl u
LEFT OUTER JOIN buytbl b
ON u.userID = b.userID
ORDER BY u.userID;

SELECT
    name,
    CONCAT(mobile1, mobile2) AS '전화번호' 
FROM usertbl
WHERE name NOT IN (
    SELECT name
    FROM usertbl
    WHERE mobile1 IS NULL
);

SELECT
    name,
    CONCAT(mobile1, mobile2) AS '전화번호' 
FROM usertbl
WHERE name IN (
    SELECT name
    FROM usertbl
    WHERE mobile1 IS NULL
);