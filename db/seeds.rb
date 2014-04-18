connie = Person.create!(
  first_name: "Connie",
  last_name: "Hutchins",
  email: "connie@hutchins.com",
  phone: "310-561-9314",
  birthday: Time.gm(1914,"jul",17,20,15,1), 
  # location: ""
  password: "foobar12",
  password_confirmation: "foobar12",
  gender: "F",
  admin: 0,
  confirmed_at: Time.now
  )

harold = Person.create!(
  first_name: "Harold",
  last_name: "Hutchins",
  email: "harold@hutchins.com",
  phone: "310-559-9244",
  birthday: Time.gm(1914,"jun",12,20,15,1),
  location: "Malibu, California",
  password: "foobar12",
  password_confirmation: "foobar12",
  gender: "M",
  admin: 0,
  confirmed_at: Time.now
  )

carol = Person.create!(
  first_name: "Carol",
  email: "carol@brady.com",
  phone: "310-452-9364",
    age: 9,
  birthday: Time.gm(1939,"feb",4,20,15,1),
  location: "Los Angeles, California",
  password: "foobar12",
  password_confirmation: "foobar12",
  gender: "F",
  mother_id: connie.id,
  father_id: harold.id,
  admin: 1,
  confirmed_at: Time.now
  )

mike = Person.create!(
  first_name: "Mike",
  email: "mike@brady.com",
  phone: "310-805-9238",
  birthday: Time.gm(1937,"feb",4,20,15,1),
  location: "Los Angeles, California",
  password: "foobar12",
  password_confirmation: "foobar12",
  gender: "M",
  admin: 0,
  confirmed_at: Time.now
  )

greg = Person.create!(
  first_name: "Greg",
  email: "greg@brady.com",
  phone: "310-775-7614",
  birthday: Time.gm(1964,"aug",23,20,15,1),
  location: "Los Angeles, California",
  password: "foobar12",
  password_confirmation: "foobar12",
  gender: "M",
  mother_id: carol.id,
  father_id: mike.id,
  admin: 0,
  confirmed_at: Time.now
  )

marcia = Person.create!(
  first_name: "Marcia",
  email: "marcia@brady.com",
  phone: "310-135-8294",
  birthday: Time.gm(1964,"nov",10,20,15,1),
  location: "Los Angeles, California",
  password: "foobar12",
  password_confirmation: "foobar12",
  gender: "F",
  mother_id: carol.id,
  father_id: mike.id,
  admin: 0,
  confirmed_at: Time.now
  )

 jenny = Person.create!(
  first_name: "Jenny",
  email: "jenny@hutchins.com",
  phone: "310-905-9276",
  birthday: Time.gm(1947,"mar",2,20,15,1),
  location: "Los Angeles, California",
  password: "foobar12",
  password_confirmation: "foobar12", 
  gender: "F",
  mother_id: connie.id, 
  father_id: harold.id, 
  admin: 0,
  confirmed_at: Time.now
  )

  jon = Person.create!(
    first_name: "Jon",
    email: "jon@hutchins.com",
    phone: "310-817-3014",
    # profile_photo: open("assets/hip_read.jpg"),
    birthday: Time.gm(1945,"jan",1,20,15,1), 
    location: "Los Angeles, California",
    password: "foobar12",
    password_confirmation: "foobar12", 
    gender: "M",
    mother_id: connie.id, 
    father_id: harold.id, 
    admin: 0,
    confirmed_at: Time.now
  )

  jon_jr = Person.create!(
    first_name: "Jon Jr.",
    email: "jon_jr@hutchins.com",
    phone: "310-213-8654",
    birthday: Time.gm(1971,"dec",30,20,15,1),
    location: "Los Angeles, California",
    password: "foobar12",
    password_confirmation: "foobar12", 
    gender: "M",
    father_id: jon.id, 
    admin: 0,
    confirmed_at: Time.now
  )

brady = Family.find_or_create_by(
  name: "Brady"
  )

hutchins = Family.find_or_create_by(
  name: "Hutchins"
  )

brady.add_members([carol, connie, harold, mike, greg, marcia])
hutchins.add_members([jon, jenny, jon_jr, carol, connie, harold])

connie.add_spouse(harold)
carol.add_spouse(mike)