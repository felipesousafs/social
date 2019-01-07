class ReactionTypesController < ApplicationController
  before_action :set_reaction_type, only: [:show, :edit, :update, :destroy]

  # GET /reaction_types
  # GET /reaction_types.json
  def index
    @reaction_types = ReactionType.all
  end

  # GET /reaction_types/1
  # GET /reaction_types/1.json
  def show
  end

  # GET /reaction_types/new
  def new
    @reaction_type = ReactionType.new
  end

  # GET /reaction_types/1/edit
  def edit
  end

  # POST /reaction_types
  # POST /reaction_types.json
  def create
    @reaction_type = ReactionType.new(reaction_type_params)

    respond_to do |format|
      if @reaction_type.save
        format.html { redirect_to @reaction_type, notice: 'Reaction type was successfully created.' }
        format.json { render :show, status: :created, location: @reaction_type }
      else
        format.html { render :new }
        format.json { render json: @reaction_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reaction_types/1
  # PATCH/PUT /reaction_types/1.json
  def update
    respond_to do |format|
      if @reaction_type.update(reaction_type_params)
        format.html { redirect_to @reaction_type, notice: 'Reaction type was successfully updated.' }
        format.json { render :show, status: :ok, location: @reaction_type }
      else
        format.html { render :edit }
        format.json { render json: @reaction_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reaction_types/1
  # DELETE /reaction_types/1.json
  def destroy
    @reaction_type.destroy
    respond_to do |format|
      format.html { redirect_to reaction_types_url, notice: 'Reaction type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reaction_type
      @reaction_type = ReactionType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reaction_type_params
      params.require(:reaction_type).permit(:name, :description)
    end
end
