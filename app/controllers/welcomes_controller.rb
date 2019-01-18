class WelcomesController < ApplicationController
  before_action :check_session, except:[:create,:new,:index]
  def index
  end
  def new 
    @welcome = Welcome.new
  end
  def create
    @welcome = Welcome.new(wel_params)
    user = User.find_by_email(params[:welcome][:email])
    if user.password == params[:welcome][:password]
        session[:user_id] = user.id
        redirect_to user, notice: "Logged in!"
        else
        @welcome.destroy
        flash.now.alert = "Email or password is invalid"
        render "new"
    end
  end
  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
  private
    def wel_params
      params.require(:welcome).permit(:email,:password)
    end
    def check_session
      if session[:user_id].blank?
        redirect_to root_url
      end
    end


end
