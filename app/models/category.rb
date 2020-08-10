# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  kind       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Category < ApplicationRecord
  has_many :circle_categories, dependent: :destroy
  has_many :circles, through: :circle_categories
end
