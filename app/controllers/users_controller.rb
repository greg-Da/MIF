class UsersController < ApplicationController
  before_action :authenticate_user!
  # before_action :validated_user?
  before_action :good_user, only: [:update]
  before_action :set_user, only: [:edit, :update]


  # GET /users/1
  def show
    @user = User.find(params[:id])
    @validated_correspondances = @user.validated_correspondances
    @correspondance_new = Correspondance.new
    @correspondance = Correspondance.select(current_user, @user)

    respond_to do |format|
      format.html {}
      format.js {render "show_user"}
    end
  end


  # GET /users/1/edit
  def edit
    @user = current_user
    @languages = Language.all
    respond_to do |format|
      format.html { redirect_to current_user}
      format.js {}
    end
  end

  # POST /users
  def create
    @user = User.new(user_params)
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  def update
    respond_to do |format|
      if @user.update(user_params)
        UserLanguage.where(user: current_user).destroy_all
        unless params[:language_ids].nil?
          params[:language_ids].each do |id|
            if Language.exists?(id)
              @user.languages << Language.find(id)
            end
          end
        end
        format.html { redirect_to user_path(current_user.id), notice: 'User was successfully updated.' }
        format.json { render :edit, status: :ok, location: @user }
      else
        flash.now[:danger] = "User was not successfully updated"
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def good_user
      if current_user != User.find(params[:id])
        flash[:danger] = "You can not modify the profile of another user"
        redirect_to root_path
      end
    end

    def set_user
      @user = User.find(current_user.id)
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :description, :age, :welcome_message, :city_id, :nationality)
    end

end
