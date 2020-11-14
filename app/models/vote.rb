class Vote < ApplicationRecord
  belongs_to :work
  belongs_to :user

  # validates :title, presence: true, uniqueness: true

end
