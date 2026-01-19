module Dashboard
  class OrganizationsController < ApplicationController
    def index
      @organizations = Organization.joins(:users).where(users: { id: params[:id] })
    end

    def switch
      org = current_user.organizations.find(params[:id])
      session[:current_organization_id] = org.id

      redirect_to dashboard_users_path(type_of: "dashboard_users")
    end
  end
end
