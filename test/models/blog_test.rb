# == Schema Information
#
# Table name: blogs
#
#  id         :bigint           not null, primary key
#  content    :text(65535)
#  title      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  circle_id  :integer
#  image_id   :string(255)
#  user_id    :integer
#
require 'test_helper'

class BlogTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
