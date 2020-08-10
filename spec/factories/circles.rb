# == Schema Information
#
# Table name: circles
#
#  id         :bigint           not null, primary key
#  content    :text(65535)
#  name       :string(255)
#  place      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  blog_id    :integer
#  image_id   :string(255)
#  user_id    :integer
#
FactoryBot.define do
  factory :circle do
    name { "test_circle_name" }
    content { "test_circle_content" }
    association :user
  end
end
