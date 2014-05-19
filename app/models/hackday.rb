class Hackday < ActiveRecord::Base
  has_many :hacks
  attr_accessible :day, :img_url, :title

  validates :title, :day, :presence => true
  validates :title, :length => { :minimum => 3 }
end
