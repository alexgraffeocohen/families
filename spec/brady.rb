module Brady
  def make_brady_bunch
    @brady    = create(:family, name: "Brady")
    @hutchins = create(:family, name: "Hutchins")

    @connie = create(:person, first_name: "Connie", last_name: "Hutchins", gender: "F", confirmed_at: Time.now)
    @harold = create(:person, first_name: "Harold", last_name: "Hutchins", gender: "M", confirmed_at: Time.now)
    
        @carol = create(:person, first_name: "Carol", mother_id: @connie.id, father_id: @harold.id, gender: "F", confirmed_at: Time.now)
        @jenny = create(:person, first_name: "Jenny", mother_id: @connie.id, father_id: @harold.id, gender: "F", confirmed_at: Time.now)
        @jon   = create(:person, first_name: "Jon", mother_id: @connie.id, father_id: @harold.id, gender: "M", confirmed_at: Time.now)
            @jon_jr = create(:person, first_name: "Jon Jr.", father_id: @jon.id, confirmed_at: Time.now)

    @robert  = create(:person, first_name: "Robert", last_name: "Brady", gender: "M", confirmed_at: Time.now)
    @rachel  = create(:person, first_name: "Rachel", last_name: "Brady", gender: "F", confirmed_at: Time.now)
    @nathan  = create(:person, first_name: "Nathan", last_name: "Smith", gender: "M", confirmed_at: Time.now)

        @mike    = create(:person, first_name: "Mike", father_id: @robert.id, mother_id: @rachel.id, gender: "M", confirmed_at: Time.now)
        @rebekah = create(:person, first_name: "Rebekah", father_id: @robert.id, mother_id: @rachel.id, gender: "F", confirmed_at: Time.now)
        @dan     = create(:person, first_name: "Dan", father_id: @robert.id, mother_id: @rachel.id, gender: "M", confirmed_at: Time.now)
    
        @greg   = create(:person, first_name: "Greg", mother_id: @carol.id, father_id: @mike.id, gender: "M", confirmed_at: Time.now)
        @peter  = create(:person, first_name: "Peter", mother_id: @carol.id, father_id: @mike.id, gender: "M", confirmed_at: Time.now)
        @bobby  = create(:person, first_name: "Bobby", mother_id: @carol.id, father_id: @mike.id, gender: "M", confirmed_at: Time.now)
        @marcia = create(:person, first_name: "Marcia", mother_id: @carol.id, father_id: @mike.id, gender: "F", confirmed_at: Time.now)
        @cindy  = create(:person, first_name: "Cindy", mother_id: @carol.id, father_id: @mike.id, gender: "F", confirmed_at: Time.now)
        @jan    = create(:person, first_name: "Jan", mother_id: @carol.id, father_id: @mike.id, gender: "F", confirmed_at: Time.now)
    
    @connie.add_spouse(@harold)
    @carol.add_spouse(@mike)
    @rachel.add_spouse(@nathan)
    @brady.add_members([@connie, @harold, @carol, @mike, @greg, @marcia, @cindy, @peter, @bobby, @jan, @robert, @rachel])
    @hutchins.add_members([@connie, @harold, @carol, @jon, @jenny, @jon_jr])
  end
end
