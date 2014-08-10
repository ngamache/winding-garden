class Leaf
  include Mongoid::Document
  include Mongoid::Slug
  
  field :title, type: String
  slug :title, :scope => :branch, :history => true
  field :body, type: String
  has_and_belongs_to_many :branches
  has_and_belongs_to_many :paths
  has_one :garden
  has_one :user, as: :creator
  
  validates_presence_of :user
  validates_presence_of :garden
  

end
