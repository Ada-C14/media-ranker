class CreateWorks < ActiveRecord::Migration[6.0]
  def change
    create_table :works do |t|
      t.string :name
      t.string :creator
      t.date :publication_date
      t.string :category
      t.string :description

      t.timestamps
    end
  end
end
