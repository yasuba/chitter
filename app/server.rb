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
	@peeps = Peep.all
	erb :index
end

post '/peeps' do
	content = params['content']
	Peep.create(:content => content)
	redirect to('/')
end

get '/users/new' do
	@user = User.new
	erb :"users/new"
end

post '/users' do
	@user = User.new(:email => params[:email],
				:password => params[:password])
	if @user.save
		session[:user_id] = @user.id
		redirect to('/')
	else
		flash.now[:errors] = @user.errors.full_messages
		erb :"users/new"
	end
end

get '/sessions/new' do
	erb :"sessions/new"
end

post '/sessions' do
	email, password = params[:email], params[:password]
	user = User.authenticate(email, password)
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
