class RenameVotesColumnInWorks < ActiveRecord::Migration[6.0]
  def change
    rename_column(:works, :votes, :vote_count)
    Work.reset_column_information
    Work.update_all(vote_count: 0)
  end
end
