class Branch
  include Mongoid::Document
  include Mongoid::Slug
  
  field :name, type: String
  slug :name, :scope => :branching, :history => true
  field :description, type: String
  belongs_to :garden
  has_one :user, as: :creator
  has_and_belongs_to_many :leafs
    
  validates_presence_of :user
  
  validates_uniqueness_of :name, scope: :garden
  
end
