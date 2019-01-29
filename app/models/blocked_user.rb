class BlockedUser < ApplicationRecord
  has_paper_trail
  belongs_to :user
  after_create :remove_friend_and_follower

  def remove_friend_and_follower
    follower = self.user.followers.find_by(follower_id: self.blocked_id)
    if follower
      follower.destroy
    end
    friendship_received = Friendship.where(receiver_id: self.user_id, user_id: self.blocked_id).first
    if friendship_received
      friendship_received.destroy
    end
    friendship_sent = self.user.friendships.where(receiver_id: self.blocked_id).first
    if friendship_sent
      friendship_sent.destroy
    end
  end
end
