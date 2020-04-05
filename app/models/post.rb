class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_rich_text :content
  acts_as_paranoid

  validates :title, presence: true, length: { maximum: 255 }
  validates :user_id, presence: true
  validates :category_id, presence: true

  scope :cate, ->(str){
    joins(:category).where("categories.name = ?", str)
  }

  scope :pub, -> {
    where(status: true)
  }
end
