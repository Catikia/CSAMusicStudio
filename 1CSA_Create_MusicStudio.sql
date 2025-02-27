﻿/*
Author: Catikia
Create Database
*/

USE master
GO

/* Checks for and drops the MusicStudio Database if it already exists */
IF DB_ID('CSAMusicStudio') IS NOT NULL
	DROP DATABASE CSAMusicStudio
GO

/* Creates the Database */
CREATE DATABASE CSAMusicStudio
GO 

/* Selects database to use */
USE CSAMusicStudio
GO

/**************Create Tables*******************/

/* Create Table Students */  
CREATE TABLE CSAStudents(
	StudentID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	FirstLessonDate date NOT NULL, 
	LessonLength varchar(50) NOT NULL,
	LessonRate money NOT NULL,
	DueWeeklyOrMonthly varchar(50) NOT NULL,
	NumberOfInstruments int NULL,
	InstrumentsPlayed varchar(50) NOT NULL,
	Birthday date NULL,
	FavoriteColor varchar(50) NULL,
	FavoriteSong varchar(50) NULL,
	FavoriteGenre varchar(50) NULL,
	Goal varchar(100) NULL
)
GO 

/* Create Table ContactInfo */ 
CREATE TABLE CSAContactInfo(
	ContactID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	StudentID int NOT NULL FOREIGN KEY REFERENCES CSAStudents(StudentID),
	StudentOrParentGuardian varchar(50) NOT NULL,
	FName varchar(50) NULL,
	LName varchar(50) NULL,
	Address1 varchar(50) NULL,
	Address2 varchar(50) SPARSE NULL,
	City varchar(50) NOT NULL,
	State char(2) NOT NULL,
	ZipCode varchar(20) NULL,
	Phone1 varchar(20) NULL,
	Phone2 varchar(20) NULL,
	Email1 varchar(50) NULL,
	Email2 varchar(50) NULL
)
GO

/* Create Table LessonInfo */ 
CREATE TABLE CSALessonInfo(
	LessonID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	StudentID int NOT NULL FOREIGN KEY REFERENCES CSAStudents(StudentID),
	LessonDate date NOT NULL,
	Attended varchar(1) NOT NULL,
	Rescheduled varchar(1) NULL,
	RescheduledDate date NULL,
	DaysPracticed int NULL,
	ActualLessonLength varchar(50) NULL,
	TeacherNotes varchar(200) NULL
)
GO

/* Create Table PaymentInfo */ 
CREATE TABLE CSAPaymentInfo(
	PaymentID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	StudentID int NOT NULL FOREIGN KEY REFERENCES CSAStudents(StudentID),
	PaymentDate date NOT NULL,
	PaymentAmount money NOT NULL,
	PaymentType varchar(50) NOT NULL,
	PaymentNote varchar(100) NULL
)
GO

/* Create Table SongsLearned */ 
CREATE TABLE CSASongsLearned(
	SongID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	LessonID int NOT NULL FOREIGN KEY REFERENCES CSALessonInfo(LessonID),
	SongName varchar(100) NULL,
	SongComposer varchar(50) NULL,
	BookSongIsIn varchar(50) NULL,
	Page int NULL,
	InstrumentPlayedOn varchar(50) NULL,
	DateStartedLearning date NULL,
	DateLearnedBasics date NULL,
	DateLearnedtoPerformanceStandards date NULL,
	DatePerformed date NULL,
	TeacherNotes varchar(200) NULL
)
GO

/* Create Table TheoryLearned */ 
CREATE TABLE CSATheoryLearned(
	TheoryID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	LessonID int NOT NULL FOREIGN KEY REFERENCES CSALessonInfo(LessonID),
	TheoryName varchar(100) NOT NULL,
	BookTheoryIsIn varchar(50) NULL,
	Page int NULL,
	InstrumentPlayedOn varchar(50) NULL,
	DateStartedLearning date NULL,
	LastPlayed date NULL,
	LastMetronomeSpeedPlayed int NULL,
	TeacherNotes varchar(200) NULL
)
GO

/* Create Table ImprovLearned */ 
CREATE TABLE CSAImprovLearned(
	ImprovID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	LessonID int NOT NULL FOREIGN KEY REFERENCES CSALessonInfo(LessonID),
	ImprovName varchar(100) NOT NULL,
	KeyImprovIsIn varchar(50) NULL,
	InstrumentPlayedOn varchar(50) NULL,
	DateStartedLearning date NULL,
	LastPlayed date NULL,
	LastMetronomeSpeedPlayed int NULL,
	TeacherNotes varchar(200) NULL
)
GO

/* Create Table Games */ 
CREATE TABLE CSAGames(
	GameID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	LessonID int NOT NULL FOREIGN KEY REFERENCES CSALessonInfo(LessonID),
	GameName varchar(50) NOT NULL,
	DatePlayed date NOT NULL,
	GameLevel int NOT NULL,
	GameScore varchar(50) NOT NULL
)
GO

/* Create Table AwardsEarned */ 
CREATE TABLE CSAAwardsEarned(
	AwardID int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	StudentID int NOT NULL FOREIGN KEY REFERENCES CSAStudents(StudentID),
	InstrumentPlayedOn varchar(50) NOT NULL,
	AwardName varchar(50) NOT NULL,
	AwardEarnedfor varchar(50) NOT NULL,
	Dateawarded date NULL
)
GO

/************Insert Data into Tables********************/

