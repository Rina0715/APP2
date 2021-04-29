class UsersController < ApplicationController
  before_action :check_user, only: [:edit, :update]
  def show
    @user = User.find(params[:id])
    @new_book = Book.new
    @books = @user.books
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.user_id = current_user.id
    if @user.save
     flash[:notice] = "User was successfully created."
     redirect_to user_path
    else
     render :edit
    end
  end

  def edit
    @user = User.find(params[:id])
     if @user == current_user

     else
       redirect_to user_path(current_user)
     end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
       flash[:notice] = "User was successfully created."
       redirect_to user_path(@user.id)
    else
       render :edit
    end
  end

  def index
    @user = current_user
    @new_book = Book.new
    @users = User.all
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :introduction)
  end
  
  def check_user
    @user = User.find(params[:id])
    if @user.id != current_user.id
      redirect_to user_path(current_user)
    end
  end


end
