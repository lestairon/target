class Request < ApplicationRecord
  belongs_to :user

  enum status: { pending: 0, in_progress: 1, solved: 2 }

  validates :text, presence: true
end
