class Peep

	include DataMapper::Resource

	# has n, :users, :through => Resource

	property :id, Serial
	property :content, String


end