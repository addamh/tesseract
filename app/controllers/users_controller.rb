class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]
  
  def index
    @users = User.all
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def update
    @user = current_user # User.find(params[:id])
    # uploaded_io = params[:user][:resume]
    # File.open(Rails.root.join('public', 'resume', uploaded_io.original_filename), 'wb') do |file|
    #   file.write(uploaded_io.read)
    # end
    if @user.update_attributes(params[:user])
      redirect_to edit_user_path, :notice => "User updated"
    else
      redirect_to edit_user_path, :notice => "Update failed"
    end
  end

  # def updateskills
  #   @user = User.find(params[:id])
  # end
  
  def destroy
    @user = current_user
    @user.destroy
    redirect_to root_path
  end
  
end
