class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :votes_left_key
  def votes_left_key 
    "votes_left_" + session[:current_hackday_id].to_s
  end
end
