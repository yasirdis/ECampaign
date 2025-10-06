module Dashboard
  class UsersController < BaseController
    def index
      authorize [:dashboard, :users]
      @users = User.joins(:organization_users)
                   .where(organization_users: { organization_id: session[:current_organization_id] })
    end
  end
end
