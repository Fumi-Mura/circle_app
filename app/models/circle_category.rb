# == Schema Information
#
# Table name: circle_categories
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  category_id :bigint
#  circle_id   :bigint
#
# Indexes
#
#  index_circle_categories_on_category_id  (category_id)
#  index_circle_categories_on_circle_id    (circle_id)
#
# Foreign Keys
#
#  fk_rails_...  (category_id => categories.id)
#  fk_rails_...  (circle_id => circles.id)
#
class CircleCategory < ApplicationRecord
  belongs_to :circle
  belongs_to :category
end
