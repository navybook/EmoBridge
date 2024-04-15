class AddUniqueIndexToEmotionPartners < ActiveRecord::Migration[7.1]
  def change
    add_index :emotion_partners, :user_id, unique: true
  end
end
