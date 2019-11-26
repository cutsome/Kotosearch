class AddRememberDigestToAgents < ActiveRecord::Migration[6.0]
  def change
    add_column :agents, :remember_digest, :string
  end
end
