class Leaf
  include Mongoid::Document
  field :title, type: String
  field :body, type: String
  embeds_one :branch, as: :branching
  has_one :user, as: :creator
  
  validates_presence_of :user
end
