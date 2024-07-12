-- SQL script that creates a trigger to adjust another table
CREATE TRIGGER trig_order
AFTER INSERT ON orders
FOR EACH ROW
BEGIN
    UPDATE items
    SET quantity = quantity - NEW.quantity
    WHERE id = NEW.item_id;
