class User < ApplicationRecord
  has_many :votes #, through: :works

  validates :username, presence: true, uniqueness: true

  #custom methods
end
