class RolesPermission < ApplicationRecord
  belongs_to :role
  belongs_to :permission
  acts_as_paranoid
end
