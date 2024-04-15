class CreateInvitations < ActiveRecord::Migration[7.1]
  def change
    create_table :invitations do |t|
      t.integer :sender_id
      t.integer :receiver_id
      t.integer :status, default: 0 # 招待状の状態
      t.datetime :expires_at # 招待の有効期限

      t.timestamps
    end

    add_index :invitations, :sender_id
    add_index :invitations, :receiver_id
  end
end
