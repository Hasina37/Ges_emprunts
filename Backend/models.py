from django.db import models


# USER (admin simple)
class User(models.Model):
    username = models.CharField(max_length=150, unique=True)
    password = models.CharField(max_length=255)
    is_admin = models.BooleanField(default=True)
    is_active = models.BooleanField(default=True)

    def __str__(self):
        return self.username


# ETUDIANT
class Etudiant(models.Model):
    numero_etudiant = models.CharField(max_length=50, unique=True)
    nom = models.CharField(max_length=100)

    def __str__(self):
        return f"{self.nom} ({self.numero_etudiant})"


# OBJET
# OBJET
from django.db import models
from django.db.models import Sum

class Categorie(models.Model):
    nom = models.CharField(max_length=100, unique=True)

    def __str__(self):
        return self.nom

class Objet(models.Model):
    nom = models.CharField(max_length=100)
    quantite_totale = models.PositiveIntegerField(default=1)
    categorie = models.ForeignKey(Categorie, on_delete=models.SET_NULL, null=True, blank=True)

    def empruntes(self):
        return Emprunt.objects.filter(objet=self, rendu=False).aggregate(
            total=Sum("quantite")
        )["total"] or 0

    def disponibles(self):
        return self.quantite_totale - self.empruntes()

    def quantite_disponible(self):
        return self.disponibles()

    def est_disponible(self):
        return self.disponibles() > 0

    def __str__(self):
        return f"{self.nom} ({self.categorie})"


# EMPRUNT
class Emprunt(models.Model):
    etudiant = models.ForeignKey(Etudiant, on_delete=models.CASCADE)
    objet = models.ForeignKey(Objet, on_delete=models.CASCADE)
    date_retour_prevue = models.DateTimeField(null=True, blank=True)

    donne_par = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)
    quantite = models.PositiveIntegerField(default=1)

    date_emprunt = models.DateTimeField(auto_now_add=True)
    rendu = models.BooleanField(default=False)
    date_rendu = models.DateTimeField(null=True, blank=True)

    def __str__(self):
        return f"{self.etudiant.nom} - {self.objet.nom}"
    
class HistoriqueEmprunt(models.Model):

    STATUS_CHOICES = [
        ("RENDU", "Rendu"),
        ("NON_RENDU", "Non rendu"),
    ]
    emprunt_id = models.IntegerField(null=True, blank=True)

    etudiant = models.CharField(max_length=100)
    objet = models.CharField(max_length=100)

    donne_par = models.CharField(max_length=100, null=True, blank=True)

    quantite = models.PositiveIntegerField()

    date_emprunt = models.DateTimeField()
    date_rendu = models.DateTimeField(null=True, blank=True)

    status = models.CharField(
        max_length=20,
        choices=STATUS_CHOICES,
        default="NON_RENDU"
    )

    action = models.CharField(max_length=50)
    created_at = models.DateTimeField(auto_now_add=True)
