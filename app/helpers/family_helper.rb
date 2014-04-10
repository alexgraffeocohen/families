module FamilyHelper
  def create_accounts(params, family)
    params[:people][:emails].each do |account| 
      family.person_families.build(person: Person.create(email: account))
      family.save
    end
  end
end
