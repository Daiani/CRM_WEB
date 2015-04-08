require_relative 'rolodex'
require_relative 'contact'
require 'sinatra'

get '/' do
@crm_app_name = "My CRM"
erb :index
end

get '/contacts' do
	@contacts = []
	@contacts << Contact.new("Yehuda", "Katz", "yeduda@gmail.com", "Developer")
	@contacts << Contact.new("Sarah", "Andrade", "mark@gmail.com", "CFO")
	@contacts << Contact.new("Paul", "Macedo", "paul@gmail.com", "sales")

erb :contacts
end


