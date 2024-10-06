class CreateChats < ActiveRecord::Migration[5.0]
  def change
    create_table "chats", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
      t.string   "application_token"
      t.integer  "chat_number"
      t.integer  "messages_count",    default: 0
      t.datetime "created_at",                    null: false
      t.datetime "updated_at",                    null: false
      t.integer  "application_id"
      t.index ["application_id"], name: "index_chats_on_application_id", using: :btree
    end
  end
end
