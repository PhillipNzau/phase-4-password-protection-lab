class UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy]


  # GET /users/1
  def show 
    if current_user
      render json: current_user
    else
      render json: { message: 'Not authenticated' }, status: :unauthorized
    end
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      render json: @user, status: :created, location: @user
    else
      render json: {errors: @user.errors.full_messages}, status: :unprocessable_entity
    end
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :password)
    end
end
