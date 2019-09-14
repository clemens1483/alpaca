require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require './config/environments' #database configuration
require './models/key'  #load class


get "/" do
    #create array of notes in melody parameter
	@melody = params[:melody].upcase.split(",")
	#shift parameter
	@shift = params[:shift]
	#initialise array for ids of notes
	notes_id_a = []
	#checks if each note exists in the database and if it does adds its id to the array notes_id_a
	@melody.each do |note|
	  if Key.exists?(name: note)
	    note_id = Key.where(name: note).pluck(:id).join.to_i
		notes_id_a << note_id
	  end
	end

	#checks if @shift has the form of an integer
	if @shift.to_i.to_s == @shift 
        #checks if notes_id_a contains as many notes as @melody in which case all the keys are valid
        if notes_id_a.length == @melody.length
          #shifts every member of notes_id_a by shift
          shift_id_a = notes_id_a.map { |a| a+@shift.to_i }
          #checks if the resulting ids are out of range of the Key table	          
          if shift_id_a.max <= 88
          	#initialises array for shifted key names used in /views/melody.erb
            @shift_name_a = []
            #finds the name for each key with id in shift_id_a array and adds it to shift_name_a
            shift_id_a.each do |key|
              key_name = Key.where(id: key).pluck(:name).join.to_s
              @shift_name_a << key_name
            end
          else
            #the the ids in shifted array shift_id_a are out of range 
            @out_of_range = true  #for /views/melody/erb
          end

        else
          #the melody contains invalid keys
          @melody_invalid = true  #for /views/melody/erb
        end

    else
      #shift is not an integer
      @shift_invalid = true  #for /views/melody/erb
    end
    #call views/melody.erb
    erb :melody

end



