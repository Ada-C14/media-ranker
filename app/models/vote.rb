class Vote < ApplicationRecord
  validates
  belongs_to :work
  belongs_to :user
end
