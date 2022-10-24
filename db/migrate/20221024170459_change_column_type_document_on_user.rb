class ChangeColumnTypeDocumentOnUser < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :document, :bigint
  end
end
