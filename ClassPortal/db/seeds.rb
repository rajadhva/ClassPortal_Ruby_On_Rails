# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name:  "Super User",
             email: "super@ncsu.edu",
             password:              "Superuser",
             password_confirmation: "Superuser",
             admin: true,
             instructor: false,
             student: false,
             super: true,
	)