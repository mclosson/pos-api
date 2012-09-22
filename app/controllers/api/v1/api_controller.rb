class Api::V1::ApiController < ActionController::Base
  include TokenAuthenticatable
  respond_to :json
  before_filter :restrict_access
end
