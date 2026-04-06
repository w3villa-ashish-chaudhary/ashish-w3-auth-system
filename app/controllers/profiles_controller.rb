class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(profile_params)
      if params[:user][:profile_picture].present?
        @user.profile_picture.attach(params[:user][:profile_picture])
      end
      redirect_to profile_path, notice: "Profile updated successfully!"
    else
      render :edit
    end
  end

  def download
    @user = current_user
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "profile_#{@user.id}",
               template: "profiles/download",
               layout: "pdf"
      end
    end
  end

  private

  def profile_params
    params.require(:user).permit(:address, :latitude, :longitude, :profile_picture)
  end
end