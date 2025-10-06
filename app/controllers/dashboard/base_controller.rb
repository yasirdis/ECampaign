module Dashboard
  class BaseController < ApplicationController
    before_action :authenticate_user!
    include Pundit::Authorization  # ✅ Add this line

    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  end
end