/* Insert Student Data into Students Table */
SET IDENTITY_INSERT CSAStudents ON
INSERT CSAStudents (StudentID, FirstLessonDate, LessonLength, LessonRate, DueWeeklyOrMonthly, NumberOfInstruments, InstrumentsPlayed, Birthday, FavoriteColor, 
FavoriteSong, FavoriteGenre, Goal) VALUES
	(1, 'August 1, 2009', '30 min', 15.00, 'weekly', 1, 'Piano', '3/17/1998', 'Blue', 'Taylor Swift', NULL,'Take all ten achievement program exams, and scales and chords'),
	(2, 'October 5, 2009', '30 min', 15.00, 'weekly', 1, 'Piano', '9/3/1999', 'Red', 'Taylor Swift', NULL, 'Take all ten achievement program exams, and scales and chords'),
	(3, 'December 9, 2009', '30 min', 15.00, 'weekly', 1, 'Piano', '3/11/2000', 'Purple', 'Sail', NULL, 'Take all achievement program exams, learn all scales and chords, enjoy music'),
	(4, 'February 13, 2010', '30 min', 15.00, 'weekly', 1, 'Piano', '6/18/2000', 'Green', 'Rolling in the deep by Adele', NULL, 'Take all achievement program exams, learn all scales and chords, enjoy music'), 
	(5, 'March 30, 2010', '60 min', 30.00, 'monthly', 1, 'Piano', '6/26/1999', 'Purple', 'Happy', 'Rock, Pop', 'Take all 10 achievement program exams, learn songs'),
	(6, 'April 17, 2010', '60 min', 30.00, 'monthly', 2, 'Piano, Guitar', '12/10/2000', 'Lt Teal, Black, Dk Purple', 'U2', 'Rock', 'Sing and play'),
	(7, 'June 21, 2010', '30 min', 16.00, 'monthly', 1, 'Piano', '9/5/2001', 'Green', 'BlueBird', 'Rock', 'scales, chords, read music, ability to play desired music (current pop/top 40 music)'),
	(8, 'August 25, 2010', '30 min', 16.00, 'weekly', 1, 'Piano', '1/16/2002', 'Blue', NULL, 'Rock', 'Read notes and play for church choir'),
	(9, 'October 29, 2010', '30 min', 16.00, 'weekly', 1, 'Piano', '3/8/2002', 'purple', NULL, 'R&B, NeoSOul, & Hip Hop', 'Read Music & Play Blue Bird by Irimono GalRart'),
	(10, 'December 4, 2010', '30 min', 16.00, 'monthly', 1, 'Piano', '7/15/2003', 'purple, blue', NULL, 'R&B, NeoSOul, & Hip Hop', 'play twinkle twinkle and lets go fly a kite'),
	(11, 'January 6, 2011', '30 min', 16.00, 'weekly', 1, 'Piano', '8/25/2002', 'Blue', 'katy perry', 'pop', 'Play church hymns, take all achievement program exams'),
	(12, 'March 10, 2011', '30 min', 16.00, 'monthly', 2, 'Piano, Guitar', '1/16/2003', 'Blue', NULL, 'pop, country', 'Love of music'),
	(13, 'April 12, 2011', '30 min', 17.00, 'monthly', 1, 'Piano', '2/3/2003', 'Pink', '1D, Sam Smith', 'pop', 'learn to play well, read music'),
	(14, 'June 16, 2011', '30 min', 17.00, 'monthly', 1, 'Piano', '6/9/2003', 'Orange & Pink', 'All about that bass', 'pop', 'learn to play well, read music'),
	(15, 'July 18, 2011', '30 min', 17.00, 'monthly', 1, 'Piano', '1/14/2004', 'Blue', 'Fight Song', 'pop', 'Learn to play country music'),
	(16, 'August 20, 2011', '30 min', 17.00, 'weekly', 1, 'Piano', '5/20/2005', 'Purple', NULL, 'pop', 'Learn to play country music'),
	(17, 'October 24, 2011', '60 min', 34.00, 'weekly', 1, 'Piano', '7/11/2004', 'Blue', NULL, 'pop', 'learn the basic stuff'),
	(18, 'December 28, 2011', '30 min', 17.00, 'weekly', 1, 'Piano', '8/6/2004', 'Purple', NULL, 'pop', 'Learn Something Simple but Fast'),
	(19, 'January 30, 2012', '30 min', 17.00, 'monthly', 1, 'Piano', '8/19/2004', 'Blue', 'Love on Top - Beyonce', NULL, 'Learn something new and broaden interests'),
	(20, 'March 4, 2012', ' 30 min', 17.00, 'monthly', 1, 'Piano', '8/25/2002', 'red', 'Let it Go', NULL, 'Learn more chords'),
	(21, 'May 12, 2012', ' 30 min', 18.00, 'monthly', 1, 'Piano', '9/17/2004', 'Orange', 'let it go', NULL, 'Learn Lots of new songs'),
	(22, 'June 16, 2012', ' 30 min', 18.00, 'weekly', 1, 'Piano', '5/28/2006', 'blue', 'Korean Song', 'Kpop', 'learn how to play'),
	(23, 'August 24, 2012', '30 min', 18.00, 'monthly', 1, 'Piano', '4/26/1985', 'red', 'Jingle Bell Rock', NULL, 'learn how to play'),
	(24, 'September 28, 2012', '30 min', 18.00, 'monthly', 1, 'Piano', '3/29/2005', 'pink', NULL, 'Hip Hop but loves all kinds of music', 'Learn frozen songs and holiday music'),
	(25, 'November 10, 2012', '30 min', 18.00, 'monthly', 1, 'Piano', '3/31/2005', 'Black', NULL, NULL, 'Learn everything'),
	(26, 'December 15, 2012', '60 min', 36.00, 'monthly', 2, 'Piano, Guitar', '3/1/2003', 'Green', NULL, 'EDM', 'Learn chords & scales, play songs, enjoy music'),
	(27, 'January 25, 2013', '30 min', 18.00, 'monthly', 1, 'Piano', '6/21/2005', 'pink', 'Dog Days Are Over by Florence and the Machine', NULL, 'Learn all scales and chords, read music'),
	(28, 'February 2, 2013', '30 min', 18.00, 'weekly', 1, 'Piano', '8/23/2005', 'Green', NULL, 'Disney', 'Learn all scales and chords, play mozart, bach, chopin...'),
	(29, 'March 5, 2013', '30 min', 18.00, 'weekly', 1, 'Piano', '10/9/2005', 'red', NULL, 'country, pop, rock', 'Learn all scales and chords, enjoy music'),
	(30, 'May 9, 2013', '30 min', 19.00, 'weekly', 1, 'Piano', '12/17/2005', 'Purple', 'keep them kisses comin by craig campbell', 'country', 'Learn all scales'),
	(31, 'July 13, 2013', '30 min', 19.00, 'weekly', 1, 'Piano', '1/2/2006', 'blue', NULL, 'Country Rock Pop', 'Learn all possibilities with piano and read music'),
	(32, 'August 17, 2013', '30 min', 19.00, 'monthly', 1, 'Piano', '1/2/2006', 'Pink', 'thinking out loud', 'pop, country', 'Learn about music'),
	(33, 'August 23, 2013', '30 min', 19.00, 'monthly', 1, 'Piano', '3/17/2006', 'Purple', NULL, 'country', 'Be good at piano and have much better understanding of music theory'),
	(34, 'October 29, 2013', '60 min', 38.00, 'monthly', 1, 'Piano', '4/10/2006', 'blue, orange', NULL, 'country', 'get better'),
	(35, 'December 7, 2013', '30 min', 19.00, 'monthly', 1, 'Piano', '10/1/1995', 'Orange', NULL, 'classical, rock', 'enjoyment, learn basics & read music to play for hobby'),
	(36, 'January 21, 2014', '30 min', 19.00, 'weekly', 1, 'Piano', '9/18/2006', 'red', 'anything by ariana Grande', 'Classical', 'Enjoy playing music'),
	(37, 'January 28, 2014', '30 min', 19.00, 'weekly', 1, 'Piano', '1/18/2007', 'Pink', NULL, 'Church Songs', 'Enjoy music, then take all 10 exams'),
	(38, 'March 31, 2014', '30 min', 19.00, 'monthly', 1, 'Piano', '8/25/2004', 'Purple & Blue', NULL, 'Christian, gospel', 'Enjoy music'),
	(39, 'April 3, 2014', '30 min', 20.00, 'monthly', 1, 'Piano', '10/9/2007', 'Purple', NULL, 'Christian rap', 'Enjoy music'),
	(40, 'June 7, 2014', '60 min', 40.00, 'weekly', 1, 'Piano', '11/1/2007', 'Purple', NULL, 'christian', 'Enjoy music'),
	(41, 'August 11, 2014', '30 min', 20.00, 'weekly', 1, 'Piano', '12/18/2007', 'Orange & Yellow', 'Blank Space-taylor swift - riptide', NULL, 'Be good at piano and have much better understanding of music theory'),
	(42, 'August 15, 2014', '30 min', 20.00, 'monthly', 2, 'Piano, Guitar', '4/1/2008', 'Purple', 'Another one bites the dust by Queen', ' Gedtile', 'Learn about music'),
	(43, 'October 7, 2014', '30 min', 20.00, 'monthly', 1, 'Piano', '4/24/2008', 'Orange', NULL, 'All Mostly Country, Pop, Latin', NULL),
	(44, 'November 11, 2014', '30 min', 20.00, 'monthly', 1, 'Piano', '8/5/2004', 'Black', NULL, 'All genre', 'Learn all scales and chords, enjoy music'),
	(45, 'December 19, 2014', '30 min', 20.00, 'monthly', 1, 'Piano', '12/20/2008', 'Green', NULL, 'pop, country', 'Learn all scales and chords, enjoy music'),
	(46, 'January 23, 2015', '60 min', 40.00, 'weekly', 1, 'Piano', '1/3/2009', 'pink', NULL, 'pop, country', 'Enjoy music'),
	(47, 'January 27, 2015', '30 min', 20.00, 'weekly', 1, 'Piano', '4/23/2005', 'Green', NULL, 'Rock', 'Learn all scales and chords, enjoy music'),
	(48, 'February 2, 2015', '30 min', 20.00, 'weekly', 1, 'Piano', '6/7/2009', 'red', NULL, 'Rock', 'Learn all scales and chords, enjoy music'),
	(49, 'February 8, 2015', '30 min', 20.00, 'monthly', 1, 'Trombone', '9/16/2001', 'Purple', NULL, 'Pop', 'Enjoy music'),
	(50, 'March 14, 2015', '30 min', 20.00, 'weekly', 1, 'Piano', '5/29/2010', 'blue', NULL, 'Rock, country', 'Learn all scales and chords, enjoy music'),
	(51, 'April 22, 2015', '30 min', 21.00, 'weekly', 1, 'Piano', '7/6/2010', 'Pink', NULL, 'Rock, country', 'Learn all scales and chords, enjoy music'),
	(52, 'August 26, 2015', '30 min', 21.00, 'weekly', 1, 'Piano', '1/6/2006', 'Purple', 'Avenged Sevenfold', 'Rock', 'Learn all scales and chords, enjoy music'),
	(53, 'November 19, 2015', '30 min', 21.00, 'weekly', 1, 'Piano', '6/30/2008', 'purple', NULL, 'Rock', 'Enjoy music'),
	(54, 'January 1, 2016', '60 min', 42.00, 'monthly', 1, 'Piano', '7/9/2010', 'purple, blue', NULL, 'Rock', 'Learn all scales and chords, enjoy music'),
	(55, 'February 8, 2016', '30 min', 21.00, 'monthly', 2, 'Piano, Guitar', '8/9/1999', 'Blue', NULL, 'pop', 'Enjoy music'),
	(56, 'April 20, 2016', '30 min', 22.00, 'weekly', 1, 'Piano', '2/7/2004', 'Blue', NULL, NULL, 'Enjoy music'),
	(57, 'May 5, 2016', '30 min', 22.00, 'weekly', 1, 'Clarinet', '2/8/2008', 'Pink', NULL, NULL, 'Be a proficient Clarinet player'),
	(58, 'June 20, 2016', '60 min', 44.00, 'weekly', 1, 'Piano', '9/8/2010', 'Orange & Pink', NULL, 'Classical', 'Learn all scales and chords, enjoy music'),
	(59, 'July 14, 2016', '30 min', 22.00, 'monthly', 1, 'Piano', '7/8/2008', 'Blue', NULL, NULL, 'Enjoy music'),
	(60, 'August 1, 2016', '30 min', 22.00, 'monthly', 1, 'Piano', '10/25/2010', 'Purple', 'Chopin', NULL, 'Learn all scales and chords, enjoy music')
