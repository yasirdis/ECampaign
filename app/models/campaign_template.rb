class CampaignTemplate < ApplicationRecord
  belongs_to :campaign
  has_many_attached :images
end
