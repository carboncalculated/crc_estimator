require "sinatra/base"
require 'rack/contrib/accept_format'
class RecurlyFaker < Sinatra::Base
  Rack::Mime::MIME_TYPES.delete(".xsl")
  use Rack::AcceptFormat
  
  before do
    response['Content-Type'] = 'application/xml'
  end
  
  post "/accounts.xml" do
    open(File.dirname(__FILE__) + '/../fixtures/recurly/account_create_success.xml')
  end
  
  get "/accounts/:id.xml" do |id|
    find_response = File.read(open(File.dirname(__FILE__) + '/../fixtures/recurly/account_find_success.xml'))
    find_response.gsub!('AID', id)    
  end
  
  post "/accounts/:account_code/subscription.xml" do
    open(File.dirname(__FILE__) + '/../fixtures/recurly/subscription_create_success.xml')
  end
end
