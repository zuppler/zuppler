require 'vcr'

VCR.config do |c|
  c.cassette_library_dir = 'features/cassettes'
  c.stub_with :webmock
end

VCR.cucumber_tags do |t|
  t.tag  '@vcr', :use_scenario_name => true
end
