CREATE TABLE Enseignants (
    enseignant_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom VARCHAR2(50) NOT NULL,
    prenom VARCHAR2(50) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL,
    date_entree DATE NOT NULL
);

CREATE TABLE Etudiants (
    etudiant_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom VARCHAR2(50) NOT NULL,
    prenom VARCHAR2(50) NOT NULL,
    email VARCHAR2(100) UNIQUE NOT NULL
);

CREATE TABLE Promotions (
    promotion_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    annee NUMBER NOT NULL
);

CREATE TABLE Etudiant_Promotion (
    etudiant_id NUMBER NOT NULL,
    promotion_id NUMBER NOT NULL,
    PRIMARY KEY (etudiant_id, promotion_id),
    FOREIGN KEY (etudiant_id) REFERENCES Etudiants(etudiant_id),
    FOREIGN KEY (promotion_id) REFERENCES Promotions(promotion_id)
);

CREATE TABLE Matieres (
    matiere_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nom VARCHAR2(100) NOT NULL
);

CREATE TABLE Enseignant_Matiere (
    enseignant_id NUMBER NOT NULL,
    matiere_id NUMBER NOT NULL,
    PRIMARY KEY (enseignant_id, matiere_id),
    FOREIGN KEY (enseignant_id) REFERENCES Enseignants(enseignant_id),
    FOREIGN KEY (matiere_id) REFERENCES Matieres(matiere_id)
);

CREATE TABLE Notes (
    note_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    etudiant_id NUMBER NOT NULL,
    matiere_id NUMBER NOT NULL,
    enseignant_id NUMBER NOT NULL,
    note NUMBER(5,2) CHECK (note BETWEEN 0 AND 20) NOT NULL,
    date_publication DATE NOT NULL,
    UNIQUE (etudiant_id, matiere_id),
    FOREIGN KEY (etudiant_id) REFERENCES Etudiants(etudiant_id),
    FOREIGN KEY (matiere_id) REFERENCES Matieres(matiere_id),
    FOREIGN KEY (enseignant_id) REFERENCES Enseignants(enseignant_id)
);

CREATE TABLE Absences (
    absence_id NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    etudiant_id NUMBER NOT NULL,
    date_absence DATE NOT NULL,
    minutes_retard NUMBER NOT NULL CHECK (minutes_retard >= 0),
    justifie CHAR(1) CHECK (justifie IN ('O', 'N')) NOT NULL,
    FOREIGN KEY (etudiant_id) REFERENCES Etudiants(etudiant_id)
);

SELECT nom AS last_name, prenom AS first_name FROM Etudiants;

SELECT * FROM Absences WHERE justifie = 'N' AND minutes_retard > 10 ORDER BY minutes_retard DESC;

SELECT n.note, n.date_publication, e.nom AS etudiant_nom, e.prenom AS etudiant_prenom, en.email AS enseignant_email
FROM Notes n
JOIN Etudiants e ON n.etudiant_id = e.etudiant_id
JOIN Enseignants en ON n.enseignant_id = en.enseignant_id
WHERE n.note BETWEEN 15 AND 20 AND EXTRACT(YEAR FROM n.date_publication) = EXTRACT(YEAR FROM SYSDATE);

INSERT INTO Enseignants (nom, prenom, email, date_entree) VALUES ('Dupont', 'Jean', 'jean.dupont@email.com', TO_DATE('2022-09-01', 'YYYY-MM-DD'));
INSERT INTO Etudiants (nom, prenom, email) VALUES ('Martin', 'Sophie', 'sophie.martin@email.com');
INSERT INTO Promotions (annee) VALUES (2025);
INSERT INTO Matieres (nom) VALUES ('Mathématiques');
INSERT INTO Enseignant_Matiere (enseignant_id, matiere_id) VALUES (1, 1);
INSERT INTO Etudiant_Promotion (etudiant_id, promotion_id) VALUES (1, 1);
INSERT INTO Notes (etudiant_id, matiere_id, enseignant_id, note, date_publication) VALUES (1, 1, 1, 17, SYSDATE);
INSERT INTO Absences (etudiant_id, date_absence, minutes_retard, justifie) VALUES (1, TO_DATE('2025-02-15', 'YYYY-MM-DD'), 15, 'N');