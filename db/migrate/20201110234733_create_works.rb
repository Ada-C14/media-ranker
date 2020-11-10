class CreateWorks < ActiveRecord::Migration[6.0]
  def change
    create_table :works do |t|
      t.string :title
      t.string :created_by
      t.integer :published
      t.string :description
      t.string :media

      t.timestamps
    end
  end
end
