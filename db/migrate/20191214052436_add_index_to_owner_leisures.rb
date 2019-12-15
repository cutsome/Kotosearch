class AddIndexToOwnerLeisures < ActiveRecord::Migration[6.0]
  def change
    add_index :owner_leisures, :owner_id
  end
end
