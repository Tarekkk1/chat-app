class AddIndexToApplications < ActiveRecord::Migration[5.0]
  def change
    add_index :applications, :token, unique: true, name: 'index_applications_on_token', using: :btree
  end
end
