# frozen_string_literal: true

VCR.configure do |config|
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.default_cassette_options = { record: :new_episodes }

  config.filter_sensitive_data('<CONTENTFUL_ACCESS_TOKEN>') { ENV.fetch('CONTENTFUL_ACCESS_TOKEN') }
  config.filter_sensitive_data('<CONTENTFUL_SPACE') { ENV.fetch('CONTENTFUL_SPACE') }
end
