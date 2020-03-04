class Role < ApplicationRecord
  has_many :permisions
  has_one :user
end
