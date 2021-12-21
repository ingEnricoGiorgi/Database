SELECT * FROM docenti;
SELECT * FROM materie;

SELECT materie.nome, materie.ore, docenti.cognome, docenti.nome
    FROM docenti 
    JOIN materie ON materie.docente_id = docenti.id;

    
SELECT materie.*, docenti.cognome
    FROM materie 
    JOIN docenti ON docente_id = docenti.id;


SELECT alunni.cognome, alunni.nome, materie.nome, docenti.cognome, frequenze.media, frequenze.ore_assenza
FROM frequenze
JOIN alunni  ON frequenze.alunno_id = alunni.id
JOIN materie ON frequenze.materia_id = materie.id
JOIN docenti ON materie.docente_id = docenti.id
/* WHERE */
ORDER BY frequenze.id DESC, docenti.cognome ASC;


/* LEFT OUTER JOIN - RIGHT OUTER JOIN */
SELECT *
FROM frequenze /* INNER */ JOIN alunni ON frequenze.alunno_id = alunni.id;

SELECT *
FROM frequenze LEFT OUTER JOIN alunni ON frequenze.alunno_id = alunni.id;

SELECT *
FROM frequenze RIGHT OUTER JOIN alunni ON frequenze.alunno_id = alunni.id;


/* WHERE */
SELECT *
FROM docenti
WHERE nome = 'Matteo' AND cognome = 'Arosti';


SELECT *
FROM docenti
WHERE nome = 'Matteo' AND cognome = 'Ribuoli';


SELECT *
FROM docenti
WHERE nome = 'Matteo' OR cognome = 'Ribuoli';

SELECT *
FROM frequenze 
    LEFT OUTER JOIN alunni ON frequenze.alunno_id = alunni.id
WHERE alunni.id = 1 AND (alunni.nome = 'Martina' OR alunni.nome = 'Francesca');

SELECT *
FROM frequenze 
    LEFT OUTER JOIN alunni ON frequenze.alunno_id = alunni.id
WHERE alunni.id = 1 AND alunni.nome = 'Martina' OR alunni.nome = 'Francesca';



SELECT <nome campi>
FROM   <tabella> EVENTUALI VARI JOIN
WHERE  <condizioni>
GROUP BY <nomi campi>
HAVING <condizioni su conteggi group by >
ORDER BY <campi ordinamento>
LIMIT 100 OFFSET 300





SELECT alunni.cognome, alunni.nome, materie.nome, docenti.cognome, frequenze.media, frequenze.ore_assenza
FROM frequenze
JOIN alunni  ON frequenze.alunno_id = alunni.id
JOIN materie ON frequenze.materia_id = materie.id
JOIN docenti ON materie.docente_id = docenti.id
WHERE frequenze.media > 7.5 AND materie.nome = 'Sistemistica' AND docenti.id < 50;

=   -> uguale
<>  -> diverso da
>   -> maggiore di
>=  -> maggiore o uguale di
<   -> minore di
<=  -> minore o uguale di
IS NULL     (WHERE docenti.id IS NULL)
IS NOT NULL
IN  es: IN(2, 3)    oppure IN('Matteo', 'Andrea')
NOT IN (2, 3)       oppure NOT IN('Matteo', 'Andrea')
prezzo >= 50 AND prezzo <= 100
LIKE



/* lista frequenze con anomalia su legame alunno (id alunno non trovato in alunni) */
SELECT *
FROM frequenze
LEFT OUTER JOIN alunni ON frequenze.alunno_id = alunni.id
WHERE alunni.id IS NULL;


/* lista degli alunni che NON frequentano nessuna materia */
SELECT *
FROM frequenze RIGHT OUTER JOIN alunni ON frequenze.alunno_id = alunni.id
WHERE frequenze.id IS NULL;


select materie.nome, docenti.nome, docenti.cognome, materie.docente_fascia
FROM materie
JOIN docenti ON materie.docente_id = docenti.id
WHERE materie.docente_fascia = 'A';


/* FUNZIONE DISTINCT per mostrare una volta solo i record duplicati nel risultato */
SELECT DISTINCT docenti.nome, docenti.cognome
FROM materie
JOIN docenti ON materie.docente_id = docenti.id
WHERE materie.docente_fascia = 'B';



1) tutte le materie ordinate per anno, numero ore (descendente), nome
2) tutti i docenti che insegnano materie del 1° e 2° anno
3) tutti i docenti che insegnano materie con più di 30 ore
4) tutti gli alunni che frequentano materie con più di 30 ore
5) tutti gli alunni che frequentano una materia di Arosti

    alunni (select nome, cognome)
    frequenze
    materie
    docenti (WHERE cognome='Arosti')

    SELECT DISTINCT alunni.id, alunni.cognome, alunni.nome
    FROM alunni
    JOIN frequenze ON frequenze.alunno_id = alunni.id
    JOIN materie   ON frequenze.materia_id = materie.id
    JOIN docenti   ON materie.docente_id = docenti.id
    WHERE docenti.cognome = 'Arosti';




