class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.references :work
      t.references :user

      t.timestamps
    end
  end
end
