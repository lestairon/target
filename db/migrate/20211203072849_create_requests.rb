class CreateRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :requests do |t|
      t.references :user, null: false, foreign_key: true
      t.text :text, null: false
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
