from django.shortcuts import render, redirect, get_object_or_404
from django.utils import timezone
from datetime import timedelta
from .models import Emprunt
from .models import User
from .models import Objet
from .models import Etudiant
from .models import Categorie 
from .models import HistoriqueEmprunt
from django.db.models import Sum, Count
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

    total_emprunts = Emprunt.objects.count()
    emprunts_non_rendu = Emprunt.objects.filter(rendu=False).count()
    emprunts_rendus = total_emprunts - emprunts_non_rendu          
    total_objets = Objet.objects.count()
    total_etudiants = Etudiant.objects.count()

    objet_le_plus_emprunte = (
    Emprunt.objects
    .values("objet__nom")
    .annotate(total=Count("id"))      
    .order_by("-total")
    .first()
        )

 
    derniers_emprunts = Emprunt.objects.select_related('etudiant', 'objet').order_by('-date_emprunt')[:5]
    recent_emprunts = []
    for emp in derniers_emprunts:
        recent_emprunts.append({
            'etudiant_nom': emp.etudiant.nom,
            'objet_nom': emp.objet.nom,
            'date_emprunt': emp.date_emprunt,
            'est_rendu': emp.rendu,
        })

    return render(request, "dashboard.html", {
        "username": username,
        "stats": {
            "total_emprunts": total_emprunts,
            "non_rendu": emprunts_non_rendu,
            "rendus": emprunts_rendus,          # ← NOUVEAU
            "total_objets": total_objets,
            "total_etudiants": total_etudiants,
        },
        "top_objet": objet_le_plus_emprunte,
        "recent_emprunts": recent_emprunts,
    })
    
def objet_list(request):
    if not request.session.get("user_id"):
        return redirect("auth")

    objets = Objet.objects.select_related("categorie").all()

    return render(request, "objet/list.html", {
        "objets": objets
    })


def objet_create(request):
    if not request.session.get("user_id"):
        return redirect("auth")

    categories = Categorie.objects.all()

    if request.method == "POST":
        nom = request.POST.get("nom")
        quantite = request.POST.get("quantite")
        categorie_id = request.POST.get("categorie")

        categorie = None
        if categorie_id:
            categorie = Categorie.objects.get(id=categorie_id)

        Objet.objects.create(
            nom=nom,
            quantite_totale=quantite,
            categorie=categorie
        )
        return redirect("objet_list")

    return render(request, "objet/create.html", {
        "categories": categories
    })



def objet_edit(request, id):
    if not request.session.get("user_id"):
        return redirect("auth")

    objet = get_object_or_404(Objet, id=id)
    categories = Categorie.objects.all()

    if request.method == "POST":
        objet.nom = request.POST.get("nom")
        objet.quantite_totale = request.POST.get("quantite")

        categorie_id = request.POST.get("categorie")
        if categorie_id:
            objet.categorie = Categorie.objects.get(id=categorie_id)
        else:
            objet.categorie = None

        objet.save()
        return redirect("objet_list")

    return render(request, "objet/edit.html", {
        "objet": objet,
        "categories": categories
    })



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



def etudiant_delete(request, id):
    if not request.session.get("user_id"):
        return redirect("auth")

    etudiant = get_object_or_404(Etudiant, id=id)
    etudiant.delete()

    return redirect("etudiant_list")

def emprunt_list(request):
    if not request.session.get("user_id"):
        return redirect("auth")

    emprunts = Emprunt.objects.filter(rendu=False)

    return render(request, "emprunt/list.html", {
        "emprunts": emprunts
    })



