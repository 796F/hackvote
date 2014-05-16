class HackdaysController < ApplicationController
  def homepage
    # launch the homepage, which has a link to the latest hack.  
    begin
      @hackday = Hackday.order("created_at").last
    rescue ActiveRecord::RecordNotFound => e
      @hackday = nil
    end
  end

  def create
    # hackday popup posts here to create new hackdays, data is stored, and we respond with json.
    @hackday = Hackday.new(params[:hackday])
    if @hackday.save
      resp = { :code => true }
      render json: resp.to_json
    else
      render :status => :bad_request, :text => "Failed to create Hackday"
    end
  end

  def show
    # find the hackday in the url ex domain.com/hackdays/1
    hackday_id = params[:id]
    @hackday = Hackday.find(hackday_id)
    # page has a link to prev day, so try to get the prev day, may not exist though.  
    begin
      @prev_hackday = Hackday.find(hackday_id.to_i-1)
    rescue ActiveRecord::RecordNotFound => e
      @prev_hackday = nil
    end
    # save it into session for use when adding hacks to hackdays
    # this probably wouldnt' have been necessary if i had used nested resources.  discovered it later.  
    session[:current_hackday_id] = hackday_id
    # each user session get 3 votes per hackday.  
    if session[votes_left_key()] == nil
      #session previously did not exist.  initialize
      session[votes_left_key()] = 3
    end

    @votes_left = session[votes_left_key()]
  end

end
