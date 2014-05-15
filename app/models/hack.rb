class Hack < ActiveRecord::Base
  belongs_to :hackday
  has_one :owner
  attr_accessible :hack_url, :img_url, :title, :votes
end
