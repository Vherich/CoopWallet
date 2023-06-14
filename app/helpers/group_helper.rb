module GroupHelper
  module Name
    def self.find(id)
      group = Group.find(id)
      return group.group_name if group
    end
  end
end
