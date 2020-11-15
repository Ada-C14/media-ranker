class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work
  #GOOGLE rails model validation uniqueness scope

  # checks that user hasn't voted before
  validates :user, uniqueness: true

end
