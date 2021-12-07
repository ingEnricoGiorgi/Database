DROP DATABASE IF EXISTS gestione_corsi;
CREATE DATABASE gestione_corsi;
USE gestione_corsi; /*senno docenti non sa dove lo fa*/

CREATE TABLE  docenti (
id INT AUTO_INCREMENT, /* PRIMARY KEY */
nome VARCHAR(20) NOT NULL,
cognome VARCHAR(20) NOT NULL,
codice_fiscale VARCHAR(16),
PRIMARY KEY(id) /*riepilogo finale */
);

CREATE TABLE  materie (
id INT AUTO_INCREMENT, /* PRIMARY KEY */
nome VARCHAR(20) NOT NULL,
anno INT(4),
ore INT(4) NOT NULL,

docente_id INT, /*FOREIGN KEY */
docente_fascia VARCHAR(1),
PRIMARY KEY(id) /*riepilogo finale */
);

CREATE TABLE  alunni (
id INT AUTO_INCREMENT, /* PRIMARY KEY */
nome VARCHAR(20) NOT NULL,
cognome VARCHAR(20) NOT NULL,
anno_di_nascita INT(4), 

PRIMARY KEY(id) /*riepilogo finale */
);

CREATE TABLE frequenze (
id int AUTO_INCREMENT,
alunno_id INT NOT NULL,
materia_id INT NOT NULL,
media DECIMAL(7,2),
ore_assenza INT(3),

PRIMARY KEY(id)
);

INSERT INTO docenti(nome,cognome) VALUES ('Matteo','Arosti'),
('Andrea','Ribuoli'), ('Gabriella', 'Acerbi' );

INSERT INTO materie(nome, ore, docente_id, docente_fascia) VALUES 
('Sistemistica', 16,1,'B'),
('Database', 40,1,'A'),
('Fond. Prog.', 80,2,'A'),
('Tecniche di rel.', 20,3,'A');

INSERT INTO alunni(nome, cognome) VALUES
('Martina', 'Pola'),
('Francesca','Massinesi'),
('Enrico','Giorgi');

INSERT INTO frequenze(alunno_id, materia_id, media, ore_assenza) VALUES
 (1, 1, 7.2, 2),
 (1, 2, 8, 0),
 (2, 1, 7.1, 5),
 (2, 3, 9.1, 0),
 (12, 4, 6, 6.1);


