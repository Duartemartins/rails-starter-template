class AddPayCustomerNameToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :pay_customer_name, :string
  end
end
