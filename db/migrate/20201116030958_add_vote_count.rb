class AddVoteCount < ActiveRecord::Migration[6.0]
  def change
    add_column :works, :votes_count, :integer, default: 0
    add_column :users, :votes_count, :integer, default: 0
  end
end
