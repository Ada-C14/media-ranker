class RelateWorksToVotes < ActiveRecord::Migration[6.0]
  def change
    # this migration will create a work_id column and appropriate index.
    add_reference :votes, :work, index: true
  end
end
