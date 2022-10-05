class CreateTables < ActiveRecord::Migration[7.0]
  def change
    create_table :tables do |t|
      t.integer :pavilion
      t.string :code
      t.integer :chairs
      t.string :image
      t.boolean :available

      t.timestamps
    end
  end
end
