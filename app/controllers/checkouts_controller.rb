class CheckoutsController < ApplicationController
  def index
    if current_user == nil
      redirect_to root_path
    else
      redirect_to root_path if current_user.premium?
    end
  end

  def charge
    begin
      @customer = Conekta::Customer.create({
        :name => "#{current_user.name}",
        :email => "#{current_user.email}"
        })

      @card = @customer.create_card(:token => params['conektaTokenId'])

      @subscription = @customer.create_subscription({
        :plan => "premium-plan"
        })
    rescue Conekta::ValidationError => e
      puts e.message_to_purchaser
    rescue Conekta::ProcessingError => e
      puts e.message_to_purchaser
    rescue Conekta::Error
      puts e.message
    end
    # current_user.upgrade - Use a webhook to check if the user payment is currently valid
  end
end