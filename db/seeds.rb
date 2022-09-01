# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

u = User.new(name: 'Andres', email: 'andres@asd.com', password: '123456')
u.skip_confirmation!
u.save

u2 = User.new(name: 'Test', email: 'test@test.com', password: '123456')
u2.skip_confirmation!
u2.save

u3 = User.new(name: 'Mariana', email: 'mariana@test.com', password: '123456')
u3.skip_confirmation!
u3.save

f1 = Food.create(user: u, name: 'apple', quantity: 2, price: 1.32, measurement_unit: 'unit')
f2 = Food.create(user: u, name: 'banana', quantity: 3, price: 1.32, measurement_unit: 'unit')
f3 = Food.create(user: u, name: 'pasta', quantity: 2, price: 1.32, measurement_unit: 'kg')
f4 = Food.create(user: u, name: 'cheese', quantity: 1, price: 5.32, measurement_unit: 'kg')
f5 = Food.create(user: u, name: 'beef', quantity: 1, price: 8.32, measurement_unit: 'lb')

f6 = Food.create(user: u2, name: 'apple', quantity: 2, price: 1.32, measurement_unit: 'unit')
f7 = Food.create(user: u2, name: 'strawberry', quantity: 3, price: 0.52, measurement_unit: 'unit')
f8 = Food.create(user: u2, name: 'macaronni', quantity: 1, price: 2.52, measurement_unit: 'kg')

f9 = Food.create(user: u3, name: 'rice', quantity: 1, price: 0.5, measurement_unit: 'kg')
f10 = Food.create(user: u3, name: 'chicken breast', quantity: 3, price: 10.32, measurement_unit: 'kg')
f11 = Food.create(user: u3, name: 'olive oil', quantity: 10, price: 0.5, measurement_unit: 'ml')
f12 = Food.create(user: u3, name: 'lettuce', quantity: 1, price: 0.7, measurement_unit: 'unit')
f13 = Food.create(user: u3, name: 'tomato', quantity: 1, price: 0.3, measurement_unit: 'unit')

f14 = Food.create(user: u, name: 'Egg', quantity: 3, price: 0.32, measurement_unit: 'unit')
f15 = Food.create(user: u, name: 'oats', quantity: 1, price: 1.22, measurement_unit: 'kg')
f16 = Food.create(user: u, name: 'milk', quantity: 1, price: 2.52, measurement_unit: 'l')
f17 = Food.create(user: u, name: 'salt', quantity: 1, price: 2.12, measurement_unit: 'kg')
f18 = Food.create(user: u, name: 'butter', quantity: 1, price: 1.35, measurement_unit: 'kg')



r1 = Recipe.create(user: u, name: 'Fruit salad', preparation_time: 10, cooking_time: 0, description: 'Delicious fruit salad', public: true)
r2 = Recipe.create(user: u, name: 'Pasta', preparation_time: 20, cooking_time: 30, description: 'Delicious pasta', public: true)
r3 = Recipe.create(user: u2, name: 'Fruit salad', preparation_time: 10, cooking_time: 0, description: 'Delicious fruit salad', public: true)
r4 = Recipe.create(user: u2, name: 'Macaronni', preparation_time: 10, cooking_time: 20, description: 'Delicious Macaronni', public: false)
r5 = Recipe.create(user: u3, name: 'Chicken', preparation_time: 20, cooking_time: 40, description: 'Delicious Chicken', public: true)
r6 = Recipe.create(user: u, name: 'Breakfast', preparation_time: 15, cooking_time: 20, description: 'Delicious Breakfast', public: true)


rf11 = RecipeFood.create(recipe: r1, food: f1, quantity: 3)
rf12 = RecipeFood.create(recipe: r1, food: f2, quantity: 5)

rf21 = RecipeFood.create(recipe: r2, food: f3, quantity: 3)
rf22 = RecipeFood.create(recipe: r2, food: f4, quantity: 2)
rf23 = RecipeFood.create(recipe: r2, food: f5, quantity: 3)

rf31 = RecipeFood.create(recipe: r3, food: f6, quantity: 7)
rf32 = RecipeFood.create(recipe: r3, food: f7, quantity: 1)

rf41 = RecipeFood.create(recipe: r4, food: f8, quantity: 3)

rf51 = RecipeFood.create(recipe: r5, food: f9, quantity: 6)
rf52 = RecipeFood.create(recipe: r5, food: f10, quantity: 7)
rf53 = RecipeFood.create(recipe: r5, food: f11, quantity: 1)
rf54 = RecipeFood.create(recipe: r5, food: f12, quantity: 4)
rf55 = RecipeFood.create(recipe: r5, food: f13, quantity: 6)

rf61 = RecipeFood.create(recipe: r6, food: f14, quantity: 7)
rf62 = RecipeFood.create(recipe: r6, food: f15, quantity: 8)
rf63 = RecipeFood.create(recipe: r6, food: f16, quantity: 2)
rf64 = RecipeFood.create(recipe: r6, food: f17, quantity: 4)
rf65 = RecipeFood.create(recipe: r6, food: f18, quantity: 6)

