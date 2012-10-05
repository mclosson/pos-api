class Api::V1::LocationsController < ActionController::Base

  respond_to :json
  before_filter :account_lookup, only: [:index]

  def index
    render json: @account.locations, status: :ok
  end

  private

  def account_lookup
    @account = Account.find_by_registration_code(@request.headers['X-Registration-Code'])
  rescue => exception
    logger.error(exception)
    render json: "{\"error\":\"account not found\"}", status: :not_found
  end

end
