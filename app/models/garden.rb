class Garden
  include Mongoid::Document
  include Mongoid::Slug
  
  field :name, type: String
  slug :name, :history => true
  field :description, type: String
  has_many :branches
  has_one :user, as: :creator
  has_many :leafs
  has_many :paths
  
  validates_presence_of :user
end
