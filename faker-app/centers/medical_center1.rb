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

  def self.professional
  	data = {}
    data[:run] = Faker::Number.number(9)
    data[:nombre] = Faker::Name.name
    data[:edad] = rand(0..110)
    #data[:nacionalidad] = Faker::Country.country
    data[:especialidad] = Faker::Company.name
    data[:freelance] = Faker::Boolean.boolean
    data 
  end

  def self.consult
  	data = {}
  	cont = 0
  	@line = nil
  	random = Random.rand(10)
  	professionalsdata = File.open('professionals.json','r')
  	professionalsdata.each_line do |infile|
  		while (cont == random)
  			@line = infile
  			break
  		end
  		cont = cont + 1
  	end
  	data_hash_professional = JSON.parse(@line)
  	data[:runProfesional] = data_hash_professional['run']
 	cont = 0
  	patientsdata = File.open('patients.json','r')
  	patientsdata.each_line do |infile|
  		while (cont == random)
  			@line = infile
  			break
  		end
  		cont = cont + 1
  	end
  	data_hash_patient = JSON.parse(@line)
    data[:runPaciente] = data_hash_patient['run']
    data[:razon] = Faker::Company.name
    data[:sintoma] = Faker::Company.name
    data[:observaciones] = Faker::Company.name
    data
  end	
end