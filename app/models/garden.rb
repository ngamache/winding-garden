require "mongoid"

class Garden
  include Mongoid::Document
  field :name, type: String
  field :description, type: String
  embeds_many :branches, as: :branching
end
