class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  #TODO: add validation for if user already voted on a work
end
