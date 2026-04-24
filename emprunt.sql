CREATE DATABASE gestion_emprunt;
USE gestion_emprunt;

-- =========================
-- TABLE USER (ADMIN)
-- =========================
CREATE TABLE user (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(150) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    is_admin BOOLEAN DEFAULT TRUE,
    is_active BOOLEAN DEFAULT TRUE
);

-- =========================
-- TABLE ETUDIANT
-- =========================
CREATE TABLE etudiant (
    id INT AUTO_INCREMENT PRIMARY KEY,
    numero_etudiant VARCHAR(50) UNIQUE NOT NULL,
    nom VARCHAR(100) NOT NULL
);

-- =========================
-- TABLE OBJET
-- =========================
CREATE TABLE objet (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(100) NOT NULL,
    quantite_totale INT NOT NULL DEFAULT 1
);

-- =========================
-- TABLE EMPRUNT
-- =========================
CREATE TABLE emprunt (
    id INT AUTO_INCREMENT PRIMARY KEY,

    etudiant_id INT NOT NULL,
    objet_id INT NOT NULL,
    donne_par_id INT,

    date_emprunt DATETIME DEFAULT CURRENT_TIMESTAMP,
    rendu BOOLEAN DEFAULT FALSE,
    date_rendu DATETIME NULL,

    FOREIGN KEY (etudiant_id) REFERENCES etudiant(id) ON DELETE CASCADE,
    FOREIGN KEY (objet_id) REFERENCES objet(id) ON DELETE CASCADE,
    FOREIGN KEY (donne_par_id) REFERENCES user(id) ON DELETE SET NULL
);