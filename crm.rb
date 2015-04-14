require 'sinatra'
require 'data_mapper'


DataMapper.setup(:default,"sqlite3:database.sqlite3")

class Contact 
	include DataMapper::Resource

	property :id, Serial
	property :first_name, String
	property :last_name, String
	property :email, String
	property :note, String


	DataMapper.finalize
	DataMapper.auto_upgrade!


	#attr_accessor :first_name, :last_name, :email, :note, :id

	# def initialize(first_name, last_name, email, note)
	#     @first_name = first_name
	#     @last_name = last_name
	#     @email = email
	#     @note = note
	# end
end



# Temporary fake data so that we always find contact with id 1000.

# $rolodex.add_contact(Contact.new("Johnny", "Bravo", "johnny@bitmakerlabs.com", "Rockstar"))

# contact = $rolodex.find(1000)

put "/contacts/:id" do
  @contact = Contact.get(params[:id])
  if @contact
    @contact.first_name = params[:first_name]
    @contact.last_name = params[:last_name]
    @contact.email = params[:email]
    @contact.note = params[:note]

    @contact.save
    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end

delete "/contacts/:id" do
  @contact = Contact.get(params[:id])
  if @contact
     @contact.destroy
    redirect to("/contacts")
  else
    raise Sinatra::NotFound
  end
end



get '/' do
	@crm_app_name = "My CRM"
	erb :index
end

get "/contacts/:id/edit" do
  @contact = Contact.get(params[:id])
    if @contact
    erb :edit_contact
  else
    raise Sinatra::NotFound

    end
end



get '/contacts' do
	@contacts = Contact.all
	erb :contacts
end


get '/contacts/new' do
	erb :new_contact
end

get '/contacts/edit' do
end

get "/contacts/:id" do
	@contact = Contact.get(params[:id].to_i)
	  erb :show_contact
    end
 

post '/contacts' do
  new_contact = Contact.create(
  first_name: params[:first_name], 
  last_name: params[:last_name],
  email: params[:email],
  note: params[:note],)
  redirect to ('/contacts')
	
end