def emprunt_create(request):
    if not request.session.get("user_id"):
        return redirect("auth")

    etudiants = Etudiant.objects.all()
    objets = Objet.objects.all()

    if request.method == "POST":
        etudiant = Etudiant.objects.get(id=request.POST.get("etudiant"))
        objet = Objet.objects.get(id=request.POST.get("objet"))
        quantite = int(request.POST.get("quantite"))

     
        if Emprunt.objects.filter(
            etudiant=etudiant,
            objet=objet,
            rendu=False
        ).exists():
            return render(request, "emprunt/create.html", {
                "etudiants": etudiants,
                "objets": objets,
                "error": "Cet étudiant a déjà emprunté cet objet"
            })

       
        if objet.disponibles() < quantite:
            return render(request, "emprunt/create.html", {
                "etudiants": etudiants,
                "objets": objets,
                "error": "Stock insuffisant"
            })

        admin = User.objects.get(id=request.session["user_id"])

        emprunt = Emprunt.objects.create(
            etudiant=etudiant,
            objet=objet,
            quantite=quantite,
            donne_par=admin,
            rendu=False
        )

   
        HistoriqueEmprunt.objects.create(
            etudiant=etudiant.nom,
            objet=objet.nom,
            quantite=quantite,
            donne_par=admin.username,
            date_emprunt=emprunt.date_emprunt,
            status="NON_RENDU",
            action="EMPRUNT_CREE",
            emprunt_id=emprunt.id
        )

        return redirect("emprunt_list")

    return render(request, "emprunt/create.html", {
        "etudiants": etudiants,
        "objets": objets
    })



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

        if ancien_objet == nouvel_objet:
            difference = nouvelle_quantite - ancienne_quantite

            if difference > 0 and nouvel_objet.disponibles() < difference:
                return render(request, "emprunt/edit.html", {
                    "emprunt": emprunt,
                    "etudiants": etudiants,
                    "objets": objets,
                    "error": "Stock insuffisant"
                })

        else:
            if nouvel_objet.disponibles() < nouvelle_quantite:
                return render(request, "emprunt/edit.html", {
                    "emprunt": emprunt,
                    "etudiants": etudiants,
                    "objets": objets,
                    "error": "Stock insuffisant"
                })

   
        emprunt.etudiant = nouvel_etudiant
        emprunt.objet = nouvel_objet
        emprunt.quantite = nouvelle_quantite
        emprunt.save()

    
        hist = HistoriqueEmprunt.objects.filter(
            etudiant=emprunt.etudiant.nom,
            objet=ancien_objet.nom,
            status="NON_RENDU"
        ).order_by("-created_at").first()

        if hist:
            hist.etudiant = nouvel_etudiant.nom
            hist.objet = nouvel_objet.nom
            hist.quantite = nouvelle_quantite
            hist.save()

        return redirect("emprunt_list")

    return render(request, "emprunt/edit.html", {
        "emprunt": emprunt,
        "etudiants": etudiants,
        "objets": objets
    })

def emprunt_delete(request, id):
    if not request.session.get("user_id"):
        return redirect("auth")

    emprunt = get_object_or_404(Emprunt, id=id)
    emprunt.delete()

    return redirect("emprunt_list")



def emprunt_rendre(request, id):
    if not request.session.get("user_id"):
        return redirect("auth")

    emprunt = get_object_or_404(Emprunt, id=id)

    emprunt.rendu = True
    emprunt.date_rendu = timezone.now()
    emprunt.save()

    HistoriqueEmprunt.objects.filter(
        emprunt_id=emprunt.id
    ).update(
        status="RENDU",
        date_rendu=emprunt.date_rendu,
        action="RETOUR"
    )

    return redirect("emprunt_list")
def historique_emprunt(request):
    if not request.session.get("user_id"):
        return redirect("auth")

    historiques = HistoriqueEmprunt.objects.all().order_by("-created_at")

    q = request.GET.get("q")
    status = request.GET.get("status")

    if q:
        historiques = historiques.filter(
            etudiant__icontains=q
        ) | historiques.filter(
            objet__icontains=q
        )

    if status == "rendu":
        historiques = historiques.filter(status="RENDU")

    elif status == "non":
        historiques = historiques.filter(status="NON_RENDU")

    return render(request, "emprunt/historique.html", {
        "historiques": historiques
    })

def categorie_list(request):
    if not request.session.get("user_id"):
        return redirect("auth")

    categories = Categorie.objects.all()

    return render(request, "categorie/list.html", {
        "categories": categories
    })



def categorie_create(request):
    if not request.session.get("user_id"):
        return redirect("auth")

    if request.method == "POST":
        nom = request.POST.get("nom")

        if nom:
            Categorie.objects.create(nom=nom)

        return redirect("categorie_list")

    return render(request, "categorie/create.html")


def categorie_edit(request, id):
    if not request.session.get("user_id"):
        return redirect("auth")

    categorie = get_object_or_404(Categorie, id=id)

    if request.method == "POST":
        categorie.nom = request.POST.get("nom")
        categorie.save()

        return redirect("categorie_list")

    return render(request, "categorie/edit.html", {
        "categorie": categorie
    })



def categorie_delete(request, id):
    if not request.session.get("user_id"):
        return redirect("auth")

    categorie = get_object_or_404(Categorie, id=id)
    categorie.delete()

    return redirect("categorie_list")
