CREATE DATABASE `transaction`;
USE `transaction`;

CREATE TABLE `account` (
    user_id VARCHAR(10) PRIMARY KEY,
    name    VARCHAR(20),
    balance INT
);

INSERT INTO account VALUES ('lhs', '이효석', 500000);
INSERT INTO account VALUES ('sj', '순자', 1000000);

SELECT * FROM account;

-- 송금 시작
-- lhs 계좌에서 10만원을 인출
UPDATE `account` SET balance = balance - 100000 WHERE user_id = 'lhs';

-- sj 계좌로 10만원을 입금
UPDATE `account` SET balance = balance + 100000 WHERE user_id = 'sj';

-- 송금 결과 확인
SELECT * FROM account;


-- 순자님이 돈을 돌려주기 시작
-- sj 계좌에서 10만원을 인출
UPDATE `account` SET balance = balance - 100000 WHERE user_id = 'sj';

-- 그런데 갑자기 정전으로 은행 시스템이 고장!!!! 그래서 아래의 쿼리는 실행이 안되었습니다!

-- 잘 못 수행된 쿼리를 바로 잡는 쿼리를 수행
UPDATE `account` SET balance = balance + 100000 WHERE user_id = 'sj';

-- 잔고가 맞는지 확인
SELECT * FROM account;















