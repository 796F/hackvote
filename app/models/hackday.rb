class Hackday < ActiveRecord::Base
	has_many :hacks
  attr_accessible :day, :img_url, :title
end
