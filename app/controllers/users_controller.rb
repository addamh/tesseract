class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]
  
  def edit
    
  end
  
  def show
    
  end
  
  def destroy
    @user = current_user
    @user.destroy
    redirect_to root_path
  end
  
end
