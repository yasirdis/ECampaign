class Campaign < ApplicationRecord
  belongs_to :organization
  has_many :campaign_templates, dependent: :destroy
end
