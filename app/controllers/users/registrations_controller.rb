module Users
  # class to manage user registration
  class RegistrationsController < Devise::RegistrationsController
    skip_before_action :verify_authenticity_token,
                       if: proc { |c| c.request.format.json? }
    skip_before_filter :verify_signed_out_user,
                       if: proc { |c| c.request.format.json? }

    respond_to :json, :html
  end
end
