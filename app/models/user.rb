class User < ApplicationRecord
  has_many :votes

  validates :user_name, presence: true
  validates :category, presence: true
  validates :creator, presence: true
end
