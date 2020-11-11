class User < ApplicationRecord
  has_many :works, through: :votes

  validates :username, uniqueness: { case_sensitive: false }

end
