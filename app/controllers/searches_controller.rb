class SearchesController < ApplicationController
  def new
    @search = Search.new
  end

  def search
    puts params
    @users = User.order(:name)
    @users = @users.where("users.name like ?", "%#{params[:name]}%") if params[:name].present?
    @users = @users.joins(:skills).where('skills.id' => params[:skill_id]) if params[:skill_id].present?
  end

  def create
    @search = Search.create!(params[:search])
    redirect_to @search
  end

  def show
    # @search = Search.find(params[:id])
    # @users = User.order(:name)
    # @users = users.where("name like ?", "%#{keywords}%") if name.present?
    # @users = users.where(skill_id: params[:id]) # if skill_id.present?
    # @users
    
  end
end
