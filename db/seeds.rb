# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(:Emp_num => '1000',:Emp_name => '性　名',:password_digest => 'passpass')
User.create(:Emp_num => '1001',:Emp_name => '性2　名2',:password_digest => 'passpass2')