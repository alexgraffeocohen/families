# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create!([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

connie = Person.new(
  first_name: "Connie",
  last_name: "Hutchins",
  email: "connie@brady.com",
  password: "foobar12",
  password_confirmation: "foobar12",
  gender: "F",
  admin: 0
  )

harold = Person.new(
  first_name: "Harold",
  last_name: "Hutchins",
  email: "harold@brady.com",
  password: "foobar12",
  password_confirmation: "foobar12",
  gender: "M",
  admin: 0
  )

carol = Person.new(
  first_name: "Carol",
  email: "carol@brady.com",
  password: "foobar12",
  password_confirmation: "foobar12",
  gender: "F",
  mother_id: connie.id,
  father_id: harold.id,
  admin: 1
  )

mike = Person.new(
  first_name: "Mike",
  email: "mike@brady.com",
  password: "foobar12",
  password_confirmation: "foobar12",
  gender: "M",
  admin: 0
  )

greg = Person.new(
  first_name: "Greg",
  email: "greg@brady.com",
  password: "foobar12",
  password_confirmation: "foobar12",
  gender: "M",
  mother_id: carol.id,
  father_id: mike.id,
  admin: 0
  )

marcia = Person.new(
  first_name: "Marcia",
  email: "marcia@brady.com",
  password: "foobar12",
  password_confirmation: "foobar12",
  gender: "F",
  mother_id: carol.id,
  father_id: mike.id,
  admin: 0
  )

brady = Family.find_or_create_by(
  name: "Brady"
  )

members = [marcia, greg, mike, carol, harold, connie]

members.each do |member|
  member.skip_confirmation!
  member.save
end

brady.add_members(members)
carol.add_spouse(mike)