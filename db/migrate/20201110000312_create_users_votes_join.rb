class CreateUsersVotesJoin < ActiveRecord::Migration[6.0]
  def change
    create_table :users_votes_joins do |t|
      t.belongs_to :user, index: true
      t.belongs_to :vote, index: true
    end
  end
end
