module Storefront::V1
    class UserController < ApiController
      before_action :load_user, only: [:show, :update, :destroy]

   def show; end

    def update
      @user.attributes = user_params
      save_user!
    end

   def create
      @user = User.new(user_params)
      save_user!
    end

    def destroy
      @user.avatar.purge
      @user.destroy!
    rescue
      render_error(fields: @user.errors.messages)
    end

    private

    def load_user
      @user = User.find(params[:id])
    end

    def save_user!
      @user.save!
      render :show
    rescue
      render_error fields: @user.errors.messages
    end

    def user_params
      params.require(:user).permit(:name, :email, :password, :profile, :password_confirmation,
                                      :avatar, :image)
    end
  end
end
