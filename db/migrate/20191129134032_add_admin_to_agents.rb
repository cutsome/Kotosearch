class AddAdminToAgents < ActiveRecord::Migration[6.0]
  def change
    add_column :agents, :admin, :boolean, default: false
  end
end
