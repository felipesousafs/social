class User < ApplicationRecord
  rolify
  has_many :addresses
  has_many :contacts
  has_many :blocked_users
  has_many :followers
  has_many :posts
  has_many :chats
  has_many :messages
  has_many :friendships
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable

  accepts_nested_attributes_for :contacts, allow_destroy: true
  accepts_nested_attributes_for :addresses, allow_destroy: true

  def to_s
    self.email
  end

  def my_friendships(accepted: false)
    Friendship.where(receiver_id: self.id, accepted: accepted) + self.friendships.where(accepted: accepted)
  end

  def followed_posts
    posts_authors_ids = [self.id]
    posts_authors_ids << Friendship.where(receiver_id: self.id, accepted: true).pluck(:user_id)
    posts_authors_ids << self.friendships.where(accepted: true).pluck(:receiver_id)
    posts_authors_ids << Follower.where(follower_id: self.id).pluck(:user_id)
    Post.where(user_id: User.find(posts_authors_ids))
  end

end
