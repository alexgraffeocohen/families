module FamilyHelper
  def create_accounts(params, family)
    created_accounts = []
    params[:people][:emails].each do |account|
      new_person = Person.create(email: account)
      created_accounts << new_person
      family.person_families.build(person: new_person)
      family.save
    end
    created_accounts
  end
end
