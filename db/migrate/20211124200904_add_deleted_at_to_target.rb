class AddDeletedAtToTarget < ActiveRecord::Migration[6.1]
  def change
    add_column :targets, :deleted_at, :datetime
    add_index :targets, :deleted_at
  end
end
