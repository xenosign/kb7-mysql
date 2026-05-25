-- =============================================
-- 결제/정산 시스템 테스트 데이터
-- =============================================

USE payment_db;

-- 기존 데이터 초기화 (FK 순서 역순)
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE settlement_items;
TRUNCATE TABLE settlements;
TRUNCATE TABLE refunds;
TRUNCATE TABLE payment_history;
TRUNCATE TABLE payments;
TRUNCATE TABLE orders;
TRUNCATE TABLE payment_methods;
TRUNCATE TABLE users;
SET FOREIGN_KEY_CHECKS = 1;

-- ---------------------------------------------
-- 1. 사용자
-- ---------------------------------------------
INSERT INTO users (id, email, name, created_at) VALUES
(1,  'alice@example.com',   '김앨리스', '2025-01-05 09:00:00'),
(2,  'bob@example.com',     '이밥',     '2025-01-10 10:30:00'),
(3,  'carol@example.com',   '박캐롤',   '2025-02-01 11:00:00'),
(4,  'dave@example.com',    '최데이브', '2025-02-15 14:00:00'),
(5,  'seller1@example.com', '판매자A',  '2025-01-01 08:00:00'),
(6,  'seller2@example.com', '판매자B',  '2025-01-02 08:00:00');

-- ---------------------------------------------
-- 2. 결제수단
-- ---------------------------------------------
INSERT INTO payment_methods (id, user_id, type, provider, masked_number, is_default, created_at) VALUES
-- 김앨리스: 카드(기본), 포인트
(1,  1, 'CARD',    'TOSS',   '1234-****-****-5678', 1, '2025-01-05 09:05:00'),
(2,  1, 'POINT',   'KAKAO',  NULL,                  0, '2025-01-05 09:10:00'),
-- 이밥: 계좌(기본), 카드
(3,  2, 'ACCOUNT', 'INICIS', '110-****-******',     1, '2025-01-10 10:35:00'),
(4,  2, 'CARD',    'KAKAO',  '9876-****-****-4321', 0, '2025-01-10 10:40:00'),
-- 박캐롤: 카드(기본)
(5,  3, 'CARD',    'INICIS', '5555-****-****-1111', 1, '2025-02-01 11:05:00'),
-- 최데이브: 카드(기본)
(6,  4, 'CARD',    'TOSS',   '4444-****-****-9999', 1, '2025-02-15 14:05:00');

-- ---------------------------------------------
-- 3. 주문
-- ---------------------------------------------
INSERT INTO orders (id, user_id, amount, status, ordered_at) VALUES
-- 김앨리스 주문
(1,  1, 50000,  'PAID',      '2025-03-01 10:00:00'),  -- 정상 결제
(2,  1, 120000, 'PAID',      '2025-03-10 15:00:00'),  -- 정상 결제 후 환불
(3,  1, 30000,  'CANCELLED', '2025-03-20 09:00:00'),  -- 취소
-- 이밥 주문
(4,  2, 75000,  'PAID',      '2025-03-05 11:00:00'),  -- 정상 결제
(5,  2, 200000, 'PAID',      '2025-03-12 16:30:00'),  -- 부분 환불
(6,  2, 45000,  'PENDING',   '2025-04-01 09:00:00'),  -- 결제 대기
-- 박캐롤 주문
(7,  3, 88000,  'PAID',      '2025-03-08 13:00:00'),  -- 정상 결제
(8,  3, 15000,  'REFUNDED',  '2025-03-25 10:00:00'),  -- 전액 환불
-- 최데이브 주문
(9,  4, 330000, 'PAID',      '2025-04-05 18:00:00'),  -- 정상 결제
(10, 4, 60000,  'PAID',      '2025-04-10 20:00:00');  -- 정상 결제

-- ---------------------------------------------
-- 4. 결제
-- ---------------------------------------------
INSERT INTO payments (id, order_id, payment_method_id, amount, status, pg_transaction_id, paid_at) VALUES
(1,  1,  1, 50000,  'APPROVED',  'PG-TOSS-20250301-000001', '2025-03-01 10:01:30'),
(2,  2,  1, 120000, 'APPROVED',  'PG-TOSS-20250310-000002', '2025-03-10 15:01:45'),
(3,  3,  2, 30000,  'CANCELLED', NULL,                      NULL),
(4,  4,  3, 75000,  'APPROVED',  'PG-INICIS-20250305-0001', '2025-03-05 11:02:00'),
(5,  5,  3, 200000, 'APPROVED',  'PG-INICIS-20250312-0002', '2025-03-12 16:31:10'),
(6,  6,  4, 45000,  'REQUESTED', NULL,                      NULL),
(7,  7,  5, 88000,  'APPROVED',  'PG-INICIS-20250308-0003', '2025-03-08 13:01:20'),
(8,  8,  5, 15000,  'APPROVED',  'PG-INICIS-20250325-0004', '2025-03-25 10:01:00'),
(9,  9,  6, 330000, 'APPROVED',  'PG-TOSS-20250405-000003', '2025-04-05 18:00:55'),
(10, 10, 6, 60000,  'APPROVED',  'PG-TOSS-20250410-000004', '2025-04-10 20:01:05');

