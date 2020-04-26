# frozen_string_literal: true

ContentfulModel.configure do |config|
  config.access_token = ENV.fetch('CONTENTFUL_ACCESS_TOKEN')
  config.space = ENV.fetch('CONTENTFUL_SPACE')
end
