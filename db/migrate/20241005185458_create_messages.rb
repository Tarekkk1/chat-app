class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table "messages", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
      t.string   "application_token"
      t.integer  "chat_number"
      t.integer  "message_number"
      t.string   "body"
      t.datetime "created_at",        null: false
      t.datetime "updated_at",        null: false
      t.integer  "chat_id"
      t.index ["chat_id"], name: "index_messages_on_chat_id", using: :btree
    end
  end
end
