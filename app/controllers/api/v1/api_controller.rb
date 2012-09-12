class Api::V1::ApiController < ApplicationController
  include TokenAuthenticatable
  respond_to :json
  before_filter :restrict_access
end