SET IDENTITY_INSERT CSAStudents OFF
GO

/* Insert Data into ContactInfo Table */
SET IDENTITY_INSERT CSAContactInfo ON
INSERT CSAContactInfo (ContactID, StudentID, StudentOrParentGuardian, FName, LName, Address1, Address2, City, State, ZipCode, Phone1, Phone2, Email1, Email2) VALUES
	(1, 1, 'Student', '(Karter) Eli', 'Collins', '114 N. Johnson Road ', NULL, 'Flagstaff', 'AZ', '85139', NULL, NULL, NULL, NULL),
	(2, 1, 'Parent', 'Sally', 'Collims', '114 N. Johnson Road ', NULL, 'Flagstaff', 'AZ', '85139', '555-480-8456', NULL, 'Sally@aol.com', 'Sally.C@gnet.gov'),
	(3, 2, 'Student', 'Abigail', 'Edgmon', '19 N. Meghan Drive', NULL, 'Flagstaff', 'AZ', '85139', NULL, NULL, NULL, NULL),
	(4, 2, 'Parent', 'Alexis', 'Edgmon', '19 N. Meghan Drive', NULL, 'Flagstaff', 'AZ', '85139', '555-480-9765', NULL, 'Alexis@aol.com', NULL),
	(5, 3, 'Student', 'Allie ', 'Jerome', '37 N Santa Cruz Dr.', NULL, 'Flagstaff', 'AZ', '85139', NULL, NULL, NULL, NULL),
	(6, 3, 'Parent', 'Annamaria', 'Jerome', '37 N Santa Cruz Dr.', NULL, 'Flagstaff', 'AZ', '85139', '555-480-6548', '555-666-2222', 'Annamaria@aol.com', NULL),
	(7, 4, 'Student', 'Annie', 'Chavez', '682 N Alma Dr', NULL, 'Flagstaff', 'AZ', '85139', NULL, NULL, NULL, NULL),
	(8, 4, 'Parent', 'Autumn', 'Chavez', '682 N Alma Dr', NULL, 'Flagstaff', 'AZ', '85139', '555-480-7593', NULL, 'Autumn@aol.com', NULL),
	(9, 5, 'Student', 'Ava', 'Knight', '20 E Bighorn Ave', NULL, 'Phoenix', 'AZ', NULL, NULL, NULL, NULL, NULL),
	(10, 5, 'Parent', 'Bailey ', 'Knight', '20 E Bighorn Ave', NULL, 'Phoenix', 'AZ', NULL, '666-777-7541', NULL, 'Bailey@aol.com', NULL),
	(11, 6, 'Student', 'Bella (Isabella)', 'Chavez', '33 W Velazquez Dr', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(12, 6, 'Parent', 'Ben', 'Chavez', '33 W Velazquez Dr', NULL, 'Tucson', 'AZ', '85248', '520-568-9875', NULL, 'Ben@aol.com', NULL),
	(13, 7, 'Student', 'Carter', 'Cozens', '300 W. Giallo Lane', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(14, 7, 'Parent', 'CeCelia ', 'Cozens', '300 W. Giallo Lane', NULL, 'Tucson', 'AZ', '85248', '520-568-4563', NULL, 'CeCelia@aol.com', NULL),
	(15, 8, 'Student', 'Charli', 'Polosky', '321 W Olivo St.', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, 'Charli@aol.com', NULL),
	(16, 9, 'Student', 'Christopher', 'Utley', '391 W. Merced St.', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(17, 9, 'Parent', 'David', 'Utley', '391 W. Merced St.', NULL, 'Tucson', 'AZ', '85248', '520-568-1236', NULL, 'David@aol.com', NULL),
	(18, 10, 'Student', 'Delaney', 'Cain', '25 W. Sanders Way', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(19, 10, 'Parent', 'Diana', 'Cain', '25 W. Sanders Way', NULL, 'Tucson', 'AZ', '85248', '602-515-1234', NULL, 'Diana@aol.com', NULL),
	(20, 11, 'Student', 'Ethan', 'Brown', '413 W. Novak Lane', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, 'Ethan@aol.com', NULL),
	(21, 12, 'Student', 'Ethan ', 'Hirsch', '408 W. Robbins Drive', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(22, 12, 'Parent', 'Gianna', 'Hirsch', '408 W. Robbins Drive', NULL, 'Tucson', 'AZ', '85248', '602-515-4567', NULL, 'Gianna@aol.com', NULL),
	(23, 13, 'Student', 'Grayson', 'Delgado', '123 W. Wade Dr.', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(24, 13, 'Parent', 'Guadalupe', 'Delgado', '123 W. Wade Dr.', NULL, 'Tucson', 'AZ', '85248', '456-789-1231', NULL, 'Guadalupe@aol.com', NULL),
	(25, 14, 'Student', 'Ianna', 'Klank', '415 W Somerset Dr', NULL, 'Tucson', 'AZ', '85248', '520-568-9875', NULL, 'Ianna@aol.com', NULL),
	(26, 15, 'Student', 'Irene', 'Tompkins', '418 W Somerset Dr', NULL, 'Tucson', 'AZ', '85248', '520-568-9873', NULL, 'Irene@aol.com', NULL),
	(27, 16, 'Student', 'Isabella', 'Warner', '41 W Colby Dr.', NULL, 'Tucson', 'AZ', '85248', '520-568-6548', NULL, 'Isabella@aol.com', NULL),
	(28, 17, 'Student', 'Jaclyn', 'Smith', '45 W Colby Dr.', NULL, 'Tucson', 'AZ', '85248', '520-568-1238', NULL, 'Jaclyn@aol.com', NULL),
	(29, 18, 'Student', 'Jamie', 'Nguyen', '41 W.Lucera Ln', NULL, 'Tucson', 'AZ', '85248', '520-568-7832', NULL, 'Jamie@aol.com', NULL),
	(30, 19, 'Student', 'Jaysha', 'Bernard', '447 W. Michaels Drive', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(31, 19, 'Parent', 'Jillian', 'Bernard', '447 W. Michaels Drive', NULL, 'Tucson', 'AZ', '85248', '456-454-7898', NULL, 'Jillian@aol.com', NULL),
	(32, 20, 'Student', 'Jonice', 'Kim', '123 Avella Dr', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(33, 20, 'Parent', 'Jordan', 'Kim', '123 Avella Dr', NULL, 'Tucson', 'AZ', '85248', '456-454-7854', NULL, 'Jordan@aol.com', NULL),
	(34, 21, 'Student', 'JT', 'Ty', '979 Wild Horse Trl', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(35, 21, 'Parent', 'Julie', 'Ty', '979 Wild Horse Trl', NULL, 'Tucson', 'AZ', '85248', '456-454-1232', NULL, 'Julie@aol.com', NULL),
	(36, 22, 'Student', 'Justice', 'Ochanda', '429 Castle Cove', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(37, 22, 'Parent', 'Kara', 'Ochanda', '429 Castle Cove', NULL, 'Tucson', 'AZ', '85248', '456-454-4512', NULL, 'Kara@aol.com', NULL),
	(38, 23, 'Student', 'Katherine ', 'Stinson', '434 Knaus Dr', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(39, 23, 'Parent', 'Kellen', 'Stinson', '434 Knaus Dr', NULL, 'Tucson', 'AZ', '85248', '456-454-7887', NULL, 'Kellen@aol.com', NULL),
	(40, 24, 'Student', 'Kellly', 'Canlas', '43 Oster Dr', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(41, 24, 'Parent', 'Kingston', 'Canlas', '43 Oster Dr', NULL, 'Tucson', 'AZ', '85248', '456-454-9878', NULL, 'Kingston@aol.com', NULL),
	(42, 25, 'Student', 'Kylie', 'Jacobs', '573 Gust Rd', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(43, 25, 'Parent', 'Laura ', 'Jacobs', '573 Gust Rd', NULL, 'Tucson', 'AZ', '85248', '456-454-9865', NULL, 'Laura@aol.com', NULL),
	(44, 26, 'Student', 'Lily', 'Vu', '45 Cowpath Rd', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(45, 26, 'Parent', 'Mama', 'Vu', '45 Cowpath Rd', NULL, 'Tucson', 'AZ', '85248', '456-454-3212', NULL, 'Mama@aol.com', NULL),
	(46, 27, 'Student', 'Marley', 'Hoos', '44 Oster Dr', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(47, 27, 'Parent', 'Mason', 'Hoos', '44 Oster Dr', NULL, 'Tucson', 'AZ', '85248', '654-656-6545', NULL, 'Mason@aol.com', NULL),
	(48, 28, 'Student', 'Matea', 'Hanson', '197 Rhinstone Rd', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(49, 28, 'Parent', 'Max', 'Hanson', '197 Rhinstone Rd', NULL, 'Tucson', 'AZ', '85248', '654-656-9879', NULL, 'Max@aol.com', NULL),
	(50, 29, 'Student', 'McKenzie', 'Prickett', '444 Desert Plant Trl', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(51, 29, 'Parent', 'Mia', 'Prickett', '444 Desert Plant Trl', NULL, 'Tucson', 'AZ', '85248', '654-656-9889', NULL, 'Mia@aol.com', NULL),
	(52, 30, 'Student', 'Michael', 'Manriquez', '450 Desert Garden Trl', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(53, 30, 'Parent', 'Micheal', 'Manriquez', '450 Desert Garden Trl', NULL, 'Tucson', 'AZ', '85248', '654-989-4123', NULL, 'Micheal@aol.com', NULL),
	(54, 31, 'Student', 'Miguel', 'Harrison', '733 Myka Trl', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(55, 31, 'Parent', 'Molly', 'Harrison', '733 Myka Trl', NULL, 'Tucson', 'AZ', '85248', '654-878-7899', NULL, 'Molly@aol.com', NULL),
	(56, 32, 'Student', 'Morgan', 'Guidi', '899 Gosta Rd', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(57, 32, 'Parent', 'Nana', 'Guidi', '899 Gosta Rd', NULL, 'Tucson', 'AZ', '85248', '654-878-9877', NULL, 'Nana@aol.com', NULL),
	(58, 33, 'Student', 'Nate', 'Turcsak', '907 Houston Dr', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(59, 33, 'Parent', 'Olivia', 'Turcsak', '907 Houston Dr', NULL, 'Tucson', 'AZ', '85248', '654-121-4566', NULL, 'Olivia@aol.com', NULL),
	(60, 34, 'Student', 'Paige', 'Cox', '78 Gurc Rd', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(61, 34, 'Parent', 'Phoenix', 'Cox', '78 Gurc Rd', NULL, 'Tucson', 'AZ', '85248', '123-789-4566', NULL, 'Phoenix@aol.com', NULL),
	(62, 35, 'Student', 'Pryanca', 'Auer', '909 W Lawson', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(63, 35, 'Parent', 'Rebecca', 'Auer', '909 W Lawson', NULL, 'Tucson', 'AZ', '85248', '123-654-7894', NULL, 'Rebecca@aol.com', NULL),
	(64, 36, 'Student', 'Regina', 'Jacobs', '404 YellowStone Trl', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(65, 36, 'Parent', 'Rick', 'Jacobs', '404 YellowStone Trl', NULL, 'Tucson', 'AZ', '85248', '123-456-4564', NULL, 'Rick@aol.com', NULL),
	(66, 37, 'Student', 'Romael', 'Nguyen', '567 Studio Rd', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(67, 37, 'Parent', 'Selina', 'Nguyen', '567 Studio Rd', NULL, 'Tucson', 'AZ', '85248', '123-123-1234', NULL, 'Selina@aol.com', NULL),
	(68, 38, 'Student', 'Sequoiah', 'Pasten', '345 Yester Trl', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(69, 38, 'Parent', 'Shiloh', 'Pasten', '345 Yester Trl', NULL, 'Tucson', 'AZ', '85248', '123-654-9879', NULL, 'Shiloh@aol.com', NULL),
	(70, 39, 'Student', 'Simon', 'Amponsah', '234 Parot ln', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(71, 39, 'Parent', 'Tonya', 'Amponsah', '234 Parot ln', NULL, 'Tucson', 'AZ', '85248', '123-454-4444', NULL, 'Tonya@aol.com', NULL),
	(72, 40, 'Student', 'Tim', 'Smith', '97 Jackrabbit Ln', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(73, 40, 'Parent', 'Alexis', 'Smith', '97 Jackrabbit Ln', NULL, 'Tucson', 'AZ', '85248', '123-454-5555', NULL, 'Alexis@gmail.com', NULL),
	(74, 41, 'Student', 'Allie ', 'Thompset', '43 Allstar Dr', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(75, 41, 'Parent', 'Annamaria', 'Thompset', '43 Allstar Dr', NULL, 'Tucson', 'AZ', '85248', '123-654-6666', NULL, 'Annamaria@gmail.com', NULL),
	(76, 42, 'Student', 'Annie', 'Oakley', '2356 Austin Place', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(77, 42, 'Parent', 'Autumn', 'Oakley', '2356 Austin Place', NULL, 'Tucson', 'AZ', '85248', '123-456-7777', NULL, 'Autumn@gmail.com', NULL),
	(78, 43, 'Student', 'Ava', 'Smitty', '346 GreenTree Rd', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(79, 43, 'Parent', 'Bailey ', 'Smitty', '346 GreenTree Rd', NULL, 'Tucson', 'AZ', '85248', '123-898-9879', NULL, 'Bailey@gmail.com', NULL),
	(80, 44, 'Student', 'Bella (Isabella)', 'Ocha', '790 Gravel Dr', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(81, 44, 'Parent', 'Ben', 'Ocha', '790 Gravel Dr', NULL, 'Tucson', 'AZ', '85248', '454-654-9878', NULL, 'Ben@gmail.com', NULL),
	(82, 45, 'Student', 'Carter', 'Oscar', '904 BellPepp Ln', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(83, 45, 'Parent', 'CeCelia ', 'Oscar', '904 BellPepp Ln', NULL, 'Tucson', 'AZ', '85248', '123-654-3333', NULL, 'CeCelia@gmail.com', NULL),
	(84, 46, 'Student', 'Charli', 'Chaplin', '797 Gravel Dr', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(85, 46, 'Parent', 'Christopher', 'Chaplin', '797 Gravel Dr', NULL, 'Tucson', 'AZ', '85248', '666-655-3333', NULL, 'Christopher@gmail.com', NULL),
	(86, 47, 'Student', 'David', 'Jaku', '946 Jedi Trl', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(87, 47, 'Parent', 'Delaney', 'Jaku', '946 Jedi Trl', NULL, 'Tucson', 'AZ', '85248', '456-789-7899', NULL, 'Delaney@gmail.com', NULL),
	(88, 48, 'Student', 'Diana', 'Hanson', '803 Powers Rd', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(89, 48, 'Parent', 'Ethan', 'Hanson', '803 Powers Rd', NULL, 'Tucson', 'AZ', '85248', '789-789-7899', NULL, 'Ethan@gmail.com', NULL),
	(90, 49, 'Student', 'Ethan ', 'Butters', '743 Partner Trl', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(91, 49, 'Parent', 'Gianna', 'Butters', '743 Partner Trl', NULL, 'Tucson', 'AZ', '85248', '456-654-6665', NULL, 'Gianna@gmail.com', NULL),
	(92, 50, 'Student', 'Grayson', 'Hoys', '8934 Astro Blvd', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(93, 50, 'Parent', 'Guadalupe', 'Hoys', '8934 Astro Blvd', NULL, 'Tucson', 'AZ', '85248', '456-456-1111', NULL, 'Guadalupe@gmail.com', NULL),
	(94, 51, 'Student', 'Ianna', 'Crain', '9823 Compt Ln', NULL, 'Tucson', 'AZ', NULL, NULL, NULL, NULL, NULL),
	(95, 51, 'Parent', 'Alexis', 'Crain', '9823 Compt Ln', NULL, 'Tucson', 'AZ', NULL, '123-121-1212', NULL, 'Alexis@hotmail.com', NULL),
	(96, 52, 'Parent', 'Allie ', 'Lolz', '345 Ash Ln', NULL, 'Tucson', 'AZ', '85248', '456-444-4564', NULL, 'Allie@hotmail.com', NULL),
	(97, 52, 'Student', 'Annamaria', 'Lolz', '345 Ash Ln', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(98, 53, 'Parent', 'Annie', 'Nun', '3467 Yoda Rd', NULL, 'Tucson', 'AZ', '85248', '686-696-6985', NULL, 'Annie@hotmail.com', NULL),
	(99, 53, 'Student', 'Autumn', 'Nun', '3467 Yoda Rd', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(100, 54, 'Parent', 'Ava', 'setter', '9238 Galaxy Dr', NULL, 'Tucson', 'AZ', '85248', '686-696-6565', NULL, 'Ava@hotmail.com', NULL),
	(101, 54, 'Student', 'Bailey ', 'setter', '9238 Galaxy Dr', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(102, 55, 'Parent', 'Bella (Isabella)', 'Once', '2398 Armored Trl', NULL, 'Tucson', 'AZ', '85248', '686-696-6544', NULL, 'Bell@hotmail.com', NULL),
	(103, 55, 'Student', 'Ben', 'Once', '2398 Armored Trl', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(104, 55, 'Parent', 'Carter', 'Once', '2398 Armored Trl', NULL, 'Tucson', 'AZ', '85248', '686-696-7676', NULL, 'Carter@hotmail.com', NULL),
	(105, 56, 'Student', 'CeCelia ', 'Ricksy', '9834 Hot Coals Rd', NULL, 'Tucson', 'AZ', '85248', '456-789-1254', NULL, NULL, NULL),
	(106, 57, 'Parent', 'Charli', 'Loyta', '7834 Greenville Trl', NULL, 'Tucson', 'AZ', '85248', '686-767-1515', NULL, 'Charli@hotmail.com', NULL),
	(107, 57, 'Student', 'Christopher', 'Loyta', '7834 Greenville Trl', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(108, 58, 'Parent', 'David', 'Hop', '23 Stultz St', NULL, 'Tucson', 'AZ', '85248', '151-515-4545', NULL, 'David@hotmail.com', NULL),
	(109, 58, 'Student', 'Delaney', 'Hop', '23 Stultz St', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(110, 59, 'Parent', 'Diana', 'Insta', '901 Podunk Rd', NULL, 'Tucson', 'AZ', '85248', '656-656-6262', NULL, 'Diana@hotmail.com', NULL),
	(111, 59, 'Student', 'Ethan', 'Insta', '901 Podunk Rd', NULL, 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL),
	(112, 60, 'Parent', 'Ethan ', 'Last', '12 First St', NULL, 'Tucson', 'AZ', '85248', '121-454-7878', '456-565-9999', 'Ethan@hotmail.com', 'Ethan.L@Skynet.Net'),
	(113, 60, 'Student', 'Gianna', 'Last', '12 First St', 'Apt 2033', 'Tucson', 'AZ', '85248', NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT CSAContactInfo OFF
GO

/* Insert Data into CSALessonInfo Table */
SET IDENTITY_INSERT CSALessonInfo ON
INSERT CSALessonInfo (LessonID, StudentID, LessonDate, Attended, Rescheduled, RescheduledDate, DaysPracticed, ActualLessonLength, TeacherNotes) VALUES
	(1, 1, 'August 1, 2009', 'Y', 'N', NULL, 1, '30 Min', 'Try to practice atleast once per day'),
	(2, 1, 'August 8, 2009', 'Y', 'N', NULL, 5, '35 Min', 'Keep practicing.  Try to make round fingers'),
	(3, 2, 'October 5, 2009', 'Y', 'N', NULL, 1, '30 Min', 'Try to practice atleast once per day'),
	(4, 3, 'December 9, 2009', 'Y', 'N', NULL, 1, '30 Min', 'Try to practice atleast once per day'),
	(5, 4, 'February 13, 2010', 'Y', 'N', NULL, 1, '30 Min', 'Try to practice atleast once per day'), 
	(6, 5, 'March 30, 2010', 'Y', 'N', NULL, 1, '60 Min', 'Try to practice atleast once per day'),
	(7, 6, 'April 17, 2010', 'Y', 'N', NULL, 1, '60 Min', 'Try to practice atleast once per day'),
	(8, 7, 'June 21, 2010', 'Y', 'N', NULL, 1, '30 Min', 'Try to practice atleast once per day'),
	(9, 8, 'August 25, 2010', 'Y', 'N', NULL, 1, '30 Min', 'Try to practice atleast once per day'),
	(10, 9, 'October 29, 2010', 'Y', 'N', NULL, 1, '30 Min', 'Try to practice atleast once per day'),
	(11, 10, 'December 4, 2010', 'Y', 'N', NULL, 1, '30 Min', 'Try to practice atleast once per day'),
	(12, 12, '8/14/2011', 'Y', 'N', NULL, 1, '30 Min', 'Try to practice atleast once per day'),
	(13, 12, '8/21/2011', 'Y', 'N', NULL, 1, '30 Min', 'Try to practice atleast once per day'),
	(14, 12, '9/14/2011', 'Y', 'N', NULL, 1, '30 Min', 'Try to practice atleast once per day'),
	(15, 12, '9/28/2011', 'Y', 'N', NULL, 1, '30 Min', 'Try to practice atleast once per day'),
	(16, 15, 'July 16, 2011', 'Y', 'N', NULL, 1, '30 Min', 'Try to practice atleast once per day'),
	(17, 15, 'July 25, 2011', 'N', 'N', NULL, NULL, NULL, 'Please call if you will miss a lesson.  48 hour notice is a courtesy to other students trying to reschedule.'),
	(18, 16, 'August 20, 2011', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(19, 1, 'August 28, 2011', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(20, 1, 'September 10, 2011', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(21, 17, 'October 24, 2011', 'Y', 'N', NULL, 1, '60 min', 'Try to practice atleast once per day'),
	(22, 18, 'December 28, 2011', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(23, 19, 'January 30, 2012', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(24, 20, 'March 4, 2012', 'Y', 'N', NULL, 1,' 30 min', 'Try to practice atleast once per day'),
	(25, 21, 'May 12, 2012', 'Y', 'N', NULL, 1, ' 30 min', 'Try to practice atleast once per day'),
	(26, 22, 'June 16, 2012', 'Y', 'N', NULL, 1, ' 30 min', 'Try to practice atleast once per day'),
	(27, 23, 'August 24, 2012', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(28, 24, 'September 28, 2012', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(29, 25, 'November 10, 2012', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(30, 26, 'December 15, 2012', 'Y', 'N', NULL, 1, '60 min', 'Try to practice atleast once per day'),
	(31, 27, 'January 25, 2013', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(32, 28, 'February 2, 2013', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(33, 29, 'March 5, 2013', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(34, 30, 'May 9, 2013', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(35, 31, 'July 13, 2013', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(36, 32, 'August 17, 2013', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(37, 33, 'August 23, 2013', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(38, 34, 'October 29, 2013', 'Y', 'N', NULL, 1, '60 min', 'Try to practice atleast once per day'),
	(39, 35, 'December 7, 2013', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(40, 36, 'January 21, 2014', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(41, 38, 'March 31, 2014', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(42, 39, 'April 3, 2014', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(43, 40, 'June 7, 2014', 'Y', 'N', NULL, 1, '60 min', 'Try to practice atleast once per day'),
	(44, 41, 'August 11, 2014', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(45, 42, 'August 15, 2014', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(46, 43, 'October 7, 2014', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(47, 44, 'November 11, 2014', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(48, 45, 'December 19, 2014', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(49, 46, 'January 23, 2015', 'Y', 'N', NULL, 1, '60 min', 'Try to practice atleast once per day'),
	(50, 47, 'January 27, 2015', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(51, 48, 'February 2, 2015', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(52, 49, 'February 8, 2015', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(53, 50, 'March 14, 2015', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(54, 51, 'April 22, 2015', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(55, 52, 'August 26, 2015', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(56, 53, 'November 19, 2015', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(57, 54, 'January 1, 2016', 'Y', 'N', NULL, 1, '60 min', 'Try to practice atleast once per day'),
	(58, 55, 'February 8, 2016', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(59, 55, 'February 16, 2016', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(60, 55, 'February 24, 2016', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(61, 56, 'April 20, 2016', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(62, 57, 'May 5, 2016', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(63, 57, 'May 11, 2016', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(64, 57, 'May 20, 2016', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(65, 57, 'May 30, 2016', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(66, 58, 'June 20, 2016', 'Y', 'N', NULL, 1, '60 min', 'Try to practice atleast once per day'),
	(67, 59, 'July 14, 2016', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(68, 59, 'July 22, 2016', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(69, 59, 'July 31, 2016', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(70, 59, 'August 5, 2016', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(71, 60, 'August 1, 2016', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(72, 60, 'August 8, 2016', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(73, 60, 'August 16, 2016', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(74, 60, 'August 26, 2016', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day'),
	(75, 60, 'September 2, 2016', 'Y', 'N', NULL, 1, '30 min', 'Try to practice atleast once per day')
SET IDENTITY_INSERT CSALessonInfo OFF
GO

/* Insert Data into CSAPaymentInfo Table */
SET IDENTITY_INSERT CSAPaymentInfo ON
INSERT CSAPaymentInfo (PaymentID, StudentID, PaymentDate, PaymentAmount, PaymentType, PaymentNote) VALUES
	(1, 1, '2009-08-01', 15.00, 'cash', NULL),
	(2, 1, '2009-08-08', 15.00, 'cash', NULL),
	(3, 2, '2009-10-05', 15.00, 'cash', NULL),
	(4, 3, '2009-12-09', 15.00, 'cash', NULL),
	(5, 4, '2010-02-13', 15.00, 'cash', NULL),
	(6, 5, '2010-03-30', 30.00, 'cash', NULL),
	(7, 6, '2010-04-17', 30.00, 'cash', NULL),
	(8, 7, '2010-06-21', 16.00, 'cash', NULL),
	(9, 8, '2010-08-25', 16.00, 'cash', NULL),
	(10, 9, '2010-10-29', 16.00, 'cash', NULL),
	(11, 10, '2010-12-04', 16.00, 'check', 'Check Number 4566'),
	(12, 11, '2011-01-06', 16.00, 'cash', NULL),
	(13, 12, '2011-03-10', 48.00, 'cash', NULL),
	(14, 13, '2011-04-12', 17.00, 'cash', NULL),
	(15, 14, '2011-06-16', 17.00, 'check', 'Check Number 4567'),
	(16, 15, '2011-07-18', 17.00, 'cash', NULL),
	(17, 15, '2011-07-25', 17.00, 'cash', NULL),
	(18, 16, '2011-08-20', 17.00, 'cash', NULL),
	(19, 16, '2011-08-28', 17.00, 'cash', NULL),
	(20, 16, '2011-09-10', 17.00, 'cash', NULL),
	(21, 17, '2011-10-24', 34.00, 'cash', NULL),
	(22, 18, '2011-12-28', 17.00, 'cash', NULL),
	(23, 19, '2012-01-30', 17.00, 'cash', NULL),
	(24, 20, '2012-03-04', 17.00, 'cash', NULL),
	(25, 21, '2012-05-12', 18.00, 'cash', NULL),
	(26, 22, '2012-06-16', 18.00, 'cash', NULL),
	(27, 23, '2012-08-24', 18.00, 'cash', NULL),
	(28, 24, '2012-09-28', 18.00, 'cash', NULL),
	(29, 25, '2012-11-10', 18.00, 'cash', NULL),
	(30, 26, '2012-12-15', 36.00, 'cash', NULL),
	(31, 27, '2013-01-25', 18.00, 'check', 'Check Number 2005'),
	(32, 28, '2013-02-02', 18.00, 'cash', NULL),
	(33, 29, '2013-03-05', 18.00, 'cash', NULL),
	(34, 30, '2013-05-09', 19.00, 'cash', NULL),
	(35, 31, '2013-07-13', 19.00, 'check', 'Check Number 2113'),
	(36, 32, '2013-08-17', 19.00, 'cash', NULL),
	(37, 33, '2013-08-23', 19.00, 'cash', NULL),
	(38, 34, '2013-10-29', 38.00, 'cash', NULL),
	(39, 35, '2013-12-07', 19.00, 'cash', NULL),
	(40, 36, '2014-01-21', 19.00, 'cash', NULL),
	(41, 38, '2014-03-31', 19.00, 'cash', NULL),
	(42, 39, '2014-04-03', 20.00, 'cash', NULL),
	(43, 40, '2014-06-07', 40.00, 'cash', NULL),
	(44, 41, '2014-08-11', 20.00, 'cash', NULL),
	(45, 42, '2014-08-15', 20.00, 'check', 'Check Number 3116'),
	(46, 43, '2014-10-07', 20.00, 'cash', NULL),
	(47, 44, '2014-11-11', 20.00, 'cash', NULL),
	(48, 45, '2014-12-19', 20.00, 'cash', NULL),
	(49, 46, '2015-01-23', 40.00, 'check', 'Check Number 9999'),
	(50, 47, '2015-01-27', 20.00, 'cash', NULL),
	(51, 48, '2015-02-02', 20.00, 'cash', NULL),
	(52, 49, '2015-02-08', 20.00, 'cash', NULL),
	(53, 50, '2015-03-14', 20.00, 'cash', NULL),
	(54, 51, '2015-04-22', 21.00, 'cash', NULL),
	(55, 52, '2015-08-26', 21.00, 'cash', NULL),
	(56, 53, '2015-11-19', 21.00, 'check', 'Check Number 7564'),
	(57, 54, '2016-01-01', 42.00, 'cash', NULL),
	(58, 55, '2016-02-08', 21.00, 'cash', NULL),
	(59, 55, '2016-02-16', 21.00, 'cash', NULL),
	(60, 55, '2016-02-24', 21.00, 'cash', NULL),
	(61, 56, '2016-04-20', 22.00, 'check', 'Check Number 4564'),
	(62, 57, '2016-05-05', 22.00, 'cash', NULL),
	(63, 57, '2016-05-11', 22.00, 'cash', NULL),
	(64, 57, '2016-05-20', 22.00, 'cash', NULL),
	(65, 57, '2016-05-30', 22.00, 'cash', NULL),
	(66, 58, '2016-06-20', 44.00, 'cash', NULL),
	(67, 59, '2016-07-14', 22.00, 'check', 'Check Number 7894'),
	(68, 59, '2016-07-22', 22.00, 'cash', NULL),
	(69, 59, '2016-07-31', 22.00, 'cash', NULL),
	(70, 59, '2016-08-05', 22.00, 'cash', NULL),
	(71, 60, '2016-08-01', 22.00, 'cash', NULL),
	(72, 60, '2016-08-08', 22.00, 'cash', NULL),
	(73, 60, '2016-08-16', 22.00, 'cash', NULL),
	(74, 60, '2016-08-26', 22.00, 'cash', NULL),
	(75, 60, '2016-09-02', 22.00, 'cash', NULL)
SET IDENTITY_INSERT CSAPaymentInfo OFF
GO


/* Insert Data into CSASongsLearned Table  */
SET IDENTITY_INSERT CSASongsLearned ON
INSERT CSASongsLearned (SongID, LessonID, SongName, SongComposer, BookSongIsIn, Page, InstrumentPlayedOn, DateStartedLearning, 
	DateLearnedBasics, DateLearnedtoPerformanceStandards, DatePerformed, TeacherNotes) VALUES
	(1, 1, 'Twinkle, Twinkle, Little Star', 'Jane Taylor', NULL, NULL, 'Piano', '8/1/2009', NULL, NULL, NULL, 'Play this 5 times each day.  Try to keep a steady speed'),
	(2, 2, 'Twinkle, Twinkle, Little Star', 'Jane Taylor', NULL, NULL, 'Piano', '8/1/2009', '8/8/2009', NULL, NULL, 'Great playing!  Remember to keep your hand shape'),
	(3, 12, 'Seven Nation Army', 'White Stripes', 'Elephant', 5, 'Guitar', '8/14/2011', NULL, NULL, NULL, 'Take it slow for good tone and to get the right frets'),
	(4, 13, 'Seven Nation Army', 'White Stripes', 'Elephant', 5, 'Guitar', '8/14/2011', '8/21/2011', NULL, NULL, 'Take it slow for good tone and to get the right frets'),
	(5, 13, 'Rock Legend', NULL, 'Guitar Method Book 1', 3, 'Guitar', '8/21/2011', NULL, NULL, NULL, 'use your fingertips'),
	(6, 14, 'Seven Nation Army', 'White Stripes', 'Elephant', 5, 'Guitar', '8/14/2011', '8/21/2011', '9/14/2011', NULL, 'Keep that nice tone with the added dynamics'),
	(7, 14, 'Rock Legend', NULL, 'Guitar Method Book 1', 3, 'Guitar', '8/21/2011', '8/28/2011', NULL, NULL, 'Add dynamics'), 
	(8, 15, 'Seven Nation Army', 'White Stripes', 'Elephant', 5, 'Guitar', '8/14/2011', '8/21/2011', '9/14/2011', '10/12/2011', NULL),
	(9, 15, 'Rock Legend', NULL, 'Guitar Method Book 1', 3, 'Guitar', '8/21/2011', '8/28/2011', '9/28/2011', '10/12/2011', NULL),
	(10, 19, 'This is Halloween', NULL, NULL, NULL, 'Piano', '8/28/2011', NULL, NULL, NULL, 'Use the metronome to help keep a steady pace'),
	(11, 20, 'This is Halloween', NULL, NULL, NULL, 'Piano', '8/28/2011', '9/10/2011', NULL, NULL, 'Add Dynamics'),
	(12, 20, 'Big Bad Goblin Blues', 'gmajormusicthoery.org', NULL, NULL, 'Piano', '9/10/2011', NULL, NULL, NULL, 'Get the rhythm before adding dynamics')
SET IDENTITY_INSERT CSASongsLearned OFF
GO

/* Insert Data into CSATheoryLearned Table */
SET IDENTITY_INSERT CSATheoryLearned ON
INSERT CSATheoryLearned (TheoryID, LessonID, TheoryName, BookTheoryIsIn, Page, InstrumentPlayedOn, DateStartedLearning, LastPlayed, LastMetronomeSpeedPlayed, TeacherNotes) VALUES
	(1, 1, 'C 5 Finger Scale', 'Scales for Beginners', 1, 'Piano', '8/1/2009', NULL, NULL, 'Play this 5 times each day.  Use the metronome to keep a steady speed'),
	(2, 2, 'C 5 Finger Scale', 'Scales for Beginners', 1, 'Piano', '8/1/2009', '8/8/2009', 60, 'Do not let your fingers bend backwards'),
	(3, 12, 'Em', 'Guitar Chord Book 1', 3, 'Guitar', '8/14/2011', NULL, NULL, 'Use your fingertips'),
	(4, 12, '4 finger warm-up', NULL, NULL, 'Guitar', '8/14/2011', NULL, NULL, 'Use a different finger for each fret. Go Slow to try for good tone'), 
	(5, 13, 'A7', 'Guitar Chord Book 1', 3, 'Guitar', '8/21/2011', NULL, NULL, 'Use your fingertips'),
	(6, 13, '4 finger warm-up', NULL, NULL, 'Guitar', '8/14/2011', '8/21/2011', NULL, 'How fast can you go while using good tone?'),
	(7, 14, 'Switch between Em and A7', 'Guitar Chord Book 1', 3, 'Guitar', '8/28/2011', NULL, 60, 'Try for good tone with good finger placement'),
	(8, 14, '4 finger warm-up on 2 strings', NULL, NULL, 'Guitar', '8/28/2011', NULL, 60, 'Use your fingertips'),
	(9, 15, 'E', 'Guitar Chord Book 1', 4, 'Guitar', '9/14/2011', NULL, 60, 'Try for good tone with good finger placement'),
	(10, 15, '4 finger warm-up on 2 strings', NULL, NULL, 'Guitar', '8/28/2011', '9/14/2011', NULL, 'How fast can you go while using good tone?'),
	(11, 19, 'Am Harmonic Scale', NULL, NULL, 'Piano', '8/28/2011', NULL, 120, 'Remember the seventh note is raised on this scale'),
	(12, 19, 'Broken Am Triad Chords', 'Theory level 2', 2, 'Piano', '8/28/2011', NULL, 120, 'Use the correct fingering. RH: 135 125 135 135, LH: 531 531 521 531'),
	(13, 19, 'Solid Am Triad Chords', 'Theory level 2', 2, 'Piano', '8/28/2011', NULL, 120, 'Use the correct fingering. RH: 135 125 135 135, LH: 531 531 521 531'),
	(14, 20, 'Am Melodic Scale', NULL, NULL, 'Piano', '8/28/2011', '9/10/2011', 120, 'Remember the 6th and 7th notes are raised going up only on this scale.  It is a natural minor scale on the way down.'),
	(15, 20, 'Broken Am Triad Chords', 'Theory level 2', 2, 'Piano', '8/28/2011', '9/10/2011', 120, 'Keep a steady speed.  No pausing.'),
	(16, 20, 'Solid Am Triad Chords', 'Theory level 2', 2, 'Piano', '8/28/2011', '9/10/2011', 120, 'Keep a steady speed.  No pausing.')
SET IDENTITY_INSERT CSATheoryLearned OFF
GO


/* Insert Data into CSAImprovLearned Table  */
SET IDENTITY_INSERT CSAImprovLearned ON
INSERT CSAImprovLearned (ImprovID, LessonID, ImprovName, KeyImprovIsIn, InstrumentPlayedOn, DateStartedLearning, LastPlayed, LastMetronomeSpeedPlayed, TeacherNotes) VALUES
	(1, 1, 'White Key Improv', 'C', 'Piano', '8/1/2009', NULL, NULL, 'Some will sound good and some will not.  The more you play around the better it will sound'),
	(2, 2, 'Improv on 5 finger scale', 'C', 'Piano', '8/8/2009', NULL, NULL, 'Play around. Make it sound good'),
	(3, 12, 'Play around', NULL, 'Guitar', '8/14/2011', NULL, NULL, 'Make it sound good'),
	(4, 13, 'Improv on the 1st string', NULL, 'Guitar', '8/21/2011', NULL, NULL, 'You are making up a song.  Make it sound good'),
	(5, 14, 'Improv on the 1st and 2nd string', NULL, 'Guitar', '8/28/2011', NULL, NULL, 'You are making up a song.  Make it sound good'),
	(6, 15, 'Play around with chords', NULL, 'Guitar', '9/14/2011', NULL, NULL, 'You are making up a song.  Make it sound good'),
	(7, 19, 'Improv on Am Harmonic Scale', 'Am', 'Piano', '8/28/2011', NULL, NULL, 'Make up a song using your scale as a melody and chords as the Harmony.'),
	(8, 19, 'Improv on 12 Bar Blues', 'C', 'Piano', '8/28/2011', NULL, NULL, 'Block the chords until you are comfortable enough to add a melody'),
	(9, 20, 'Improv on Am Melodic Scale', 'Am', 'Piano', '9/10/2011', NULL, NULL, 'Make up a song using your scale as a melody and chords as the Harmony.'),
	(10, 20, 'Improv on 12 Bar Blues', 'C', 'Piano', '8/28/2011', '9/10/2011', NULL, 'Good Chord transitions.  Add a melody this week')
SET IDENTITY_INSERT CSAImprovLearned OFF
GO


/* Insert Data into CSAGames Table */
SET IDENTITY_INSERT CSAGames ON
INSERT CSAGames (GameID, LessonID, GameName, DatePlayed, GameLevel, GameScore) VALUES
	(1, 1, 'Rhythm Cat', '8/1/2009', 3, '2 Stars'),
	(2, 2, 'Rhythm Cat', '8/8/2009', 3, '3 Stars'),
	(3, 12, 'Rhythm Cat', '8/14/2011', 4, '3 Stars'),
	(4, 13, 'Treble Cat', '8/21/2011', 3, '3 Stars'),
	(5, 14, 'Treble Cat', '8/28/2011', 6, '3 Stars'),
	(6, 15, 'Rhythm Cat', '9/14/2011', 5, '3 Stars'),
	(7, 19, 'Eek Shark', '8/28/2011', 1, '120 Seconds'),
	(8, 19, 'Eek Shark', '8/28/2011', 2, '90 Seconds'),
	(9, 20, 'Eek Shark', '9/10/2011', 4, '60 Seconds'),
	(10, 20, 'Treble Cat', '9/10/2011', 13, '3 Stars')
SET IDENTITY_INSERT CSAGames OFF
GO


/* Insert Data into CSAAwardsEarned Table */
SET IDENTITY_INSERT CSAAwardsEarned ON
INSERT CSAAwardsEarned (AwardID, StudentID, InstrumentPlayedOn, AwardName, AwardEarnedfor, Dateawarded) VALUES
	(1, 1, 'Piano', 'Great Practicer', 'Practicing 5 days a week for 1 month', '10/16/2009'),
	(2, 1, 'Piano', 'Great Practicer', 'Practicing 5 days a week for 1 month', '5/15/2010'), 
	(3, 1, 'Piano', 'Technical Certificate', 'Completing all theory for level Primary', '5/15/2010'),
	(4, 1, 'Piano', 'Amazing Practicer', 'Practicing 5 days a week for 6 months', '10/15/2010'),
	(5, 1, 'Piano', 'Technical Certificate', 'Completing all theory for level One', '10/15/2010'),
	(6, 1, 'Piano', 'Amazing Practicer', 'Practicing 5 days a week for 6 months', '10/12/2011'),
	(7, 1, 'Piano', 'Human Jukebox', 'Memorizing 25 Songs', '10/12/2011'),
	(8, 12, 'Piano', 'Great Practicer', 'Practicing 5 days a week for 1 month', '10/12/2011'),
	(9, 12, 'Guitar', 'Technical Certificate', 'Completing all theory for level Primary', '10/12/2011'),
	(10, 12, 'Guitar', 'Great Practicer', 'Practicing 5 days a week for 1 month', '10/12/2011')
SET IDENTITY_INSERT CSAAwardsEarned OFF
GO

CREATE INDEX IX_CSAContactInfo_StudentID
    ON CSAContactInfo (StudentID);
CREATE INDEX IX_CSAPaymentInfo_StudentID
    ON CSAPaymentInfo (StudentID);
CREATE INDEX IX_CSAAwardsEarned_StudentID
    ON CSAAwardsEarned (StudentID);
CREATE INDEX IX_CSALessonInfo_StudentID
    ON CSALessonInfo (StudentID);
CREATE INDEX IX_CSAGames_LessonID
    ON CSAGames (LessonID);
CREATE INDEX IX_CSASongsLearned_LessonID
    ON CSASongsLearned (LessonID);
CREATE INDEX IX_CSATheoryLearned_LessonID
    ON CSATheoryLearned (LessonID);
CREATE INDEX IX_CSAImprovLearned_LessonID
    ON CSAImprovLearned (LessonID);
