class User
  include DataMapper::Resource
  property :id, Serial
  property :name, Text
  property :birthday, Date
  property :email, Text
  property :winner, Boolean, :default => false
  has n, :invitations
end
