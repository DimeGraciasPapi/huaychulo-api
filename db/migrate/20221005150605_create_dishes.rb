class CreateDishes < ActiveRecord::Migration[7.0]
  def change
    create_table :dishes do |t|
      t.references :category, null: false, foreign_key: true
      t.string :name
      t.float :price
      t.integer :quantity
      t.text :description
      t.integer :waiting_time
      t.string :image

      t.timestamps
    end
    add_index :dishes, :name, unique: true
  end
end
