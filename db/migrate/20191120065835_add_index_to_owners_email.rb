class AddIndexToOwnersEmail < ActiveRecord::Migration[6.0]
  def change
    add_index :owners, :email, unique: true
  end
end
