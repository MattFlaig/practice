-- Dateneingabe Script für Film Tabelle
INSERT INTO filme 
(
	titel, erscheinungsjahr, regisseur, spieldauer, kurzbeschreibung, kategorie_id, hauptdarsteller, ausgeliehen, regal
)
 VALUES 
(
 	'Mononoke-hime', 1997, 'Hayao Myazaki', 134, 'Das Schicksaal der Welt liegt in den Händen eines einzigen Kriegers.', 1, 'Mononoke-san', 1, '10a'   
),
(
	'Donnie Darko', 2001, 'Richard Kelly', 125, 'Das Leben ist eine lange verrückte Reise. Einige Leute haben einfach einen besseren Orientierungssinn', 2, 'Jake Gyllenhall', 1, '12b'
),
(
	'The Dark Knight', 2008, 'Christopher Nolan', 180, 'Batman, Gordon und Harvey Dent müssen den Joker stoppen, ein Anarchistengenie, der einen Ring der Gewalt über die Stadt legt.', 3, 'Heath Ledger', 1, '21f'
),
(
	'The Prestige', 2006, 'Christopher Nolan', 125, 'Robert und Alfred sind Magierrivalen. Als Alfred den ultimativen Trick zeigt, versucht Robert verzweifelt das Geheimnis herauszufinden.', 2, 'Hugh Jackman', 0, '12b'
),
(
	'Star Trek', 2009, 'J.J.Abrahams', 127, 'Die Zukunft beginnt', 4, 'Chris Pine', 0, '8d'
),
(
	'District 9', 2009, 'Neil Blomkamp', 153, 'Eine auserirdische Rasse ist gezwungen auf der Erde in Slums zu leben...', 4, 'Sharlto Copley', 0, '8d'
);