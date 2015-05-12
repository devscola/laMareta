class VipClient
  include DataMapper::Resource
  property :id, Serial
  property :name, Text
  property :birthday, Date
  property :email, Text
  has n, :invitations
end

def validate

end