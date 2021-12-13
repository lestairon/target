class AddAddressToTarget < ActiveRecord::Migration[6.1]
  def change
    add_column :targets, :address, :string
  end
end
