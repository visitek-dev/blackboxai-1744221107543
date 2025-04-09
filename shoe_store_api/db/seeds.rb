# Reset database
User.delete_all
Product.delete_all
Category.delete_all

# Create admin user
User.create!(
  email: 'admin@shoestore.com',
  password: 'admin123',
  admin: true
)

# Create sample categories
mens = Category.create!(name: "Men's Shoes", description: "Formal and casual shoes for men")
womens = Category.create!(name: "Women's Shoes", description: "Elegant and comfortable shoes for women")
kids = Category.create!(name: "Kids' Shoes", description: "Durable and fun shoes for children")

# Create sample products
Product.create!([
  {
    name: "Classic Oxford",
    size: "10",
    color: "Black",
    brand: "Allen Edmonds",
    price: 295.99,
    quantity: 15,
    category: mens
  },
  {
    name: "Running Pro",
    size: "9",
    color: "Blue/White",
    brand: "Nike",
    price: 129.99,
    quantity: 22,
    category: mens
  },
  {
    name: "Ballet Flat",
    size: "7",
    color: "Nude",
    brand: "Sam Edelman",
    price: 89.99,
    quantity: 18,
    category: womens
  },
  {
    name: "Light-Up Sneakers",
    size: "3",
    color: "Pink",
    brand: "Skechers",
    price: 49.99,
    quantity: 10,
    category: kids
  }
])

puts "Created #{Category.count} categories and #{Product.count} products"
