class AddIndexToOwnerLeisuresLeisureId < ActiveRecord::Migration[6.0]
  def change
    add_index :owner_leisures, :leisure_id
  end
end
