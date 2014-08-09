class MiniLeaf
  include Mongoid::Document
  include Mongoid::Slug
  
  field :title, type: String
  slug :title, :scope => :branch, :history => true
  has_one :user, as: :creator
  has_one :leaf
  embedded_in :branch
  
  validates_presence_of :user
  validates_presence_of :leaf
end
