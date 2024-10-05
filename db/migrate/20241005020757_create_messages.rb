class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.references :chat, foreign_key: true
      t.text :message_body
      t.integer :chat_creation_number
      t.string :application_token
      t.integer :creation_number

      t.timestamps
    end
  end
end
