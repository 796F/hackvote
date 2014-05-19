class HacksController < ApplicationController

  def create
    @hackday = Hackday.find_by_id(params[:hackday_id])
    hack = @hackday.hacks.create(params[:hack])
    if hack.valid?
      redirect_to hackday_path(@hackday)
    else
      render :status => :bad_request, :text => hack.errors.full_messages
    end
  end

  def update
    hack = Hack.find_by_id(params[:id])
    if session[votes_left_key()] < 1
      # out of votes.
      code = false
      msg = "out of votes"
    else
      hack.votes += 1
      if hack.save
        session[votes_left_key()] -= 1        
        msg = "Voted Successfully"
        code = true
      else
        render :status => :bad_request, :text => @hack.errors.full_messages
      end
    end
    render :json => { :code => code, :msg => msg, :votes => hack.votes }
  end

  def show
    # display the particular hack
    @hack = Hack.find_by_id(params[:id])
  end
end
