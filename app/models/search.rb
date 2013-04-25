class Search < ActiveRecord::Base
  attr_accessible :name, :skill_id
  def users
    @users ||= find_users
  end

  private

  def find_users
    users = User.order(:name)
    users = users.where("name like ?", "%#{keywords}%") if name.present?
    users = users.where(skill_id: params[:id]) # if skill_id.present?
    users
  end
end
