class User < ActiveRecord::Base
  # To use devise-twitter don't forget to include the :twitter_oauth module:
  # e.g. devise :database_authenticatable, ... , :twitter_oauth

  # IMPORTANT: If you want to support sign in via twitter you MUST remove the
  #            :validatable module, otherwise the user will never be saved
  #            since it's email and password is blank.
  #            :validatable checks only email and password so it's safe to remove

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :twitter_handle, :provider, 
    :uid, :phone, :first_name, :last_name, :company, :facebook, :linkedin, :foursquare, :googleplus, :homepage
  # attr_accessible :title, :body

  def self.find_for_twitter_oauth(omniauth)
    user = User.where(:provider => omniauth['provider'], :uid => omniauth['uid']).first
    if user.nil?
      password = Devise.friendly_token[0,20]
      user = User.create!(:provider => omniauth['provider'], :uid => omniauth['uid'], :password => password, :password_confirmation => password, :email => omniauth['uid'] + "@twitter.com")
      user.save
    end
    user
  end
end
