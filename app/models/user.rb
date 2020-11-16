class User < ApplicationRecord
  has_many :works, through: :votes

  validates :username, presence: true
end
