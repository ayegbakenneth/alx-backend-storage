-- Create the users table
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    name VARCHAR(255)
);

-- Create the projects table
CREATE TABLE IF NOT EXISTS projects (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL UNIQUE
);

-- Corrections table
CREATE TABLE IF NOT EXISTS corrections (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    project_id INT,
    score INT,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (project_id) REFERENCES projects(id)
);

-- User_averages table
CREATE TABLE IF NOT EXISTS user_averages (
    user_id INT PRIMARY KEY,
    average_score DECIMAL(5, 2),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Drop the stored procedure if exists
DROP PROCEDURE IF EXISTS ComputeAverageScoreForUser;

-- ComputeAverageScoreForUser Stored procedure
DELIMITER //

CREATE PROCEDURE ComputeAverageScoreForUser (
    IN user_id INT
)
BEGIN
    DECLARE avg_score DECIMAL(5, 2);
    
    -- average score for the given user_id
    SELECT AVG(score) INTO avg_score
    FROM corrections
    WHERE user_id = user_id;
    
    -- Update the average score in the user_averages table
    INSERT INTO user_averages (user_id, average_score)
    VALUES (user_id, avg_score)
    ON DUPLICATE KEY UPDATE
    average_score = VALUES(average_score);
END //

DELIMITER ;
