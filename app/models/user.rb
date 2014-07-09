class User
  include Mongoid::Document
  field :username, type: String
  field :firstname, type: String
  field :lastname, type: String
  field :email, type: String
  belongs_to :creator, polymorphic: true
  
  validates :email, email: true
end
