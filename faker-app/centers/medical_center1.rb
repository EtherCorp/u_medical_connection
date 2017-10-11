require 'faker'
require 'json'

class MedicalCenter1
  def self.patient
    data = {}
    data[:run] = Faker::Number.number(9)
    data[:nombre] = Faker::Name.name
    data[:edad] = rand(0..110)
    data
  end
end