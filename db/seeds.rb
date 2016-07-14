Organization.delete_all
organizations = Organization.create([
  { name: 'Microsoft' },
  { name: 'Apple' },
  { name: 'Xerox' },
  ])

User.delete_all
user = User.create([
 {name: 'Admin', email: 'admin@gmail.com', :password => '123456', :password_confirmation => '123456', organization: organizations.sample[1] },
 {name: 'User', email: 'user@gmail.com', :password => '123456', :password_confirmation => '123456', organization: organizations.sample[1] }

 ])

Category.delete_all
categories = Category.create([
  { name: 'First course' },
  { name: 'Main course' },
  { name: 'Drinks' }
])

Product.delete_all
first_course_products = Product.create([
  { name:"Chicken and Wild Rice Soup",           price: 110,      category: categories[0] },
  { name:"North Woods Bean Soup ",                price: 100,      category: categories[0] },
  { name:"Indian-Spiced Lentils and Lamb",     price: 120,      category: categories[0] },
  { name:"Baked Potato Soup",                         price: 130,      category: categories[0] },
  { name:"Garden Minestrone",                         price: 115,       category: categories[0] },
  { name:"Chicken Soup",                                  price: 90,         category: categories[0] },
  { name:"Borsch",                                             price: 125,       category: categories[0] }
])
main_course_products = Product.create([
  { name:"Grilled Burgers With Mushroom ",  price: 145,    category: categories[1] },
  { name:"Pike Cakes with Crayfish Sauce ",  price: 135,    category: categories[1] },
  { name:"Basque Seafood Stew",                   price: 140,    category: categories[1] },
  { name:"Bacon and Egg Fried Rice",             price: 145,    category: categories[1] },
  { name:"Corkscrew Pasta with Eggplant",    price: 155,    category: categories[1] },
  { name:"Tortellini Primavera",                      price: 165,    category: categories[1] }
])
drinks_products =   Product.create([
   { name:"Coca Cola", price: 85,              category: categories[2] },
   { name:"Fresh",        price: 110,            category: categories[2] },
   { name:"Tea",           price: 85,              category: categories[2] },
   { name:"Coffe",        price: 85,               category: categories[2] },
   { name:"Sprite",       price: 85,               category: categories[2] },
   { name:"Lemonade", price: 95,              category: categories[2] }
])

Weekday.delete_all
Weekday.create! id:1, name: "Monday", products:  first_course_products.sample(3) + main_course_products.sample(3) + drinks_products.sample(3)
Weekday.create! id:2, name: "Tuesday", products:  first_course_products.sample(3) + main_course_products.sample(3) + drinks_products.sample(3)
Weekday.create! id:3, name: "Wednesday", products:  first_course_products.sample(3) + main_course_products.sample(3) + drinks_products.sample(3)
Weekday.create! id:4, name: "Thursday", products:  first_course_products.sample(3) + main_course_products.sample(3) + drinks_products.sample(3)
Weekday.create! id:5, name: "Friday", products:  first_course_products.sample(3) + main_course_products.sample(3) + drinks_products.sample(3)
Weekday.create! id:6, name: "Saturday", products:  first_course_products.sample(3) + main_course_products.sample(3) + drinks_products.sample(3)
Weekday.create! id:7, name: "Sunday", products:  first_course_products.sample(3) + main_course_products.sample(3) + drinks_products.sample(3)
