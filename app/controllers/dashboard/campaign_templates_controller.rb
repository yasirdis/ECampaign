# app/controllers/dashboard/campaign_templates_controller.rb
module Dashboard
  class CampaignTemplatesController < ApplicationController
    def index
      @campaign_templates = CampaignTemplate.where(campaign_id: params[:campaign_id])
    end
    def new
      @campaign_template = CampaignTemplate.new
    end

    def create
      @template = CampaignTemplate.new(template_params)
      if @template.save!
        redirect_to [ :dashboard, @template ], notice: "Template created!"
      else
        render :new
      end
    end

    def show
        @campaign_template = CampaignTemplate.find(params[:id])
    end

    def graphjs_email_studio
      @campaign_template = CampaignTemplate.find(params[:id])
    end

    def save_asset
      puts "//////////////////"
    end

    def destroy_asset
    end

    def project_load
      puts "jjjjjjjjjj"
    end

    def project_save
      puts "rrrrrrrrr------------------ rrr"
      puts params[:project]
    end

    private

    def template_params
      params.require(:campaign_template).permit(:name, :html_code, :css_code, :campaign_id, images: [])
    end
  end
end
