# frozen_string_literal: true

require 'rubygems'
require 'bundler'

Bundler.require(:default)
Bundler.require(Sinatra::Base.environment)

Dir['./config/initializers/*.rb'].sort.each { |file| require file }
Dir['./app/**/*.rb'].sort.each { |file| require file }
