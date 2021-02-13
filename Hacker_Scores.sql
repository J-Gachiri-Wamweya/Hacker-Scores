-- HACKER SCORES

-- Given the following two tables, write a query to return the hacker ID, name, and total score 
-- (the sum of maximum scores for each challenge completed) ordered by descending score, 
-- and by ascending hacker ID in the case of score tie. 
-- Do not display entries for hackers with a score of zero. 

create database if not exists practicedb;
use practicedb;


create table if not exists hackers (
hacker_id integer not null, 
name varchar(40)
);

create table if not exists submissions (
submission_id integer not null,
hacker_id integer, 
challenge_id integer, 
score integer);
/*
insert into hackers (hacker_id, name)
VALUES
(1, 'John'),
(2, 'Jane'),
(3, 'Joe'),
(4, 'Jim');

insert into submissions (submission_id, hacker_id, challenge_id, score)
VALUES
(101, 1, 1, 10),
(102, 1, 1, 12),
(103, 2, 1, 11),
(104, 2, 1, 9),
(105, 2, 2, 13),
(106, 3, 1, 9),
(107, 3, 2, 12),
(108, 3, 2, 15),
(109, 4, 1, 0);
*/

select * from hackers;
select * from submissions;

with t1 as (
select hacker_id,challenge_id, max(score) as max_score
from submissions
group by hacker_id,challenge_id
having max_score > 0
)
select hackers.hacker_id, hackers.name,sum( max_score) as total_score 
from t1 
join hackers 
on hackers.hacker_id=t1.hacker_id
group by hackers.hacker_id
order by total_score desc, hackers.hacker_id;

