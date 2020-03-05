class Role < ApplicationRecord
  has_many :roles_permisions
  has_many :permisions, through: :roles_permisions
  belongs_to :user
end
