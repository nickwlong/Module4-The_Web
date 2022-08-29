require 'sinatra/base'
require 'sinatra/reloader'

class Application < Sinatra::Base
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
  end

  get '/hello' do
    name = params[:name]
    return "Hello #{name}"
  end 

  post '/submit' do
    name = params[:name]
    message = params[:message]

    return "Thanks #{name}, you sent this message: \"#{message}\""
  end

  post '/sort-names' do
    names = params[:names]
    return names.split(',').sort.join(',')
  end


#   # Request:
# POST /submit

# # With body parameters:
# name=Leo
# message=Hello world

# # Expected response (2OO OK):
# Thanks Leo, you sent this message: "Hello world"
end