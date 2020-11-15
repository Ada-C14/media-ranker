class Vote < ApplicationRecord
  validates :user, presence: true

end
