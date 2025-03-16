/* --Create and Use Database-- */ 
CREATE DATABASE INFO_330B_Proj_TAKTheater
USE INFO_330B_Proj_TAKTheater

/* --CREATING TABLES----------------------------------------------------------------------------------* /
/* --Table Not References-- */
/* tblGenre, tblActor, tblProductionCompany */

CREATE TABLE tblGENRE (
  GenreID INT IDENTITY (1,1) PRIMARY KEY,
  GenreName VARCHAR(50),
  GenreDescription VARCHAR(50)
)

CREATE TABLE tblACTOR (
  ActorID INT IDENTITY (1,1) PRIMARY KEY,
  ActorFName VARCHAR(50),
  ActorLName VARCHAR(50)
)


CREATE TABLE tblAGERATING (
  AgeRatingID INT IDENTITY (1,1) PRIMARY KEY,
  AgeRating CHAR(5) NOT NULL
)

CREATE TABLE tblDIRECTOR (
  DirectorID INT IDENTITY (1,1) PRIMARY KEY,
  DirectorFName VARCHAR(50),
  DirectorLName VARCHAR(50)
)

CREATE TABLE tblPRODUCTIONCOMPANY (
  ProductionCompanyID INT IDENTITY (1,1) PRIMARY KEY,
  CompanyName VARCHAR(50) NOT NULL
)

CREATE TABLE tblCUSTOMER (
  CustomerID INT IDENTITY (1,1) PRIMARY KEY,
  CustomerFName VARCHAR(50),
  CustomerLName VARCHAR(50),
  CustomerBirth DATE
)

CREATE TABLE tblSEATTYPE (
  SeatTypeID INT IDENTITY (1,1) PRIMARY KEY,
  SeatTypeName VARCHAR(50)
)

/* --Table References to Other Tables -- */
/* tblMovie */

CREATE TABLE tblMOVIE (
  MovieID INT IDENTITY (1,1) PRIMARY KEY,
  AgeRatingID INT REFERENCES tblAGERATING(AgeRatingID),
  Title VARCHAR(50) NOT NULL,
  MovieDescription VARCHAR(150),
  MovieDurationInMinutes INT NOT NULL,
  PremiereDate DATE
)

CREATE TABLE tblSCHEDULE (
  ScheduleID INT IDENTITY (1,1) PRIMARY KEY, 
  ShowDateTime DATETIME NOT NULL,
  MovieID INT REFERENCES tblMOVIE(MovieID),
)

CREATE TABLE tblRESERVATION (
  ReservationID INT IDENTITY (1,1) PRIMARY KEY,
  Price DECIMAL(10, 2) NOT NULL,
  SeatNumber CHAR(5) NOT NULL,
  CustomerID INT REFERENCES tblCUSTOMER(CustomerID),
  SeatTypeID INT REFERENCES tblSEATTYPE(SeatTypeID),
  ScheduleID INT REFERENCES tblSCHEDULE(ScheduleID),
  ReservationCreated DATETIME
)

/* --Creating Bridge Table-- */
/* tblMOVIE_ACTOR, tblMOVIE_DIRECTOR, tblMOVIE_PRODUCTIONCOMPANY */

CREATE TABLE tblMOVIE_GENRE (
  MovieID INT REFERENCES tblMOVIE(MovieID),
  GenreID INT REFERENCES tblGENRE(GenreID),
  PRIMARY KEY (MovieID, GenreID)
)

CREATE TABLE tblMOVIE_ACTOR (
  MovieID INT REFERENCES tblMOVIE(MovieID),
  ActorID INT REFERENCES tblACTOR(ActorID),
  PRIMARY KEY (MovieID, ActorID)
)

CREATE TABLE tblMOVE_DIRECTOR (
  MovieID INT REFERENCES tblMOVIE(MovieID),
  DirectorID INT REFERENCES tblDIRECTOR(DirectorID),
  PRIMARY KEY (MovieID, DirectorID)
)

CREATE TABLE tblMOVE_PRODUCTIONCOMPANY (
  MovieID INT REFERENCES tblMOVIE(MovieID),
  ProductionCompanyID INT REFERENCES tblPRODUCTIONCOMPANY(ProductionCompanyID),
  PRIMARY KEY (MovieID, ProductionCompanyID)
)

/* --Populating Tables----------------------------------------------------------------------------------* /

/* Populating References Tables*/

-- Age Rating
INSERT INTO tblAGERATING(AgeRating)
VALUES ('G')

INSERT INTO tblAGERATING(AgeRating)
VALUES ('PG')

INSERT INTO tblAGERATING(AgeRating)
VALUES ('PG-13')

INSERT INTO tblAGERATING(AgeRating)
VALUES ('R')

-- tblSEATTYPE
INSERT INTO tblSEATTYPE(SeatTypeName)
VALUES ('Big')

INSERT INTO tblSEATTYPE(SeatTypeName)
VALUES ('Small')

INSERT INTO tblSEATTYPE(SeatTypeName)
VALUES ('Disability')

/* --Callback Stored Procedures-- */
-- Stored Procedures that grab ID is used in other stored Procedures 

/* Grab MovieID from tblMOVIE */
GO
CREATE OR ALTER PROCEDURE get_movie_ID
@movieTitle VARCHAR(50),
@movieDate DATE,
@movieID INT OUTPUT
AS 
Set @movieID = (SELECT MovieID
    FROM tblMOVIE
    WHERE Title = @movieTitle
    AND PremiereDate = @movieDate)

