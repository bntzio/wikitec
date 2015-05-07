 # Store the environment variables on the Rails.configuration object
 Rails.configuration.conekta = {
   conekta_public: ENV['CONEKTA_PUBLIC'],
   conekta_private: ENV['CONEKTA_PRIVATE']
 }
 
 # Set our app-stored secret key with Conekta
 Conekta.api_key = Rails.configuration.conekta[:conekta_private]