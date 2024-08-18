class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.integer :user_id, null: false
      t.integer :partner_id, null: false
      t.integer :emotion_id, null: false
      t.integer :status, null: false, default: 0

      t.timestamps
    end

    add_index :notifications, :user_id
    add_index :notifications, :partner_id
    add_index :notifications, :emotion_id
  end
end
