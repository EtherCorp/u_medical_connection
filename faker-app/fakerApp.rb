
require 'faker'
require 'rubygems'
require 'json'
require 'net/http'
require 'uri'
n = 0
File.open("example.json","w") do |f|
while n < 100
  


  number = rand(3)
  name = Faker::Name.name
  addres = Faker::Address.city
  number_cellphone = Faker::PhoneNumber.cell_phone
  job = Faker::Job.title
  sick = Faker::Boolean.boolean
  isapre = Faker::Company.name
  exam_date = Faker::Date.forward(23)
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  if number == 1
    my_hash = { :name => name, :Address => addres, :cellphone => number_cellphone, :job => job, :exam_date => exam_date }
  
  elsif number == 2
    my_hash = { :name => name, :Address => addres, :cellphone => number_cellphone, :job => job, :isapre => isapre, :sick => sick }

  else
    my_hash = { :first_name => first_name, :last_name => last_name, :Address => addres, :cellphone => number_cellphone, :job => job, :isapre => isapre, :sick => sick }
  end

  n += 1

   File.open("temp.json","a") do |f|
     f.puts(my_hash)
     f.puts
   end
   puts my_hash
   header = {'Content-Type': 'application/json'}
   uri = URI.parse("http://localhost:3000/api/v1/")
   http = Net::HTTP.new(uri.host, uri.port)
  request = Net::HTTP::Post.new(uri.path,header)
  request.body = my_hash.to_json
  response = http.request(request)
end
end
