# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create!([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
connie = Person.create!(
  name: "Connie Hutchins",
  email: "connie@brady.com",
  password: "foobar12",
  password_confirmation: "foobar12",
  gender: "F"
  )

harold = Person.create!(
  name: "Harold Hutchins",
  email: "harold@brady.com",
  password: "foobar12",
  password_confirmation: "foobar12",
  gender: "M"
  )

carol = Person.create!(
  name: "Carol Brady",
  email: "carol@brady.com",
  password: "foobar12",
  password_confirmation: "foobar12",
  gender: "F",
  mother_id: connie.id,
  father_id: harold.id
  )

mike = Person.create!(
  name: "Mike Brady",
  email: "mike@brady.com",
  password: "foobar12",
  password_confirmation: "foobar12",
  gender: "M"
  )
greg = Person.create!(
  name: "Greg Brady",
  email: "greg@brady.com",
  password: "foobar12",
  password_confirmation: "foobar12",
  gender: "M",
  mother_id: carol.id,
  father_id: mike.id
  )
marcia = Person.create!(
  name: "Marcia Brady",
  email: "marcia@brady.com",
  password: "foobar12",
  password_confirmation: "foobar12",
  gender: "F",
  mother_id: carol.id,
  father_id: mike.id
  )

carol.spouse_id = mike.id
mike.spouse_id = carol.id
carol.save!
mike.save!