# frozen_string_literal: true

require 'spec_helper'
require 'sinatra_helper'

RSpec.describe Sinatra::Application do
  describe 'route /' do
    it 'accepts the request' do
      get '/'

      expect(last_response).to be_ok
      expect(last_response.body).to eq 'Hello, Marley Spoon!'
    end
  end
end
