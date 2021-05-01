class Application < Sinatra::Base
  get '/ping' do
    'OK'
  end
end