/* Grab ProductionCompanyID from tblPRODUCTIONCOMPANY */
GO
CREATE OR ALTER PROCEDURE get_PCompany_id
@CompanyName VARCHAR(50),
@PCompanyID INT OUTPUT
AS
SET @PCompanyID = (SELECT ProductionCompanyID
  FROM tblPRODUCTIONCOMPANY
  WHERE CompanyName = @CompanyName)

/* --Populating Tables: Stored Procedures-- */

/*  Populating tblCUSTOMER */
-- A stored procedure that insert a given customer into tblCUSTOMER

--Stored Procedure
GO
CREATE OR ALTER PROCEDURE insert_customer
@customerFName VARCHAR(50),
@customerLName VARCHAR(50),
@customerBirth DATE 

AS
INSERT INTO tblCUSTOMER
VALUES (@customerFName, @customerLName, @customerBirth)
GO

-- Execute Procedures
EXECUTE insert_customer
@customerFName = 'Elisha',
@customerLName = 'Ficken',
@customerBirth = '1988-07-12'

EXECUTE insert_customer
@customerFName = 'Ilysa',
@customerLName = 'Ficken',
@customerBirth = '1986-06-13'

EXECUTE insert_customer
@customerFName = 'Dominic',
@customerLName = 'Bernardoni',
@customerBirth = '1995-03-16'

EXECUTE insert_customer
@customerFName = 'Erica',
@customerLName = 'Pighills',
@customerBirth = '1994-12-12'

EXECUTE insert_customer
@customerFName = 'Harley',
@customerLName = 'Geffinger',
@customerBirth = '1992-03-01'

EXECUTE insert_customer
@customerFName = 'Jean',
@customerLName = 'Backhouse',
@customerBirth = '1991-09-11'

EXECUTE insert_customer
@customerFName = 'Tracy',
@customerLName = 'Mallinson',
@customerBirth = '1985-05-12'

EXECUTE insert_customer
@customerFName = 'Lauree',
@customerLName = 'Fosten',
@customerBirth = '1986-02-10'

EXECUTE insert_customer
@customerFName = 'Rochelle',
@customerLName = 'McQuin',
@customerBirth = '1980-08-12'

EXECUTE insert_customer
@customerFName = 'Mike',
@customerLName = 'Smith',
@customerBirth = '1984-11-22'

EXECUTE insert_customer
@customerFName = 'Aaron',
@customerLName = 'Ho',
@customerBirth = '2002-05-22'

/*  Populating tblMovie */
-- Stored Procedure

-- This inserts a given info of a Movie in tblMOVIE
-- This procedure will also add values into tables: production company and director, if inputed values doesn't exists
GO
CREATE OR ALTER PROCEDURE INSERT_MOVIE
@Title VARCHAR(50),
@Description VARCHAR(50),
@MinutesDuration INT,
@PremiereDate DATE,
@Age_Rating CHAR(5),
@ProductionCompany VARCHAR(50),
@DirectorFName VARCHAR(50),
@DirectorLName VARCHAR(50)
AS
DECLARE @AR_ID INT, @PC_ID INT, @D_ID INT, @M_ID INT

IF (SELECT COUNT(*) FROM tblDIRECTOR WHERE DirectorFName = @DirectorFName AND DirectorLName = @DirectorLName) = 0 
  BEGIN
    INSERT INTO tblDIRECTOR(DirectorFName, DirectorLName)
    VALUES(@DirectorFName, @DirectorLName)
  END

IF (SELECT COUNT(*) FROM tblPRODUCTIONCOMPANY WHERE CompanyName = @ProductionCompany) = 0 
  BEGIN
    INSERT INTO tblPRODUCTIONCOMPANY(CompanyName)
    VALUES(@ProductionCompany)
  END

SET @AR_ID = (SELECT AgeRatingID
  FROM tblAGERATING
  WHERE AgeRating = @Age_Rating)

EXECUTE get_PCompany_id
@CompanyName = @ProductionCompany,
@PCompanyID = @PC_ID OUTPUT

SET @D_ID = (SELECT DirectorID
  FROM tblDIRECTOR
  WHERE DirectorFName = @DirectorFName
  AND DirectorLName = @DirectorLName)

BEGIN TRAN T1
  INSERT INTO tblMOVIE(AgeRatingID, Title, MovieDescription, MovieDurationInMinutes, PremiereDate)
  VALUES(@AR_ID, @Title, @Description, @MinutesDuration, @PremiereDate)

  EXECUTE get_movie_ID
  @movieTitle = @Title,
  @movieDate = @PremiereDate,
  @movieID = @M_ID OUTPUT

  INSERT INTO tblMOVE_PRODUCTIONCOMPANY
  VALUES(@M_ID, @PC_ID)
  
  INSERT INTO tblMOVE_DIRECTOR
  VALUES(@M_ID, @D_ID)
COMMIT TRAN T1  
GO

-- Execute Procedures
EXECUTE INSERT_MOVIE
@Title = 'The Super Mario Bros. Movie',
@Description = 'A plumber named Mario travels through an underground labyrinth with his brother, Luigi, trying to save a captured princess.',
@MinutesDuration = 85,
@PremiereDate = '2023-04-07',
@Age_Rating = 'PG',
@ProductionCompany = 'Illumination',
@DirectorFName = 'Aaron',
@DirectorLName = 'Horvath'

EXECUTE INSERT_MOVIE
@Title = 'Elemental',
@Description = 'In a city where fire, water, land, and air residents live together, a fiery young woman and a go-with-the-flow guy discover something elemental',
@MinutesDuration = 93,
@PremiereDate = '2023-06-16',
@Age_Rating = 'PG',
@ProductionCompany = 'Pixar',
@DirectorFName = 'Peter',
@DirectorLName = 'Sohn'

