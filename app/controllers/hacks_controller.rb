class HacksController < ApplicationController

  def create
    # currently the json pushed in contains data for 2 objects, not one.  so must extract from param.  
    form_data = params[:hack]
    # get the hackday from session.  
    @hackday = Hackday.find_by_id(session[:current_hackday_id])
    # create a hack object from some of the parameters
    hack = Hack.new(:hack_url => form_data[:hack_url], img_url: form_data[:img_url], title: form_data[:title], votes:0)
    # create an owner from the owner's name parameter
    hack.create_owner(:name => form_data[:owner])
    # assign the hack to that hackday
    hack.hackday = @hackday
    if hack.save
      redirect_to hackday_path(@hackday)
    else
      # not handling the error yet.  not sure about the right way to architect this in rails. 
      redirect_to hackday_path(@hackday)
    end
  end

  def update
    # PUT here to increase the vote on a certain hack
    hack = Hack.find_by_id(params[:id])
    if session[votes_left_key()] < 1
      # out of votes.  do not change anything.  return old vote.  
      code = false
      msg = "out of votes"
    else
      # increase the votes by 1
      hack.votes += 1
      if hack.save
        session[votes_left_key()] -= 1        
        msg = "Voted Successfully"
        code = true
      else
        render :status => :bad_request, :text => @hack.errors.full_messages
      end
    end
    render json: { :code => code, :msg => msg, :votes => hack.votes }
  end

  def show
    # display the particular hack
    @hack = Hack.find_by_id(params[:id])
  end
end
