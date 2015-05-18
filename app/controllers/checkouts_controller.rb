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
      @charge = Conekta::Charge.create({
        amount: "22900",
        currency: "MXN",
        description: "Premium Account",
        reference_id: "premium-account",
        details:
        {
          name: "#{current_user.name}",
          email: "#{current_user.email}"
        },
        card: params['conektaTokenId']
        })
      flash[:notice] = "Card charged successfully."
    rescue Conekta::ParameterValidationError => e
      puts e.message_to_purchaser
    rescue Conekta::ProcessingError => e
      puts e.message_to_purchaser
    rescue Conekta::Error
      puts e.message_to_purchaser
    end
    current_user.upgrade
  end
end