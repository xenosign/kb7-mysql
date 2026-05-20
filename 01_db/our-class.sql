CREATE DATABASE `kb7-our-class-1`;

USE `kb7-our-class-1`;

CREATE TABLE students (
  id                  INT           AUTO_INCREMENT PRIMARY KEY,
  name                VARCHAR(20)   NOT NULL,
  birth_year          YEAR          NOT NULL,
  mbti                CHAR(4),
  birthday            VARCHAR(10),
  cake_preference     VARCHAR(50),
  primary_language    VARCHAR(20),
  info                VARCHAR(255),
  first_project_team  VARCHAR(50),
  first_project_topic VARCHAR(100),
  manitto_round       INT,
  manitto_who         VARCHAR(100)
);

INSERT INTO students (
  name, birth_year, mbti, birthday,
  cake_preference, primary_language, info,
  first_project_team, first_project_topic,
  manitto_round, manitto_who
) VALUES
('이효석', 1985, 'ESFP', '11/18',  '티라미수', 'JS, JAVA', '강원 삼척시, 페이커 팬, 김태희 팬', null, null, 2, '강태규');

INSERT INTO students (
  name, birth_year, mbti, birthday,
  cake_preference, primary_language, info,
  first_project_team, first_project_topic,
  manitto_round, manitto_who
) VALUES
('이효석', 1985, 'ESFP', '11/18',  '티라미수', 'JS, JAVA', '강원 삼척시, 페이커 팬, 김태희 팬', null, null, 3, '양승환');



