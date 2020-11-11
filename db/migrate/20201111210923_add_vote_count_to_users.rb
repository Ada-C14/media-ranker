class AddVoteCountToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :votes_count, 0
  end
end
