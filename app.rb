require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require './config/environments' #database configuration
require './models/key'  #load class


get "/" do
		#should check array size is small to prevent large arrays for DDOS
		@melody = params[:melody].upcase.split(",")
		#shift parameter
		@shift = params[:shift]
		
		
		#creates an active record relation with all entries that match the name
		#of the keys in the search array and converts it to an array
		#.pluck(:id) only returns id of the keys
		# .to_a converts to array
		#Should put this in first if statement for efficiency
		#@parameter_db = Key.where(name: @melody).pluck(:id).to_a
		#initialise empty array
		@parameter_db = []

		@melody.each do |note|
			if Key.exists?(name: note)
			  note_id = Key.where(name: note).pluck(:id).join.to_i
			  @parameter_db << note_id
			end
		end


		#converts shift to integer and back to string and checks if it's the same
		if @shift.to_i.to_s == @shift
			#should check how to redfine variable value
	        #checks if the table array contains as many keys as the parameters
	        #in which case all the keys are valid
	        if @parameter_db.length == @melody.length
	          #shifts every member of parameter_db by shift
	          shift_id_a = @parameter_db.map { |a| a+@shift.to_i }	          
	          if shift_id_a.max <= 88
	            #finds corresponding keys in table
	            #shift_name_a = Key.where(id: shift_id_a).pluck(:name).to_a
	            shift_name_a = []
	            shift_id_a.each do |note|
	              shift_name_a << Key.where(id: note).pluck(:name).join.to_s
	            end
	          @keys = shift_name_a
	         else
	          @out_of_range = true 
	         end


	        else
	        	@melody_invalid = true
	        end

        else
        	@shift_invalid = true
         end
         erb :melody

end



