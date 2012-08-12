class ProfilesController < ApplicationController
  def create
    password = Devise.friendly_token[0,20]
    params[:user][:password] = password
    params[:user][:password_confirmation] = password
    user = User.new(params[:user])
    user.save!

    respond_to do |format|
      format.json { render :json => { :success => true, :user_id => user.id } }
    end
  end
end