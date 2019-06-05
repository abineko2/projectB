# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name:"橋爪",email:"email@sample.com",
             password:"password",employee_number:1,uid:"admin1",
             password_confirmation: "password",superior:true,
             admin: true)
User.create!(name:"斎藤",email:"superior1@sample.com",
             password:"password",employee_number:2,uid:"superior1",
             password_confirmation: "password",superior:true,
             admin: false)    
User.create!(name:"吉井",email:"superior2@sample.com",
             password:"password",employee_number:3,uid:"superior2",
             password_confirmation: "password",superior:true,
             admin: false)                   
             

59.times do |n|
  gimei = Gimei.new    
  name  = gimei.name.kanji
  email = "email#{n+1}@sample.com"
  employee_number=n+4
  uid="user#{n+4}"
  password = "password"
  User.create!(name:name,email:email,employee_number:employee_number,uid:uid,password:password,password_confirmation:password)
end