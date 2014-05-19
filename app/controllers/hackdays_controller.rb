class HackdaysController < ApplicationController
  def index
    # launch the homepage, which has a link to the latest hack.  
    @hackday = Hackday.order("created_at").last
  end

  def create
    # hackday popup posts here to create new hackdays, data is stored, and we respond with json.
    @hackday = Hackday.create(params[:hackday])
    if @hackday.valid?
      render :json => { :code => true }
    else
      render :status => :bad_request, :text => @hackday.errors.full_messages
    end
  end

  def show
    # find the hackday in the url ex domain.com/hackdays/1
    @hackday = Hackday.find_by_id(params[:id])
    # page has a link to prev day, so try to get the prev day, may not exist though.  
    @prev_hackday = Hackday.where("created_at < ?", @hackday.created_at).last
    # each user session get 3 votes per hackday.  
    if session[votes_left_key()] == nil
      #session previously did not exist.  initialize
      session[votes_left_key()] = 3
    end

    @votes_left = session[votes_left_key()]
  end

end
