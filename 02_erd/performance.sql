SELECT * FROM `product`;

SELECT * FROM `member`;

ALTER TABLE `member`
ADD INDEX idx_member_name (name);

ALTER TABLE `member`
DROP INDEX idx_member_name;

EXPLAIN ANALYZE
SELECT *
FROM `member`
WHERE name = '홍길동';




EXPLAIN
SELECT *
FROM `member`
WHERE id = 25;

EXPLAIN
SELECT *
FROM `member`
WHERE email = 'gildong.hong@example.com';

CREATE TABLE member_no_index (
    id         BIGINT       NOT NULL AUTO_INCREMENT,
    name       VARCHAR(50)  NOT NULL,
    email      VARCHAR(100) NOT NULL,
    created_at DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);

-- 과도한 인덱스 테이블
CREATE TABLE member_over_index (
    id         BIGINT       NOT NULL AUTO_INCREMENT,
    name       VARCHAR(50)  NOT NULL,
    email      VARCHAR(100) NOT NULL,
    created_at DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    INDEX idx_name          (name),
    INDEX idx_email         (email),
    INDEX idx_created_at    (created_at),
    INDEX idx_name_email    (name, email),
    INDEX idx_email_name    (email, name)
);

DROP TABLE IF EXISTS insert_benchmark;

CREATE TABLE insert_benchmark (
    id         BIGINT      NOT NULL AUTO_INCREMENT,
    table_name VARCHAR(50) NOT NULL,
    elapsed_us BIGINT      NOT NULL,
    tested_at  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);

CALL benchmark_insert();

-- 테이블별 평균/최소/최대 비교
SELECT
    table_name,
    COUNT(*)          AS 총건수,
    AVG(elapsed_us)   AS 평균_마이크로초,
    MIN(elapsed_us)   AS 최소_마이크로초,
    MAX(elapsed_us)   AS 최대_마이크로초
FROM insert_benchmark
GROUP BY table_name;