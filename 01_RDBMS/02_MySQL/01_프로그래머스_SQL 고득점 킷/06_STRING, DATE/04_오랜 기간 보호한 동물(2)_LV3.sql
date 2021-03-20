-- 내가 짠 코드 매우 지저분하다
-- 인라인뷰를 사용
SELECT      T.animal_id, T.name
FROM        (SELECT          I.animal_id AS 'animal_id',
                             I.name AS 'name',
                             TIMESTAMPDIFF(SECOND, I.datetime, O.datetime) AS 'date_diff'
            FROM             animal_ins I
            LEFT JOIN        animal_outs O ON I.animal_id = O.animal_id
            ORDER BY         date_diff DESC) T 
LIMIT       2;




-- 다른사람의 코드를 보고 다시짬
SELECT          I.animal_id, I.name
FROM            animal_ins I
LEFT JOIN       animal_outs O 
ON              I.animal_id = O.animal_id
ORDER BY        TIMESTAMPDIFF(SECOND, I.datetime, O.datetime) DESC
LIMIT           2;