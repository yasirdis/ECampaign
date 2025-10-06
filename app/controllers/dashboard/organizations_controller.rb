module Dashboard
  class OrganizationsController < ApplicationController
    def index
      @organizations = Organization.all
      auth
    end
  end
end
