class User
  include Mongoid::Document
  field :username, type: String
  field :firstname, type: String
  field :lastname, type: String
  field :email, type: String
  
  validates :email, email: true
end
