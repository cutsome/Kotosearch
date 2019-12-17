class AddManyColumnsToOwners < ActiveRecord::Migration[6.0]
  def change
    add_column :owners, :address, :string
    add_column :owners, :scale, :string
    add_column :owners, :period, :string
    add_column :owners, :target_audience, :string
    add_column :owners, :photo, :string
  end
end
