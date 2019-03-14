class CorrespondancesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_correspondance, only: [:show, :edit, :update, :destroy]

  # GET /correspondances
  # GET /correspondances.json
  def index
    @correspondances = current_user.correspondances
  end

  # GET /correspondances/1
  # GET /correspondances/1.json
  def show
  end

  # GET /correspondances/new
  def new
    @correspondance = Correspondance.new
  end

  # GET /correspondances/1/edit
  def edit
  end

  # POST /correspondances
  # POST /correspondances.json
  def create
    other_user = User.find(params[:correspondance][:user_id])
    @correspondance = Correspondance.new(creator: current_user, acceptor: other_user)
    message = params[:correspondance][:message]
    message == ""? message = "#{current_user.name } ask you to be his penfriend": message
    @correspondance.message = message
    respond_to do |format|
      if @correspondance.save
        format.html { redirect_to current_user, notice: 'You have send a new penfrend request' }
      else
        format.html { redirect_to other_user }
      end
    end
  end

  # PATCH/PUT /correspondances/1
  # PATCH/PUT /correspondances/1.json
  def update
    respond_to do |format|
      if @correspondance.update(correspondance_params)
        format.html { redirect_to @correspondance, notice: 'Correspondance was successfully updated.' }
        format.json { render :show, status: :ok, location: @correspondance }
      else
        format.html { render :edit }
        format.json { render json: @correspondance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /correspondances/1
  # DELETE /correspondances/1.json
  def destroy
    @correspondance.destroy
    respond_to do |format|
      format.html { redirect_to correspondances_url, notice: 'Correspondance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_correspondance
      @correspondance = Correspondance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def correspondance_params
      params.require(:correspondance).permit(:user_id, :user_id)
    end
end
