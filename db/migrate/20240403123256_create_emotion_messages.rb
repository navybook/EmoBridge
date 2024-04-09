class CreateEmotionMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :emotion_messages do |t|
      t.references :user, null: false, foreign_key: true
      t.references :emotion, null: false, foreign_key: true
      t.references :user_template, null: false, foreign_key: true
      t.text :message

      t.timestamps
    end
  end
end
