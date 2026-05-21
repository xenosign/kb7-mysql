CREATE DATABASE `kb7-our-class-2`;
USE `kb7-our-class-2`;

SELECT * FROM students;

-- 기본 테이블
CREATE TABLE students (
  id                  INT           AUTO_INCREMENT PRIMARY KEY,
  name                VARCHAR(20)   NOT NULL,
  birth_year          YEAR          NOT NULL,
  mbti                CHAR(4),
  birthday            VARCHAR(10)  
);

-- 케이크 테이블 분리 > 1NF
CREATE TABLE cake_preference (
    cake_id     INT             NOT NULL AUTO_INCREMENT,
    student_id  INT             NOT NULL,
    cake_type   VARCHAR(50)     NOT NULL,
    PRIMARY KEY (cake_id),
    FOREIGN KEY (student_id) REFERENCES students(id)
);

INSERT INTO students (
  name, birth_year, mbti, birthday
) VALUES ('이효석', 1985, 'ESFP', '11/18');

INSERT INTO students (
  name, birth_year, mbti, birthday
) VALUES ('강태규', 1999, 'INFP', '8/6');

INSERT INTO students (
  name, birth_year, mbti, birthday
) VALUES ('', 2000, 'ENTP', '7/11');


INSERT INTO cake_preference (student_id, cake_type) VALUES
(1, '티라미수'),
(1, '치즈');

SELECT 
    s.id,
    s.name,
    s.birth_year,
    s.mbti,
    s.birthday,
    c.cake_type
FROM students s
JOIN cake_preference c ON s.id = c.student_id;

-- 메인 언어 테이블 분리 > 1NF
CREATE TABLE primary_language (
    primary_language_id     INT             NOT NULL AUTO_INCREMENT,
    student_id  INT             NOT NULL,
    language   VARCHAR(50)     NOT NULL,
    PRIMARY KEY (primary_language_id),
    FOREIGN KEY (student_id) REFERENCES students(id)
);

INSERT INTO primary_language (student_id, language) VALUES
(1, 'JS'),
(1, 'JAVA');

SELECT *
FROM students s
JOIN primary_language p ON s.id = p.student_id;

-- 마니또 테이블 분리 > 2NF
CREATE TABLE manito (
    manito_id   INT        NOT NULL AUTO_INCREMENT,
    student_id  INT        NOT NULL,          
    round       INT        NOT NULL,          
    target_id   INT,                           
    PRIMARY KEY (manito_id),
    FOREIGN KEY (student_id) REFERENCES students(id),
    FOREIGN KEY (target_id)  REFERENCES students(id)
);

INSERT INTO manito (student_id, round, target_id) VALUES
(1, 2, 2);

INSERT INTO manito (student_id, round, target_id) VALUES
(1, 3, 3);

SELECT
	m.round,
    s1.name,
    s2.name
FROM manito m
JOIN students s1 ON m.student_id = s1.id
JOIN students s2 ON m.target_id = s2.id;


