class CreateLikes < ActiveRecord::Migration[7.1]
  def change
    create_table :likes do |t|
      t.references :emotion, null: false, foreign_key: true
      t.integer :sender_id, null: false
      t.integer :receiver_id, null: false

      t.timestamps
    end

    add_index :likes, [:emotion_id, :sender_id, :receiver_id], unique: true
  end
end
