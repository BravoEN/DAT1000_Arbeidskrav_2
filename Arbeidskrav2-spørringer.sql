USE dogstore;

-- Må ta bilder på nytt
SELECT *
FROM Hund;

SELECT Etternavn,Fornavn,Mobilnr
FROM Kunde
ORDER BY Etternavn;

SELECT *
FROM Hund
WHERE Startdato>'2022-01-01';

SELECT COUNT(*) AS AntallKunder
FROM Kunde;

SELECT *
FROM Utleie;

SELECT Etternavn,Fornavn,Mobilnr, COUNT(Utleie.HundeID) AS Leieforhold
FROM Kunde,Utleie,Hund
WHERE Utleie.HundeID=Hund.HundeID
	AND Hund.Eier=Kunde.Mobilnr
GROUP BY Etternavn,Fornavn,Mobilnr;

SELECT Etternavn,Fornavn,Mobilnr, COUNT(Utleie.HundeID) AS Leieforhold
FROM Hund JOIN Kunde LEFT OUTER JOIN Utleie
	ON Utleie.HundeID=Hund.HundeID
	AND Hund.Eier=Kunde.Mobilnr
GROUP BY Etternavn,Fornavn,Mobilnr;

SELECT Etternavn,Fornavn,Mobilnr, COUNT(Utleie.HundeID) AS Leieforhold
FROM Hund JOIN Kunde LEFT OUTER JOIN Utleie
	ON Utleie.HundeID=Hund.HundeID
	AND Hund.Eier=Kunde.Mobilnr
GROUP BY Etternavn,Fornavn,Mobilnr
HAVING Leieforhold='0';

SELECT Boks.BoksID, COUNT(Utleie.BoksID) AS LeidBoks
FROM Boks LEFT OUTER JOIN Utleie
	ON Utleie.BoksID=Boks.BoksID
GROUP BY Boks.BoksID
HAVING LeidBoks='0';

-- DET UNDER ER IKKE I WORD
INSERT INTO Kunde VALUES('11111111','Tore','Hundemann','1111222233334444');

DROP VIEW IF EXISTS LedigeBokser;
CREATE VIEW LedigeBokser AS
(
SELECT Boks.BoksID,SenterID
FROM Boks,Utleie
WHERE
	(SELECT Sluttidspkt FROM Utleie
    WHERE Sluttidspkt IS NULL)
GROUP BY Boks.BoksID,SenterID
);

SELECT *
FROM LedigeBokser