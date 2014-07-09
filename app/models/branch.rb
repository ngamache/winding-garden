class Branch
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  embedded_in :branching, polymorphic: true
  has_one :user, as: :creator
  
  validates_presence_of :user
end
