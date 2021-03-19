SELECT      animal_id, name
FROM        animal_outs
WHERE       animal_id NOT IN (SELECT     animal_id
                             FROM        animal_ins);

-- 오라클은 MINUS라는 명령어가 있지만
-- MYSql은 차집합을 서브쿼리로 구현
