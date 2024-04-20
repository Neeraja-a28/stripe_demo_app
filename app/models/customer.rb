class Customer < ApplicationRecord
	 validates :full_name, presence: true
	 validates :email, presence: true, uniqueness: true
	 validates :contact_number, presence: true
end
