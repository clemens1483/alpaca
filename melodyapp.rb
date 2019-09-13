require 'sinatra'
require 'sinatra/reloader'

get "/" do
  #should check array size is small to prevent large arrays for DDOS
  @melody = params[:melody].upcase.split(",")
  #converts to integer
  shift = params[:shift].to_i
  shift_s = params[:shift]
  erb :melodyapp

end



		


