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
# Eventbrite Clone - THP Project

Application Rails pour la gestion d'événements (projet THP).

## État actuel

- Refactor des vues en partials (`layouts`, `shared`, `events` partials).
- Système de **commentaires** ajouté sous les événements (modèle, contrôleur, vues).
- Thème visuel : palette verte professionnelle (Bootswatch Minty + `overrides.css`).
- Police technique pour les titres : `Orbitron` (Google Fonts).
- CSS principal consolidé dans `app/assets/stylesheets/application.css`.

## Fonctionnalités principales

- Gestion des utilisateurs via `devise`.
- Création/édition/suppression d'événements.
- Participation (attendances).
- Commentaires sur les événements.
- Notifications par e‑mail (mailers prêts).

## Stack technique

- **Backend**: Ruby on Rails 8
- **Base de données**: SQLite (développement/test)
- **Assets JS**: `importmap-rails`
- **Authentification**: Devise

## Lancer l'application en local

1. Cloner le dépôt

```bash
git clone <url_du_depot>
cd <repo>
```

2. Installer les dépendances

```bash
bundle install
```

3. Préparer la base de données

```bash
bin/rails db:migrate
bin/rails db:seed
```

4. Variables d'environnement

Créer un fichier `.env` (ou utiliser votre méthode) et ajouter les clefs externes si nécessaire:

```env
STRIPE_PUBLISHABLE_KEY=
STRIPE_SECRET_KEY=
```

5. Lancer le serveur

```bash
bin/rails server
```

6. Lancer les tests

```bash
bin/rails test
```

## Styles et thème

- Règles de thème personnalisées : `app/assets/stylesheets/overrides.css`.
- Palette principale définie via des variables CSS (ex: `--primary-green`).
- Les liens de la navbar (`Parcourir`, `Se connecter`) ont été mis en évidence pour assurer un bon contraste.

## 🎵 Drum Kit avec Stimulus

Un projet d'entraînement JavaScript utilisant **Stimulus** (framework léger pour Rails).

### Vue d'ensemble

- **Page**: `/drums` — une grille de 9 touches (A—L) qui changent de couleur au clic
- **Contrôleur Stimulus**: `app/javascript/controllers/drumkit_controller.js`
- **Styles**: `app/assets/stylesheets/drumkit.css` (chargés uniquement sur la page drums)
- **Sons**: `app/assets/sounds/*.wav` (fichiers silencieux de test fournis)

### Fonctionnalités

- **Événement clavier** : appuie sur une touche A–L → la case devient orange/rose
- **Stimulus ciblé** : le contrôleur Stimulus ne s'exécute **que** sur `/drums` (grâce à `data-controller="drumkit"`)
- **Asset pipeline** : sons et styles servis via Rails correctement

### Tester

```bash
bin/rails server
# puis ouvrir http://localhost:3000/drums
# appuyer sur A S D F G H J K L
```

### Remplacer les sons

Les fichiers `.wav` actuels sont des silences de test. Tu peux les remplacer par les vrais sons du [Drum Kit de Wes Bos](https://github.com/wesbos/JavaScript30/tree/master/01%20-%20JavaScript%20Drum%20Kit/sounds) en les copiant dans `app/assets/sounds/`.

### Fichiers clés

- `app/controllers/drums_controller.rb` — contrôleur Rails
- `app/views/drums/index.html.erb` — vue avec `data-controller="drumkit"`
- `app/javascript/controllers/drumkit_controller.js` — logique Stimulus
- `app/assets/config/manifest.js` — configuration asset pipeline
- `PLAN_D_ACTION.md` — plan de développement détaillé

## 🎯 "Bonjour monde" sur toutes les pages

Un fichier JS exécuté partout :

```javascript
// app/assets/javascripts/hello.js
console.log("bonjour monde !");
```

- Inclus via `javascript_include_tag 'hello'` dans `app/views/layouts/application.html.erb`
- Visible dans la console du navigateur sur **toutes les pages**

## Fichiers importants

- `app/views/layouts/application.html.erb` — layout principal, inclusion des partials.
- `app/views/shared/_navbar.html.erb` — barre de navigation.
- `app/assets/stylesheets/application.css` — styles principaux.
- `app/assets/stylesheets/overrides.css` — overrides de thème (Minty -> vert pro).
- `app/models/comment.rb` et `app/controllers/comments_controller.rb` — commentaires.

## Prochaines actions proposées

- Supprimer `overrides.css` et fusionner ses règles dans `application.css` (si validé).
- Commiter et pousser les fichiers non‑staged (partials, contrôleur et migration de commentaires).

---

README mis à jour pour refléter l'état actuel. Dis‑moi si tu veux que je
committe et pousse aussi les fichiers restants (partials, modèles,
contrôleur, migration), ou que je supprime `overrides.css` maintenant.