EXECUTE INSERT_MOVIE
@Title = 'Black Panther: Wakanda Forever',
@Description = 'Queen Ramonda, Shuri, MBaku, Okoye and the Dora Milaje fight to protect their nation from intervening world powers in the wake of King TChallas death.',
@MinutesDuration = 161,
@PremiereDate = '2022-11-11',
@Age_Rating = 'PG-13',
@ProductionCompany = 'Marvel Studios',
@DirectorFName = 'Ryan',
@DirectorLName = 'Coogler'

EXECUTE INSERT_MOVIE
@Title = 'Black Adam',
@Description = 'After 5,000 years of bestowed with powers of the Egyptian gods–and imprisoned, Black Adam is freed from his earthly tomb, ready to unleash his unique form of justice on the modern world.',
@MinutesDuration = 124,
@PremiereDate = '2022-10-21',
@Age_Rating = 'PG-13',
@ProductionCompany = 'DC Films',
@DirectorFName = 'Jaume',
@DirectorLName = 'Collet-Serra'

EXECUTE INSERT_MOVIE
@Title = 'Strange World',
@Description = 'The Clades are a legendary family of explorers whose differences threaten to topple their latest and most crucial mission into uncharted and treacherous territory.',
@MinutesDuration = 102,
@PremiereDate = '2022-11-23',
@Age_Rating = 'PG',
@ProductionCompany = 'Walt Disney Pictures',
@DirectorFName = 'Don',
@DirectorLName = 'Hall'

EXECUTE INSERT_MOVIE
@Title = 'Guardians of the Galaxy Vol. 3',
@Description = 'Still reeling from the loss of Gamora, Peter Quill rallies his team to defend the universe and one of their own - a mission that could mean the end of the Guardians if not successful.',
@MinutesDuration = 150,
@PremiereDate = '2023-05-05',
@Age_Rating = 'PG-13',
@ProductionCompany = 'Marvel Studios',
@DirectorFName = 'James',
@DirectorLName = 'Gunn'

EXECUTE INSERT_MOVIE
@Title = 'Violent Night',
@Description = 'When a team of mercenaries breaks into a wealthy family compound on Christmas Eve, taking everyone inside hostage, the team isn’t prepared for a surprise combatant: Santa Claus and he’s about to show why this Nick is no saint.',
@MinutesDuration = 112,
@PremiereDate = '2022-12-02',
@Age_Rating = 'R',
@ProductionCompany = '87North Productions',
@DirectorFName = 'Tommy',
@DirectorLName = 'Wirkola'

EXECUTE INSERT_MOVIE
@Title = 'Avatar: The Way of Water',
@Description = 'After the events of the first film, begins to tell the story of the Sully family, the trouble that follows them, the lengths they go to keep each other safe, the battles they fight to stay alive and the tragedies they endure.',
@MinutesDuration = 192,
@PremiereDate = '2022-12-16',
@Age_Rating = 'PG-13',
@ProductionCompany = 'TSG Entertainment',
@DirectorFName = 'James',
@DirectorLName = 'Cameron'

EXECUTE INSERT_MOVIE
@Title = 'Puss in Boots: The Last Wish',
@Description = 'Puss in Boots discovers that his passion for adventure has taken its toll: he has burned through eight of his nine lives. Puss sets out on an epic journey to find the mythical Last Wish and restore his nine lives.',
@MinutesDuration = 102,
@PremiereDate = '2022-12-21',
@Age_Rating = 'PG',
@ProductionCompany = 'DreamWorks Animation',
@DirectorFName = 'Joel',
@DirectorLName = 'Crawford'

EXECUTE INSERT_MOVIE
@Title = 'Top Gun: Maverick',
@Description = 'After more than thirty years of service as one of the Navy’s top aviators, Pete “Maverick” Mitchell is where he belongs, pushing the envelope as a courageous test pilot and dodging the advancement in rank that would ground him.',
@MinutesDuration = 131,
@PremiereDate = '2022-05-27',
@Age_Rating = 'PG-13',
@ProductionCompany = 'Skydance',
@DirectorFName = 'Joseph',
@DirectorLName = 'Kosinski'

/*  Populating tblPRODUCTIONCOMPANY */
--Stored Procedure: Adding productions companies that help produces a movie.
-- If the Production Companies doesn't exists, then it create a new on inside the table
GO
CREATE OR ALTER PROCEDURE insert_production_company_to_movie
@ProductionCompany VARCHAR(50),
@Title VARCHAR(50),
@PremiereDate DATE
AS
DECLARE @M_ID INT, @PC_ID INT

IF (SELECT COUNT(*) FROM tblPRODUCTIONCOMPANY WHERE CompanyName = @ProductionCompany) = 0 
  BEGIN
    INSERT INTO tblPRODUCTIONCOMPANY(CompanyName)
    VALUES(@ProductionCompany)
  END

EXECUTE get_movie_ID
@movieTitle = @Title,
@movieDate = @PremiereDate,
@movieID = @M_ID OUTPUT

EXECUTE get_PCompany_id
@CompanyName = @ProductionCompany,
@PCompanyID = @PC_ID OUTPUT

BEGIN TRAN T1
  INSERT INTO tblMOVE_PRODUCTIONCOMPANY
  VALUES(@M_ID, @PC_ID)
COMMIT TRAN T1 
GO

