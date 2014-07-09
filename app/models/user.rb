class User
  include Mongoid::Document
  include Mongoid::Slug
  
  field :username, type: String
  slug :username, :history => true
  field :firstname, type: String
  field :lastname, type: String
  field :email, type: String
  belongs_to :creator, polymorphic: true
  
  validates :email, email: true
end
