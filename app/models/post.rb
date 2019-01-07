class Post < ApplicationRecord
  has_many :comments
  belongs_to :user
  has_one_attached :post_cover

  default_scope ->{ order(updated_at: :desc) }
  paginates_per 5


end
