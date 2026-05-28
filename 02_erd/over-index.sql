-- 기존 테이블 전체 초기화
DROP TABLE IF EXISTS insert_benchmark;
DROP TABLE IF EXISTS member_no_index;
DROP TABLE IF EXISTS member_over_index;


-- 인덱스 없는 테이블 (컬럼 많음)
CREATE TABLE member_no_index (
    id          BIGINT       NOT NULL AUTO_INCREMENT,
    name        VARCHAR(50)  NOT NULL,
    email       VARCHAR(100) NOT NULL,
    phone       VARCHAR(20)  NOT NULL,
    address     VARCHAR(200) NOT NULL,
    birth_date  DATE         NOT NULL,
    gender      VARCHAR(10)  NOT NULL,
    job         VARCHAR(50)  NOT NULL,
    company     VARCHAR(100) NOT NULL,
    salary      INT          NOT NULL,
    grade       VARCHAR(20)  NOT NULL,
    point       INT          NOT NULL DEFAULT 0,
    created_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);


-- 과도한 인덱스 테이블 (동일한 컬럼 + 인덱스 잔뜩)
CREATE TABLE member_over_index (
    id          BIGINT       NOT NULL AUTO_INCREMENT,
    name        VARCHAR(50)  NOT NULL,
    email       VARCHAR(100) NOT NULL,
    phone       VARCHAR(20)  NOT NULL,
    address     VARCHAR(200) NOT NULL,
    birth_date  DATE         NOT NULL,
    gender      VARCHAR(10)  NOT NULL,
    job         VARCHAR(50)  NOT NULL,
    company     VARCHAR(100) NOT NULL,
    salary      INT          NOT NULL,
    grade       VARCHAR(20)  NOT NULL,
    point       INT          NOT NULL DEFAULT 0,
    created_at  DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    INDEX idx_name                  (name),
    INDEX idx_email                 (email),
    INDEX idx_phone                 (phone),
    INDEX idx_birth_date            (birth_date),
    INDEX idx_gender                (gender),
    INDEX idx_job                   (job),
    INDEX idx_company               (company),
    INDEX idx_salary                (salary),
    INDEX idx_grade                 (grade),
    INDEX idx_point                 (point),
    INDEX idx_created_at            (created_at),
    INDEX idx_name_email            (name, email),
    INDEX idx_name_phone            (name, phone),
    INDEX idx_company_salary        (company, salary),
    INDEX idx_grade_point           (grade, point),
    INDEX idx_gender_job            (gender, job),
    INDEX idx_name_email_phone      (name, email, phone),
    INDEX idx_company_salary_grade  (company, salary, grade)
);


-- 벤치마크 기록 테이블
CREATE TABLE insert_benchmark (
    id         BIGINT      NOT NULL AUTO_INCREMENT,
    table_name VARCHAR(50) NOT NULL,
    elapsed_us BIGINT      NOT NULL,
    tested_at  DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
);


-- 측정 프로시저
DROP PROCEDURE IF EXISTS benchmark_insert;

DELIMITER $$
CREATE PROCEDURE benchmark_insert()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE start DATETIME(6);
    DECLARE elapsed BIGINT;

    -- member_no_index 측정
    SET i = 1;
    WHILE i <= 1000 DO
        SET start = NOW(6);
        INSERT INTO member_no_index
            (name, email, phone, address, birth_date, gender, job, company, salary, grade, point)
        VALUES (
            CONCAT('user', i),
            CONCAT('user', i, '@test.com'),
            CONCAT('010-', LPAD(i, 4, '0'), '-', LPAD(i, 4, '0')),
            CONCAT('서울시 강남구 테스트로 ', i, '길'),
            DATE_ADD('1990-01-01', INTERVAL MOD(i, 365) DAY),
            IF(MOD(i, 2) = 0, 'MALE', 'FEMALE'),
            ELT(MOD(i, 5) + 1, '개발자', '디자이너', '기획자', '마케터', '영업'),
            CONCAT('회사', MOD(i, 50) + 1),
            3000000 + (MOD(i, 10) * 100000),
            ELT(MOD(i, 4) + 1, 'BRONZE', 'SILVER', 'GOLD', 'PLATINUM'),
            MOD(i, 10000)
        );
        SET elapsed = TIMESTAMPDIFF(MICROSECOND, start, NOW(6));
        INSERT INTO insert_benchmark (table_name, elapsed_us) VALUES ('no_index', elapsed);
        SET i = i + 1;
    END WHILE;

    -- member_over_index 측정
    SET i = 1;
    WHILE i <= 1000 DO
        SET start = NOW(6);
        INSERT INTO member_over_index
            (name, email, phone, address, birth_date, gender, job, company, salary, grade, point)
        VALUES (
            CONCAT('user', i),
            CONCAT('user', i, '@test.com'),
            CONCAT('010-', LPAD(i, 4, '0'), '-', LPAD(i, 4, '0')),
            CONCAT('서울시 강남구 테스트로 ', i, '길'),
            DATE_ADD('1990-01-01', INTERVAL MOD(i, 365) DAY),
            IF(MOD(i, 2) = 0, 'MALE', 'FEMALE'),
            ELT(MOD(i, 5) + 1, '개발자', '디자이너', '기획자', '마케터', '영업'),
            CONCAT('회사', MOD(i, 50) + 1),
            3000000 + (MOD(i, 10) * 100000),
            ELT(MOD(i, 4) + 1, 'BRONZE', 'SILVER', 'GOLD', 'PLATINUM'),
            MOD(i, 10000)
        );
        SET elapsed = TIMESTAMPDIFF(MICROSECOND, start, NOW(6));
        INSERT INTO insert_benchmark (table_name, elapsed_us) VALUES ('over_index', elapsed);
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;

CALL benchmark_insert();


-- 결과 확인
SELECT
    table_name,
    COUNT(*)                    AS 총건수,
    ROUND(AVG(elapsed_us))      AS 평균_마이크로초,
    MIN(elapsed_us)             AS 최소_마이크로초,
    MAX(elapsed_us)             AS 최대_마이크로초,
    ROUND(SUM(elapsed_us))      AS 총소요_마이크로초
FROM insert_benchmark
GROUP BY table_name;