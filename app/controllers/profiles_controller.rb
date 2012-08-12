class ProfilesController < ApplicationController
  def create
    if params[:user][:id]
      user = User.find(params[:user][:id])
      user.update_attributes(params[:user])
    else
      password = Devise.friendly_token[0,20]
      params[:user][:password] = password
      params[:user][:password_confirmation] = password
      user = User.new(params[:user])
      user.save!
    end

    respond_to do |format|
      format.json { render :json => { :user => user } }
    end
  end
end