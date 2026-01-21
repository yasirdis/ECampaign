module Dashboard
  class UsersController < BaseController
    before_action :find_by_id, only: [ :show ]
    def index
      authorize [ :dashboard, :users ]
      @users = User.joins(:organization_users)
                   .where(organization_users: { organization_id: session[:current_organization_id],
                                                type_of: :dashboard_user })
    end

    def show
      @user
    end

    private

    def find_by_id
      @user = User.find(params[:id])
    end
  end
end
