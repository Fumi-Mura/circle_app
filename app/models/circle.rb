class Circle < ApplicationRecord
  attachment :image
  
  has_many :circle_categories
  has_many :categories, through: :circle_categories
  
  belongs_to :user
end
