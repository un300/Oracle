SELECT      I.animal_id, I.name
FROM        animal_ins I
LEFT JOIN   animal_outs O ON I.animal_id = O.animal_id
WHERE       I.datetime > O.datetime
ORDER BY    I.datetime;