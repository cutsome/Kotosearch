class AddIndexToAgentTargetsAgentId < ActiveRecord::Migration[6.0]
  def change
    add_index :agent_targets, :agent_id
  end
end
