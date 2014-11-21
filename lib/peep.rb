class Peep

  include DataMapper::Resource

  has 1, :user, :through => Resource

  property :id, Serial
  property :content, String
  property :timestamp, DateTime

  def self.with(content, user)
      create(content: content, user: user, timestamp: Time.now )
  end

end