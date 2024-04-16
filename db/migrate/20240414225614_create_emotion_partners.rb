class CreateEmotionPartners < ActiveRecord::Migration[7.1]
  def change
    create_table :emotion_partners do |t|
      t.integer :user_id, null: false
      t.integer :partner_id, null: false

      t.timestamps
    end
  end
end
