class Leaf
  include Mongoid::Document
  include Mongoid::Slug
  
  field :title, type: String
  slug :title, :scope => :branch, :history => true
  field :body, type: String
  embeds_one :branch, as: :branching
  has_one :garden
  has_one :user, as: :creator
  belongs_to :mini_leaf, dependent: :destroy
  
  validates_presence_of :user
  validates_presence_of :garden
  
  after_update :update_mini_leaf
  after_upsert :update_mini_leaf

  def update_mini_leaf
    unless self.mini_leaf.nil?
      self.mini_leaf.user = self.user
      self.mini_leaf.title = self.title
      self.mini_leaf.save
      self.save
    end
  end
  
end
