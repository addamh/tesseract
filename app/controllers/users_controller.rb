class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]
  
  def 
  def index
    @users = User.all
    
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def show
    
  end
  
  def update
    @profile = Profile.find(params[:id])
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to edit_user_path, :notice => "User updated"
    else
      redirect_to edit_user_path, :notice => "Update failed"
    end
  end
  
  def destroy
    @user = current_user
    @user.destroy
    redirect_to root_path
  end
  
end
