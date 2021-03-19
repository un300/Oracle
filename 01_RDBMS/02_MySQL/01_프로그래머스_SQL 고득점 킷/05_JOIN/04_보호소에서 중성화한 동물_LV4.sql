SELECT      I.animal_id, I.animal_type, I.name
FROM        animal_ins I
LEFT JOIN   animal_outs O ON I.animal_id = O.animal_id
WHERE       LEFT(I.sex_upon_intake, 1) = 'I'
AND         LEFT(O.sex_upon_outcome, 1) != 'I';