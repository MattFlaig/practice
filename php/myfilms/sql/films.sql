CREATE TABLE directors
(
	director_id INTEGER PRIMARY KEY AUTO_INCREMENT,
	director_name VARCHAR(90) NOT NULL
);

CREATE TABLE actors
(
	actor_id INTEGER PRIMARY KEY AUTO_INCREMENT,
	actor_name VARCHAR(90) NOT NULL
);

CREATE TABLE categories
(
	category_id INTEGER PRIMARY KEY AUTO_INCREMENT,
	category_name VARCHAR(80) NOT NULL
);

CREATE TABLE films
(   
	film_id INTEGER PRIMARY KEY AUTO_INCREMENT, 
	title VARCHAR(90) NOT NULL, 
	release_date INTEGER(4) NOT NULL, 
	duration INTEGER(3) NOT NULL,
	description VARCHAR(500) NOT NULL,
	director_id INTEGER NOT NULL,
	FOREIGN KEY (director_id) REFERENCES directors (director_id)
);

CREATE TABLE actors_films
(
	actor_id INTEGER NOT NULL,
	film_id INTEGER NOT NULL,
	FOREIGN KEY (actor_id) REFERENCES actors (actor_id),
	FOREIGN KEY (film_id) REFERENCES films (film_id),
	PRIMARY KEY (actor_id, film_id)
);


CREATE TABLE categories_films
(
	category_id INTEGER NOT NULL,
	film_id INTEGER NOT NULL,
	FOREIGN KEY (category_id) REFERENCES categories (category_id),
	FOREIGN KEY (film_id) REFERENCES films (film_id),
	PRIMARY KEY (category_id, film_id) 
);




START TRANSACTION;



INSERT INTO actors(actor_name)VALUES('Mononoke-san'),('Jake Gyllenhall'),('Heath Ledger'),('Hugh Jackman'),('Chris Pine'),('Sharlto Copley'),('Jena Malone'),('Drew Barrymore'),('Christian Bale'),('Gary Oldman'),('Zachary Quinto');

INSERT INTO directors(director_name)VALUES('Hayao Myazaki'),('Richard Kelly'),('Christopher Nolan'),('J.J.Abrahams'),('Neil Blomkamp'),('Dan Gilroy'),('Ang Lee');

INSERT INTO categories(category_name)VALUES('Anime'),('Fantasy'),('Drama'),('Thriller'),('Science Fiction');


INSERT INTO films
(
	title, release_date, duration, description, director_id
)
 VALUES 
(
 	'Mononoke-hime', 1997, 134, 'Das Schicksaal der Welt liegt in den Händen eines einzigen Kriegers.', 1   
),
(
	'Donnie Darko', 2001, 125, 'Das Leben ist eine lange verrückte Reise. Einige Leute haben einfach einen besseren Orientierungssinn', 2
),
(
	'The Dark Knight', 2008, 180, 'Batman, Gordon und Harvey Dent müssen den Joker stoppen, ein Anarchistengenie, der einen Ring der Gewalt über die Stadt legt.', 3
),
(
	'The Prestige', 2006, 125, 'Robert und Alfred sind Magierrivalen. Als Alfred den ultimativen Trick zeigt, versucht Robert verzweifelt das Geheimnis herauszufinden.', 3
),
(
	'Star Trek', 2009, 127, 'Die Zukunft beginnt', 4
),
(
	'District 9', 2009, 153, 'Eine ausserirdische Rasse ist gezwungen auf der Erde in Slums zu leben...', 5
),
(
	'Night Crawler', 2014, 135, 'Ein Mann, der sich in Los Angeles als freier Journalist auf die Suche nach sensationellen Bildern von Unfällen und Verbrechen macht', 6
),
(
	'Brokeback Mountain', 2005, 133, 'Der Film erzählt den Verlauf einer homosexuellen Liebesbeziehung zweier Cowboys', 7
);



INSERT INTO actors_films(actor_id, film_id)VALUES(1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(2,7),(2,8),(3,8),(7,2),(8,2),(9,3),(10,3),(9,4),(11,5);

INSERT INTO categories_films(category_id, film_id)VALUES(1,1),(2,2),(2,3),(2,4),(3,2),(3,4),(4,3),(4,4),(5,5),(5,6),(3,7),(4,7),(3,8);



COMMIT;




