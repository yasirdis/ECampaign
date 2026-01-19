class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :organization_users
  has_many :organizations, through: :organization_users
  # A user can belong to many organizations through the join model organization_users
  # This allows for a many-to-many relationship between users and organizations
  def highest_access_role
    priority = %w[admin full_access manage read_only]
    role = roles
            .where(name: priority)
            .pluck(:name)
            .min_by { |r| priority.index(r) }

    role&.titleize
  end
end
