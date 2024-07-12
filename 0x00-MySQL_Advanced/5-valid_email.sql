DELIMITER //
-- SQL script that creates a trigger that resets the attribute
-- valid_email only when the email has been changed
CREATE TRIGGER rseet_valid_email
AFTER INSERT ON users
FOR EACH ROW
BEGIN
	IF NEW.email <> OLD.email
		UPDATE users
		SET valid_email = FALSE
		WHERE id = NEW.id;
	END IF;
END //
DELIMITER ;
