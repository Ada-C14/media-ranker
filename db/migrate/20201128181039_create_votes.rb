class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.string :work

      t.timestamps
    end
  end
end
