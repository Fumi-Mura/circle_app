# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  confirmation_sent_at   :datetime
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  name                   :string(255)
#  profile_text           :text(65535)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string(255)
#  unconfirmed_email      :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  profile_image_id       :string(255)
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable
  attachment :profile_image

  has_many :circles, dependent: :destroy
  has_many :blogs, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :active_relationships, class_name:  "Relationship",
                                  foreign_key: "follower_id",
                                  dependent:   :destroy
  has_many :passive_relationships, class_name:  "Relationship",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :entries
  has_many :messages
  has_many :rooms, through: :entries

  with_options presence: true do
    validates :name
    validates :email
  end
  validates :name, length:{maximum:30}
  validates :profile_text, length:{maximum:200}

  def already_liked?(blog)
    self.likes.exists?(blog_id: blog.id)
  end

  def follow(other_user)
    return if self == other_user
    unless following?(other_user)
      following << other_user
    end
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy! if following?(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def self.guest
    find_or_create_by!(name: "ゲストユーザー", email: 'guestuser@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end

end
