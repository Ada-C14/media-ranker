class Work < ApplicationRecord
  has_many :users, through: :votes

end
