class User < ApplicationRecord
  has_many :votes, dependent: :destroy
  has_many :works, through: :votes

  validates :name, presence: true, uniqueness: true
end
