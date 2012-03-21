require 'bundler'
Bundler.require :default

enable :sessions

get '/' do
  haml :index
end

get '/app.js' do
  content_type "text/javascript"
  coffee :app
end

get '/style.css' do
  scss :style
end

get '/showcase/:type/:number' do
  @type = params[:type]
  @number = params[:number]
  haml :showcase, :layout => (request.xhr? ? false : :layout)
end

class Test
  attr_reader :stage
  def initialize( stage )
    @stage = stage
  end

  private

  def prepare_1
  end

end
