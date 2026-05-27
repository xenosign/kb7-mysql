SELECT * FROM `buytbl`;
SELECT * FROM `usertbl`;

SELECT *
FROM buytbl b
INNER JOIN usertbl u ON b.userID = u.userID;

SELECT *
FROM buytbl b
INNER JOIN usertbl u ON b.userID = u.userID
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

SELECT *
FROM usertbl
WHERE mobile1 IS NOT NULL;

SELECT *
FROM usertbl
WHERE mobile1 IS NULL;




