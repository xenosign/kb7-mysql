-- 잔고 상태를 확인
SELECT * FROM `account`;

-- 여러 쿼리를 묶어주는 트랜잭션을 시작!!
START TRANSACTION;

-- 순자님이 돈을 돌려주기 시작, sj 계좌에서 10만원을 인출
UPDATE `account` SET balance = balance - 100000 WHERE user_id = 'sj';

-- 현재의 계좌 상태를 확인
SELECT * FROM `account`;


-- 이번에는 시스템에 문제가 없었습니다!!

-- lhs 계좌로 10만원을 입금
UPDATE `account` SET balance = balance + 100000 WHERE user_id = 'lhs';

-- 트랜잭션 내부에서 수행한 모든 작업을 수행!!
COMMIT;

-- 최종 계좌 상태를 확인
SELECT * FROM `account`;