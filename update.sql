-- Part 2.4 update.sql
--
-- Submitted by: Cherry Lim Siang Sue, 1837527
--

-- DO NOT use these SQL commands in your submission(they will cause an
--  error on the NMS database server):
-- CREATE SCHEMA
-- USE

-- 1. Update the coach and participant information to only contain the
-- hourly payment. Given that the shows have a duration of 2 hours and
-- that coaches and participants were required to arrive one hour before
-- the show and to leave one hour after the show, the hourly payment
-- should be calculated as the daily payment divided by 4.

-- UPDATE COACH
ALTER TABLE COACH
ADD hourlysalary DECIMAL(8,2);

UPDATE COACH
SET hourlysalary = dailysalary/4;

ALTER TABLE COACH
DROP COLUMN dailysalary;

-- UPDATE PARTICIPANT
ALTER TABLE PARTICIPANT
ADD hourlysalary DECIMAL(6,2);

UPDATE PARTICIPANT
SET hourlysalary = dailysalary/4;

ALTER TABLE PARTICIPANT
DROP COLUMN dailysalary;

-- 2. Add new fields to the attendance table to register when coaches
-- and contenders arrive to and leave the shows.

ALTER TABLE COACHINSHOW
ADD timearrived TIME;
ALTER TABLE COACHINSHOW
ADD timeleft TIME;

ALTER TABLE CONTENDERINSHOW
ADD timearrived TIME;
ALTER TABLE CONTENDERINSHOW
ADD timeleft TIME;

-- 3. UPDATE the attendance information to include the arrival and
-- departure times for the past shows. Your query should set the arrival
-- time to one hour before the show started and the departure time
-- to one hour after the end time.

-- UPDATE COACHINSHOW
CREATE TABLE NEWCOACHINSHOW
SELECT coach, `show`,
SUBTIME(TVSHOW.starttime, '1:00:00') as timearrived,
ADDTIME(TVSHOW.endtime, '1:00:00') as timeleft
FROM COACHINSHOW, TVSHOW
WHERE `show`=idshow;

DELETE FROM COACHINSHOW;

INSERT INTO COACHINSHOW
SELECT * FROM NEWCOACHINSHOW;

-- UPDATE CONTENDERINSHOW
CREATE TABLE NEWCONTENDERINSHOW
SELECT contender, `show`,
SUBTIME(TVSHOW.starttime, '1:00:00') as timearrived,
ADDTIME(TVSHOW.endtime, '1:00:00') as timeleft
FROM CONTENDERINSHOW, TVSHOW
WHERE `show`=idshow;

DELETE FROM CONTENDERINSHOW;

INSERT INTO CONTENDERINSHOW
SELECT * FROM NEWCONTENDERINSHOW;
