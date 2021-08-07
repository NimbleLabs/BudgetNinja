class Api::V1::SessionsController < Devise::SessionsController
  respond_to :json
  skip_before_action :verify_authenticity_token

  def create
    self.resource = warden.authenticate!(auth_options.merge({store:false}))
    sign_in(resource_name, resource, store: false)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end
end