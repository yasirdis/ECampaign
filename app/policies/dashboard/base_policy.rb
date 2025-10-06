module Dashboard
  class BasePolicy < ApplicationPolicy

    def has_dasboard_access
      nil
      # puts "hhhhhhhhhhhhhhhhhhhhhhhhhh"
      # puts record.to_json
      # user.roles.where(resource_id: sessions[:current_organization_id]).exists?
    end

    def has_admin_role
      user.has_role?(:admin)
    end
  end
end
