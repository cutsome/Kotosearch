class CreateOwnerLeisures < ActiveRecord::Migration[6.0]
  def change
    create_table :owner_leisures do |t|
      t.integer :owner_id
      t.integer :leisure_id

      t.timestamps
    end
  end
end
