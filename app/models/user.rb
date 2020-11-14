class User < ApplicationRecord
  has_many :votes, dependent: :destroy
  has_many :works, through: :votes

  validates :username,
            presence: true,
            uniqueness: true

  def includes_work?(work_id)
    works = self.works

    works.each do |work|
      return true if work.id == work_id
    end

    return false
  end
end
