class Path
  include Mongoid::Document
  
  has_one :user, as: :creator
  has_and_belongs_to_many :leafs
  
  validates_presence_of :user
  
  def add_leaf(leaf)
    self.mini_leafs[] = leaf.create_mini_leaf(self)
  end
  
end
