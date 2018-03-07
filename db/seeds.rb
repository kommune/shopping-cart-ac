
Admin.create!(email: "admin@example.com", password: "123123")
puts "Default admin created!"

User.create!(first_name: "Sally", last_name: "Who", email:"SallyWho@example.com", password: "123123", shipping_address: "Sample address", billing_address: "Sample address", contact_number: "123456")
puts "1 user created!"

Product.create!(name: "Bob", price: 12.00, description: "Nice accessory" )
Product.create!(name: "Tom", price: 10.00, description: "Great accessory" )
Product.create!(name: "Jerry", price: 7.00, description: "Lovely accessory" )
puts "3 products created!"

Category.create!(name: 0)
Category.create!(name: 1)
Category.create!(name: 2)
Category.create!(name: 3)
Category.create!(name: 4)
Category.create!(name: 5)
puts "4 categories created!"

