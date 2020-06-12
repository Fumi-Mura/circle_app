# == Schema Information
#
# Table name: circles
#
#  id         :bigint           not null, primary key
#  content    :text(65535)
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  image_id   :string(255)
#  user_id    :integer
#
require 'test_helper'

class CircleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
