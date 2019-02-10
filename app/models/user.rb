class User < ApplicationRecord
  rolify
  has_paper_trail
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

  has_one_attached :avatar
  accepts_nested_attributes_for :contacts, allow_destroy: true
  accepts_nested_attributes_for :addresses, allow_destroy: true

  after_update :new_location, unless: :current_address
  after_update :update_location, if: :current_address

  def to_s
    self.first_name || self.email
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

  def soft_delete
    update_attribute(:disabled_at, Time.current)
  end

  # ensure user account is active
  def active_for_authentication?
    super && !disabled_at
  end

  # provide a custom message for a deleted account
  def inactive_message
    !disabled_at ? super : :deleted_account
  end

  def current_address
    self.addresses.first&.street
  end

  def new_location
    if self.latitude and self.longitude
      api = ApiService.new(self.email, token: self.authentication_token)
      response = api.create_location(self.latitude, self.longitude)
      self.addresses.create(street: response['address'])
    end
  end

  def update_location
    if self.latitude and self.longitude
      api = ApiService.new(self.email, token: self.authentication_token)
      response = api.update_location(self.latitude, self.longitude)
      self.addresses.first.update(street: response['address'])
    end
  end

  def get_nearby_users
    api = ApiService.new(self.email, token: self.authentication_token)
    api.nearby_users
  end

  def full_name
    "#{first_name} #{last_name}"
  end

end
