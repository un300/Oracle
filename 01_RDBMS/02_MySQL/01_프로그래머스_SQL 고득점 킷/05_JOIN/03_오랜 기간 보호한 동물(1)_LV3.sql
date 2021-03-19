SELECT      S.name, S.datetime
FROM        (SELECT      I.name, I.datetime
            FROM        animal_ins I
            LEFT JOIN   animal_outs O ON I.animal_id = O.animal_id
            WHERE       O.animal_id IS NULL
            ORDER BY    I.datetime) S 
LIMIT       3;


-- 서브쿼리를 FROM에 사용할때(인라인뷰를 사용할때)
-- 사용한 인라인뷰에는 ALIAS(=AS)를 꼭 붙여주어야 한다.