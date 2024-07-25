class CreateUserStates < ActiveRecord::Migration[7.1]
  def change
    create_table :user_states do |t|
      t.references :user, null: false, foreign_key: true
      t.string :state
      t.string :feeling
      t.string :category
      t.string :rating
      t.string :message_template
      t.timestamps
    end
  end
end
