class HomeController < ApplicationController
  def index
    if user_signed_in?
    current_user.payment_processor.payment_method_token = params[:payment_method_token]
    end
  end
end
