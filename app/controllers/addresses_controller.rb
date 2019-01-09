class AddressesController < ApplicationController
  before_action :set_addresses
  before_action :set_address, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET users/1/addresses
  def index
    @addresses = @user.addresses
  end

  # GET users/1/addresses/1
  def show
  end

  # GET users/1/addresses/new
  def new
    @address = @user.addresses.build
  end

  # GET users/1/addresses/1/edit
  def edit
  end

  # POST users/1/addresses
  def create
    @address = @user.addresses.build(address_params)

    if @address.save
      redirect_to([@address.user, @address], notice: 'Address was successfully created.')
    else
      render action: 'new'
    end
  end

  # PUT users/1/addresses/1
  def update
    if @address.update_attributes(address_params)
      redirect_to([@address.user, @address], notice: 'Address was successfully updated.')
    else
      render action: 'edit'
    end
  end

  # DELETE users/1/addresses/1
  def destroy
    @address.destroy

    redirect_to user_addresses_url(@user)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_addresses
      @user = User.find(params[:user_id])
    end

    def set_address
      @address = @user.addresses.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def address_params
      params.require(:address).permit(:cep, :street, :number, :complement, :user_id)
    end
end
