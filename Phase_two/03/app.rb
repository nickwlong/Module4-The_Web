require 'sinatra/base'
require 'sinatra/reloader'

class Application < Sinatra::Base
  # This allows the app code to refresh
  # without having to restart the server.
  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    # The erb method takes the view file name (as a Ruby symbol)
    # and reads its content so it can be sent 
    # in the response.
    return erb(:index)
  end

  get '/hello' do
    @name = params[:name]
    return erb(:hello)
  end

  post '/sort-names' do
    names = params[:names]
    return names.split(',').sort.join(',')
  end

end