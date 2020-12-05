class TopController < ApplicationController
  def index
    if logged_in?
      redirect_to actionplans_path;
    end
  end
end
