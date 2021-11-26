class AddTargetsCountToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :targets_count, :integer
  end
end
