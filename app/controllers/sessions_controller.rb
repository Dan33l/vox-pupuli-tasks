class SessionsController < ApplicationController
  skip_before_action :logged_in, only: [:new, :create]
  def new; end

  def create
    user = User.from_omniauth(request.env['omniauth.auth'])

    if user.valid?
      session[:user_id] = user.id
      redirect_to(root_path)
      #redirect_to request.env['omniauth.origin']
    end
  end

  def destroy
    reset_session
    redirect_to request.referer
  end
end