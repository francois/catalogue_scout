class ApplicationController < ActionController::Base
  before_action :authenticate

  private

  def authenticate
    redirect_to signin_path unless signed_in?
  end

  def current_user
    return nil
    @_current_user ||= User.find(1)
  end

  def signed_in?
    !!current_user
  end
end
