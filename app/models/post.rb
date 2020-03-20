class Post < ApplicationRecord
  belongs_to :user
  has_rich_text :content
  acts_as_paranoid
end
