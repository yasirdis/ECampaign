# app/controllers/dashboard/campaign_templates_controller.rb
module Dashboard
  class CampaignTemplatesController < ApplicationController
    before_action :find_by_id, only: [ :send_campaign ]
    def index
      @campaign_templates = CampaignTemplate.where(campaign_id: params[:campaign_id])
      @campaign_id = params[:campaign_id]
    end
    def new
      @campaign_template = CampaignTemplate.new
      @campaign_id = params[:campaign_id]
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
      @campaign_id = @campaign_template.campaign_id
      @html_code = MjmlRenderer.to_html(@campaign_template.mjml)
    end

    def graphjs_email_studio
      if params[:id].present?
        @campaign_template = CampaignTemplate.find(params[:id])
        { project: @campaign_template.html_code || "{}" }
      else
        render json: { error: "No template ID provided" }, status: :unprocessable_entity
      end
    end

    def save_asset
      file = params[:files]
      if file.nil?
        render json: { error: "No file uploaded" }, status: :unprocessable_entity
        return
      end
      blob = ActiveStorage::Blob.create_and_upload!(
              io: file.tempfile,
              filename: file.original_filename,
              content_type: file.content_type
            )
      render json: [
        { src: url_for(blob) }
      ]
    end

    def destroy_asset
      @campaign_template = CampaignTemplate.find(params[:id])

      # Parse JSON string coming from GrapesJS
      project_data = JSON.parse(params[:project])
      assets = project_data["assets"] || []

      deleted = []

      assets.each do |asset|
        url = asset["src"]

        # Extract signed id from ActiveStorage URL
        # URL format:
        # /rails/active_storage/blobs/redirect/<SIGNED_ID>/<filename>
        if url =~ /blobs\/redirect\/([^\/]+)\//
          signed_id = Regexp.last_match(1)

          begin
            blob = ActiveStorage::Blob.find_signed(signed_id)

            # Remove the blob and its attachment
            blob.attachments.each(&:purge)
            blob.purge

            deleted << url
          rescue ActiveSupport::MessageVerifier::InvalidSignature
            Rails.logger.warn "Invalid signed_id: #{signed_id}"
          end
        end
      end

      render json: { deleted: deleted }
    end


    def project_load
      if params[:id].present?
        @campaign_template = CampaignTemplate.find(params[:id])
        raw = @campaign_template.html_code

        # If stored as Ruby hash string ("key"=>value)
        if raw.is_a?(String)
          json = raw.gsub("=>", ":")       # convert Ruby hash syntax to JSON
          json = JSON.parse(json) rescue {}
        else
          json = raw
        end

        render json: { project: json || "{}" }
      else
        render json: { error: "No template ID provided" }, status: :unprocessable_entity
      end
    end

    def template_save
      if params[:project].present? and params[:id].present?
        @campaign_template = CampaignTemplate.find(params[:id])
        project_hash = JSON.parse(params[:project])
        @campaign_template.update(html_code: project_hash, mjml: params[:mjml])
        head :ok
      elsif params[:project].present?
        CampaignTemplate.create(html_code: params[:project], name: "Untitled", mjml: params[:mjml])
      else
        render json: { error: "No project data provided" }, status: :unprocessable_entity
      end
    end

    def send_campaign
      Campaigns::CampaignMailer.send_campaign(to: "test@email.com", subject: "Test Subject", html: "<h1>Hello World</h1>").deliver_now
      render plain: "Campaign sent!"
    end

    def mjml_preview
      template = CampaignTemplate.find(params[:id])

      @html = MjmlRenderer.to_html(template.mjml).html_safe
    end

    private

    def find_by_id
      @campaign_template = CampaignTemplate.find(params[:id])
    end

    def template_params
      params.require(:campaign_template).permit(:name, :html_code, :css_code, :campaign_id, images: [])
    end
  end
end
