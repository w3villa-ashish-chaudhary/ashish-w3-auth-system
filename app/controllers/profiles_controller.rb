require 'prawn'

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
      format.pdf do
        pdf = Prawn::Document.new
        pdf.font_size 12

        pdf.text "User Profile", size: 24, style: :bold
        pdf.move_down 10
        pdf.stroke_horizontal_rule
        pdf.move_down 20

        pdf.text "Email:", style: :bold
        pdf.text @user.email
        pdf.move_down 10

        pdf.text "Member Since:", style: :bold
        pdf.text @user.created_at.strftime("%B %d, %Y")
        pdf.move_down 10

        pdf.text "Address:", style: :bold
        pdf.text @user.address.present? ? @user.address : "Not provided"
        pdf.move_down 10

        pdf.text "Account Status:", style: :bold
        pdf.text @user.confirmed? ? "Verified" : "Unverified"
        pdf.move_down 10

        pdf.text "Downloaded On:", style: :bold
        pdf.text Time.now.strftime("%B %d, %Y at %I:%M %p")

        send_data pdf.render,
                  filename: "profile_#{@user.id}.pdf",
                  type: "application/pdf",
                  disposition: "attachment"
      end
    end
  end

  private

  def profile_params
    params.require(:user).permit(:address, :latitude, :longitude, :profile_picture)
  end
end