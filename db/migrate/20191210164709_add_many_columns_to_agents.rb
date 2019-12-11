class AddManyColumnsToAgents < ActiveRecord::Migration[6.0]
  def change
    add_column :agents, :category, :string
    add_column :agents, :address, :string
    add_column :agents, :scale, :string
    add_column :agents, :target_audience, :string
  end
end
