require 'yaml'
require 'csv'
require 'mongo'

config = YAML.load_file('config.yml')
client = Mongo::Client.new([ config['mongo']['host'] ], :database => config['mongo']['database'])
CSV.foreach(config['csv']['file'], headers:config['csv']['has_header']) do |row|
  client[config['mongo']['collection']].insert_one(row.to_hash)
end