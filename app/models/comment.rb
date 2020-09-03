# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  comment    :text(65535)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  blog_id    :bigint
#  user_id    :integer
#
# Indexes
#
#  index_comments_on_blog_id  (blog_id)
#
# Foreign Keys
#
#  fk_rails_...  (blog_id => blogs.id)
#
class Comment < ApplicationRecord
  validates :comment, presence: true, length: { maximum: 100 }

  belongs_to :user
  belongs_to :blog
  has_many :notifications, dependent: :destroy
end
