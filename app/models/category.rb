class Category < ApplicationRecord
  has_many :circle_categories
  has_many :circles, through: :circle_categories
end
