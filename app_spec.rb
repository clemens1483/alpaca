require File.dirname(__FILE__) + '/app.rb'
require 'test/unit'
require 'rack/test'

set :environment, :test

def app
  Sinatra::Application
end

describe 'Melody Transposition' do
	include Rack::Test::Methods
	melody_param = 'B4,B4,C5,D5,D5,C5,B4,A4'
	melody_param_inv = 'B4,K4,C5,D5,D5,C5,B4,A4'

	it "should be out of range" do
		get '/',{:melody => melody_param, :shift => '400'}
    	expect(last_response.body).to include 'transposed melody out of range'   	
	end

	it "should be an invalid value for melody" do
		get '/',{:melody => melody_param_inv, :shift => '4'}
    	expect(last_response.body).to include "invalid value for melody: 'B4,K4,C5,D5,D5,C5,B4,A4'"   	
	end

	it "should be an invalid value for shift 'hello'" do
		get '/',{:melody => melody_param, :shift => 'hello'}
    	expect(last_response.body).to include "invalid value for shift: 'hello'"   	
	end

	it "should return the melody shifted by 4" do
		get '/',{:melody => melody_param, :shift => '4'}
    	expect(last_response.body).to include 'D#5,D#5,E5,F#5,F#5,E5,D#5,C#5'   	
	end
end