class AddIndexToAgentTargetsTargetId < ActiveRecord::Migration[6.0]
  def change
    add_index :agent_targets, :target_id
  end
end
