class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.integer :user_type, default: 0
      t.string :name
      t.string :last_name
      t.bigint :document
      t.string :password_digest
      t.float :intake, default: 0
      t.integer :document_type, default: 0
      t.string :token

      t.timestamps
    end
    add_index :users, :token, unique: true
    add_index :users, :document, unique: true
  end
end
