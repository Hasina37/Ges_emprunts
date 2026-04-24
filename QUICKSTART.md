# 🚀 Guide de Démarrage Rapide

## Pour les utilisateurs Windows (CMD/PowerShell)

### 1️⃣ Première fois seulement - Installation complète

```bash
# 1. Cloner le projet
git clone https://github.com/Hdjdhdbe/Methode_Agile.git
cd Projet_agile

# 2. Créer l'environnement virtuel
python -m venv env
env\Scripts\activate

# 3. Installer les dépendances
pip install -r requirements.txt

# 4. Créer la base de données MySQL
# Ouvrez phpMyAdmin et créez une base "emprunt_db"
# OU exécutez dans MySQL:
# CREATE DATABASE emprunt_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

# 5. Configurer settings.py
# Éditez config/settings.py avec les paramètres MySQL

# 6. Appliquer les migrations
python manage.py migrate

# 7. Créer un utilisateur admin
python manage.py createsuperuser

# 8. Lancer le serveur
python manage.py runserver
```

Ouvrez : **http://localhost:8000/**

---

### 2️⃣ Les fois suivantes - Démarrage rapide

```bash
# Aller dans le dossier du projet
cd e:\Projet_agile

# Activer l'environnement
env\Scripts\activate

# Lancer le serveur
python manage.py runserver
```

Ouvrez : **http://localhost:8000/**

---

## 🎯 Étapes essentielles une seule fois

### Configuration MySQL (phpMyAdmin)

1. Ouvrez **http://localhost/phpmyadmin**
2. Login avec : `root` / (votre mot de passe ou vide)
3. Créez une nouvelle base de données :
   - Nom : `emprunt_db`
   - Collation : `utf8mb4_unicode_ci`
4. Cliquez "Créer"

### Configuration Django

Éditez `config/settings.py` (ligne ~80) :

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'emprunt_db',           # Nom de votre base
        'USER': 'root',                  # Utilisateur MySQL
        'PASSWORD': '',                  # Mot de passe MySQL
        'HOST': 'localhost',
        'PORT': '3306',
    }
}
```

### Appliquer les migrations

```bash
python manage.py migrate
python manage.py createsuperuser  # Créer l'admin
```

---

## 📱 Accès à l'application

| URL | Utilité |
|-----|---------|
| http://localhost:8000/ | Page d'accueil |
| http://localhost:8000/admin/ | Panneau d'administration |
| http://localhost:8000/etudiant/ | Gestion des étudiants |
| http://localhost:8000/objet/ | Gestion des objets |
| http://localhost:8000/emprunt/ | Gestion des emprunts |

---

## ⚡ Commandes rapides

```bash
# Voir tous les modèles dans l'admin
python manage.py shell
# Puis dans le shell:
# >>> from Backend.models import *
# >>> Etudiant.objects.all()

# Relancer les migrations (après changement des modèles)
python manage.py makemigrations
python manage.py migrate

# Collecte les fichiers statiques (production)
python manage.py collectstatic --noinput

# Lancer les tests
python manage.py test

# Arrêter le serveur: Ctrl+C
```

---

## 🆘 Problèmes courants

**"Module django introuvable"**
```bash
env\Scripts\activate  # Vérifier que (env) s'affiche
pip install django
```

**"Impossible de se connecter à MySQL"**
- Vérifiez MySQL est en cours d'exécution
- Testez : `mysql -u root -p`

**"Le port 8000 est utilisé"**
```bash
python manage.py runserver 8001
```

**"Erreur 'Table doesn't exist'"**
```bash
python manage.py migrate
```

---

## 📖 Voir aussi

- README.md - Documentation complète
- config/settings.py - Configuration générale
- Backend/models.py - Modèles de données
- Backend/views.py - Logique métier

Bonne chance ! 🎉
