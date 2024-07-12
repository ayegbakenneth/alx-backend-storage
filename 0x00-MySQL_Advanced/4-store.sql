-- SQL script that creates a trigger to adjust another table
CREATE TRIGGER trigorder
AFTER INSERT ON orders
FOR EACH ROW
BEGIN UPDATE items
SET quantity = quantity - NEW.quantity
WHERE item.id = NEW.item.id;
