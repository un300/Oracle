SELECT      name AS 'NAME', COUNT(*) AS 'COUNT'
FROM        animal_ins
WHERE       name IS NOT NULL
GROUP BY    name
HAVING      COUNT > 1
ORDER BY    NAME;