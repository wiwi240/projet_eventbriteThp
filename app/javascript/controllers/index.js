// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"

// Eager-load all controllers in app/javascript/controllers (including our new drumkit)
eagerLoadControllersFrom("controllers", application)

