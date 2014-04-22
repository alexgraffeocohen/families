connie = Person.create!(
  first_name: "Connie",
  last_name: "Hutchins",
  email: "connie@hutchins.com",
  phone: "310-561-9314",
  # profile_photo: File.open(File.join(Rails.root, 'app/assets/images/connie.jpg')),
  birthday: Time.gm(1914+34,"jul",17,20,15,1), 
  location: "Malibu, California",
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
  # profile_photo: File.open(File.join(Rails.root, 'app/assets/images/harold.jpg')),
  birthday: Time.gm(1914+34,"jun",12,20,15,1),
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
  # profile_photo: File.open(File.join(Rails.root, 'app/assets/images/carol.jpg')),
  birthday: Time.gm(1939+34,"feb",4,20,15,1),
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
  # profile_photo: File.open(File.join(Rails.root, 'app/assets/images/mike.jpg')),
  birthday: Time.gm(1937+34,"feb",4,20,15,1),
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
  # profile_photo: File.open(File.join(Rails.root, 'app/assets/images/greg.jpg')),
  birthday: Time.gm(1964+33,"aug",23,20,15,1),
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
  # profile_photo: File.open(File.join(Rails.root, 'app/assets/images/marcia.jpg')),
  birthday: Time.gm(1964+34,"nov",10,20,15,1),
  location: "Los Angeles, California",
  password: "foobar12",
  password_confirmation: "foobar12",
  gender: "F",
  mother_id: carol.id,
  father_id: mike.id,
  admin: 1,
  confirmed_at: Time.now
  )

cindy = Person.create!(
  first_name: "Cindy",
  email: "cindy@brady.com",
  phone: "310-243-8234",
  # profile_photo: File.open(File.join(Rails.root, 'app/assets/images/cindy.jpg')),
  birthday: Time.gm(1966+38,"nov",7,23,15,1),
  location: "Los Angeles, California",
  password: "foobar12",
  password_confirmation: "foobar12",
  gender: "F",
  mother_id: carol.id,
  father_id: mike.id,
  admin: 0,
  confirmed_at: Time.now
  )

peter = Person.create!(
  first_name: "Peter",
  email: "peter@brady.com",
  phone: "310-321-6735",
  # profile_photo: File.open(File.join(Rails.root, 'app/assets/images/peter.jpg')),
  birthday: Time.gm(1965+34,"oct",8,23,15,1),
  location: "Los Angeles, California",
  password: "foobar12",
  password_confirmation: "foobar12",
  gender: "M",
  mother_id: carol.id,
  father_id: mike.id,
  admin: 0,
  confirmed_at: Time.now
  )

bobby = Person.create!(
  first_name: "Bobby",
  email: "bobby@brady.com",
  phone: "310-765-4926",
  # profile_photo: File.open(File.join(Rails.root, 'app/assets/images/bobby.jpg')),
  birthday: Time.gm(1966+38,"nov",4,16,15,1),
  location: "Los Angeles, California",
  password: "foobar12",
  password_confirmation: "foobar12",
  gender: "M",
  mother_id: carol.id,
  father_id: mike.id,
  admin: 0,
  confirmed_at: Time.now
  )

jan = Person.create!(
  first_name: "Jan",
  email: "jan@brady.com",
  phone: "310-344-8362",
  # profile_photo: File.open(File.join(Rails.root, 'app/assets/images/jan.jpg')),
  birthday: Time.gm(1962+35,"feb",8,7,15,1),
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
  birthday: Time.gm(1947+34,"mar",2,20,15,1),
  # profile_photo: File.open(File.join(Rails.root, 'app/assets/images/jenny.jpg')),
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
    # profile_photo: File.open(File.join(Rails.root, 'app/assets/images/jon.jpg')),
    birthday: Time.gm(1945+34,"jan",1,20,15,1), 
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
    birthday: Time.gm(1971+38,"dec",30,20,15,1),
    # profile_photo: File.open(File.join(Rails.root, 'app/assets/images/jon_jr.jpg')),
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

brady.add_members([carol, connie, harold, mike, greg, marcia, cindy, peter, bobby, jan])
hutchins.add_members([jon, jenny, jon_jr, carol, connie, harold])

connie.add_spouse(harold)
carol.add_spouse(mike)


greg_marcia_convo = Conversation.create!(
  title: "Family Vacation to Hawaii",
  person_id: marcia.id,
  permissions: "greg#{greg.id}"
)

Message.create!(
  conversation_id: greg_marcia_convo.id,
  person_id: marcia.id,
  content: "Hey greg, what are you bringing to Hawaii?"
)

Message.create!(
  conversation_id: greg_marcia_convo.id,
  person_id: greg.id,
  content: "My surfboard and some swimmies."
)

Message.create!(
  conversation_id: greg_marcia_convo.id,
  person_id: marcia.id,
  content: "Cool, I was thinking we could surprise Mom and Dad by organizing a luau."
)

Message.create!(
  conversation_id: greg_marcia_convo.id,
  person_id: greg.id,
  content: "Yea! We can all wear matching outfits."
)

Message.create!(
  conversation_id: greg_marcia_convo.id,
  person_id: marcia.id,
  content: "I don't know if grandma and grandpa will be into it."
)

Message.create!(
  conversation_id: greg_marcia_convo.id,
  person_id: greg.id,
  content: "We should start an event and a conversation without mom and dad invited."
)

Message.create!(
  conversation_id: greg_marcia_convo.id,
  person_id: marcia.id,
  content: "Perfect, then we can brainstorm ideas with everyone."
)

Message.create!(
  conversation_id: greg_marcia_convo.id,
  person_id: greg.id,
  content: "Exactly."
)

Message.create!(
  conversation_id: greg_marcia_convo.id,
  person_id: marcia.id,
  content: "Great!"
)

Event.create!(
  name: "Surprise Luau for Mom and Dad!",
  person_id: greg.id,
  permissions: "1, 4, 9, 11",
  start_date: Time.now + 1.day + 4.hours,
  end_date: Time.now + 1.day + 10.hours,
  description: "Everyone meet at the beach at sundown!"
)

Event.create!(
  name: "Family Dinner",
  person_id: greg.id,
  permissions: "1, 2, 4, 9, 11",
  start_date: Time.now + 2.hours,
  end_date: Time.now + 4.hours,
  description: "Meatloaf"
)

Event.create!(
  name: "Shopping with Jan and Cindy",
  person_id: marcia.id,
  permissions: "jan#{jan.id} cindy#{cindy.id}",
  start_date: Time.now + 3.days,
  end_date: Time.now + 3.days + 3.hours,
  description: "Let's get new dresses for the summer."
)

album = Album.create!(name: "Family fun!", person_id: carol.id, family_id: brady.id, permissions: "1, 2, 3, 8, 12")

Photo.create!(
  # data: File.open(File.join(Rails.root, 'app/assets/images/album1.jpg')),
  caption: "At the beach in Hawaii",
  album_id: album.id
)

Photo.create!(
  # data: File.open(File.join(Rails.root, 'app/assets/images/album2.jpg')),
  caption: "The girls found some birds",
  album_id: album.id
)

Photo.create!(
  # data: File.open(File.join(Rails.root, 'app/assets/images/album3.jpg')),
  caption: "Family meeting",
  album_id: album.id
)

Photo.create!(
  # data: File.open(File.join(Rails.root, 'app/assets/images/album4.jpg')),
  caption: "Kodak moment!",
  album_id: album.id
)

Photo.create!(
  # data: File.open(File.join(Rails.root, 'app/assets/images/album5.jpg')),
  caption: "Top phone user of the fam",
  album_id: album.id
)





