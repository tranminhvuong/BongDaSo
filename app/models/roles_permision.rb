class RolesPermision < ApplicationRecord
  belongs_to :role
  belongs_to :permision
end