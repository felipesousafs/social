class Friendship < ApplicationRecord
  belongs_to :user


  def receiver
    User.find(receiver_id)
  end
end
