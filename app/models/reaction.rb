class Reaction < ApplicationRecord
  belongs_to :post
  belongs_to :user
  belongs_to :reaction_type
end
