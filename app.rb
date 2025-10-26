#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

set :database, {adapter: "sqlite3", database: "barbershop.db"}

class Client < ActiveRecord::Base
	validates :name, { presence: true, length: { minimum: 3 } }
	validates :phone, { presence: true }
	validates :datestamp, { presence: true }
	validates :color, { presence: true }
end

class Barber <ActiveRecord::Base
end

class Contact <ActiveRecord::Base
	validates :name, { presence: true, length: { minimum: 3 } }
	validates :email, { presence: true }
	validates :message, { presence: true }
end

before do
	@barbers = Barber.all
end

get '/' do
	erb :index
end

get '/visit' do
	@client = Client.new
	erb :visit
end

post '/visit' do

	@client = Client.new params[:client]

	if @client.save
		erb "Thanks for visit"
	else
		@error = @client.errors.full_messages.first
		erb :visit
	end

end

get '/contacts' do
	@contact = Contact.new
	erb :contacts	
end

post '/contacts' do 

	@contact = Contact.new params[:contact]
	
	if @contact.save
		erb "Thanks for message"
	else
		@error = @contact.errors.full_messages.first
		erb :contacts
	end
	
end

get '/barber/:id' do 
	erb :barber
end