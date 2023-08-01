class HomeController < ApplicationController
  before_action :authenticate_user!, except: %i[index show]

  def index
    @user_name = if user_signed_in?
                   extract_user_name(current_user.email)
                 else
                   'Guest'
                 end
  end

  private

  def extract_user_name(email)
    email.split('@').first.capitalize
  end
end
