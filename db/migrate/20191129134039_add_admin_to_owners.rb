class AddAdminToOwners < ActiveRecord::Migration[6.0]
  def change
    add_column :owners, :admin, :boolean, default: false
  end
end
