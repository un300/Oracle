
-- 1. %조건% 쓰는방법
SELECT      animal_id, name
FROM        animal_ins
WHERE       name LIKE '%el%'
AND         animal_type = 'dog'
ORDER BY    name;


-- 2. REGEXP 쓰는 방법
SELECT      animal_id, name
FROM        animal_ins
WHERE       animal_type = 'dog'
AND         name REGEXP 'el'
ORDER BY    name;