INSERT INTO students (
  name, birth_year, mbti, birthday,
  cake_preference, primary_language, info,
  first_project_team, first_project_topic
) VALUES
('강채연', 2000, 'ISFP', '6/20',  '초코',                    'C++',  '대전, 게임 안좋아함, 한화 팬',                                                                          '환우삼연',          '금융 챌린지 기반 절약 가계부'),
('강태규', 1999, 'INFP', '8/6',   '초코',                    'JAVA', 'SW 전공, 평택 거주, 발로란트, 농구 배구 보기',                                                          '돈독',              '게이미피케이션 기반 가계부'),
('권유현', 2001, 'ISFJ', '6/15',  'ALL',                     NULL,   '동탄, 유치원, 귀여운 사람 좋아함',                                                                      '돈독',              '게이미피케이션 기반 가계부'),
('김건우', 2001, 'ISTP', '6/23',  NULL,                      NULL,   '자취, 광주, 멀티미디어소프트',                                                                          '환우삼연',          '금융 챌린지 기반 절약 가계부'),
('김기선', 1998, 'ISTJ', '1/9',   '아이스크림, 평화',        NULL,   '청주, 고양이, 야구 키움 팬, 산업공학과',                                                               '강사님코드가숨을안쉬어요', '사용자 성향에 따른 UI/UX 맞춤 가계부'),
('김민철', 1999, 'ENTJ', '5/20',  NULL,                      NULL,   '복전 컴퓨터 사회학, 개인프로젝트 경험, 일본 여행 경험',                                                'Vue티풀',           '게이미피케이션 기반 소비 건강 체크'),
('김수현', 2000, 'ISFP', '7/12',  '아이스크림, 초코, 평화', NULL,   '6조, 26회, 소주 한병, 풋살, 롤 에메, 안양, 귀여운 사람',                                              '가계부한다고부자가되진않조', '참여자간 공유 가계부'),
('김현태', 1999, 'INTP', '3/8',   '마이넘버원',              NULL,   '동작구, 재즈힙합',                                                                                      'Vue티풀',           '게이미피케이션 기반 소비 건강 체크'),
('송준수', 2001, 'ISTP', '7/19',  'ALL',                     NULL,   '인천, 헬스, 야구',                                                                                      'Vue티풀',           '게이미피케이션 기반 소비 건강 체크'),
('송태권', 2000, 'ISTP', '3/21',  NULL,                      NULL,   '세종대',                                                                                                '가계부한다고부자가되진않조', '참여자간 공유 가계부'),
('양승환', 2000, 'ENTP', '7/11',  '아이스크림',              NULL,   '건대 거주, 여친 있음, 183, 헬스 3년, 롤 증바람, 남동생 군대, 국민은행 취업 희망, 블로그 맛집 5800',    '환우삼연',          '금융 챌린지 기반 절약 가계부'),
('오진호', 1999, 'ISTP', '12/10', '생크림 듬뿍',             NULL,   '북 위례',                                                                                               'Vue티풀',           '게이미피케이션 기반 소비 건강 체크'),
('이대주', 2000, 'ISFP', '11/24', NULL,                      NULL,   '마석, 대성리 거주, 여친 있음, 헬스 하다 손가락 부상, 서든어택 FPS, 누나, 막내, 국민은행, 스크린골프 알바', '가계부한다고부자가되진않조', '참여자간 공유 가계부'),
('이민호', 1997, 'INTP', '6/23',  '아이스크림, 민초',        NULL,   '부천, 단국대, SW, 롤 에메 티모',                                                                       '돈독',              '게이미피케이션 기반 가계부'),
('이아영', 2002, 'ISTP', '12/17', NULL,                      NULL,   'IT 공학과, 전전 남친 4년, 영화보기 로맨스',                                                            '강사님코드가숨을안쉬어요', '사용자 성향에 따른 UI/UX 맞춤 가계부'),
('이지민', 2001, 'ISTP', '8/3',   NULL,                      NULL,   '컴퓨터, 재학생, 용산',                                                                                  '가계부한다고부자가되진않조', '참여자간 공유 가계부'),
('이지은', 2003, 'ISTP', NULL,    NULL,                      NULL,   '인천',                                                                                                  '강사님코드가숨을안쉬어요', '사용자 성향에 따른 UI/UX 맞춤 가계부'),
('이채연', 2001, 'INTP', '10/29', NULL,                      NULL,   '밴드 좋아함, 클라이밍, 솔로지옥, 보컬',                                                                '환우삼연',          '금융 챌린지 기반 절약 가계부'),
('장지연', 2003, 'ESFJ', '2/7',   '초코',                    NULL,   '용인, 통학 1시간, 컴퓨터과학, 필테, 고양이, 멋사',                                                     '환우삼연',          '금융 챌린지 기반 절약 가계부'),
('최규진', 2001, 'ISTJ', '1/5',   NULL,                      NULL,   '경영 복전, 봉천역, 철저한 편, 정장 면접, 라켓볼 취미, 까다로운 입맛 아님',                             '돈독',              '게이미피케이션 기반 가계부'),
('최보윤', 2003, 'ISTP', '1/14',  'not 생크림',              NULL,   NULL,                                                                                                    '돈독',              '게이미피케이션 기반 가계부'),
('홍상우', 2000, 'INFJ', '10/12', NULL,                      NULL,   '경기도 양주, 중랑구, 롤 골드 서폿',                                                                    '강사님코드가숨을안쉬어요', '사용자 성향에 따른 UI/UX 맞춤 가계부'),
('황지원', 2001, 'ENTJ', '3/26',  '고구마',                  NULL,   '마포, IT 공학, 휴학 여행, 강아지',                                                                     '강사님코드가숨을안쉬어요', '사용자 성향에 따른 UI/UX 맞춤 가계부');

SELECT * FROM students;

SELECT * FROM students WHERE birth_year >= 2000 ORDER BY birth_year DESC;
SELECT * FROM students WHERE birth_year < 2000 ORDER BY birth_year ASC;

SELECT * FROM students WHERE info LIKE '%야구%';



UPDATE students SET mbti = 'ENFP' WHERE name = '이효석';

SELECT * FROM students WHERE name = '이효석';

DELETE FROM students WHERE name = '이효석';
DELETE FROM students WHERE name = '강채연';