class HomeController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @user_name = if user_signed_in?
                   current_user.name
                 else
                   'Guest'
                 end
  end
end