-- Execute Procedures
EXECUTE insert_production_company_to_movie
@ProductionCompany = 'Universal Pictures',
@Title = 'The Super Mario Bros. Movie',
@PremiereDate = '2023-04-07'

EXECUTE insert_production_company_to_movie
@ProductionCompany = 'Walt Disney Pictures',
@Title = 'Elemental',
@PremiereDate = '2023-06-16'

/*  Populating tblActor and tblMOVIE_ACTOR */
-- Adding a new value to tblActor, it also add the actor to the bridge table of given movie
CREATE OR ALTER PROCEDURE INSERT_INTO_tblActor
@actorFName VARCHAR(50),
@actorLName VARCHAR(50),
@Title VARCHAR(50),
@PremiereDate DATE
AS 
DECLARE @actor_id INT, @M_ID INT

IF (SELECT COUNT(*) FROM tblACTOR WHERE ActorFName = @actorFName AND ActorLName = @actorLName) = 0 
  BEGIN
    INSERT INTO tblACTOR(ActorFName, ActorLName)
    VALUES(@actorFName, @actorLName)
  END

EXECUTE get_movie_ID
@movieTitle = @Title,
@movieDate = @PremiereDate,
@movieID = @M_ID OUTPUT

SET @actor_id = (SELECT ActorID
  FROM tblACTOR
  WHERE ActorFName = @actorFName
  AND ActorLName = @actorLName)

BEGIN TRAN T1 
  INSERT INTO tblMOVIE_ACTOR 
  VALUES(@M_ID, @actor_id)
COMMIT TRAN T1 

GO

-- Executing procedures
EXEC INSERT_INTO_tblActor
@actorFName = 'Chris',
@actorLName = 'Pratt',
@Title = 'The Super Mario Bros. Movie',
@PremiereDate = '2023-04-07'

-- Executing procedures
EXEC INSERT_INTO_tblActor
@actorFName = 'Anya',
@actorLName = 'Taylor-Joy',
@Title = 'The Super Mario Bros. Movie',
@PremiereDate = '2023-04-07'

EXEC INSERT_INTO_tblActor
@actorFName = 'Chris',
@actorLName = 'Pratt',
@Title = 'Guardians of the Galaxy Vol. 3',
@PremiereDate = '2023-05-05'

EXEC INSERT_INTO_tblActor
@actorFName = 'Leah',
@actorLName = 'Lewis',
@Title = 'Elemental',
@PremiereDate = '2023-06-16'

EXEC INSERT_INTO_tblActor
@actorFName = 'Letitia',
@actorLName = 'Wright',
@Title = 'Black Panther: Wakanda Forever',
@PremiereDate = '2022-11-11'

EXEC INSERT_INTO_tblActor
@actorFName = 'Dwayne',
@actorLName = 'Johnson',
@Title = 'Black Adam',
@PremiereDate = '2022-10-21'

EXEC INSERT_INTO_tblActor
@actorFName = 'Jake',
@actorLName = 'Gyllenhaal',
@Title = 'Strange World',
@PremiereDate = '2022-11-23'

EXEC INSERT_INTO_tblActor
@actorFName = 'David',
@actorLName = 'Harbour',
@Title = 'Violent Night',
@PremiereDate = '2022-12-02'

EXEC INSERT_INTO_tblActor
@actorFName = 'Zoe',
@actorLName = 'Saldana',
@Title = 'Avatar: The Way of Water',
@PremiereDate = '2022-12-16'

EXEC INSERT_INTO_tblActor
@actorFName = 'Antonio',
@actorLName = 'Banderas',
@Title = 'Puss in Boots: The Last Wish',
@PremiereDate = '2022-12-21'

EXEC INSERT_INTO_tblActor
@actorFName = 'Tom',
@actorLName = 'Cruise',
@Title = 'Top Gun: Maverick',
@PremiereDate = '2022-05-27'

/*  Populating tblGENRE */
--Stored Procedure: Populate Values to table Genres
GO
CREATE OR ALTER PROCEDURE INSERT_INTO_tblGenre
@genre VARCHAR(50),
@genreDescription VARCHAR(50)
AS 

BEGIN TRAN T1 
  INSERT INTO tblGENRE(GenreName, GenreDescription)
  VALUES (@genre, @genreDescription)
COMMIT TRAN T1 

GO

-- Execute Procedures
EXEC INSERT_INTO_tblGenre
@genre = 'Horror',
@genreDescription = 'Horror is a genre of storytelling intended to scare, shock, and thrill its audience.'

EXECUTE INSERT_INTO_tblGenre
@genre = 'Western',
@genreDescription = 'Westerns tell the tale of a cowboy or gunslinger pursuing an outlaw in the Wild West'

EXECUTE INSERT_INTO_tblGenre
@genre = 'Comedy',
@genreDescription = 'Center around a comedic premise—usually putting someone in a challenging, amusing, or humorous situation they’re not prepared to handle'

EXECUTE INSERT_INTO_tblGenre
@genre = 'Action',
@genreDescription = 'Action genre are fast-paced and include a lot of action like fight scenes, chase scenes, and slow-motion shots'

EXECUTE INSERT_INTO_tblGenre
@genre = 'Adventure',
@genreDescription = 'Adventure genre usually contain the same basic genre elements as an action movie, with the setting as the critical difference'

EXECUTE INSERT_INTO_tblGenre
@genre = 'Drama',
@genreDescription = 'Features stories with high stakes and many conflicts. They’re plot-driven and demand that every character and scene move the story forward'

