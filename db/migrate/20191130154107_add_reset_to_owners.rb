class AddResetToOwners < ActiveRecord::Migration[6.0]
  def change
    add_column :owners, :reset_digest, :string
    add_column :owners, :reset_sent_at, :datetime
  end
end
