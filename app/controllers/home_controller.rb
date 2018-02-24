class HomeController < ApplicationController
  skip_before_action :authenticate

  def show
    if signed_in?
      render :authenticated
    else
      render :anonymous
    end
  end
end