EXECUTE INSERT_INTO_tblGenre
@genre = 'Fantasy',
@genreDescription = 'Fantasy genre feature magical and supernatural elements that do not exist in the real world'

EXECUTE INSERT_INTO_tblGenre
@genre = 'Thriller',
@genreDescription = 'thrillers are well-paced, often introducing red herrings, divulging plot twists, and revealing information at the exact right moments to keep the audience intrigued'

EXECUTE INSERT_INTO_tblGenre
@genre = 'Thriller',
@genreDescription = 'thrillers are well-paced, often introducing red herrings, divulging plot twists, and revealing information at the exact right moments to keep the audience intrigued'

EXECUTE INSERT_INTO_tblGenre
@genre = 'Romance',
@genreDescription = 'Center around two protagonists exploring some of the elements of love like relationships, sacrifice, marriage, obsession, or destruction'

EXECUTE INSERT_INTO_tblGenre
@genre = 'Science Fiction',
@genreDescription = 'sci-fi genre builds worlds and alternate realities filled with imagined elements that don’t exist in the real world'

/* Populating tblMOVIE_GENRE */
-- Stored Procedure
GO
CREATE OR ALTER PROCEDURE insert_movie_genre
@Genre VARCHAR(50),
@Title VARCHAR(50),
@PremiereDate DATE
AS
DECLARE @M_ID INT, @G_ID INT

EXECUTE get_movie_ID
@movieTitle = @Title,
@movieDate = @PremiereDate,
@movieID = @M_ID OUTPUT

SET @G_ID = (SELECT GenreID
  FROM tblGENRE
  WHERE GenreName = @Genre)

BEGIN TRAN T1
  INSERT INTO tblMOVIE_GENRE
  VALUES(@M_ID, @G_ID)
COMMIT TRAN T1 
GO

-- Execute Procedures
EXECUTE insert_movie_genre
@Genre = 'Adventure',
@Title = 'The Super Mario Bros. Movie',
@PremiereDate = '2023-04-07'

EXECUTE insert_movie_genre
@Genre = 'Comedy',
@Title = 'The Super Mario Bros. Movie',
@PremiereDate = '2023-04-07'

EXECUTE insert_movie_genre
@Genre = 'Comedy',
@Title = 'Elemental',
@PremiereDate = '2023-06-16'

EXECUTE insert_movie_genre
@Genre = 'Action',
@Title = 'Black Panther: Wakanda Forever',
@PremiereDate = '2022-11-11'

EXECUTE insert_movie_genre
@Genre = 'Action',
@Title = 'Black Adam',
@PremiereDate = '2022-10-21'

EXECUTE insert_movie_genre
@Genre = 'Fantasy',
@Title = 'Black Adam',
@PremiereDate = '2022-10-21'

EXECUTE insert_movie_genre
@Genre = 'Adventure',
@Title = 'Strange World',
@PremiereDate = '2022-11-23'

EXECUTE insert_movie_genre
@Genre = 'Adventure',
@Title = 'Guardians of the Galaxy Vol. 3',
@PremiereDate = '2023-05-05'

EXECUTE insert_movie_genre
@Genre = 'Adventure',
@Title = 'Guardians of the Galaxy Vol. 3',
@PremiereDate = '2023-05-05'

EXECUTE insert_movie_genre
@Genre = 'Comedy',
@Title = 'Violent Night',
@PremiereDate = '2022-12-02'

EXECUTE insert_movie_genre
@Genre = 'Fantasy',
@Title = 'Avatar: The Way of Water',
@PremiereDate = '2022-12-16'

EXECUTE insert_movie_genre
@Genre = 'Comedy',
@Title = 'Puss in Boots: The Last Wish',
@PremiereDate = '2022-12-21'

EXECUTE insert_movie_genre
@Genre = 'Drama',
@Title = 'Top Gun: Maverick',
@PremiereDate = '2022-05-27'

/*  Populating tblSchedule */
-- Stored Procedure: Add values to bridge tables of given Movies and Genres
GO
CREATE OR ALTER PROCEDURE INSERT_SCHEDULE
@MovieName VARCHAR(50),
@PremiereDate DATE,
@ShowDateTime DATETIME
AS
DECLARE @M_ID INT

EXECUTE get_movie_ID
@movieTitle = @MovieName,
@movieDate = @PremiereDate,
@movieID = @M_ID OUTPUT

INSERT INTO tblSCHEDULE(ShowDateTime, MovieID)
VALUES(@ShowDateTime, @M_ID)

GO

-- Execute Procedures
EXECUTE INSERT_SCHEDULE
@MovieName = 'The Super Mario Bros. Movie',
@PremiereDate = '2023-04-07',
@ShowDateTime = '2023-04-07 10:00:00'

EXECUTE INSERT_SCHEDULE
@MovieName = 'Black Panther: Wakanda Forever',
@PremiereDate = '2022-11-11',
@ShowDateTime = '2022-11-12 15:00:00'

EXECUTE INSERT_SCHEDULE
@MovieName = 'Black Panther: Wakanda Forever',
@PremiereDate = '2022-11-11',
@ShowDateTime = '2022-12-24 12:00:00'

EXECUTE INSERT_SCHEDULE
@MovieName = 'Elemental',
@PremiereDate = '2023-06-16',
@ShowDateTime = '2023-06-16 10:00:00'

EXECUTE INSERT_SCHEDULE
@MovieName = 'Black Adam',
@PremiereDate = '2022-10-21',
@ShowDateTime = '2023-12-16 12:00:00'

EXECUTE INSERT_SCHEDULE
@MovieName = 'Strange World',
@PremiereDate = '2022-11-23',
@ShowDateTime = '2022-12-15 10:00:00'

