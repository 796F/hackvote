class Owner < ActiveRecord::Base
  belongs_to :hack
  attr_accessible :name
end
