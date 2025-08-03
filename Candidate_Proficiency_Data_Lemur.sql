select candidate_id from (
SELECT candidate_id,count(skill) 
FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
group by candidate_id
having count(skill)>2
order by count(skill) desc) as candidate_id