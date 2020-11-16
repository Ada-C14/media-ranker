class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :work_id, presence: true
  validates :user_id, presence: true, uniqueness: {scope: :work_id, message: "You may only vote once"}


end
