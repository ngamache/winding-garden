class User
  include Mongoid::Document
  include Mongoid::Slug
  
  field :username, type: String
  slug :username, :history => true
  field :firstname, type: String
  field :lastname, type: String
  field :email, type: String
  belongs_to :creator, polymorphic: true
  has_many :stones
  has_many :paths
  
  validates :email, email: true
  validates_uniqueness_of :username
  validates_uniqueness_of :email
  
end
