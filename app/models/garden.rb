require "mongoid"

class Garden
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  embeds_many :branches, as: :branching
  has_one :user, as: :creator
  
  validates_presence_of :user
end
