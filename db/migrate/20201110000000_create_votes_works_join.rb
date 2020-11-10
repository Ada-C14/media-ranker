class CreateVotesWorksJoin < ActiveRecord::Migration[6.0]
  def change
    create_table :votes_works_joins do |t|
      t.belongs_to :vote, index: true
      t.belongs_to :work, index: true
    end
  end
end
