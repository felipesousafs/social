class Message < ApplicationRecord
  has_paper_trail
  belongs_to :user
  belongs_to :chat
end
