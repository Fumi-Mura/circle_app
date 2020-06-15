# == Schema Information
#
# Table name: likes
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  blog_id    :integer
#  user_id    :integer
#
class Like < ApplicationRecord
  belongs_to :user
  belongs_to :blog
  
  validates_uniqueness_of :blog_id, scope: :user_id
end
