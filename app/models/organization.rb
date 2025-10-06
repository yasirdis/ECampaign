class Organization < ApplicationRecord
  has_many :organization_users
  has_many :users, through: :organization_users
  has_many :campaigns, dependent: :destroy
  # An organization can have many users through the join model organization_users
  # This allows for a many-to-many relationship between organizations and users
  # only settings of a business need to be stored
end
