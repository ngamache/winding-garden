class Leaf
  include Mongoid::Document
  field :title, type: String
  field :body, type: String
  embeds_one :branch, as: :branching
end
