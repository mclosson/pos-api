class AccountsController < ApplicationController
  def new
    @account = Account.new
    @account.users.build
  end

  def create
    @account = Account.new(params[:account])
    if @account.save
      redirect_to login_url, status: 'Successfully created account'
    else
      render :new
    end
  end
end
