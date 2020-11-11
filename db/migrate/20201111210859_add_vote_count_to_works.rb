class AddVoteCountToWorks < ActiveRecord::Migration[6.0]
  def change
    add_column :works, :votes_count, 0
  end
end
