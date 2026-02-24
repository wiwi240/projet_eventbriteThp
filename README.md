# Eventbrite Clone - THP Project

Application Rails pour la gestion d'événements (projet THP).

## 🚀 Fonctionnalités

- **Gestion des utilisateurs** via `devise`.
- **Création d'événements** (titre, description, date, lieu).
- **Système de participation** (attendances).
- **Emails** (inscription, notifications d'événements).

## 🛠 Stack technique (dans ce dépôt)

- **Backend**: Ruby on Rails (8.0.4)
- **Base de données**: SQLite (développement/test) — voir `config/database.yml`
- **Assets JS**: `importmap-rails` (pas de Webpacker/Yarn requis)
- **Authentification**: Devise
- **Analyse sécurité / lint**: Brakeman, RuboCop

## ⚙️ Installation locale

1. Cloner le dépôt

```bash
git clone <url_du_depot>
cd <repo>
```

2. Installer les dépendances Ruby

```bash
bundle install
```

3. Préparer la base de données

```bash
bin/rails db:migrate
bin/rails db:seed
```

4. Variables d'environnement

Créer un fichier `.env` (ou utiliser votre méthode) pour les clefs externes, par exemple :

```env
STRIPE_PUBLISHABLE_KEY=
STRIPE_SECRET_KEY=
```

5. Lancer le serveur

```bash
bin/rails server
```

6. Lancer la suite de tests

```bash
bin/rails test
```
