# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Product.delete_all
Product.create(:title => "learn rails 1",
  :description =>
  %{
    Lorem ipsum dolor sit amet, consectetur adipisicing elit. Vitae molestias, quisquam maiores, aspernatur cupiditate et est aperiam ullam, blanditiis aut, architecto repellendus? Dolores nihil deserunt obcaecati fugiat, suscipit corporis ipsum.
  },
  :image_url => "rails_1.png",
  :price => 20
)
Product.create(:title => "learn rails 2",
  :description =>
  %{
    Lorem ipsum dolor sit amet, consectetur adipisicing elit. Vitae molestias, quisquam maiores, aspernatur cupiditate et est aperiam ullam, blanditiis aut, architecto repellendus? Dolores nihil deserunt obcaecati fugiat, suscipit corporis ipsum.
  },
  :image_url => "rails_2.png",
  :price => 30
)

