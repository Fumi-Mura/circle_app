# == Schema Information
#
# Table name: comments
#
#  id         :bigint           not null, primary key
#  comment    :text(65535)      not null
#  name       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  blog_id    :bigint
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
  
  validates :name, presence: true, length: {maximum: 30}
  validates :comment, presence: true, length: {maximum: 500}
  
  belongs_to :blog
end
