# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create! name: "Hoang Anh Tu", email: "hoangtuyb96@gmail.com", password: "12345678", password_confirmation: "12345678", birthday: "19960423", phone: "0989539988"
Micropost.create! content: "Test", user_id: 1
Micropost.create! content: "Test_2", user_id: 1