EXECUTE INSERT_SCHEDULE
@MovieName = 'Guardians of the Galaxy Vol. 3',
@PremiereDate = '2023-05-05',
@ShowDateTime = '2023-05-22 12:00:00'

EXECUTE INSERT_SCHEDULE
@MovieName = 'Violent Night',
@PremiereDate = '2022-12-02',
@ShowDateTime = '2022-12-03 16:00:00'

EXECUTE INSERT_SCHEDULE
@MovieName = 'Avatar: The Way of Water',
@PremiereDate = '2022-12-16',
@ShowDateTime = '2022-12-17 14:00:00'

EXECUTE INSERT_SCHEDULE
@MovieName = 'Puss in Boots: The Last Wish',
@PremiereDate = '2022-12-21',
@ShowDateTime = '2022-12-21 10:00:00'

EXECUTE INSERT_SCHEDULE
@MovieName = 'Top Gun: Maverick',
@PremiereDate = '2022-05-27',
@ShowDateTime = '2022-12-21 13:00:00'

/*  Populating tblRESERVATION */
-- Stored Procedure: Adding a reservations for an schedule showing
GO
CREATE OR ALTER PROCEDURE insert_reservation
@price DECIMAL(10, 2),
@seatNumber CHAR(5),
@customerFName VARCHAR(50),
@customerLName VARCHAR(50),
@customerBirth DATE, 
@seatTypeName VARCHAR(50),
@ShowDateTime DATETIME,
@movieTitle VARCHAR(50)

AS -- C is customer, STT is seattype, S is schedule
DECLARE @C_ID INT, @ST_ID INT, @S_ID INT

SET @C_ID = (SELECT customerID 
  FROM tblCUSTOMER
  WHERE CustomerFName = @customerFName
  AND CustomerLName = @customerLName
  AND CustomerBirth = @customerBirth)

SET @ST_ID = (SELECT SeatTypeID 
  FROM tblSEATTYPE
  WHERE SeatTypeName = @seatTypeName)

SET @S_ID = (SELECT s.ScheduleID
  FROM tblSCHEDULE s
  JOIN tblMOVIE m on m.MovieID = s.MovieID
  WHERE s.ShowDateTime = @ShowDateTime
  AND m.Title = @movieTitle)

BEGIN TRAN T1
  INSERT INTO tblRESERVATION(Price, SeatNumber, CustomerID, SeatTypeID, ScheduleID, ReservationCreated)
  VALUES(@price, @seatNumber, @C_ID, @ST_ID, @S_ID, GETDATE())
COMMIT TRAN T1
GO

-- Execute Stored Procedures
EXECUTE insert_reservation
@price = 13.50,
@seatNumber = 'G5',
@customerFName = 'Harley',
@customerLName = 'Geffinger',
@customerBirth = '1992-03-01', 
@seatTypeName = 'Small',
@ShowDateTime = '2022-12-24 12:00:00',
@movieTitle = 'Black Panther: Wakanda Forever'

EXECUTE insert_reservation
@price = 13.50,
@seatNumber = '65',
@customerFName = 'Elisha',
@customerLName = 'Ficken',
@customerBirth = '1988-07-12', 
@seatTypeName = 'Small',
@ShowDateTime = '2022-12-24 12:00:00',
@movieTitle = 'Black Panther: Wakanda Forever'

EXECUTE insert_reservation
@price = 13.50,
@seatNumber = '66',
@customerFName = 'Ilysa',
@customerLName = 'Ficken',
@customerBirth = '1986-06-13', 
@seatTypeName = 'Small',
@ShowDateTime = '2022-12-24 12:00:00',
@movieTitle = 'Black Panther: Wakanda Forever'

EXECUTE insert_reservation
@price = 10.00,
@seatNumber = '10',
@customerFName = 'Dominic',
@customerLName = 'Bernardoni',
@customerBirth = '1995-03-16', 
@seatTypeName = 'Disability',
@ShowDateTime = '2022-12-03 16:00:00.000',
@movieTitle = 'Violent Night'

EXECUTE insert_reservation
@price = 13.50,
@seatNumber = '22',
@customerFName = 'Erica',
@customerLName = 'Pighills',
@customerBirth = '1994-12-12', 
@seatTypeName = 'Big',
@ShowDateTime = '2022-12-15 10:00:00.000',
@movieTitle = 'Strange World'

EXECUTE insert_reservation
@price = 13.50,
@seatNumber = '58',
@customerFName = 'Jean',
@customerLName = 'Backhouse',
@customerBirth = '1991-09-11', 
@seatTypeName = 'Small',
@ShowDateTime = '2022-12-17 14:00:00.000',
@movieTitle = 'Avatar: The Way of Water'

EXECUTE insert_reservation
@price = 13.50,
@seatNumber = '58',
@customerFName = 'Tracy',
@customerLName = 'Mallinson',
@customerBirth = '1985-05-12', 
@seatTypeName = 'Small',
@ShowDateTime = '2022-12-21 10:00:00.000',
@movieTitle = 'Puss in Boots: The Last Wish'

EXECUTE insert_reservation
@price = 13.50,
@seatNumber = '58',
@customerFName = 'Lauree',
@customerLName = 'Fosten',
@customerBirth = '1986-02-10', 
@seatTypeName = 'Small',
@ShowDateTime = '2022-12-21 13:00:00.000',
@movieTitle = 'Top Gun: Maverick'

