class Path
  include Mongoid::Document
  
  has_one :user, as: :creator
  belongs_to :garden
  has_many :stones
  
  validates_presence_of :user
  validates_presence_of :garden
  
  def step_on_stone(leaf)
    stone = self.stones.where(leaf_id: leaf.id).first
    if stone.nil?
      stone = Stone.new(path: self, leaf: leaf, stepped: Time.now)
    else
      stone.stepped = Time.now
    end
      stone.save
  end
  
  def untread_stone(leaf)
    stone = self.stones.where(leaf_id: leaf.id)
    stone.destroy
  end
  
end
