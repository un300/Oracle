-- 코드를 입력하세요
SELECT      datetime
FROM        animal_ins
WHERE       datetime = (SELECT  MIN(datetime)
                        FROM    animal_ins) ;