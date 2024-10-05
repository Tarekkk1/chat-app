class CreateChats < ActiveRecord::Migration[5.0]
  def change
    create_table :chats do |t|
      t.references :application, foreign_key: true
      t.integer :creation_number
      t.string :application_token

      t.timestamps
    end
  end
end
