select artist_name,
concert_revenue,
genre,
number_of_members,
revenue_per_member
from 
(
select artist_name,
concert_revenue,
genre,
number_of_members,
concert_revenue / number_of_members AS revenue_per_member,
rank() over( 
partition by genre 
order by concert_revenue / number_of_members desc) as ranked_concerts
from concerts) as A
where ranked_concerts=1
order by revenue_per_member desc
;
