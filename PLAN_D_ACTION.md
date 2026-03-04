# Plan d'action — Drum Kit avec Stimulus (Rails)

Objectif : intégrer un Drum Kit JavaScript en utilisant Stimulus, et s'assurer que les assets (sons, CSS) sont servis uniquement pour la page concernée.

Étapes réalisées :
- 1) Créer le contrôleur Rails `DrumsController#index` (fichier : `app/controllers/drums_controller.rb`) — fait
- 2) Ajouter la view `app/views/drums/index.html.erb` avec `data-controller="drumkit"` — fait
- 3) Générer le contrôleur Stimulus `drumkit` (fichier : `app/javascript/controllers/drumkit_controller.js`) — fait
- 4) Ajouter les styles spécifiques `app/assets/stylesheets/drumkit.css` et les charger seulement sur la view — fait
- 5) Préparer le dossier des sons `app/assets/sounds/` et ajouter `app/assets/config/manifest.js` pour inclure `sounds` — fait

Étapes restantes / recommandations :
- 6) Déposer les fichiers `.wav` dans `app/assets/sounds/` (noms attendus : `clap.wav`, `hihat.wav`, `kick.wav`, `openhat.wav`, `boom.wav`, `ride.wav`, `snare.wav`, `tom.wav`, `tink.wav`).
- 7) Redémarrer le serveur Rails après ajout des sons (pour que l'asset pipeline prenne en compte les nouveaux fichiers).
- 8) Tester localement :
```
bin/rails server
# puis ouvrir http://localhost:3000/drums
```
- 9) Optionnel : rendre `/drums` racine temporairement pour tests (modifier `config/routes.rb` : `root 'drums#index'`).

Notes techniques :
- Le contrôleur Stimulus ne s'exécute que quand `data-controller="drumkit"` est présent, donc pas d'impact sur le reste de l'app.
- Si tu veux, je peux ajouter des fichiers `.wav` de test (silencieux) pour vérifier le flux sans attendre tes fichiers.
