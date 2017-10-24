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
    data[:apellido] = Faker::Name.last_name 
    data[:edad] = rand(0..110)
    data[:nacionalidad] = Faker::Demographic.demonym
    data[:job_title] = Faker::Job.title
    data[:grant_date] = Faker::Date.backward
    data[:granting_entity] = Faker::University.name
    #data[:especiality] = Faker::Job.title  <-- como es una referencia de la tabla especialidad... no se que colocar
    data[:numero_registro] = Faker::Number.number(9)
    data[:fecha_registro]= Faker::Date.backward
    data[:especialidad] = Faker::Company.name
    data[:freelance] = Faker::Boolean.boolean
    data[:telefono] = Faker::Number.number(9)
    data[:email]= Faker::Internet.email(data[:nombre])
    
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
    data[:fecha] = Faker::Date.backward
    data[:razon] = Faker::Company.name
    data[:sintoma] = Faker::Company.name
    data[:observaciones] = Faker::Company.name
    data
  end	
end