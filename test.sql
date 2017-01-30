--select
--id,
--0 as wins,
--(select count(*) from matches)
--from players
--where id not in (SELECT DISTINCT(winner) FROM matches)
--union
--select
--winner as id,
--count(*) as wins
--from matches
--group by id
--order by wins desc,
--id;

select winner as player, count(*) from (select winner from matches union all select loser from matches) as multipleValues group by player;


