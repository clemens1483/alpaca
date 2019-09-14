require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'
require './config/environments' #database configuration


class MelodiesController < ApplicationController

	get "/" do
	  #should check array size is small to prevent large arrays for DDOS
	  @melody = params[:melody].upcase.split(",")
	  #converts to integer
	  shift = params[:shift].to_i
	  shift_s = params[:shift]
	  erb :melodyapp

	end

end



		


