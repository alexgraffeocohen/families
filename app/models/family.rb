class Family < ActiveRecord::Base
  has_many :person_families
  has_many :people, :through => :person_families, foreign_key: :person_id
  has_many :albums

  def add_members(family_members_array)
    family_members_array.each do |family_member|
      person_families.create(person_id: family_member.id)
      family_member.last_name ||= self.name
    end
  end

end
