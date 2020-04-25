# frozen_string_literal: true

module RSpecSinatra
  include Rack::Test::Methods

  def app
    described_class
  end
end

RSpec.configure do |config|
  config.include RSpecSinatra
end
