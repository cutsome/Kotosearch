class AddIndexToPhotosAgentId < ActiveRecord::Migration[6.0]
  def change
    add_index :photos, :agent_id
  end
end
