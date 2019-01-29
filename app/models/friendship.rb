class Friendship < ApplicationRecord
  has_paper_trail
  belongs_to :user

  def receiver
    User.find(receiver_id)
  end
end
