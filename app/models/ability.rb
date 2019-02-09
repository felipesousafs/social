class Ability
  include CanCan::Ability

  def initialize(user)

    # Colocar algumas dessas regras em Concerns
    if user.present?
      can [:read, :destroy], Friendship do |f|
        f.user_id == user.id
        end
      can [:read, :update, :edit, :accept_friendship, :destroy], Friendship do |f|
        f.receiver_id == user.id
      end
      can :my_timeline, User
      can :read, Follower
      can :destroy, Follower, user_id: user.id
      can :read, Chat, user_id: user.id, receiver_id: user.id
      can [:edit, :friendship_requests], User, id: user.id

      can :read, User do |u|
        u.blocked_users.where(blocked_id: user.id).none?
      end
      can :follow, User do |u|
        (u.id != user.id) and u.followers.where(follower_id: user.id).none? and u.public_profile?
      end
      can :unfollow, User do |u|
        u.followers.where(follower_id: user.id).any?
      end
      can :send_friendship, User do |u|
        (u.id != user.id) and u.friendships.where(receiver_id: user.id).none? and user.friendships.where(receiver_id: u.id).none?
      end
      can :block_user, User do |u|
        (u.id != user.id) and user.blocked_users.where(blocked_id: u.id).none?
      end
      can :unblock_user, User do |u|
        user.blocked_users.where(blocked_id: u.id).any?
      end

      can [:read, :destroy], BlockedUser, user_id: user.id

      can [:new, :create], Post
      can :read, Post do |p|
        user.followed_posts.include?(p)
      end
      can [:edit, :update, :destroy], Post, user_id: user.id

      if user.has_role? :admin
        can [:read, :edit, :update, :destroy], :all
        can :read, :admin
        can :add_comment, Post
        can :add_superuser, User do |u|
          !(u.has_role? :admin)
          end
        can :remove_superuser, User do |u|
          u.has_role? :admin
        end
      end
    end
  end
end
