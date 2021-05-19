CREATE DATABASE CSC315Final2021;
USE CSC315Final2021;

CREATE TABLE Genre (
	gid INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	gname CHAR(20) NOT NULL
);

INSERT INTO Genre (gname) VALUES ('Rock'), ('Jazz'), ('Country'), ('Classical'), ('Throat Singing');

CREATE TABLE Sub_Genre (
	sgid INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	gname CHAR(20) NOT NULL,
	sgname CHAR(20) NOT NULL
);

INSERT INTO Sub_Genre (gname, sgname) VALUES ('Rock', 'Blues'), ('Rock', 'Classic Rock'), ('Rock', 'Power Metal'), ('Rock', 'Thrash Metal'), ('Rock', 'Death Metal'), ('Rock', 'Folk Metal');
INSERT INTO Sub_Genre (gname, sgname) VALUES ('Jazz', 'Swing'), ('Jazz', 'Smooth Jazz'), ('Jazz', 'Bossa Nova'), ('Jazz', 'Ragtime');
INSERT INTO Sub_Genre (gname, sgname) VALUES ('Country', 'Bluegrass'), ('Country', 'Country and Western'), ('Country', 'Jug Band');
INSERT INTO Sub_Genre (gname, sgname) VALUES ('Classical', 'Chamber Music'), ('Classical', 'Opera'), ('Classical', 'Orchestral');
INSERT INTO Sub_Genre (gname, sgname) VALUES ('Throat Singing', 'Khoomii'), ('Throat Singing', 'Kargyraa'), ('Throat Singing', 'Khamryn');

CREATE TABLE Region (
	rid INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	rname CHAR(20) NOT NULL
);

INSERT INTO Region (rname) VALUES ('Central Asia'), ('Europe'), ('North Americ'), ('South America');

CREATE TABLE Country (
	rid INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	rname CHAR(20) NOT NULL,
	cname CHAR(20) NOT NULL
);

INSERT INTO Country (rname, cname) VALUES ('Central Asia', 'Mongolia'), ('Central Asia', 'Tibet'), ('Central Asia', 'Tuva');
INSERT INTO Country (rname, cname) VALUES ('North Americ', 'Canada'), ('North Americ', 'United States'), ('North Americ', 'Mexico');
INSERT INTO Country (rname, cname) VALUES ('South Americ', 'Brazil');
INSERT INTO Country (rname, cname) VALUES ('Europe', 'Norway'), ('Europe', 'Austria'), ('Europe', 'England'), ('Europe', 'Russia');

CREATE TABLE Bands (
	bid INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	bname CHAR(20) NOT NULL
);

INSERT INTO Bands (bname) VALUES ('Seputura'), ('Death'), ('Muddy Waters'), ('Led Zeppelin'), ('The Guess Who');
INSERT INTO Bands (bname) VALUES ('The Hu'), ('Huun-Huur-Tu'), ('Paul Pena'), ('Battuvshin'), ('Sade');
INSERT INTO Bands (bname) VALUES ('Mozart'), ('Tchaikovsky'), ('Twisted Sister'), ('Testament'), ('Tengger Cavalry');

CREATE TABLE Band_Origins (
	boid INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	bname CHAR(20) NOT NULL,
	cname CHAR(20) NOT NULL
);

INSERT INTO Band_Origins (bname, cname) VALUES ('Seputura', 'Brazil');
INSERT INTO Band_Origins (bname, cname) VALUES ('Death', 'United States');
INSERT INTO Band_Origins (bname, cname) VALUES ('Muddy Waters', 'United States');
INSERT INTO Band_Origins (bname, cname) VALUES ('Led Zeppelin', 'England');
INSERT INTO Band_Origins (bname, cname) VALUES ('The Guess Who', 'Canada');
INSERT INTO Band_Origins (bname, cname) VALUES ('The Hu', 'Mongolia');
INSERT INTO Band_Origins (bname, cname) VALUES ('Huun-Huur-Tu', 'Tuva');
INSERT INTO Band_Origins (bname, cname) VALUES ('Paul Pena', 'United States');
INSERT INTO Band_Origins (bname, cname) VALUES ('Battuvshin', 'Mongolia');
INSERT INTO Band_Origins (bname, cname) VALUES ('Sade', 'England');
INSERT INTO Band_Origins (bname, cname) VALUES ('Mozart', 'Austria');
INSERT INTO Band_Origins (bname, cname) VALUES ('Tchaikovsky', 'Russia');
INSERT INTO Band_Origins (bname, cname) VALUES ('Twisted Sister', 'United States');
INSERT INTO Band_Origins (bname, cname) VALUES ('Testament', 'United States');
INSERT INTO Band_Origins (bname, cname) VALUES ('Tengger Cavalry', 'United States');

