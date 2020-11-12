class Work < ApplicationRecord
  validates :title, presence: true, uniqueness: true

  def spotlight

  end

  def get_top_ten

  end
end
