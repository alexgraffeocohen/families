module Checkable
  def singular_checkbox_hash(relationships, index, hash)
    hash[index+1] = [self.send(relationships[0]).try(:permission_slug)]
    hash[index+1] = [] if hash[index+1].nil?
    hash[index+1] << self.send(relationships[1]).try(:permission_slug)
  end

  def group_checkbox_hash(relationships, index, hash)
    hash[index+1] = self.send(parametize(relationships[0])).try(:map) do |rel| 
      rel.permission_slug
    end
    if relationships[1] && self.send(parametize(relationships[1]))
      hash[index+1] << self.send(parametize(relationships[1])).map {|rel| rel.permission_slug}
    end
  end
end