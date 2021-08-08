class RegistrationsController < Devise::RegistrationsController
  # before_action :check_captcha, only: [:create]

  def new
    if params[:uuid].present?
      @invitation = Invitation.find_by_uuid(params[:uuid])
    end

    super
  end

end