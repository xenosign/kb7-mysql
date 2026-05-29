SELECT * FROM `account`;

-- 격리성 확인 2, 트랙잭션을 시작
START TRANSACTION;
-- 순자님이 다시 저에게 돈을 송금하려고 하는 상황
-- 1단계: 순자님의 계좌에서 인출
UPDATE `account` SET balance = balance - 100000 WHERE user_id = 'sj';
-- 2단계: 제 계좌로 입금
UPDATE `account` SET balance = balance + 100000 WHERE user_id = 'lhs';

-- 순자님의 송금 트랜잭션 커밋을 완료!
COMMIT;

SELECT * FROM `account`;

