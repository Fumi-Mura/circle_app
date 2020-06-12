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
require 'test_helper'

class CircleCategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
