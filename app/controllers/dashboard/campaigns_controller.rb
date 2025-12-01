module Dashboard
  class CampaignsController < ApplicationController
    def index
      @campaigns =  Campaign.where(organization_id: session[:current_organization_id])
    end
  end
end
