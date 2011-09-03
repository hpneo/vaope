class SessionsController < ApplicationController

  def create
    auth = request.env['omniauth.auth']
    user = User.find_by_provider_and_uid(auth['provider'], auth['uid'])
    user ||= User.create_with_omniauth(auth)

    if user
      sign_in_and_redirect(:user, user)
    else
      redirect_to new_user_registration_url
    end
  end

  def failure
    render :text => params[:message]
  end

end
