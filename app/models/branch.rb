class Branch
  include Mongoid::Document
  include Mongoid::Slug
  
  field :name, type: String
  slug :name, :scope => :branching, :history => true
  field :description, type: String
  embedded_in :branching, polymorphic: true
  has_one :user, as: :creator
  embeds_one :mini_leaf
    
  validates_presence_of :user
  
end
