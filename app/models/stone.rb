class Stone
  include Mongoid::Document
  field :stepped, type: DateTime
  belongs_to :path
  belongs_to :leaf

end
