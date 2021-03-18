SELECT      animal_type,
            CASE
                WHEN name IS NOT NULL THEN name
                ELSE "No name"
            END AS 'animal_type',
            sex_upon_intake
FROM        animal_ins 
ORDER BY    animal_id;
