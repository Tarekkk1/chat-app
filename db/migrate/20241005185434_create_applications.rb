class CreateApplications < ActiveRecord::Migration[5.0]
  def change
    create_table "applications", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1" do |t|
      t.string   "name"
      t.string   "token"
      t.datetime "created_at",              null: false
      t.datetime "updated_at",              null: false
      t.integer  "chats_count", default: 0
    end
  end
end
