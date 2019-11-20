class AddPasswordDigestToAgents < ActiveRecord::Migration[6.0]
  def change
    add_column :agents, :password_digest, :string
  end
end
