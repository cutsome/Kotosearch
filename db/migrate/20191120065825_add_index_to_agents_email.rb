class AddIndexToAgentsEmail < ActiveRecord::Migration[6.0]
  def change
    add_index :agents, :email, unique: true
  end
end
