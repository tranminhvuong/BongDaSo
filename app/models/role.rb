class Role < ApplicationRecord
  has_many :users
  acts_as_paranoid
end
