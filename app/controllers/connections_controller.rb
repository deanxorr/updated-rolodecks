class ConnectionsController < ApplicationController
	def create
		Contact.find(params[:current_id]).connect(Contact.find(params[:contact_id]))
		redirect_to contacts_path()
	end

end