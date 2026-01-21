module Dashboard
  class OrganizationsController < ApplicationController
    def index
      @organizations = Organization.joins(:users).where(users: { id: params[:id] })
    end

    def switch
      org = current_user.organizations.find(params[:id])
      session[:current_organization_id] = org.id

      redirect_to dashboard_analytics_path
    end
  end
end
