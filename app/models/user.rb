class User < ApplicationRecord
  has_many :votes, dependent: :delete_all

  validates :username, presence: true
end
