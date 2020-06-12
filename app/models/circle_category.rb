# == Schema Information
#
# Table name: circle_categories
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :integer
#  circle_id   :integer
#
class CircleCategory < ApplicationRecord
  belongs_to :circle
  belongs_to :category
end
