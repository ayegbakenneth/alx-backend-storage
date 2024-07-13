-- The items table
CREATE TABLE IF NOT EXISTS items (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    quantity INT DEFAULT 0
);

-- The orders table
CREATE TABLE IF NOT EXISTS orders (
    id INT AUTO_INCREMENT PRIMARY KEY,
    item_id INT,
    quantity INT,
    FOREIGN KEY (item_id) REFERENCES items(id)
);
DELIMITER //
-- SQL script that creates a trigger to adjust another table
CREATE TRIGGER trig_order
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    UPDATE orders
    SET quantity = quantity - NEW.quantity
    WHERE id = NEW.item_id
END //
DELIMITER ;
