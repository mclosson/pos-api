class Api::V1::DevicesController < ActionController::Base

  respond_to :json
  before_filter :account_lookup, only: [:link]

  def link
    render json: "{}", status: :ok
  end

  private

  def account_lookup
    @account = Account.find_by_registration_code(request.headers['X-Registration-Code'])
    render(json: "{\"error\":\"account not found\"}", status: :not_found) if @account.nil?
  rescue => exception
    logger.error(exception)
    render json: "{\"error\":\"account not found\"}", status: :not_found
  end

end
