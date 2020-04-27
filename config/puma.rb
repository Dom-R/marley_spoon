# frozen_string_literal: true

ENV['RACK_ENV'] = 'production'

workers 3
preload_app!
