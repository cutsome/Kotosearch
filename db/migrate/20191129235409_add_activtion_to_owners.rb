class AddActivtionToOwners < ActiveRecord::Migration[6.0]
  def change
    add_column :owners, :activation_digest, :string
    add_column :owners, :activated, :boolean, default: false
    add_column :owners, :activated_at, :datetime
  end
end
