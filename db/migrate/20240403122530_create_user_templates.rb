class CreateUserTemplates < ActiveRecord::Migration[7.1]
  def change
    create_table :user_templates do |t|
      t.references :user, null: false, foreign_key: true
      t.references :message_template, null: false, foreign_key: true

      t.timestamps
    end
  end
end
