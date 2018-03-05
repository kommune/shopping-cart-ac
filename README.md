[![CircleCI](https://circleci.com/gh/kommune/shopping-cart-ac/tree/master.svg?style=svg)](https://circleci.com/gh/kommune/shopping-cart-ac/tree/master)

# Shopping Cart AC

This is a shopping cart application for jewellery! 
To visit this site, go to [Bobby!](https://shopping-cart-ac.herokuapp.com/)

# Setup

1. Clone the application
```
git clone https://github.com/kommune/shopping-cart-ac.git
```

2. Run bundle
```
cd shopping-cart-ac
bundle install
```

3. Set up database
```
rake db:create db:migrate db:seed
```