module WorksHelper
  def top_work_overall(works)
    return works.max_by{|work| work.votes.count}
  end

  def top_ten_works(works, category)
    return works.where(category: category).max_by(10){|work| work.votes.count}
  end

  def categories
    return
  end
end
