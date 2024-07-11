-- a SQL script that ranks country origins of bands
-- ordered by the number of (non-unique) fans

INSERT INTO test
SELECT INTO origin, COUNT(*) AS nb_fans
FROM metal bands
GROUP BY origin
ORDER BY nb_fans DESC;
