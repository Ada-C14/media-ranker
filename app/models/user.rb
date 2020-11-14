class User < ApplicationRecord
  #has_many ..

  validates :username, presence: true, uniqueness: true

  #custom methods
end
