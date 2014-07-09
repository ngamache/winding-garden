class Leaf
  include Mongoid::Document
  include Mongoid::Slug
  
  field :title, type: String
  slug :title, :scope => :branch, :history => true
  field :body, type: String
  embeds_one :branch, as: :branching
  has_one :user, as: :creator
  
  validates_presence_of :user
end
