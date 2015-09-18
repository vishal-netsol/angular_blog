class Users::SessionsController < Devise::SessionsController
  skip_before_action :verify_authenticity_token,
                       if: proc { |c| c.request.format.json? }
  skip_before_filter :verify_signed_out_user,
                       if: proc { |c| c.request.format.json? }


  def create
    user = warden.authenticate!(auth_options)
    token = Tiddle.create_and_return_token(user, request)
    render json: { authentication_token: token, email: user.email}
  end

  def destroy
    Tiddle.expire_token(current_user, request) if current_user
    sign_out(current_user)
    render json: {}
  end

end