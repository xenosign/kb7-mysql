-- CREATE DATABASE `kb7-our-class-2`;
-- USE `kb7-our-class-2`;
-- SELECT * FROM students;

-- 기본 테이블
CREATE TABLE students (
  student_id          INT           AUTO_INCREMENT PRIMARY KEY,
  name                VARCHAR(20)   NOT NULL,
  birth_year          YEAR          NOT NULL,
  mbti                CHAR(4),
  birthday            VARCHAR(10)  
);

INSERT INTO students (
  name, birth_year, mbti, birthday
) VALUES ('이효석', 1985, 'ESFP', '11/18');

INSERT INTO students (
  name, birth_year, mbti, birthday
) VALUES ('강태규', 1999, 'INFP', '8/6');

INSERT INTO students (
  name, birth_year, mbti, birthday
) VALUES ('권유현', 2001, 'ISFJ', '6/15');

-- 케이크 테이블 분리 > 1NF
CREATE TABLE cake_preference (
    cake_id     INT             NOT NULL AUTO_INCREMENT,
    student_id  INT             NOT NULL,
    cake_type   VARCHAR(50)     NOT NULL,
    PRIMARY KEY (cake_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);

INSERT INTO cake_preference (student_id, cake_type) VALUES
(1, '티라미수'),
(1, '치즈');

SELECT 
    s.student_id,
    s.name,
    s.birth_year,
    s.mbti,
    s.birthday,
    c.cake_type
FROM students s
JOIN cake_preference c ON s.student_id = c.student_id;

-- 마니또 테이블 분리 > 2NF
CREATE TABLE manito (
    manito_id   INT        NOT NULL AUTO_INCREMENT,
    student_id  INT        NOT NULL,          
    round       INT        NOT NULL,          
    target_id   INT,                           
    PRIMARY KEY (manito_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (target_id)  REFERENCES students(student_id)
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
JOIN students s1 ON m.student_id = s1.student_id
JOIN students s2 ON m.target_id = s2.student_id;

-- 프로젝트 테이블 분리 > 3NF
CREATE TABLE projects (
    project_id   INT            NOT NULL AUTO_INCREMENT PRIMARY KEY,    
    round        INT            NOT NULL,          
    team         VARCHAR(20)    NOT NULL,
    project_subject      VARCHAR(50)    NOT NULL
);

INSERT INTO projects (round, team, project_subject) VALUES
(1, '돈독', '돼지 키우기');

CREATE TABLE project_member (
	project_member_id       INT            NOT NULL AUTO_INCREMENT PRIMARY KEY,
    project_id              INT            NOT NULL,
    student_id              INT            NOT NULL,
    FOREIGN KEY (project_id) REFERENCES projects(project_id),
    FOREIGN KEY (student_id)  REFERENCES students(student_id)    
);

INSERT INTO project_member (project_id, student_id) VALUES
(1, 2);

INSERT INTO project_member (project_id, student_id) VALUES
(1, 3);


