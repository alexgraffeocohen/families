module Brady
  def brady_bunch
    @brady = create(:family)
    @connie = create(:person, last_name: "Hutchins", gender: "F")
        @connie.confirmed_at = Time.now
    @harold = create(:person, gender: "M")
        @harold.confirmed_at = Time.now
    @carol = create(:person, mother_id: @connie.id, father_id: @harold.id, gender: "F")
        @carol.confirmed_at = Time.now
    @mike = create(:person, gender: "M")
        @mike.confirmed_at = Time.now
    @greg = create(:person, mother_id: @carol.id, father_id: @mike.id, gender: "M", email: "greg@greg.com")
        @greg.confirmed_at = Time.now
    @marcia = create(:person, mother_id: @carol.id, father_id: @mike.id, gender: "F")
        @marcia.confirmed_at = Time.now
    @connie.add_spouse(@harold)
    @carol.add_spouse(@mike)
    @brady.add_members([@harold, @carol, @mike, @greg, @marcia])
  end
end
