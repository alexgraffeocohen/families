module Brady
  def make_brady_bunch
    @brady = create(:family, name: "Brady")
    @connie = create(:person, first_name: "Connie", last_name: "Hutchins", gender: "F")
        @connie.confirmed_at = Time.now
    @harold = create(:person, first_name: "Harold", gender: "M")
        @harold.confirmed_at = Time.now
    @carol = create(:person, first_name: "Carol", mother_id: @connie.id, father_id: @harold.id, gender: "F")
        @carol.confirmed_at = Time.now
    @mike = create(:person, first_name: "Mike", gender: "M")
        @mike.confirmed_at = Time.now
    @greg = create(:person, first_name: "Greg", mother_id: @carol.id, father_id: @mike.id, gender: "M", email: "greg@greg.com")
        @greg.confirmed_at = Time.now
    @marcia = create(:person, first_name: "Marcia", mother_id: @carol.id, father_id: @mike.id, gender: "F")
        @marcia.confirmed_at = Time.now
    @connie.add_spouse(@harold)
    @carol.add_spouse(@mike)
    @brady.add_members([@harold, @carol, @mike, @greg, @marcia])
  end
end
