class Permision < ApplicationRecord
  has_many :roles_permisions
  has_many :role, through: :roles_permisions
end
