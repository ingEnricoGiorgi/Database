SELECT * FROM docenti;
SELECT * FROM materie;

SELECT * FROM materie
JOIN docenti ON materie.docenti_id = docenti.id;

SELECT materie.*, docenti.cognome FROM materie
JOIN docenti ON materie.docenti_id = docenti.id;

SELECT materie.*, docenti.cognome FROM materie
JOIN docenti ON materie.docenti_id = docenti.id;

SELECT frequenze.*, alunni.nome, alunni.cognome, materie.nome 
FROM frequenze
JOIN alunni ON frequenze.alunno_id = alunni.id
JOIN  materie ON frequenze.materia_id = materie.id
JOIN  docenti ON materie.docenti_id = docenti.id
ORDER BY frequenze.media;

SELECT *
FROM frequenze
LEFT OUTER JOIN alunni on frequenze.alunno_id = alunni.id;

//se non trovi decodifica la parte che non trovo è NULL su alunni
SELECT *
FROM docenti
WHERE nome='Matteo' AND cognome='Arosti';

/* AND OR */
SELECT *
FROM frequenze
LEFT OUTER JOIN alunni on frequenze.alunno_id = alunni.id
WHERE alunni.id = 1 AND alunnni.nome='Martina'
OR alunni.nome='francesca';

SELECT frequenze.*, alunni.nome, alunni.cognome, materie.nome 
FROM frequenze
JOIN alunni ON frequenze.alunno_id = alunni.id
JOIN  materie ON frequenze.materia_id = materie.id
JOIN  docenti ON materie.docenti_id = docenti.id
WHERE frequenza.media > 7.5 AND materie.nome='Sistemistica'
AND docenti.id < 50;

/*diverso <> */

/*lista studenti senza frequenza */
SELECT *
FROM frequenze
RIGHT OUTER JOIN alunni ON frequenze.alunno_id = alunni.id
WHERE frequenze.id IS NULL;

solo i nome e cognome di fascia A docenti con relative materie

 SELECT DISTINCT docenti.*, docenti_fascia 
 FROM docenti INNER JOIN materie 
 ON docenti.id = materie.docenti_id
 WHERE materie.docenti_fascia= 'B';

1)tutte le materie ordinate per  anno numero ore desc, nome
2)docenti che insegnano materie 1 e 2 anno
3)docenti che insegnao materie > 30 ore
4)alunni che frequentano materie con ore > 30
 
SELECT  anno, nome, ore
FROM materie
ORDER BY  ore DESC;

SELECT docenti.*, materie.*
FROM docenti JOIN materie
ON docenti.id = materie.docenti_id
WHERE materie.anno=1 OR materie.anno=2;

SELECT docenti.*, ore
FROM docenti JOIN materie
ON docenti.id = materie.docenti_id
WHERE ore > 30;

SELECT alunni.*, ore
FROM alunni
JOIN frequenze ON alunni.id = frequenze.alunno_id
JOIN materie ON frequenze.materia_id  = materie.id
WHERE ore > 30;

