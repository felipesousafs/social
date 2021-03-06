class StrikesController < ApplicationController
  before_action :set_strike, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  # GET /strikes
  # GET /strikes.json
  def index
    @strikes = Strike.all
  end

  # GET /strikes/1
  # GET /strikes/1.json
  def show
  end

  # GET /strikes/new
  def new
    @strike = Strike.new
  end

  # GET /strikes/1/edit
  def edit
  end

  # POST /strikes
  # POST /strikes.json
  def create
    @strike = Strike.new(strike_params)

    respond_to do |format|
      if @strike.save
        format.html { redirect_to @strike, notice: 'Strike was successfully created.' }
        format.json { render :show, status: :created, location: @strike }
      else
        format.html { render :new }
        format.json { render json: @strike.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /strikes/1
  # PATCH/PUT /strikes/1.json
  def update
    respond_to do |format|
      if @strike.update(strike_params)
        format.html { redirect_to @strike, notice: 'Strike was successfully updated.' }
        format.json { render :show, status: :ok, location: @strike }
      else
        format.html { render :edit }
        format.json { render json: @strike.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /strikes/1
  # DELETE /strikes/1.json
  def destroy
    @strike.destroy
    respond_to do |format|
      format.html { redirect_to strikes_url, notice: 'Strike was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_strike
      @strike = Strike.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def strike_params
      params.require(:strike).permit(:text, :user_id, :post_id)
    end
end
