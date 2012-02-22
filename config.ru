require 'rubygems'
require 'sinatra'
require 'pp'
require 'haml'

class Stream
  def initialize(path)
    @path = path
  end

  def each
	Dir::foreach(@path) { |f| yield "<a href='box1/#{f}'>#{f}</a><BR>\n" }
  end
end

get('/') { haml :index }
get('/box1') {
	Stream.new('public/box1')
	
}
post '/upload' do
    if params[:file]
        #new_filename = DateTime.now.strftime('%s') + File.extname(params[:file][:filename])
	new_filename = params[:file][:filename]
        save_file = './public/box1/' + new_filename
        File.open(save_file, 'wb'){ |f| f.write(params[:file][:tempfile].read) }
        #@mes = 'upload completed!'
	haml :upload
    end
end
run Sinatra::Application

