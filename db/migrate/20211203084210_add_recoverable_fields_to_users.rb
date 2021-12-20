class AddRecoverableFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    change_table :users, bulk: true do |t|
      t.string :reset_password_token
      t.datetime :reset_password_sent_at
    end
  end
end
