class CreateEmotionCategories < ActiveRecord::Migration[7.1]
  def change
    create_table :emotion_categories do |t|
      t.references :emotion, null: false, foreign_key: true
      t.references :user_category, null: false, foreign_key: true
      t.integer :rating, null: false

      t.timestamps
    end
  end
end
