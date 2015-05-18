class Invitation
  include DataMapper::Resource
  property :id, Serial
  property :created_at, DateTime
  property :updated_at, DateTime
  belongs_to :VipClient#, required: false
end
