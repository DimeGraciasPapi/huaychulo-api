class CreateTables < ActiveRecord::Migration[7.0]
  def change
    create_table :tables do |t|
      t.string :pavilion
      t.string :code
      t.integer :chairs
      t.string :image
      t.boolean :available, default: true

      t.timestamps
    end
    add_index :tables, :code, unique: true
  end
end
