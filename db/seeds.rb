Admin.create(email: "admin@example.com", password: "123123")
puts "Default admin created!"

User.create(first_name: "Sally", last_name: "Who", email:"SallyWho@example.com", password: "123123", shipping_address: "Sample address", billing_address: "Sample address", contact_number: "123456")
puts "1 user created!"
