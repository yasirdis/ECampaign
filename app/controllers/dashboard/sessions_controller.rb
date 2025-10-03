# frozen_string_literal: true

module Dashboard
  class SessionsController < Devise::SessionsController
    class RestrictedError < StandardError; end

    # rescue_from RestrictedError, with: :restricted

    def after_sign_out_path_for(resource)
      new_user_session_path
    end

    def after_sign_in_path_for(resource)
      dashboard_analytics_path
    end

    # def restricted
    #   sign_out(resource)
    #   flash.delete(:notice)
    #   if resource.has_role?(:staff)
    #     render 'sunset/index', layout: 'application'
    #   else
    #     flash[:error] = 'You don\'t have permission to access this site.'
    #     redirect_to new_user_session_path
    #   end
    # end
  end
end
