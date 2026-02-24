require 'faker'

# Nettoyage
Attendance.destroy_all
Event.destroy_all
User.destroy_all

# Configuration des prix par catégorie
CATEGORY_DATA = {
  "Concert" => { min: 20, max: 120 },
  "Sport" => { min: 10, max: 80 },
  "Conférence" => { min: 0, max: 50 },
  "Formation" => { min: 100, max: 500 },
  "Networking" => { min: 0, max: 30 },
  "Exposition" => { min: 5, max: 25 }
}

puts "Création des utilisateurs..."
10.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    description: Faker::Lorem.paragraph(sentence_count: 3),
    email: Faker::Internet.unique.email,
    password: "password123"
  )
end

users = User.all

puts "Création des événements avec prix cohérents..."
20.times do |i|
  admin = users.sample
  category_name = CATEGORY_DATA.keys.sample
  price_range = CATEGORY_DATA[category_name]
  
  # Utilisation de Faker::Commerce ou Faker::Book pour des titres plus stables
  title = "#{category_name} : #{Faker::Commerce.product_name}"
  
  event = Event.new(
    admin: admin,
    category: category_name,
    title: title,
    description: Faker::Lorem.paragraph(sentence_count: 10),
    price: rand(price_range[:min]..price_range[:max]),
    location: Faker::Address.city,
    start_date: Faker::Time.forward(days: 30, period: :evening),
    duration: [30, 60, 90, 120].sample
  )

  if event.save
    puts "✅ [#{event.category}] '#{event.title}' - #{event.price}€ (par #{admin.first_name})"
  else
    puts "❌ Erreur : #{event.errors.full_messages.join(', ')}"
  end
end

puts "Seed terminé."