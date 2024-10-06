config = YAML.load_file(Rails.root.join('config', 'elasticsearch.yml'))[Rails.env]

Elasticsearch::Model.client = Elasticsearch::Client.new(
  host: config['host'],
  log: true
)
