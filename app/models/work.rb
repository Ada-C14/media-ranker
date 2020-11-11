class Work < ApplicationRecord
  def top_ten(category)
    top_ten_list = Work.where(category: category)
    return top_ten_list
  end
end
