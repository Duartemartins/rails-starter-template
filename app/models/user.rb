class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  pay_customer stripe_attributes: :stripe_attributes
  pay_customer default_payment_processor: :stripe

  def stripe_attributes(pay_customer)
    {
      address: {
        city: pay_customer.owner.city,
        country: pay_customer.owner.country
      },
      metadata: {
        pay_customer_id: pay_customer.id,
        user_id: id # or pay_customer.owner_id
      }
    }
  end

  after_initialize :set_default_usage_count, if: :new_record?

  private

  def set_default_usage_count
    self.usage_count ||= 0
  end
end
