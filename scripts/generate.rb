require 'toml'

SOURCE = Rails.root.join('db/demo.toml')

sample_data = TOML.load_file(SOURCE)
sample_data.each do |model_name, records|
  model_class = model_name.classify.constantize
  puts records.each { |r| model_class.create! r }
end
