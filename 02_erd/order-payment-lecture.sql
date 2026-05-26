CREATE DATABASE `kb7-order-payment`;
USE `kb7-order-payment`;

CREATE TABLE `member` (
	id            BIGINT        NOT NULL AUTO_INCREMENT,
    name          VARCHAR(50)   NOT NULL,
    email         VARCHAR(100)  NOT NULL UNIQUE,
    created_at    DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    
    PRIMARY KEY (id)
);

CREATE TABLE `product` (
	id            BIGINT        NOT NULL AUTO_INCREMENT,
    name          VARCHAR(50)   NOT NULL,
    price         INT           NOT NULL,
    stock         INT           NOT NULL DEFAULT 0,
    updated_at    DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_at    DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    
    PRIMARY KEY (id)
);

CREATE TABLE `order` (
	id            BIGINT        NOT NULL AUTO_INCREMENT,
    member_id_fk  BIGINT        NOT NULL,
    status        VARCHAR(20)   NOT NULL DEFAULT 'PENDING',
    total_price   INT           NOT NULL,    
    order_date    DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_at    DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    
    PRIMARY KEY (id),
	CONSTRAINT fk_order_member FOREIGN KEY (member_id_fk) REFERENCES `member` (id)
);

CREATE TABLE `order-item` (
	id            BIGINT        NOT NULL AUTO_INCREMENT,
    order_id_fk   BIGINT        NOT NULL,
    product_id_fk BIGINT        NOT NULL,
    quantity      INT           NOT NULL,    
    product_price INT           NOT NULL,        
    created_at    DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    
    PRIMARY KEY (id),
	CONSTRAINT fk_order_item_order FOREIGN KEY (order_id_fk) REFERENCES `order` (id),
    CONSTRAINT fk_order_item_product FOREIGN KEY (product_id_fk) REFERENCES `product` (id)
);

CREATE TABLE `settlement` (
    id             BIGINT      NOT NULL AUTO_INCREMENT,
    order_id_fk    BIGINT      NOT NULL UNIQUE,
    settled_amount INT         NOT NULL,
    fee            INT         NOT NULL DEFAULT 0,
    status         VARCHAR(20) NOT NULL DEFAULT 'PENDING',
    settled_at     DATETIME    NULL,
    created_at     DATETIME    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),    
    CONSTRAINT fk_settlement_order FOREIGN KEY (order_id_fk) REFERENCES `order` (id)
);







