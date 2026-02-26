# config/importmap.rb
pin "application"
pin "@hotwired/turbo-rails", to: "turbo.min.js"
pin "@hotwired/stimulus", to: "stimulus.min.js"
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin_all_from "app/javascript/controllers", under: "controllers"

# Verrouille ces deux noms pour le JS
pin "bootstrap", to: "bootstrap.js"
pin "@popperjs/core", to: "@popperjs/core.js"