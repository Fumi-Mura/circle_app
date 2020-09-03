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
  validates :title, length: { maximum: 50 }
  validates :content, length: { maximum: 1000 }

  belongs_to :user
  belongs_to :circle
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :notifications, dependent: :destroy

  def liked_by?(user)
    likes.where(user_id: user.id).exists?
  end

  def create_notification_like!(current_user)
    temp = Notification.where([
      "visitor_id = ? and visited_id = ? and blog_id = ? and action = ? ",
      current_user.id, user_id, id, 'like',
    ])
    if temp.blank?
      notification = current_user.active_notifications.new(
        blog_id: id,
        visited_id: user_id,
        action: 'like'
      )
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  def create_notification_comment!(current_user, comment_id)
    temp_ids = Comment.select(:user_id).where(blog_id: id).
      where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_user, comment_id, temp_id['user_id'])
    end
    save_notification_comment!(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_user, comment_id, visited_id)
    notification = current_user.active_notifications.new(
      blog_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
