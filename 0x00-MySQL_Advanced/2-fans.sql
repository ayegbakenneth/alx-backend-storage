-- A SQL script that ranks country origins of bands
-- ordered by the number of (non-unique) fans
CREATE TABLE IF NOT EXISTS test (
        origin VARCHAR(255),
        nb_fans INT(255)
)       
-- An SQL query statement that ranks country origins of bands
-- ordered by the number of non unique fans.
INSERT INTO test
SELECT INTO origin, COUNT(*) AS nb_fans
FROM metal bands
GROUP BY origin
ORDER BY nb_fans DESC;
