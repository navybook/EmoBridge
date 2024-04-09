class CreateMessageTemplates < ActiveRecord::Migration[7.1]
  def change
    create_table :message_templates do |t|
      t.text :message, null: false

      t.timestamps
    end
  end
end
