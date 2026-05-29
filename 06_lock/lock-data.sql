CREATE TABLE ticket (
    id      INT PRIMARY KEY,
    name    VARCHAR(50),
    stock   INT,
    version INT DEFAULT 0  
);

INSERT INTO ticket VALUES (1, '한국 시리즈', 1, 0);
