module Dashboard
  class CampaignsController < ApplicationController
    def index
      @campaigns =  Campaign.where(organization_id: session[:current_organization_id])
    end

    def new
      @campaign = Campaign.new
    end

    def create
      @campaign = Campaign.new(permitted_params)
      @campaign.organization_id = session[:current_organization_id]
      @campaign.save!

      redirect_to dashboard_campaigns_path
    end

    private

    def permitted_params
      params.require(:campaign).permit(:name)
    end
  end
end
