class Hack < ActiveRecord::Base
  belongs_to :hackday
  attr_accessible :hackday_id, :hack_url, :img_url, :title, :votes, :owner, :description 

  validates :title, :hackday, :presence => true
  validates :title, :length => { :minimum => 3 }
  
end
