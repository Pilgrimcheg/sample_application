class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :index, :destroy]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy

def show
  @user = User.find(params[:id])
  @hotels = @user.hotels.paginate(page: params[:page], per_page: 3)
end

  def new
    if signed_in?
      redirect_to root_path
    else
    @user = User.new
  end
  end

  def create
    if signed_in?
      redirect_to root_path
    else
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success]="Welcome to the Hotel Advisor!"
      redirect_to @user
    else
      render 'new'
    end
    end
  end

  def  edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 7)
  end

  def destroy
    user = User.find(params[:id])
    if (current_user == user) && (current_user.admin?)
      flash[:error] = "Can not delete own admin account!"
    else
      user.destroy
    flash[:success]="User destroyed"
  end
    redirect_to users_url
  end

  private

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def  admin_user
      redirect_to(root_path) unless current_user.admin?
      end

end
