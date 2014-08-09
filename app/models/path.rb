class Path
  include Mongoid::Document
  
  embeds_one :mini_leaf, as: :leafy
end
