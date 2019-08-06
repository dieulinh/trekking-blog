config = {
  host: ENV['ELASTICSEARCH_HOST'],
  transport_options: {
   request: { timeout: 10000 }
  },
  logger: Logger.new(STDERR)
}

# if File.exists?("config/elasticsearch.yml")
#   config.merge!(YAML.load_file("config/elasticsearch.yml")[Rails.env].deep_symbolize_keys)
# end

Elasticsearch::Model.client = Elasticsearch::Client.new(config)
