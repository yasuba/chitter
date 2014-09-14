require 'sinatra'
require 'data_mapper'

env = ENV["RACK_ENV"] || "development"

DataMapper.setup(:default, "postgres://localhost/chitter_#{env}")

require './lib/peep'

DataMapper.finalize
DataMapper.auto_upgrade!

get '/' do
	@peeps = Peep.all
	erb :index
end

post '/peeps' do
	content = params['content']
	Peep.create(:content => content)
	redirect to('/')
end
