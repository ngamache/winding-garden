class Garden
  include Mongoid::Document
  include Mongoid::Slug
  
  field :name, type: String
  slug :name, :history => true
  field :description, type: String
  embeds_many :branches, as: :branching
  has_one :user, as: :creator
  belongs_to :leaf
  
  validates_presence_of :user
end
