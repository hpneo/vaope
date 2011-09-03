class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me

  has_many :places

  def self.create_with_omniauth(auth)
    user = User.new
    user.provider = auth['provider']
    user.uid = auth['uid']
    
    if auth['user_info']
      user.name = auth['user_info']['name'] if auth['user_info']['name']
      user.email = auth['user_info']['email'] if auth['user_info']['email']
    end
    if auth['extra']['user_hash']
      user.name = auth['extra']['user_hash']['name'] if auth['extra']['user_hash']['name']
      user.email = auth['extra']['user_hash']['email'] if auth['extra']['user_hash']['email']
    end

    password = Devise.friendly_token[0,20]
    user.email = 'robot@vaope.com' if user.email.blank?
    user.password = password
    user.password_confirmation = password

    if user.save
      user
    else
      puts user.errors.inspect
      nil
    end
  end
  
end
