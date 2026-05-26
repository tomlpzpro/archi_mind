class CreateFurnitures < ActiveRecord::Migration[8.1]
  def change
    create_table :furnitures do |t|
      t.string :title
      t.text :description
      t.references :project, null: false, foreign_key: true

      t.timestamps
    end
  end
end
