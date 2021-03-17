SELECT      DATE_FORMAT(datetime, '%H') AS 'hour',
            COUNT(*) AS 'count'
FROM        animal_outs 
GROUP BY    hour
HAVING      hour BETWEEN "09" AND "20"
ORDER BY    hour;