1)  select * from materie 
    order by anno, materie.ore DESC, materie.nome;

2)  SELECT DISTINCT docenti.id, docenti.nome, cognome
    FROM docenti
    JOIN materie ON materie.docente_id = docenti.id
    /* WHERE materie.anno = 1 OR materie.anno = 2 */
    WHERE anno IN(1, 2);

3)  SELECT DISTINCT docenti.cognome, docenti.nome
    FROM docenti
    JOIN materie ON materie.docente_id = docenti.id
    WHERE materie.ore > 30;

4)  SELECT DISTINCT alunni.cognome, alunni.nome
    FROM alunni
    JOIN frequenze ON alunni.id = frequenze.alunno_id
    JOIN materie   ON frequenze.materia_id = materie.id
    WHERE materie.ore > 30;

    SELECT *
    FROM alunni
    JOIN frequenze 
        ON alunni.id = frequenze.alunno_id
       AND alunni.pippo = frequenze.ciao
    



/* ESEMPI GROUP BY */
SELECT *
FROM materie JOIN docenti ON materie.docente_id = docenti.id;

SELECT docenti.id, docenti.cognome, docenti.nome, 
    COUNT(*), SUM(materie.ore), AVG(materie.ore)
FROM materie JOIN docenti ON materie.docente_id = docenti.id
GROUP BY docenti.id, docenti.cognome, docenti.nome;


/* Elenco degli alunni, conteggio materie frequentate, e media della loro media */
SELECT alunni.cognome AS pippo, 
    alunni.nome, 
    count(*) AS num_freq, 
    AVG(frequenze.media) AS media, 
    SUM(ore_assenza) AS tot_ore_ass,
    MAX(ore_assenza) AS ore_ass_max_per_mat,
    MIN(ore_assenza) AS ore_ass_mini_per_mat
FROM alunni
JOIN frequenze ON frequenze.alunno_id = alunni.id
WHERE frequenze.ore_assenza > 0 /* filtra in origine i dati partendo dai record */
GROUP BY alunni.id, alunni.nome, alunni.cognome
HAVING COUNT(*) > 1             /* filtra i dati partendo dai dati di group by */
ORDER BY AVG(frequenze.media) DESC;


CLIENTE A ---- > 55.000€
CLIENTE B ---- > 38.000€

having sum(importo_ordine) > 50.000


UPDATE clienti
SET stato = 'CLOSE', provincia = 'PU'
WHERE id = 3;

DELETE FROM clienti
WHERE nazione = 'ITALIA' AND ....;


SELECT count(*) FROM clienti
WHERE id = 3;


SELECT * 
FROM clienti 
WHERE ragione_sociale LIKE '%Aro%sti%';

SELECT *
FROM clienti
WHERE ragione_sociale LIKE 'A_osti%';
                            Arrosti
                            Agostini

                     LIKE '%Arosti%'


SELECT *
FROM clienti WHERE provincia IN ('PU', 'AN');


Tab ordini: cliente_id
Cliente: di una provincia

SELECT *
from ordini JOIN clienti ON .....
WHERE clienti.provincia IN ('PU', 'AN');

// SUBQUERY, o SOTTOQUERY
SELECT *
FROM ordini
WHERE cliente_id IN (
    SELECT id FROM clienti 
    WHERE provincia IN ('PU', 'AN')
);

SELECT *
FROM ordini
WHERE cliente_id IN (1, 45, 66, 89);

SELECT d.nome AS nome_docente, m.nome, pippo.nome
FROM docenti d
JOIN materie m ON ....
JOIN (
    SELECT * FROM .....
) pippo ON d.docente_id = pippo.docente_id
ORDER BY m.nome


INSERT INTO clienti(nome, cognome) VALUES('Matteo', 'Arosti'), ('Pinco', 'Pallino');

INSERT INTO clienti(nome, cognome, codice_fiscale) VALUES (
    SELECT nome, cognome, fff FROM clienti_di_appoggio
);


SHOW INDEXES FROM docenti;
ALTER TABLE `docenti`
	ADD UNIQUE INDEX `idx_cognone_nome` (`cognome`, 'nome');

ALTER TABLE docenti ADD INDEX idx_cognome (cognome);    

ALTER TABLE docenti
	ADD INDEX cognome_nome (cognome, nome);


CREATE VIEW materie_docenti AS (
    select materie.nome AS materie_nome, docenti.nome AS docenti_nome 
    from materie JOIN docenti on materie.docente_id = docenti.id
    WHERE 1=1
) ;



INSERT INTO materie(nome, ore, docente_id, docente_fascia) VALUES
    ('Magento', 160, 3, 'A');



START TRANSACTION;  // -> Attiva una transazione
...
...
COMMIT;     // -> Conferma tutte le operazione
ROLLBACK;   // -> Annulla tutte le operazioni e ripristina allo precedente
