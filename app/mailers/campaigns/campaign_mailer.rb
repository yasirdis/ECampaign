module Campaigns
  class CampaignMailer < ApplicationMailer
    def send_campaign(to:, subject:, html:)
      m = mail(to: to, subject: subject) do |format|
            format.html { render html: html.html_safe }
          end
    end
  end
end