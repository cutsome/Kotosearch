class AddRememberDigestToOwners < ActiveRecord::Migration[6.0]
  def change
    add_column :owners, :remember_digest, :string
  end
end
