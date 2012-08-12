class ProfilesController < ApplicationController
  def create
    if params[:user][:id]
      user = User.find(params[:user][:id])
    elsif params[:user][:twitter_handle]
      user = User.where(:twitter_handle => params[:user][:twitter_handle]).first
    end
    if user
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