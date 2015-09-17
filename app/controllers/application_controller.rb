class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_filter :verify_authenticity_token, if: proc { |c| c.request.format.json? }
  #before_filter :authenticate_user_from_token!, if: proc { |c| c.request.format.json? }
  #before_filter :authenticate_user!

private

def authenticate_user_from_token!
    # Notice how we use Devise.secure_compare to compare the token
    # in the database with the token given in the params, mitigating
    # timing attacks.
    authenticate_or_request_with_http_token do |token, options|
      user_email = options['user-email']
      user = user_email && User.find_by_email(user_email)
      validate_user_authenticity(user, token)
    end
  end

  def validate_user_authenticity(user, token)
    if user && Devise.secure_compare(user.authentication_token,
                                     token)
      sign_in user, store: false
    elsif devise_controller? && params[:action] == 'create'
      true
    elsif !devise_controller? || (devise_controller? &&
                                params[:action] == 'destroy')
      render json: { message: "Unauthorized", status_code: 401 }
    end
  end

end
