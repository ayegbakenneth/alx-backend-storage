-- Drop the stored procedure if exist
DROP PROCEDURE IF EXISTS AddBonus;
-- Create the AddBonus stored procedure
DELIMITER //
CREATE PROCEDURE AddBonus (
    IN user_id INT,
    IN project_name VARCHAR(255),
    IN score INT
)
BEGIN
    DECLARE id_project INT;
    -- Check if the project exists
    SELECT id INTO id_project
    FROM projects
    WHERE name = projecName;
    -- If it does not exist, create it
    IF id_project IS NULL THEN
        INSERT INTO projects (name)
        VALUES (projectName);
        -- Get the new project ID
        SET id_project = LAST_INSERT_ID();
    END IF;
    -- Add a new correction
    INSERT INTO corrections (user_id, id_project, score)
    VALUES (user_id, id_project, score);
END //

DELIMITER ;
