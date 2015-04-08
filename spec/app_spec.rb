require File.join(File.dirname(__FILE__), '..', 'app.rb')
require "rack/test"

set :enviroment, :test

def app
  Sinatra::Application
end

describe 'App Service' do
  include Rack::Test::Methods

  it "loads homepage" do
    get '/'

    expect(last_response).to be_ok
  end
end