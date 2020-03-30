class Post < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_rich_text :content
  acts_as_paranoid

  scope :cate, ->(str){
    joins(:category).where("categories.name = ?", str)
  }

  scope :pub, -> {
    where(status: true)
  }
end
