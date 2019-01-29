class Comment < ApplicationRecord
  has_paper_trail
  belongs_to :post
  belongs_to :user

  def to_s
    text
  end
end
