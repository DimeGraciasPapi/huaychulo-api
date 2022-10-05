class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.integer :type
      t.string :name
      t.string :last_name
      t.string :document
      t.string :password_digest
      t.float :intake, default: 0
      t.integer :document_type
      t.string :token

      t.timestamps
    end
    add_index :users, :token, unique: true
    add_index :users, :document, unique: true
  end
end
