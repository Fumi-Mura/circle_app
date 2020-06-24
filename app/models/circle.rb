# == Schema Information
#
# Table name: circles
#
#  id         :bigint           not null, primary key
#  content    :text(65535)
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  blog_id    :integer
#  image_id   :string(255)
#  user_id    :integer
#
class Circle < ApplicationRecord
  attachment :image
  
  with_options presence: true do
    validates :name
    validates :content
  end
  validates :name, length: {maximum: 30}
  validates :content, length: {maximum: 1000}
  
  has_many :circle_categories, dependent: :destroy
  has_many :categories, through: :circle_categories
  has_many :blogs, dependent: :destroy
  belongs_to :user
end
