Admin.create!(email: "admin@example.com", password: "123123")
puts "Default admin created!"

User.create!(first_name: "Sally", last_name: "Who", email:"sallywho@example.com", password: "123123")
puts "1 user created!"

Product.create!(name: "Stacker Ring", price: 69.00, description: "Solid Yellow Gold" )
Product.create!(name: "Stacker Ring", price: 69.00, description: "Solid White Gold" )
Product.create!(name: "Stacker Ring", price: 69.00, description: "Solid Rose Gold" )
Product.create!(name: "Diamond Beaded Ring", price: 169.00, description: "Solid Yellow Gold, Diamond" )
Product.create!(name: "Diamond Beaded Ring", price: 169.00, description: "Solid White Gold, Diamond" )
Product.create!(name: "Diamond Beaded Ring", price: 169.00, description: "Solid Rose Gold, Diamond" )
puts "6 products created!"

Category.create!(name: 0)
Category.create!(name: 1)
Category.create!(name: 2)
Category.create!(name: 3)
Category.create!(name: 4)
Category.create!(name: 5)
puts "4 categories created!"

CategoriesProduct.create!(product: Product.first, category: Category.first)
CategoriesProduct.create!(product: Product.second, category: Category.first)
CategoriesProduct.create!(product: Product.third, category: Category.first)
CategoriesProduct.create!(product: Product.fourth, category: Category.second)
CategoriesProduct.create!(product: Product.fifth, category: Category.third)
CategoriesProduct.create!(product: Product.last, category: Category.third)
puts "Category-Product association created!"