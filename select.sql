-- Part 2.3 select.sql
--
-- Submitted by: Cherry Lim Siang Sue, 1837527
--

-- DO NOT use these SQL commands in your submission(they will cause an
--  error on the NMS database server):
-- CREATE SCHEMA
-- USE


-- 1. Average Female Participant Salary

SELECT AVG(dailysalary)
FROM PARTICIPANT
WHERE gender='F';

-- *** 2. Coaching Report.

SELECT `name`, surname, idcoach, COUNT(*)
FROM COACH, CONTENDER
WHERE idcoach=coach
GROUP BY idcoach;

-- 3. Coach Monthly Attendance Report

-- total number of shows attended by each coach in March
SELECT `name`, surname, idcoach, EXTRACT(MONTH FROM `date`) AS month, COUNT(*) AS shows
FROM COACH, COACHINSHOW, TVSHOW
WHERE idcoach=coach AND `show`=idshow AND EXTRACT(MONTH FROM `date`)=3
GROUP BY idcoach

UNION
-- total number of shows attended by each coach in April
SELECT `name`, surname, idcoach, EXTRACT(MONTH FROM `date`), COUNT(*)
FROM COACH, COACHINSHOW, TVSHOW
WHERE idcoach=coach AND `show`=idshow AND EXTRACT(MONTH FROM `date`)=4
GROUP BY idcoach;

-- 4. Most Expensive Contender

SELECT stagename, MAX(totaldailysalary)
FROM (
SELECT stagename, SUM(dailysalary) AS totaldailysalary
FROM CONTENDER, PARTICIPANT
WHERE type='G' AND idcontender=contender

UNION
SELECT stagename, dailysalary AS totaldailysalary
FROM CONTENDER, PARTICIPANT
WHERE type='S' AND idcontender=contender
) AS tdstable;


-- 5. March Payment Report
-- for each coach and participant:
-- name, no. of shows, dailysalary, totalmarchsalary
-- last line: total amt to be paid in march

CREATE TABLE MSTABLE
-- for coach
SELECT 'coach' as type, `name`, surname, idcoach, EXTRACT(MONTH FROM `date`) AS month,
COUNT(*) AS shows, dailysalary, COUNT(*) * dailysalary AS monthlysalary
FROM COACH, COACHINSHOW, TVSHOW
WHERE idcoach=coach AND `show`=idshow AND EXTRACT(MONTH FROM `date`)=3
GROUP BY idcoach

UNION
-- for participant
SELECT 'participant' as `type`, `name`, surname, idparticipant, EXTRACT(MONTH FROM `date`) AS month,
COUNT(*) AS shows, dailysalary, COUNT(*) * dailysalary AS monthlysalary
FROM PARTICIPANT, CONTENDERINSHOW, TVSHOW
WHERE PARTICIPANT.contender=CONTENDERINSHOW.contender AND `show`=idshow
AND EXTRACT(MONTH FROM `date`)=3
GROUP BY idparticipant;

SELECT * FROM MSTABLE;

-- total amt to be paid in march
SELECT month, SUM(monthlysalary) AS totaltobepaid
FROM MSTABLE;

-- 6. Well Formed Groups!

-- create a group contender with 1 member
INSERT INTO CONTENDER
VALUES ('Izzy', 'G', 6, 2);

INSERT INTO PARTICIPANT
VALUES ('Isabel', 'Shapiro', '1994-05-16', 11, '07566483954', 232, 'F', 6);

-- display whether or not it violates
SELECT stagename, idcontender, COUNT(*) AS numberofmembers,
CASE WHEN COUNT(*)>1 THEN 'True' ELSE 'False' END AS morethanone
FROM CONTENDER, PARTICIPANT
WHERE `type`='G' AND idcontender=contender
GROUP BY idcontender;

-- delete test contender
DELETE FROM PARTICIPANT WHERE contender=6;
DELETE FROM CONTENDER WHERE idcontender=6;
