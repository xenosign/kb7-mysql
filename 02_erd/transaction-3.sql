-- 잔고 상태를 확인
SELECT * FROM `account`;

-- 여러 쿼리를 묶어주는 트랜잭션을 시작!!
START TRANSACTION;

-- 제가 이건 아닌거 같아서, 다시 sj 에게 10만원을 보내기로 함
-- lhs 계좌에서 10만원을 인출
UPDATE `account` SET balance = balance - 100000 WHERE user_id = 'lhs';

-- 현재의 계좌 상태를 확인
SELECT * FROM `account`;


-- 하지만 이번엔 다시 문제가 생겼습니다!!

-- 트랜잭션 내부에서 수행한 모든 작업을 취소 처리!!
ROLLBACK;

-- 롤백한 계좌 상태를 확인
SELECT * FROM `account`;


