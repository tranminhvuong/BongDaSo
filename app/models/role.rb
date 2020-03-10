class Role < ApplicationRecord
  has_many :roles_permissions
  has_many :permissions, through: :roles_permissions
  belongs_to :user
  acts_as_paranoid
end
