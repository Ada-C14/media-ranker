class ResetAllArticlesCacheCounters < ActiveRecord::Migration[6.0]
  def change
    Work.all.each do |work|
      Work.reset_counters(work.id, :votes)
    end
  end
end
