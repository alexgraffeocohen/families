module Brady
  
  def brady_bunch
    @brady = create(:family)
    @connie = create(:person, last_name: "Hutchins", gender: "F")
    @harold = create(:person, gender: "M")
    @carol = create(:person, mother_id: @connie.id, father_id: @harold.id, gender: "F")
    @mike = create(:person, gender: "M")
    @greg = create(:person, mother_id: @carol.id, father_id: @mike.id, gender: "M", email: "greg@greg.com")
    @marcia = create(:person, mother_id: @carol.id, father_id: @mike.id, gender: "F")
    @connie.add_spouse(@harold)
    @carol.add_spouse(@mike)
    @brady.add_members([@harold, @carol, @mike, @greg, @marcia])
  end
end
