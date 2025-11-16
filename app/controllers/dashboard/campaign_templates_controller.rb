# app/controllers/dashboard/campaign_templates_controller.rb
module Dashboard
  class CampaignTemplatesController < ApplicationController
    def new
      @template = CampaignTemplate.new
    end

    def create
      @template = CampaignTemplate.new(template_params)
      if @template.save!
        redirect_to [ :dashboard, @template ], notice: "Template created!"
      else
        render :new
      end
    end

    private

    def template_params
      params.require(:campaign_template).permit(:name, :html_code, :css_code, :organization_id, images: [])
    end
  end
end
