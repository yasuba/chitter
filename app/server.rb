require 'sinatra'
require 'data_mapper'
require 'rack-flash'

require './lib/peep'
require './lib/user'
require_relative 'helpers/application'
require_relative 'data_mapper_setup'

enable :sessions
set :session_secret, 'super secret'
use Rack::Flash

get '/' do
  if params[:user]
     @peeps = User.first(id: params[:user].to_i).peeps.sort{|a,b| b.timestamp <=> a.timestamp}
  else
    @peeps = Peep.all.sort{|a,b| b.timestamp <=> a.timestamp}
  end
  @session = session[:user_id]
  erb :index
end

post '/peeps' do
  Peep.with(params['content'], current_user)
  redirect to('/')
end

get '/users/new' do
  @user = User.new
  erb :"users/new"
end

post '/users' do
  @user = User.new(:name => params[:name],
           :username => params[:username],
           :email => params[:email],
           :password => params[:password],
           :password_confirmation => params[:password_confirmation])
  if @user.save
    session[:user_id] = @user.id
    redirect to('/')
  else
    flash[:notice] = @user.errors.full_messages
    erb :"users/new"
  end
end

get '/sessions/new' do
  erb :"sessions/new"
end

post '/sessions' do
  username, password = params[:username], params[:password]
  user = User.authenticate(username, password)
  if user
    session[:user_id] = user.id
    redirect to ('/')
  else
    flash[:errors] = ["The email or password is incorrect"]
      erb :"sessions/new"
  end
end

delete '/sessions' do
  flash[:notice] = "Good bye!"
  session[:user_id] = nil
  redirect('/')
end
