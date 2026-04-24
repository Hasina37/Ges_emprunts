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

class Objet(models.Model):
    nom = models.CharField(max_length=100)
    quantite_totale = models.PositiveIntegerField(default=1)

    # 🔥 total réellement emprunté (avec quantités)
    def empruntes(self):
        return Emprunt.objects.filter(objet=self, rendu=False).aggregate(
            total=Sum("quantite")
        )["total"] or 0

    # 🔥 disponibles
    def disponibles(self):
        return self.quantite_totale - self.empruntes()

    # compatibilité ancien code
    def quantite_disponible(self):
        return self.disponibles()

    def est_disponible(self):
        return self.disponibles() > 0

    def __str__(self):
        return self.nom


# EMPRUNT
class Emprunt(models.Model):
    etudiant = models.ForeignKey(Etudiant, on_delete=models.CASCADE)
    objet = models.ForeignKey(Objet, on_delete=models.CASCADE)

    donne_par = models.ForeignKey(User, on_delete=models.SET_NULL, null=True)
    quantite = models.PositiveIntegerField(default=1)

    date_emprunt = models.DateTimeField(auto_now_add=True)
    rendu = models.BooleanField(default=False)
    date_rendu = models.DateTimeField(null=True, blank=True)

    def __str__(self):
        return f"{self.etudiant.nom} - {self.objet.nom}"