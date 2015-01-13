CREATE TABLE filme
(   -- Primärschlüssel
	film_id INTEGER PRIMARY KEY AUTO_INCREMENT, 
	titel VARCHAR(90), 
	erscheinungsjahr INTEGER(4), 
	regisseur VARCHAR(90),
	spieldauer INTEGER(3),
	kurzbeschreibung VARCHAR(500),
	-- Fremdschlüssel
	kategorie_id INTEGER,
	hauptdarsteller VARCHAR(90),
	-- Spalte, um Verfügbarkeit zu überprüfen
	ausgeliehen BOOLEAN,
	regal VARCHAR(20)
);

CREATE TABLE kunden
(
	kunden_id INTEGER PRIMARY KEY AUTO_INCREMENT, 
	name VARCHAR(50), 
	vorname VARCHAR(50), 
	strasse VARCHAR(80),
	hausnr VARCHAR(10),
	stadt VARCHAR(80),
	plz VARCHAR(5),
	tel VARCHAR(30),
	email VARCHAR(50),
	username VARCHAR(50),
	passwort VARCHAR(80)
);

CREATE TABLE leihen
(
	ausleihe_id INTEGER PRIMARY KEY AUTO_INCREMENT,
	ausleihdatum DATE,
	-- Fremdschlüssel Filme
	film_id INTEGER,
	-- Fremdschlüssel Kunden
	kunden_id INTEGER
);

CREATE TABLE kategorien
(
	kategorie_id INTEGER PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(80)
);