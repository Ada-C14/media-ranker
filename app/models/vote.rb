class Vote < ApplicationRecord
  belongs_to :works
  belongs_to :users

  validates :user_id, uniqueness: { scope: :work_id }
end
