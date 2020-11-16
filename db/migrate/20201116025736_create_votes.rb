class CreateVotes < ActiveRecord::Migration[6.0]
  def change
    create_table :votes do |t|
      t.bigint :user_id
      t.bigint :work_id

      t.timestamps
    end
  end
end
