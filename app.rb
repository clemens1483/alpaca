require 'sinatra'
require 'sinatra/activerecord'
require './models/key'  #load class
# require 'sinatra/reloader' only used for development and testing

set :port, 9292 #set localhost port, alternatively run rackup config.ru to start server


def parameters()
	@melody = params[:melody].upcase.split(",") #create array of notes in melody parameter
	@shift = params[:shift] #shift parameter
end



get '/' do
	parameters()
	melody_db = Key.where(name: @melody).pluck(:id, :name) #array of subarrays [id,name] of notes in @melody
	melody_db_name = melody_db.map{ |a| a[1]} #array of only names 

	if @shift.to_i.to_s == @shift #checks if @shift has the form of an integer

		if (@melody - melody_db_name).empty? #checks if each value in melody param is in Key table
			# for each note in @melody get the corresponding id
			s_melody_id = [] #initialise array for shifted ids
			@melody.each do |note|
				melody_db.each do |notedb|
					if note == notedb[1] #names match
						s_melody_id << notedb[0]+@shift.to_i #add shifted (by shift param) id to array
					end
				end
			end

			if s_melody_id.max <= 88 #checks if the resulting ids are out of range of the Key table	
				s_melody_db = Key.where(id: s_melody_id).pluck(:id, :name) #retrieve [id,name] of shifted ids from Key table
				# for each id in s_melody_id get corresponding key name
				@s_melody = [] #initalise array for shifted melody
				s_melody_id.each do |noteid|
					s_melody_db.each do |s_notedb|
						if noteid == s_notedb[0] #ids match
							@s_melody << s_notedb[1] #add corresponding name to array
						end
					end
				end
			else #shift out of range
				@out_of_range = true #for out of range error message in /views/melody/erb
			end
		else #there is a parameter which is not a note			
			@melody_invalid = true #for melody invalid error message in /views/melody/erb
		end
	else #shift is not an integer
	    @shift_invalid = true  #for shift invalid error message in /views/melody/erb
	end

	erb :melody #call views/melody.erb

end

