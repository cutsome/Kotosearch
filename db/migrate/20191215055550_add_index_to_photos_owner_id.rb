class AddIndexToPhotosOwnerId < ActiveRecord::Migration[6.0]
  def change
    add_index :photos, :owner_id
  end
end
