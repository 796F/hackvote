class HacksController < ApplicationController
	
	def new
		# this is the dialog popup for creating a new hack.  nothing needed from rails. 
	end

	def edit
		# doesn't exist, were not editing any hacks.  
	end

	def create
		# currently the json pushed in contains data for 2 objects, not one.  so must extract from param.  
		form_data = params[:hack]
		# get the hackday from session.  
		hackday_id = session[:current_hackday_id]
		@hackday = Hackday.find(hackday_id)
		# create a hack object from some of the parameters
		hack = Hack.new(hack_url: form_data[:hack_url], img_url: form_data[:img_url], title: form_data[:title], votes:0)
		# create an owner from the owner's name parameter
		hack.create_owner(name: form_data[:owner])
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
		hack = Hack.find(params[:id])
		if session[votes_left_key()] < 1
			# out of votes.  do not change anything.  return old vote.  
			code=-1
			msg="Failed to Vote"
		else
			# increase the votes by 1
			hack.votes += 1
			if hack.save
				session[votes_left_key()] -= 1
				code=1
				msg="Vote Successful"
			else
				code = -2
				msg="Error Voting"
			end
		end
		resp = { :code => code, :msg => msg, :votes => hack.votes }
		render json: resp.to_json
		
	end

	def show
		# display the particular hack
		@hack = Hack.find(params[:id])
	end
end
