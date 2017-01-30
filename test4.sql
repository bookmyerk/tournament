select
winner as id,
count(*) as wins
from matches
group by id
order by wins desc,
id