EXECUTE insert_reservation
@price = 13.50,
@seatNumber = '37',
@customerFName = 'Mike',
@customerLName = 'Smith',
@customerBirth = '1984-11-22', 
@seatTypeName = 'Big',
@ShowDateTime = '2022-12-21 13:00:00.000',
@movieTitle = 'Top Gun: Maverick'

EXECUTE insert_reservation
@price = 13.50,
@seatNumber = '44',
@customerFName = 'Aaron',
@customerLName = 'Ho',
@customerBirth = '2002-05-22', 
@seatTypeName = 'Small',
@ShowDateTime = '2023-04-07 10:00:00.000',
@movieTitle = 'The Super Mario Bros. Movie'

/* --Business Rules----------------------------------------------------------------------------------*/

-- 
-- Rule: A reservation can't be added to a movie that's already air
-- Reason: It doesn't make sense in context if someone was to buy tickets to a previous showing

-- Main Function
CREATE OR ALTER FUNCTION movie_aired_restriction()
RETURNS INT
AS
BEGIN
DECLARE @ret INT = 0
IF EXISTS (SELECT *
  FROM tblSCHEDULE s
  JOIN tblRESERVATION r on r.ScheduleID = s.ScheduleID
  WHERE s.ShowDateTime < r.ReservationCreated)
SET @ret = 1
RETURN @ret
END

GO
-- Add Check Function to Table
ALTER TABLE tblRESERVATION WITH NOCHECK
ADD CONSTRAINT CHK_movie_aired_restrictions
CHECK(dbo.movie_aired_restriction() = 0)

-- 
-- Rule: A showtime of a movie can't be during another airing movie
-- Reason: Our theater is small and we only have one room. It doesn't make sense
-- there was a showing overlapping with another showing

-- Main Function
CREATE OR ALTER FUNCTION movie_have_same_showing()
RETURNS INT
AS
BEGIN
DECLARE @ret INT = 0
  IF EXISTS (SELECT *
  FROM tblMOVIE m
  JOIN tblSCHEDULE s ON s.MovieID = m.MovieID
  INNER JOIN tblSCHEDULE s2
  ON s.ShowDateTime BETWEEN DATEADD(second, 1, s2.ShowDateTime) AND DATEADD(minute, m.MovieDurationInMinutes, s2.ShowDateTime)
  OR s2.ShowDateTime BETWEEN DATEADD(second, 1, s.ShowDateTime) AND DATEADD(minute, m.MovieDurationInMinutes, s.ShowDateTime)
  WHERE s2.ShowDateTime IS NOT NULL
  AND s.ShowDateTime IS NOT NULL)
SET @ret = 1
RETURN @ret
END

GO
-- Add Check Function to Table
ALTER TABLE tblSCHEDULE WITH NOCHECK
ADD CONSTRAINT CHK_movie_have_same_showing
CHECK(dbo.movie_have_same_showing() = 0)

-- 
-- Rule: A business rule where a movie's duration can't be less than an hour
-- Reason: For a movie theater, we consider a showing for a movie to be longer than an hour
CREATE OR ALTER FUNCTION restrict_movie_length()
RETURNS INT 
AS 
BEGIN
DECLARE @ret INT = 0
  IF EXISTS(SELECT *
  FROM tblMOVIE
  WHERE MovieDurationInMinutes < 60)
SET @ret = 1
RETURN @ret
END
GO

ALTER TABLE tblMOVIE WITH NOCHECK
ADD CONSTRAINT constraint_restrict_movie_length
CHECK (dbo.restrict_movie_length() = 0)

-- 
-- Rule: Customers must be within the age range to watch a movie 
-- Reasons: For movies that are Rated R, we can't allow any young people to watch it
-- as it will go against rules 
GO
CREATE OR ALTER FUNCTION restrict_age_function()
RETURNS INT 
AS 
BEGIN
DECLARE @ret INT = 0
IF EXISTS(SELECT *
  FROM tblCUSTOMER c
  JOIN tblRESERVATION r ON c.CustomerID = r.CustomerID
  JOIN tblSCHEDULE s ON r.ScheduleID = s.ScheduleID
  JOIN tblMOVIE m ON s.MovieID = m.MovieID
  JOIN tblAGERATING ar ON m.AgeRatingID = ar.AgeRatingID
  WHERE (DATEDIFF(YEAR,c.CustomerBirth, GETDATE()) < 17
  AND ar.AgeRating = 'R') OR (DATEDIFF(YEAR,c.CustomerBirth, GETDATE()) < 13
  AND ar.AgeRating = 'PG-13'))
SET @ret = 1
RETURN @ret
END
GO

ALTER TABLE tblRESERVATION WITH NOCHECK
ADD CONSTRAINT constraint_age_function
CHECK (dbo.restrict_age_function() = 0)
GO

-- 
-- Rule: A customer can’t reserve a seat that’s already taken
-- Reason: It doesn't make sense if a person reserve a seat that's already taken
-- How would two people share the same seat then?
GO
CREATE OR ALTER FUNCTION movie_seat_restriction()
RETURNS INT
AS 
BEGIN
DECLARE @ret INT = 0
IF EXISTS(SELECT *
  FROM tblRESERVATION r INNER JOIN tblRESERVATION r2
  ON r.SeatNumber = r2.SeatNumber AND r.ScheduleID = r2.ScheduleID
  WHERE r.ReservationCreated < r2.ReservationCreated)
SET @ret = 1
RETURN @ret
END
GO 

-- Add Check Function to Table
ALTER TABLE tblRESERVATION WITH NOCHECK
ADD CONSTRAINT CHK_movie_seat_restriction
CHECK(dbo.movie_seat_restriction() = 0)

