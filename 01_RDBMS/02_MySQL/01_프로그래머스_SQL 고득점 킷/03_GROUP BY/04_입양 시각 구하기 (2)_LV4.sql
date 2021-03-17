SELECT  CASE
            WHEN LEFT(T.hour, 1)="0" THEN RIGHT(T.hour, 1)
            ELSE T.hour
        END AS 'hour',
        T.count AS 'count'
FROM    (SELECT     DATE_FORMAT(datetime, '%H') AS 'hour',
                    COUNT(*) AS 'count'
        FROM        animal_outs 
        GROUP BY    hour
        ORDER BY    hour) T;


-- 매우 어렵군.. 날잡고 하루종일 풀어야할듯