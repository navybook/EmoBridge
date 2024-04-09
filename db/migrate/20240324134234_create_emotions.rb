class CreateEmotions < ActiveRecord::Migration[7.1]
  def change
    create_table :emotions do |t|
      t.string :feeling, null: false
      t.integer :feeling_score
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
