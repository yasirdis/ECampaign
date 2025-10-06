class CreateCampaignTemplates < ActiveRecord::Migration[8.0]
  def change
    create_table :campaign_templates do |t|
      t.string :name
      t.text :html_code
      t.text :css_code
      t.references :campaign, null: false, foreign_key: true

      t.timestamps
    end
  end
end
