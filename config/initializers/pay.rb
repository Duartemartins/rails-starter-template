Pay.setup do |config|
  # For use in the receipt/refund/renewal mailers
  config.business_name = ''
  config.business_address = ''
  config.application_name = ''
  config.support_email = ''
  config.default_product_name = 'default'
  config.default_plan_name = 'default'

  config.automount_routes = true
  config.routes_path = '/pay' # Only when automount_routes is true
  # All processors are enabled by default. If a processor is already implemented in your application, you can omit it from this list and the processor will not be set up through the Pay gem.
  config.enabled_processors = %i[stripe braintree paddle]
  # All emails can be configured independently as to whether to be sent or not. The values can be set to true, false or a custom lambda to set up more involved logic. The Pay defaults are show below and can be modified as needed.
  config.emails.payment_action_required = true
  config.emails.receipt = true
  config.emails.refund = true
  # This example for subscription_renewing only applies to Stripe, therefor we supply the second argument of price
  config.emails.subscription_renewing = lambda { |_pay_subscription, price|
    (price&.type == 'recurring') && (price.recurring&.interval == 'month')
  }

  # Customize who receives emails. Useful when adding additional recipients other than the Pay::Customer. This defaults to the pay customer's email address.
  # config.mail_to = ->(mailer, params) { "#{params[:pay_customer].customer_name} <#{params[:pay_customer].email}>" }

  # Customize mail() arguments. By default, only includes { to: }. Useful when you want to add cc, bcc, customize the mail subject, etc.
  # config.mail_arguments = ->(mailer, params) {
  #   {
  #     to: Pay.mail_recipients.call(mailer, params)
  #   }
  # }
end