CREATE TABLE Band_Styles (
	boid INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
	bname CHAR(20) NOT NULL,
	sgname CHAR(20) NOT NULL
);

INSERT INTO Band_Styles (bname, sgname) VALUES ('Seputura', 'Death Metal');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Seputura', 'Thrash Metal');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Death', 'Death Metal');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Muddy Waters', 'Blues');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Led Zeppelin', 'Classic Rock');
INSERT INTO Band_Styles (bname, sgname) VALUES ('The Guess Who', 'Classic Rock');
INSERT INTO Band_Styles (bname, sgname) VALUES ('The Hu', 'Folk Metal');
INSERT INTO Band_Styles (bname, sgname) VALUES ('The Hu', 'Khoomii');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Huun-Huur-Tu', 'Khoomii');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Huun-Huur-Tu', 'Kargyraa');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Paul Pena', 'Blues');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Paul Pena', 'Kargyraa');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Battuvshin', 'Khoomii');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Battuvshin', 'Smooth Jazz');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Sade', 'Smooth Jazz');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Mozart', 'Opera');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Tchaikovsky', 'Opera');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Tchaikovsky', 'Orchestral');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Twisted Sister', 'Thrash Metal');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Testament', 'Thrash Metal');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Tengger Cavalry', 'Folk Metal');
INSERT INTO Band_Styles (bname, sgname) VALUES ('Tengger Cavalry', 'Khoomii');

CREATE TABLE `User`(
	uid INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    	name CHAR(100) NOT NULL,
    	home_country CHAR(100) NOT NULL
);

INSERT INTO `User` (uid, name, home_country) VALUES (1, 'Harry Chen', 'United States');
INSERT INTO `User` (uid, name, home_country) VALUES (2, 'James Cameron', 'United States');
INSERT INTO `User` (uid, name, home_country) VALUES (3, 'Lisa Monet', 'United States');
INSERT INTO `User` (uid, name, home_country) VALUES (4, 'Michelle Kyles', 'United States');
INSERT INTO `User` (uid, name, home_country) VALUES (5, 'Jason Tabs', 'United States');

CREATE TABLE Favorites (
	uid INT NOT NULL,
    	band_id INT NOT NULL,
    	FOREIGN KEY (uid) REFERENCES `User`(uid),
    	FOREIGN KEY (band_id) REFERENCES Bands(bid)
);

INSERT INTO Favorites (uid, band_id) VALUES (1, 1);
INSERT INTO Favorites (uid, band_id) VALUES (1, 2);
INSERT INTO Favorites (uid, band_id) VALUES (1, 3);
INSERT INTO Favorites (uid, band_id) VALUES (2, 2);
INSERT INTO Favorites (uid, band_id) VALUES (2, 4);
INSERT INTO Favorites (uid, band_id) VALUES (2, 6);
INSERT INTO Favorites (uid, band_id) VALUES (3, 1);
INSERT INTO Favorites (uid, band_id) VALUES (3, 10);
INSERT INTO Favorites (uid, band_id) VALUES (4, 7);
INSERT INTO Favorites (uid, band_id) VALUES (4, 9);
INSERT INTO Favorites (uid, band_id) VALUES (4, 8);
INSERT INTO Favorites (uid, band_id) VALUES (4, 12);

CREATE USER 'api'@'localhost' IDENTIFIED WITH caching_sha2_password BY 'musicapipassword';
GRANT SELECT ON CSC315Final2021.* TO 'api'@'localhost';
GRANT SELECT, INSERT, UPDATE ON CSC315Final2021.User TO 'api'@'localhost';
GRANT SELECT, INSERT, UPDATE ON CSC315Final2021.Favorites TO 'api'@'localhost';

-- Indexes
CREATE UNIQUE INDEX user_id USING HASH ON `User` (uid);
CREATE INDEX band_name_sub_genre USING HASH ON Band_Styles (sgname);
CREATE INDEX sub_genre_name USING HASH ON Sub_Genre (sgname);
CREATE INDEX genre_gname USING HASH ON Genre (gname);
CREATE INDEX band_origin_bname USING HASH ON Band_Origins (bname);
CREATE INDEX country_cname USING HASH ON Country (cname);
CREATE INDEX band_bname USING HASH ON Bands (bname);
CREATE INDEX region_rname USING HASH ON Region (rname);