-- ---------------------------------------------
-- 5. 결제 상태 이력
-- ---------------------------------------------
INSERT INTO payment_history (payment_id, from_status, to_status, reason, changed_at) VALUES
-- 결제 1: REQUESTED → APPROVED
(1, NULL,        'REQUESTED', NULL,           '2025-03-01 10:01:00'),
(1, 'REQUESTED', 'APPROVED',  '정상 승인',    '2025-03-01 10:01:30'),
-- 결제 2: REQUESTED → APPROVED
(2, NULL,        'REQUESTED', NULL,           '2025-03-10 15:01:00'),
(2, 'REQUESTED', 'APPROVED',  '정상 승인',    '2025-03-10 15:01:45'),
-- 결제 3: REQUESTED → CANCELLED
(3, NULL,        'REQUESTED', NULL,           '2025-03-20 09:00:00'),
(3, 'REQUESTED', 'CANCELLED', '사용자 취소',  '2025-03-20 09:00:30'),
-- 결제 4: REQUESTED → APPROVED
(4, NULL,        'REQUESTED', NULL,           '2025-03-05 11:01:30'),
(4, 'REQUESTED', 'APPROVED',  '정상 승인',    '2025-03-05 11:02:00'),
-- 결제 5: REQUESTED → APPROVED
(5, NULL,        'REQUESTED', NULL,           '2025-03-12 16:30:50'),
(5, 'REQUESTED', 'APPROVED',  '정상 승인',    '2025-03-12 16:31:10'),
-- 결제 6: REQUESTED (미처리)
(6, NULL,        'REQUESTED', NULL,           '2025-04-01 09:00:00'),
-- 결제 7: REQUESTED → APPROVED
(7, NULL,        'REQUESTED', NULL,           '2025-03-08 13:00:50'),
(7, 'REQUESTED', 'APPROVED',  '정상 승인',    '2025-03-08 13:01:20'),
-- 결제 8: REQUESTED → APPROVED
(8, NULL,        'REQUESTED', NULL,           '2025-03-25 10:00:40'),
(8, 'REQUESTED', 'APPROVED',  '정상 승인',    '2025-03-25 10:01:00'),
-- 결제 9: REQUESTED → APPROVED
(9, NULL,        'REQUESTED', NULL,           '2025-04-05 18:00:30'),
(9, 'REQUESTED', 'APPROVED',  '정상 승인',    '2025-04-05 18:00:55'),
-- 결제 10: REQUESTED → APPROVED
(10, NULL,       'REQUESTED', NULL,           '2025-04-10 20:00:40'),
(10, 'REQUESTED','APPROVED',  '정상 승인',    '2025-04-10 20:01:05');

-- ---------------------------------------------
-- 6. 환불
-- ---------------------------------------------
INSERT INTO refunds (id, payment_id, amount, status, reason, refunded_at) VALUES
-- 결제 2 전액 환불 (COMPLETED)
(1, 2,  120000, 'COMPLETED', '단순 변심',          '2025-03-15 10:00:00'),
-- 결제 5 부분 환불 (COMPLETED)
(2, 5,   80000, 'COMPLETED', '상품 일부 불량',      '2025-03-18 14:00:00'),
-- 결제 8 전액 환불 (COMPLETED)
(3, 8,   15000, 'COMPLETED', '상품 미도착',         '2025-03-28 11:00:00'),
-- 결제 9 환불 요청 중 (REQUESTED)
(4, 9,   50000, 'REQUESTED', '사이즈 불일치',       NULL),
-- 결제 7 환불 거절 (REJECTED)
(5, 7,   88000, 'REJECTED',  '환불 기간 초과',      NULL);

-- ---------------------------------------------
-- 7. 정산 (헤더)
-- 판매자A(id=5): 3월 정산, 판매자B(id=6): 3월 정산
-- ---------------------------------------------
INSERT INTO settlements (id, seller_id, settlement_date, total_amount, fee_amount, net_amount, status) VALUES
(1, 5, '2025-03-31', 213000, 6390, 206610, 'COMPLETED'),  -- 결제 1(50000) + 결제 4(75000) + 결제 7(88000)
(2, 6, '2025-03-31',  15000,  450,  14550, 'COMPLETED'),  -- 결제 8(15000)
(3, 5, '2025-04-30', 390000, 11700, 378300, 'PENDING');   -- 결제 9(330000) + 결제 10(60000)

-- ---------------------------------------------
-- 8. 정산 항목 (라인)
-- ---------------------------------------------
INSERT INTO settlement_items (id, settlement_id, payment_id, amount, fee_amount) VALUES
-- 정산 1 항목
(1, 1, 1,  50000, 1500),  -- 수수료 3%
(2, 1, 4,  75000, 2250),
(3, 1, 7,  88000, 2640),
-- 정산 2 항목
(4, 2, 8,  15000,  450),
-- 정산 3 항목 (PENDING)
(5, 3, 9,  330000, 9900),
(6, 3, 10,  60000, 1800);

-- =============================================
-- 데이터 검증 쿼리
-- =============================================

-- 테이블별 건수 확인
SELECT 'users'            AS tbl, COUNT(*) AS cnt FROM users
UNION ALL
SELECT 'payment_methods',          COUNT(*) FROM payment_methods
UNION ALL
SELECT 'orders',                   COUNT(*) FROM orders
UNION ALL
SELECT 'payments',                 COUNT(*) FROM payments
UNION ALL
SELECT 'payment_history',          COUNT(*) FROM payment_history
UNION ALL
SELECT 'refunds',                  COUNT(*) FROM refunds
UNION ALL
SELECT 'settlements',              COUNT(*) FROM settlements
UNION ALL
SELECT 'settlement_items',         COUNT(*) FROM settlement_items;
