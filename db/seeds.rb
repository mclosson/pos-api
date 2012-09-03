# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Account.destroy_all
Location.destroy_all
User.destroy_all

ingen = Account.create(name: "Ingen Corporation")

sorna = Location.create(account_id: ingen.id, address1: '200 Dinosaur Way', city: 'Isla Sorna')

Location.create(account_id: ingen.id, address1: '1875 International Drive', city: 'Isla Nublar')

User.create(account_id: ingen.id, firstname: 'Isi', lastname: 'Robayna', shortname: 'IR', 
            username: 'irobayna', password: 'ipass', email: 'isi@ingen.com', 
            enabled: true, default_location: sorna.id)

User.create(account_id: ingen.id, firstname: 'Matt', lastname: 'Closson', shortname: 'MC',
            username: 'mclosson', password: 'mpass', email: 'matt@ingen.com', 
            enabled: true, default_location: sorna.id)

Account.create(name: "Isi and Matt's Clothing Company")
Account.create(name: "Hurley Surf Wear")