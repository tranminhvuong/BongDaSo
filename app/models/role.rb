class Role < ApplicationRecord
  has_many :users
  acts_as_paranoid

  validates :name, presence: true, length: { maximum: 255 }
end
