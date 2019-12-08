class CreateAgentTargets < ActiveRecord::Migration[6.0]
  def change
    create_table :agent_targets do |t|
      t.integer :agent_id
      t.integer :target_id

      t.timestamps
    end
  end
end
