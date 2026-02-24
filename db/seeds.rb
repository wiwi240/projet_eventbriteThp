User.destroy_all
Event.destroy_all

# 1. Création des utilisateurs
5.times do
  User.create(
    first_name: "Prénom",
    last_name: "Nom",
    description: "Une description de plus de vingt caractères.",
    email: "test#{rand(1..10000)}@yopmail.com",
    password: "password123" # Utilise 'password' pour Devise
  )
end
puts "5 utilisateurs créés."

# 2. Création des événements
5.times do
  Event.create(
    admin: User.all.sample, # Prend un utilisateur au hasard comme admin
    title: "Événement #{rand(1..100)}",
    description: "Une description de plus de vingt caractères pour passer les validations.",
    price: rand(1..1000),
    location: ["Paris", "Lyon", "Marseille", "Bordeaux"].sample,
    start_date: Time.now + rand(1..30).days,
    duration: [30, 60, 90, 120].sample
  )
end
puts "5 événements créés."