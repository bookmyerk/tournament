-- Table definitions for the tournament project.
--
-- Put your SQL 'create table' statements in this file; also 'create view'
-- statements if you choose to use it.
--
-- You can write comments in this file by starting them with two dashes, like
-- these lines here.
drop database if exists tournament;

create database tournament;

\c tournament;

create table players (
id serial,
name text);


create table matches (
winner integer,
loser integer);



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

