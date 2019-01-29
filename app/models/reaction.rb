class Reaction < ApplicationRecord
  has_paper_trail
  belongs_to :post
  belongs_to :user
  belongs_to :reaction_type
end
