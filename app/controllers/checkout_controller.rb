class CheckoutController < ApplicationController
  before_action :authenticate_user!

  def show
    current_user.set_payment_processor :stripe
    current_user.payment_processor.customer

    @checkout_session = current_user.payment_processor.checkout(
      mode: "subscription",
      line_items: "price_xxx",
      success_url: checkout_success_url,
      cancel_url: checkout_cancel_url
    )
  end

  def success
    @session = Stripe::Checkout::Session.retrieve(params[:session_id])
    @line_items = Stripe::Checkout::Session.list_line_items(params[:session_id])
    current_user.set_payment_processor :stripe
    customer = current_user.payment_processor.customer

    # Get the subscription ID from the session
    subscription_id = @session.subscription
    subscription = Stripe::Subscription.retrieve(subscription_id)

    # Get the payment method ID from the subscription
    payment_method_id = subscription.default_payment_method
    payment_method = Stripe::PaymentMethod.retrieve(payment_method_id)

    # Attach the payment method to the customer if it's not already attached
    if payment_method.customer.nil? || payment_method.customer != customer.id
      Stripe::PaymentMethod.attach(payment_method_id, {
        customer: customer.id,
      })
    end

    # Set the attached payment method as the customer's default payment method
    Stripe::Customer.update(customer.id, {
      invoice_settings: {
        default_payment_method: payment_method_id,
      },
    })

    # Proceed with the subscription
    current_user.payment_processor.subscribe(name: "default", plan: "price_xxx")
    if current_user.payment_processor.subscribed?
      flash[:success] = "Payment registered"
      redirect_to root_path
    else
      flash[:warning] = "Payment was not successful. Please try again."
      redirect_to root_path
    end
  end
  def cancel
    flash[:warning] = "Payment was not successful. Please try again."
    redirect_to root_path
  ends
end
