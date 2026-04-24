from django.shortcuts import render, redirect
from django.shortcuts import render, redirect, get_object_or_404
from django.utils import timezone
from .models import Emprunt
from .models import User
from .models import Objet
from .models import Etudiant
from django.contrib.auth.hashers import check_password


def auth(request):

    if request.GET.get("action") == "logout":
        request.session.flush()
        return redirect("auth")
    erreur = None

    if request.method == "POST":
        username = request.POST.get("username")
        password = request.POST.get("password")

        try:
            user = User.objects.get(username=username, is_active=True)

            if check_password(password, user.password):
                request.session["user_id"] = user.id
                request.session["username"] = user.username
                return redirect("dashboard")
            else:
                erreur = "Mot de passe incorrect"

        except User.DoesNotExist:
            erreur = "Utilisateur introuvable"

    return render(request, "auth.html", {"erreur": erreur})


def dashboard(request):
    if not request.session.get("user_id"):
        return redirect("auth")

    username = request.session.get("username")

    # Statistics
    total_emprunts = Emprunt.objects.count()
    emprunts_non_rendu = Emprunt.objects.filter(rendu=False).count()
    total_objets = Objet.objects.count()
    total_etudiants = Etudiant.objects.count()

    return render(request, "dashboard.html", {
        "username": username,
        "stats": {
            "total_emprunts": total_emprunts,
            "non_rendu": emprunts_non_rendu,
            "total_objets": total_objets,
            "total_etudiants": total_etudiants,
        }
    })
def objet_list(request):
    if not request.session.get("user_id"):
        return redirect("auth")

    objets = Objet.objects.all()

    return render(request, "objet/list.html", {
        "objets": objets
    })


# CREATE
def objet_create(request):
    if not request.session.get("user_id"):
        return redirect("auth")

    if request.method == "POST":
        nom = request.POST.get("nom")
        quantite = request.POST.get("quantite")

        Objet.objects.create(
            nom=nom,
            quantite_totale=quantite
        )
        return redirect("objet_list")

    return render(request, "objet/create.html")


# EDIT
def objet_edit(request, id):
    if not request.session.get("user_id"):
        return redirect("auth")

    objet = get_object_or_404(Objet, id=id)

    if request.method == "POST":
        objet.nom = request.POST.get("nom")
        objet.quantite_totale = request.POST.get("quantite")
        objet.save()
        return redirect("objet_list")

    return render(request, "objet/edit.html", {"objet": objet})


# DELETE
def objet_delete(request, id):
    if not request.session.get("user_id"):
        return redirect("auth")

    objet = get_object_or_404(Objet, id=id)
    objet.delete()

    return redirect("objet_list")

def etudiant_list(request):
    if not request.session.get("user_id"):
        return redirect("auth")

    etudiants = Etudiant.objects.all()
    return render(request, "etudiant/list.html", {"etudiants": etudiants})


# CREATE
def etudiant_create(request):
    if not request.session.get("user_id"):
        return redirect("auth")

    if request.method == "POST":
        numero = request.POST.get("numero")
        nom = request.POST.get("nom")

        Etudiant.objects.create(
            numero_etudiant=numero,
            nom=nom
        )
        return redirect("etudiant_list")

    return render(request, "etudiant/create.html")


# EDIT
def etudiant_edit(request, id):
    if not request.session.get("user_id"):
        return redirect("auth")

    etudiant = get_object_or_404(Etudiant, id=id)

    if request.method == "POST":
        etudiant.numero_etudiant = request.POST.get("numero")
        etudiant.nom = request.POST.get("nom")
        etudiant.save()
        return redirect("etudiant_list")

    return render(request, "etudiant/edit.html", {"etudiant": etudiant})


# DELETE
def etudiant_delete(request, id):
    if not request.session.get("user_id"):
        return redirect("auth")

    etudiant = get_object_or_404(Etudiant, id=id)
    etudiant.delete()

    return redirect("etudiant_list")




# 📋 LISTE
def emprunt_list(request):
    if not request.session.get("user_id"):
        return redirect("auth")

    emprunts = Emprunt.objects.filter(rendu=False)

    return render(request, "emprunt/list.html", {
        "emprunts": emprunts
    })


# ➕ CREATE
def emprunt_create(request):
    if not request.session.get("user_id"):
        return redirect("auth")

    etudiants = Etudiant.objects.all()
    objets = Objet.objects.all()

    if request.method == "POST":
        etudiant = Etudiant.objects.get(id=request.POST.get("etudiant"))
        objet = Objet.objects.get(id=request.POST.get("objet"))
        quantite = int(request.POST.get("quantite"))

        # 🔥 contrôle stock réel
        if objet.disponibles() < quantite:
            return render(request, "emprunt/create.html", {
                "etudiants": etudiants,
                "objets": objets,
                "error": "Stock insuffisant"
            })

        admin = User.objects.get(id=request.session["user_id"])

        Emprunt.objects.create(
            etudiant=etudiant,
            objet=objet,
            quantite=quantite,
            donne_par=admin,
            rendu=False
        )

        return redirect("emprunt_list")

    return render(request, "emprunt/create.html", {
        "etudiants": etudiants,
        "objets": objets
    })


# ✏️ EDIT
def emprunt_edit(request, id):
    if not request.session.get("user_id"):
        return redirect("auth")

    emprunt = get_object_or_404(Emprunt, id=id)
    etudiants = Etudiant.objects.all()
    objets = Objet.objects.all()

    ancien_objet = emprunt.objet
    ancienne_quantite = emprunt.quantite

    if request.method == "POST":

        nouvel_etudiant = Etudiant.objects.get(id=request.POST.get("etudiant"))
        nouvel_objet = Objet.objects.get(id=request.POST.get("objet"))
        nouvelle_quantite = int(request.POST.get("quantite"))

        # 🔥 CAS 1 : même objet
        if ancien_objet == nouvel_objet:

            difference = nouvelle_quantite - ancienne_quantite

            if difference > 0 and nouvel_objet.disponibles() < difference:
                return render(request, "emprunt/edit.html", {
                    "emprunt": emprunt,
                    "etudiants": etudiants,
                    "objets": objets,
                    "error": "Stock insuffisant"
                })

        # 🔥 CAS 2 : changement objet
        else:
            if nouvel_objet.disponibles() < nouvelle_quantite:
                return render(request, "emprunt/edit.html", {
                    "emprunt": emprunt,
                    "etudiants": etudiants,
                    "objets": objets,
                    "error": "Stock insuffisant"
                })

        # ✔ IMPORTANT : mise à jour
        emprunt.etudiant = nouvel_etudiant
        emprunt.objet = nouvel_objet
        emprunt.quantite = nouvelle_quantite
        emprunt.save()

        return redirect("emprunt_list")

    return render(request, "emprunt/edit.html", {
        "emprunt": emprunt,
        "etudiants": etudiants,
        "objets": objets
    })


# ❌ DELETE
def emprunt_delete(request, id):
    if not request.session.get("user_id"):
        return redirect("auth")

    emprunt = get_object_or_404(Emprunt, id=id)
    emprunt.delete()

    return redirect("emprunt_list")


# 🔄 RENDRE
def emprunt_rendre(request, id):
    if not request.session.get("user_id"):
        return redirect("auth")

    emprunt = get_object_or_404(Emprunt, id=id)

    emprunt.rendu = True
    emprunt.date_rendu = timezone.now()
    emprunt.save()

    return redirect("emprunt_list")
