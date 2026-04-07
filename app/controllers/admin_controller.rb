class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :require_admin!

  def users
    @users = User.all
    @users = @users.where("email LIKE ?", "%#{params[:search]}%") if params[:search].present?
    @users = @users.page(params[:page]).per(10)
  end

  private

  def require_admin!
    redirect_to dashboard_path, alert: "Access denied!" unless current_user.admin?
  end
end