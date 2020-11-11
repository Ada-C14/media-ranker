class CreateTableWorks < ActiveRecord::Migration[6.0]
  def change
    create_table :works do |t|
      t.string :title
      t.string :description
      t.date :publication_date
      t.string :category
      t.timestamps
    end
  end
end
