class AddActivtionToAgents < ActiveRecord::Migration[6.0]
  def change
    add_column :agents, :activation_digest, :string
    add_column :agents, :activated, :boolean, default: false
    add_column :agents, :activated_at, :datetime
  end
end
