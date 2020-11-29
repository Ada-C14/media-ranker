class Vote < ApplicationRecord
  validates :user, uniqueness: {scope: :work}

  belongs_to :user
  belongs_to :work
end