-- Create a query to determine which sub_genres come from which regions.
SELECT DISTINCT sg.sgname AS 'Sub Genres', r.rname AS 'Region'
FROM Sub_Genre sg 
JOIN Band_Styles bs ON bs.sgname = sg.sgname
JOIN Bands b ON b.bname = bs.bname 
JOIN Band_Origins bo ON bo.bname = b.bname
JOIN Country c ON c.cname = bo.cname
JOIN Region r ON r.rname = c.rname;

-- Create a query to determine what other bands, not currently in their favorites, are of the same sub_genres as those which are.
SELECT DISTINCT b.bname AS 'Band'
FROM Bands b
JOIN Band_Styles bs ON bs.bname = b.bname
WHERE b.bname NOT IN (
	SELECT b.bname
	FROM `User` u 
	JOIN Favorites f ON u.uid = f.uid 
	JOIN Bands b ON b.bid = f.band_id
	WHERE u.uid = 1
) AND bs.sgname IN (
	SELECT bs.sgname
	FROM `User` u
	JOIN Favorites f ON u.uid = f.uid 
	JOIN Bands b ON b.bid = f.band_id
    JOIN Band_Styles bs ON bs.bname = b.bname
	WHERE u.uid = 1
); 

--  Create a query to determine what other bands, not currently in their favorites, are of the same genres as those which are.
SELECT b.bname AS 'Band'
FROM Bands b 
JOIN Band_Styles bs ON bs.bname = b.bname
JOIN Sub_Genre sg ON sg.sgname = bs.sgname
JOIN Genre g ON g.gname = sg.gname 
WHERE b.bname NOT IN (
	SELECT b.bname
	FROM `User` u 
	JOIN Favorites f ON u.uid = f.uid 
	JOIN Bands b ON b.bid = f.band_id
	WHERE u.uid = 1
) AND g.gname IN (
	SELECT g.gname
	FROM `User` u
	JOIN Favorites f ON u.uid = f.uid 
	JOIN Bands b ON b.bid = f.band_id
	JOIN Band_Styles bs ON bs.bname = b.bname
	JOIN Sub_Genre sg ON sg.sgname = bs.sgname
	JOIN Genre g ON g.gname = sg.gname 
	WHERE u.uid = 1
);

-- Create a query which finds other users who have the same band in their favorites, and list their other favorite bands.
SELECT DISTINCT b.bname AS 'Band', u.uid AS 'User Id'
FROM Bands b
JOIN Favorites f ON f.band_id = b.bid
JOIN `User` u ON u.uid = f.uid
WHERE u.uid IN (
	-- get all users that share a favorite band with user 1
	SELECT u.uid
	FROM `User` u2 
	JOIN Favorites f2 ON f2.uid = u2.uid
	JOIN Bands b2 ON b2.bid = f2.band_id
	WHERE u2.uid != 1 AND b2.bname IN (
		SELECT b2.bname 
		FROM `User` u3
		JOIN Favorites f3 ON f3.uid = u3.uid
		JOIN Bands b3 ON b3.bid = f3.band_id
		WHERE u3.uid = 1
	)
)  AND b.bname NOT IN (
	SELECT b4.bname
	FROM `User` u4
	JOIN Favorites f4 ON f4.uid = u4.uid
	JOIN Bands b4 ON b4.bid = f4.band_id
	WHERE u4.uid = 1
);

--  Create a query to list other countries, excluding the user’s home country, where they could travel to where they could hear the same genres as the bands in their favorites.
-- gets user 1's favorite genres
SELECT DISTINCT c.cname
FROM `User` u, Country c 
JOIN Band_Origins bo ON bo.cname = c.cname
JOIN Bands b ON b.bname = bo.bname
JOIN Band_Styles bs ON bs.bname = b.bname
JOIN Sub_Genre sg ON sg.sgname = bs.sgname
JOIN Genre g ON g.gname = sg.gname
WHERE u.uid = 1 
AND c.cname != u.home_country
AND g.gname IN (
	SELECT g2.gname
	FROM `User` u2 
	JOIN Favorites f ON f.uid = u2.uid
	JOIN Bands b2 ON b2.bid = f.band_id
	JOIN Band_Styles bs2 ON bs2.bname = b2.bname
	JOIN Sub_Genre sg2 ON sg2.sgname = bs2.sgname 
	JOIN Genre g2 ON g2.gname = sg2.gname
	WHERE u2.uid = 1
);

-- cleanup
-- DROP TABLE Band_Styles;
-- DROP TABLE Band_Origins;
-- DROP TABLE Bands;
-- DROP TABLE Country;
-- DROP TABLE Region;
-- DROP TABLE Sub_Genre;
-- DROP TABLE Genre;
-- DROP TABLE `User`;
-- DROP DATABASE CSC315Final2021;
