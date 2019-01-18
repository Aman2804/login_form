class UsersController < ApplicationController
  before_action :session_check, except: [:create,:new]
  before_action :action_check, only:[:new,:create]
  def index
    @user = User.all
  end
  def show
    @user = User.find(params[:id])
  end
  def new
    @user = User.new
  end
  def edit
    @user = User.find(params[:id])
  end
  def create
    @user = User.new(usr_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
    else
      render 'new'
    end
  end
  def update
    @user = User.find(params[:id])
    if @user.update(update_params)
      redirect_to @user
    else
      #Rails.logger.info(@user.errors.messages.inspect)
      render 'edit'
    end
  end
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end
  
  private
  def usr_params
    params.require(:user).permit(:name,:email,:email_confirmation,:password,:dob)
  end
  def update_params
    params.require(:user).permit(:name,:email,:dob)
  end
  def session_check
    if session[:user_id].blank?
      redirect_to root_url
    end
  end
  def action_check
    if session[:user_id].present?
      redirect_to user_path(session[:user_id])
    end
  end

end
