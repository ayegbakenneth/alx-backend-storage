-- Initial
DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS orders;
-- Items table
CREATE TABLE IF NOT EXISTS items (
    name VARCHAR(255) NOT NULL,
    quantity int NOT NULL DEFAULT 10
);
-- Orders table
CREATE TABLE IF NOT EXISTS orders (
    item_name VARCHAR(255) NOT NULL,
    number int NOT NULL
);
-- adding items into Item table
INSERT INTO items (name) VALUES ("apple"), ("pineapple"), ("pear");
DELIMITER //
-- SQL script that creates a trigger to adjust another table
CREATE TRIGGER trig_order
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    UPDATE items
    SET quantity = quantity - NEW.quantity
    WHERE id = NEW.item_id
END //
DELIMITER ;
