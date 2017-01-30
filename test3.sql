drop view playerStandings;
create view playerStandings as
select
players.id as p_id,
players.name,
COALESCE(winRanking.wins, 0) as wins,
COALESCE(matchesPlayed.matchCnt, 0) as matches
FROM players
LEFT JOIN
(select winner as id, count(*) as matchCnt
from (select winner from matches union all select loser from matches)
as multipleValues group by winner) matchesPlayed
ON matchesPlayed.id = players.id
LEFT JOIN
(select
winner as id,
count(*) as wins
from matches
group by id
order by wins desc,
id) winRanking
ON matchesPlayed.id = winRanking.id
order by wins desc;



--select distinct winner from
--(select winner from matches union all select loser from matches) a;

--select p.id as player, p.name, winRanking.wins as wins, matchesPlayed.matchCnt as matches from
--players p,
--(select
--winner as id,
--count(*) as wins
--from matches
--group by id
--order by wins desc,
--id) winRanking,
--(select winner as id, count(*) as matchCnt
--from (select winner from matches union all select loser from matches)
--as multipleValues group by winner) matchesPlayed
--where p.id = matchesPlayed.id and p.id = winRanking.id
--order by wins desc

--select winner, count(*) from (select winner from matches union all select loser from matches) as multipleValues group by winner;



