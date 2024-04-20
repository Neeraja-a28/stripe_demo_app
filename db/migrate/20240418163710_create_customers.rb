class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :full_name
      t.string :email
      t.integer :contact_number
      t.integer :stripe_customer_id

      t.timestamps
    end
  end
end
