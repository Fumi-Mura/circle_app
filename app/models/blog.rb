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
class Blog < ApplicationRecord
  attachment :image
  
  with_options presence: true do
    validates :title
    validates :content
  end
  validates :title, length: {maximum: 50}
  validates :content, length: {maximum: 1000}
  
  belongs_to :user
  belongs_to :circle
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  
  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end
end
