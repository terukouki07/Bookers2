class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @books = @user.books
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "You have updated user successfully."
      # ユーザーのShow画面
      redirect_to user_path(@user.id)
    else
      # Userのedit画面
      render :edit
    end
  end

  def index
    @users = User.all
    @user = current_user
  end

  # ストロングパラメータ
  private

  def user_params
    params.require(:user).permit(:name, :image, :introduction)
  end
end
