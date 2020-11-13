class AddWorkIdToVotes < ActiveRecord::Migration[6.0]
  def change
    add_column :votes, :work_id, :integer
  end
end
