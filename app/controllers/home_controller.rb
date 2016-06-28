class HomeController < ApplicationController
  def index
    render json: current_user
  end
  def list_of_classes

  end
end
