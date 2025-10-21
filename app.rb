#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "barbershop.db"}

class Client < ActiveRecord::Base
end

class Barber <ActiveRecord::Base
end

class Contact <ActiveRecord::Base
end

before do
	@barbers = Barber.all
end

get '/' do
	erb :index
end

get '/visit' do
	erb :visit
end

post '/visit' do

	@username = params[:username]
	@phone = params[:phone]
	@datetime = params[:datetime]
	@barber = params[:barber]
	@color = params[:color]

	Client.create(
		name: "#{@username}", 
		phone: "#{@phone}", 
		datestamp: "#{@datetime}", 
		barber: "#{@barber}", 
		color: "#{@color}")

	erb "OK, username is #{@username}, #{@phone}, #{@datetime}, #{@barber}, #{@color}"

end

get '/contacts' do
	erb :contacts	
end

post '/contacts' do 

	@name = params[:name]
	@email = params[:email]
	@message = params[:message]

	hh = {
		:name => "Enter name",
		:email => "Enter email",
		:message => "Enter message" }

	@error = hh.select {|key,_| params[key] == ""}.values.join(", ")

	if @error != ""
		return erb :contacts
	else
		Contact.create(
		name: "#{@name}",
		email: "#{@email}",
		message: "#{@message}")

		return erb "Message sent successfully"
	end

end