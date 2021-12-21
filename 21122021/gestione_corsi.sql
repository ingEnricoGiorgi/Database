DROP DATABASE IF EXISTS gestione_corsi;
CREATE DATABASE gestione_corsi;
USE gestione_corsi;

CREATE TABLE docenti (
    id INT AUTO_INCREMENT /* PRIMARY KEY */,  
    nome VARCHAR(20) NOT NULL,
    cognome VARCHAR(20) NOT NULL,
    codice_fiscale VARCHAR(16),

    PRIMARY KEY(id)
);

CREATE TABLE materie (
    id INT AUTO_INCREMENT /* PRIMARY KEY */,
    nome VARCHAR(20) NOT NULL,
    anno INT(4),
    ore  INT(3) NOT NULL,

    /* LEGAME CON DOCENTE */
    docente_id INT  /* specifiche FOREIGN KEY */,
    docente_fascia VARCHAR(1),

    PRIMARY KEY (id),
    FOREIGN KEY (docente_id) REFERENCES docenti(id) -- FORMA BASE MINIMALE
                ON DELETE CASCADE  /* SET NULL */ /* RESTRICT */ /* SET DEFAULT */
                ON UPDATE SET NULL
);

CREATE TABLE alunni (
    id INT AUTO_INCREMENT /* PRIMARY KEY */,  
    nome VARCHAR(20) NOT NULL,
    cognome VARCHAR(20) NOT NULL,
    anno_nascita INT(4),

    PRIMARY KEY(id)
);

CREATE TABLE frequenze (
    id INT AUTO_INCREMENT,
    alunno_id INT NOT NULL,
    materia_id INT NOT NULL,
    media DECIMAL(7,2),
    ore_assenza INT(3),

    PRIMARY KEY(id),
    FOREIGN KEY (alunno_id) REFERENCES alunni(id),
    FOREIGN KEY (materia_id) REFERENCES materie(id) ON DELETE CASCADE
);

/* INSERT DATI DI ESEMPIO */
INSERT INTO docenti(nome, cognome) VALUES
    ('Matteo', 'Arosti'), ('Andrea', 'Ribuoli'), ('Gabriella', 'Acerbi');
INSERT INTO materie(nome, ore, docente_id, docente_fascia, anno) VALUES
    ('Sistemistica', 16, 1, 'B', 1),
    ('Database', 40, 1, 'B', 1),
    ('Fond. Prog.', 80, 2, 'A', 2),
    ('Tecniche di rel.', 20, 3, 'A', NULL);
INSERT INTO alunni(nome, cognome) VALUES
    ('Martina', 'Pola'),
    ('Francesca', 'Massalini'),
    ('Enrico', 'Giorgi');
INSERT INTO frequenze(alunno_id, materia_id, media, ore_assenza) VALUES
    (1, 1, 7.2, 2),
    (1, 2, 8, 0),
    (2, 1, 7.1, 5),
    (2, 3, 9.1, 0),
    (1, 4, 6.1, 1);
