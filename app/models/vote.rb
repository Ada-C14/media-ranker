class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :work

  validates :user_id, presence: true
  validates :work_id, presence: true
  validates :user_id, uniqueness: { scope: :work,
                                    message: "Only one vote per work, please" }

  def user_votes_table_row
    work = self.work
    return [work.title, work.creator, work.publication, work.category.capitalize, self.created_at, work.id]
  end
end
