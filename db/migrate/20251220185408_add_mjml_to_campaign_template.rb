class AddMjmlToCampaignTemplate < ActiveRecord::Migration[8.0]
  def change
    add_column :campaign_templates, :mjml, :text
  end
end
