require 'rubygems'
require 'sinatra'

helpers do
  def protect!
    unless authorized?
      response['WWW-Authenticate'] = %(Basic realm="Restricted Area")
      throw(:halt, [401, "Not authorized\n"])
    end
  end

  def authorized?
    @auth ||=  Rack::Auth::Basic::Request.new(request.env)
    username = ENV['BASIC_AUTH_USERNAME']
    password = ENV['BASIC_AUTH_PASSWORD']
    @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == [username, password]
  end
end

get '/' do
  protect!
  # 'アクセス制限なし'
  File.read(File.join('public', 'index.html'));
end

get '/famous_like_view/index.html' do
  protect!
  # 'アクセス制限なし'
  File.read(File.join('public', 'index.html'));
end