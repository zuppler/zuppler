require 'vcr'

VCR.configure do |c|
  c.cassette_library_dir = 'features/cassettes'
  c.hook_into :webmock
  c.allow_http_connections_when_no_cassette = true
end

VCR.cucumber_tags do |t|
  t.tag '@vcr', use_scenario_name: true
end
