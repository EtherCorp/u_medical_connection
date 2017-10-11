require 'json'

class JsonFileEstandar
	def createJson(token, medicalcenter, save, name, lastname, age, rut, queued, status)
		tempHash = {
		    "token" => token,
		    "medical_center" => medicalcenter,
		    "save" => save,
		    "name" => name,
		    "lastname" => lastname,
		    "age" => age,
		    "rut" => rut,
		    "queued" => queued,
		    "status" => status
		}
		File.open("./temp.json","w") do |f|
  			f.write(tempHash.to_json)
		end
	end
end