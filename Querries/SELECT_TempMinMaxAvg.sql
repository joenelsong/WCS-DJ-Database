-- Temp Stats --
SELECT MIN(t.bpm) as min, MAX(t.bpm) as max, AVG(t.bpm) as av
FROM Track t
WHERE t.bpm !=""
;
