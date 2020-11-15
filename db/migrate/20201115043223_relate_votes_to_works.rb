class RelateVotesToWorks < ActiveRecord::Migration[6.0]
  def change
    add_reference :votes, :works, index: true
  end
end
