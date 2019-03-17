-- Part 2.5 delete.sql
--
-- Submitted by: Cherry Lim Siang Sue, 1837527
--

-- DO NOT use these SQL commands in your submission(they will cause an
--  error on the NMS database server):
-- CREATE SCHEMA
-- USE

-- Using this contender stage name as its identifying attribute in the
-- query, write the DELETE statement(s) that removes this contender and
-- all their related data from the database.

-- tables PARTICIPANT and CONTENDERINSHOW referencing CONTENDER
-- are set to ON DELETE CASCADE.
DELETE FROM CONTENDER
WHERE stagename='Kay';
