class Message < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :chat
  validates :body, presence: true
  validates :chat_number, presence: true
  validates :application_token, presence: true
  validates :message_number, uniqueness: { scope: [:chat_number, :application_token] }
  settings do
    mappings dynamic: 'false' do
      indexes :body, type: :text, analyzer: 'standard'
      indexes :chat_number, type: :integer
      indexes :application_token, type: :keyword
    end
  end
end

