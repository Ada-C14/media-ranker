class Vote < ApplicationRecord

  belongs_to :work
  belongs_to :user

  validates :work, :presence => true
  validates :user, :presence => true

  validates_uniqueness_of :user_id, :scope => :work_id

end
