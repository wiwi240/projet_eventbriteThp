require 'open-uri'

# Nettoyage de la base de données
puts "Nettoyage de la base de données..."
Attendance.destroy_all
Event.destroy_all
User.destroy_all

# Création de l'administrateur
admin_user = User.create!(
  first_name: "William",
  last_name: "Mahi",
  email: "wiwi.mahi@gmail.com",
  password: "123456",
  is_admin: true,
  description: "Administrateur de la plateforme."
)

# Création d'un utilisateur standard
standard_user = User.create!(
  first_name: "Jean",
  last_name: "Dupont",
  email: "jean.dupont@test.com",
  password: "123456",
  is_admin: false,
  description: "Utilisateur test pour les soumissions."
)

# Listes de titres réalistes
validated_titles = [
  "Concert de Jazz au Parc", 
  "Marathon de Paris 2026", 
  "Exposition Peinture Moderne", 
  "Festival de Street Food", 
  "Conférence Innovation Tech"
]

pending_titles = [
  "Atelier Poterie Débutant", 
  "Cours de Yoga au lever du soleil", 
  "Tournoi d'Échecs local", 
  "Randonnée Forêt de Fontainebleau", 
  "Dégustation Vins et Fromages"
]

# 1. Création des Événements VALIDÉS (visibles sur l'index)
puts "Création des événements validés..."
validated_titles.each_with_index do |title, i|
  event = Event.new(
    title: title,
    description: "Une expérience unique à ne pas manquer. Venez nombreux pour découvrir cet événement exceptionnel !",
    start_date: DateTime.now + (i + 1).days,
    duration: 60,
    price: rand(10..50),
    location: "Paris, France",
    category: "Culture",
    admin: admin_user,
    is_validated: true
  )
  
  # Image aléatoire
  file = URI.open("https://picsum.photos/seed/#{rand(1..1000)}/600/400")
  event.event_picture.attach(io: file, filename: "validated_#{i}.jpg", content_type: 'image/jpeg')
  
  event.save!
end

# 2. Création des Événements EN ATTENTE (visibles dans /admin/event_submissions)
puts "Création des soumissions en attente..."
pending_titles.each_with_index do |title, i|
  event = Event.new(
    title: title,
    description: "Proposez votre participation à cette nouvelle activité. Nous attendons la validation de l'administrateur.",
    start_date: DateTime.now + (i + 5).days,
    duration: 120,
    price: rand(5..100),
    location: "Lyon, France",
    category: "Loisirs",
    admin: standard_user,
    is_validated: false
  )

  file = URI.open("https://picsum.photos/seed/#{rand(1..1000)}/600/400")
  event.event_picture.attach(io: file, filename: "pending_#{i}.jpg", content_type: 'image/jpeg')
  
  event.save!
end

puts "Seed terminé ! 10 événements créés."