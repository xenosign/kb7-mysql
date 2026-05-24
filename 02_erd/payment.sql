-- =============================================
-- 결제/정산 시스템 DDL
-- =============================================

CREATE DATABASE IF NOT EXISTS payment_db
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_unicode_ci;

USE payment_db;

-- ---------------------------------------------
-- 1. 사용자
-- ---------------------------------------------
CREATE TABLE users (
    id          BIGINT          NOT NULL AUTO_INCREMENT,
    email       VARCHAR(255)    NOT NULL,
    name        VARCHAR(100)    NOT NULL,
    created_at  DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    UNIQUE KEY uq_users_email (email)
);

-- ---------------------------------------------
-- 2. 결제수단
-- ---------------------------------------------
CREATE TABLE payment_methods (
    id              BIGINT          NOT NULL AUTO_INCREMENT,
    user_id         BIGINT          NOT NULL,
    type            ENUM('CARD', 'ACCOUNT', 'POINT') NOT NULL,
    provider        VARCHAR(50)     NOT NULL COMMENT 'ex) TOSS, INICIS, KAKAO',
    masked_number   VARCHAR(30)     NULL     COMMENT 'ex) 1234-****-****-5678',
    is_default      TINYINT(1)      NOT NULL DEFAULT 0,
    created_at      DATETIME        NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    CONSTRAINT fk_pm_user FOREIGN KEY (user_id) REFERENCES users (id)
);

-- ---------------------------------------------
-- 3. 주문
-- ---------------------------------------------
CREATE TABLE orders (
    id          BIGINT      NOT NULL AUTO_INCREMENT,
    user_id     BIGINT      NOT NULL,
    amount      BIGINT      NOT NULL COMMENT '단위: 원',
    status      ENUM('PENDING', 'PAID', 'CANCELLED', 'REFUNDED') NOT NULL DEFAULT 'PENDING',
    ordered_at  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    CONSTRAINT fk_orders_user FOREIGN KEY (user_id) REFERENCES users (id),

    INDEX idx_orders_user_id (user_id),
    INDEX idx_orders_status  (status)
);

-- ---------------------------------------------
-- 4. 결제
-- ---------------------------------------------
CREATE TABLE payments (
    id                  BIGINT          NOT NULL AUTO_INCREMENT,
    order_id            BIGINT          NOT NULL,
    payment_method_id   BIGINT          NOT NULL,
    amount              BIGINT          NOT NULL COMMENT '단위: 원',
    status              ENUM('REQUESTED', 'APPROVED', 'FAILED', 'CANCELLED') NOT NULL DEFAULT 'REQUESTED',
    pg_transaction_id   VARCHAR(100)    NULL     COMMENT 'PG사 발급 트랜잭션 ID',
    paid_at             DATETIME        NULL,

    PRIMARY KEY (id),
    CONSTRAINT fk_payments_order  FOREIGN KEY (order_id)          REFERENCES orders          (id),
    CONSTRAINT fk_payments_method FOREIGN KEY (payment_method_id) REFERENCES payment_methods (id),

    UNIQUE KEY uq_payments_order     (order_id),
    UNIQUE KEY uq_payments_pg_tx     (pg_transaction_id),
    INDEX      idx_payments_status   (status),
    INDEX      idx_payments_paid_at  (paid_at)
);

-- ---------------------------------------------
-- 5. 결제 상태 이력
-- ---------------------------------------------
CREATE TABLE payment_history (
    id          BIGINT      NOT NULL AUTO_INCREMENT,
    payment_id  BIGINT      NOT NULL,
    from_status ENUM('REQUESTED', 'APPROVED', 'FAILED', 'CANCELLED') NULL COMMENT '최초 생성 시 NULL',
    to_status   ENUM('REQUESTED', 'APPROVED', 'FAILED', 'CANCELLED') NOT NULL,
    reason      VARCHAR(255) NULL,
    changed_at  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,

    PRIMARY KEY (id),
    CONSTRAINT fk_ph_payment FOREIGN KEY (payment_id) REFERENCES payments (id),

    INDEX idx_ph_payment_id (payment_id)
);

-- ---------------------------------------------
-- 6. 환불
-- ---------------------------------------------
CREATE TABLE refunds (
    id          BIGINT      NOT NULL AUTO_INCREMENT,
    payment_id  BIGINT      NOT NULL,
    amount      BIGINT      NOT NULL COMMENT '부분환불 지원 — 원래 결제금액 이하',
    status      ENUM('REQUESTED', 'COMPLETED', 'REJECTED') NOT NULL DEFAULT 'REQUESTED',
    reason      VARCHAR(255) NULL,
    refunded_at DATETIME     NULL,

    PRIMARY KEY (id),
    CONSTRAINT fk_refunds_payment FOREIGN KEY (payment_id) REFERENCES payments (id),

    INDEX idx_refunds_payment_id (payment_id),
    INDEX idx_refunds_status     (status)
);

-- ---------------------------------------------
-- 7. 정산 (헤더)
-- ---------------------------------------------
CREATE TABLE settlements (
    id               BIGINT  NOT NULL AUTO_INCREMENT,
    seller_id        BIGINT  NOT NULL COMMENT 'users.id 참조 (판매자)',
    settlement_date  DATE    NOT NULL COMMENT '정산 기준일',
    total_amount     BIGINT  NOT NULL COMMENT '정산 대상 총액',
    fee_amount       BIGINT  NOT NULL DEFAULT 0 COMMENT '수수료',
    net_amount       BIGINT  NOT NULL COMMENT 'total_amount - fee_amount',
    status           ENUM('PENDING', 'COMPLETED') NOT NULL DEFAULT 'PENDING',

    PRIMARY KEY (id),
    CONSTRAINT fk_settlements_seller FOREIGN KEY (seller_id) REFERENCES users (id),

    UNIQUE KEY uq_settlement_seller_date (seller_id, settlement_date),
    INDEX      idx_settlements_status    (status)
);

-- ---------------------------------------------
-- 8. 정산 항목 (라인)
-- ---------------------------------------------
CREATE TABLE settlement_items (
    id              BIGINT  NOT NULL AUTO_INCREMENT,
    settlement_id   BIGINT  NOT NULL,
    payment_id      BIGINT  NOT NULL,
    amount          BIGINT  NOT NULL,
    fee_amount      BIGINT  NOT NULL DEFAULT 0,

    PRIMARY KEY (id),
    CONSTRAINT fk_si_settlement FOREIGN KEY (settlement_id) REFERENCES settlements (id),
    CONSTRAINT fk_si_payment    FOREIGN KEY (payment_id)    REFERENCES payments    (id),

    UNIQUE KEY uq_si_settlement_payment (settlement_id, payment_id)
);