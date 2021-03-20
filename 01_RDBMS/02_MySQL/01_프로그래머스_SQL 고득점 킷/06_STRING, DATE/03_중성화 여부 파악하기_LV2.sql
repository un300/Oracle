SELECT          animal_id, 
                name,
                CASE
                    WHEN sex_upon_intake REGEXP 'Neutered|Spayed' THEN 'O'
                    ELSE 'X'
                END AS '중성화'
FROM            animal_ins;
