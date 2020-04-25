# frozen_string_literal: true

require 'capybara'
require 'capybara/rspec'

Capybara.current_driver = :rack_test
Capybara.app = Sinatra::Application
Capybara.threadsafe = true

RSpec.configure do |config|
  config.include Capybara::DSL
end
