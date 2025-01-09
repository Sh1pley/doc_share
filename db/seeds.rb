# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
admin_email = 'admin@example.com'

if Teacher.exists?(email: admin_email)
  puts "Admin user already exists with email: #{admin_email}"
else
  Teacher.create!(
    first_name: 'Admin',
    last_name: 'User',
    email: admin_email,
    password: 'password', # Change to a secure password before production!
    password_confirmation: 'password',
    admin: true
  )
  puts "Admin user created with email: #{admin_email}"
end
