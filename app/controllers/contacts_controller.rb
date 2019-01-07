class ContactsController < ApplicationController
  before_action :set_contacts
  before_action :set_contact, only: [:show, :edit, :update, :destroy]

  # GET users/1/contacts
  def index
    @contacts = @user.contacts
  end

  # GET users/1/contacts/1
  def show
  end

  # GET users/1/contacts/new
  def new
    @contact = @user.contacts.build
  end

  # GET users/1/contacts/1/edit
  def edit
  end

  # POST users/1/contacts
  def create
    @contact = @user.contacts.build(contact_params)

    if @contact.save
      redirect_to([@contact.user, @contact], notice: 'Contact was successfully created.')
    else
      render action: 'new'
    end
  end

  # PUT users/1/contacts/1
  def update
    if @contact.update_attributes(contact_params)
      redirect_to([@contact.user, @contact], notice: 'Contact was successfully updated.')
    else
      render action: 'edit'
    end
  end

  # DELETE users/1/contacts/1
  def destroy
    @contact.destroy

    redirect_to user_contacts_url(@user)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contacts
      @user = User.find(params[:user_id])
    end

    def set_contact
      @contact = @user.contacts.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def contact_params
      params.require(:contact).permit(:email, :phone, :user_id)
    end
end