-- 
-- Rule: rule where a movie can't have a showing before their premiere date
-- Reason: In terms of legal contracts, we aren't allow to air movies ahead of
-- time of their respective premiere date. Otherwise we will lose permission to air
-- those companies' movies
GO
CREATE OR ALTER FUNCTION movie_premiredate_restriction()
RETURNS INT
AS 
BEGIN
DECLARE @ret INT = 0
IF EXISTS (SELECT *
    FROM tblSCHEDULE s
    JOIN tblMOVIE m ON s.MovieID = m.MovieID
    WHERE s.ShowDateTime < m.PremiereDate)
SET @ret = 1
RETURN @ret
END

GO 

  -- Add Check Function to Table
ALTER TABLE tblSCHEDULE WITH NOCHECK
ADD CONSTRAINT CHK_movie_premiredate_restriction
CHECK(dbo.movie_premiredate_restriction() = 0)

/* --Complex Queries----------------------------------------------------------------------------------*/

--  
-- What movies has been released with Chris Pratt and is not rated R? 
SELECT m.Title
FROM tblMOVIE m
JOIN tblMOVIE_ACTOR ma on m.MovieID = ma.MovieID
JOIN tblACTOR a on a.ActorID = ma.ActorID
JOIN tblAGERATING ar on ar.AgeRatingID = m.AgeRatingID
WHERE ar.AgeRating != 'R'
AND a.ActorFName = 'Chris'
AND a.ActorLName = 'Pratt'

-- 
-- What is each year number of movies aired that has a ticked sold, and each year total earnings
SELECT YEAR(m.PremiereDate) As Year, COUNT(m.MovieID) AS TotalMovies, SUM(r.Price) AS TotalEarnings
FROM tblMOVIE m
JOIN tblSCHEDULE s on s.MovieID = m.MovieID
JOIN tblRESERVATION r on r.ScheduleID = s.ScheduleID
GROUP BY YEAR(m.PremiereDate)


-- 
-- What is each genres total earnings over years of the movie theater's life span?
SELECT g.GenreName, SUM(r.Price) AS TotalEarnings
FROM tblMOVIE m
JOIN tblMOVIE_GENRE mg on m.MovieID = mg.MovieID
JOIN tblGENRE g on g.GenreID = mg.GenreID
JOIN tblSCHEDULE s on m.MovieID = s.MovieID
JOIN tblRESERVATION r on s.ScheduleID = r.ScheduleID
GROUP BY g.GenreName

-- 
-- Which adventure movie in 2022 has the most earnings?
SELECT TOP 1(m.Title), SUM(r.Price) AS TotalEarning
FROM tblMOVIE m
JOIN tblMOVIE_GENRE mg on m.MovieID = mg.MovieID
JOIN tblGENRE g on mg.GenreID = g.GenreID
JOIN tblSCHEDULE s on m.MovieID = s.MovieID
JOIN tblRESERVATION r on s.ScheduleID = r.ScheduleID
WHERE g.GenreName = 'Adventure'
AND YEAR(m.PremiereDate) = '2022'
GROUP BY m.Title

-- 
-- How many movies have been released with the actor Chris Pratt in the years from 2022 - 2023?
SELECT COUNT(m.MovieID) AS TotalMovies
FROM tblMOVIE m 
JOIN tblMOVIE_ACTOR ma on m.MovieID = ma.MovieID
JOIN tblACTOR a on ma.ActorID = a.ActorID
WHERE a.ActorFName = 'Chris'
AND a.ActorLName = 'Pratt'
AND m.PremiereDate > '2022-01-01'
AND m.PremiereDate < '2023-12-31'

-- 
-- Which production company makes the least total earning in 2022 and the total amount of earnings they had in 2022?
GO

CREATE OR ALTER PROCEDURE report_lowest_company_earnings
AS
  SELECT TOP 1 (pc.CompanyName), SUM(r.price) AS TotalEarning
  FROM tblMOVIE m
  JOIN tblMOVE_PRODUCTIONCOMPANY mp on m.MovieID = mp.MovieID
  JOIN tblPRODUCTIONCOMPANY pc on pc.ProductionCompanyID = mp.ProductionCompanyID
  JOIN tblSCHEDULE s on s.MovieID = m.MovieID
  JOIN tblRESERVATION r on s.ScheduleID = r.ScheduleID
  WHERE YEAR(m.PremiereDate) = '2022'
  GROUP BY pc.CompanyName
  ORDER BY TotalEarning ASC
GO

EXECUTE report_lowest_company_earnings

/* UNRELATED */

/* Select Statements */
/* Feel free to view each tables, and their values */
/* We know it's not part of the assignment, but if you have time to look through database */
/* Here you go! -Team TAK */

SELECT *
FROM tblGENRE

SELECT *
FROM tblACTOR

SELECT *
FROM tblAGERATING 

SELECT *
FROM tblDIRECTOR

SELECT *
FROM tblPRODUCTIONCOMPANY

SELECT *
FROM tblCUSTOMER 

SELECT *
FROM tblSEATTYPE

-- 

SELECT *
FROM tblMOVIE

SELECT *
FROM tblSCHEDULE

SELECT *
FROM tblRESERVATION 

-- 

SELECT *
FROM tblMOVIE_GENRE

SELECT *
FROM tblMOVIE_ACTOR

SELECT *
FROM tblMOVE_DIRECTOR

SELECT *
FROM tblMOVE_PRODUCTIONCOMPANY 