module Drivers
  # Driver for Medical Center 1
  # This parse the request to a normalized json-like hash
  class MedicalCenter1 < BaseDriver
    def parse_patients(request)
      parsed = {}
      rut_string = request['run']
      parsed[:rut] = rut_string[0..-2] + '-' + rut_string[-1]
      parsed[:name], parsed[:last_name] = request['nombre'].split(' ', 2)
      parsed[:age] = request['edad']
      parsed
    end

    def parse_professionals(request)
      parsed = {}
      rut_string = request['run']
      parsed[:rut] = rut_string[0..-2] + '-' + rut_string[-1]
      parsed[:name] = request['nombre']
      parsed[:last_name] = request['apellido']
      parsed[:age] = request['edad']
      parsed[:nationality] = request['nacionalidad']
      parsed[:job_title] = request['job_title'] 
      parsed[:grant_date] = request['grant_date']
      parsed[:granting_entity] = request['granting_entity']
      parsed[:speciality] = request['especialidad']
      parsed[:registration_number] = request['numero_registro']
      parsed[:registration_date] = request['fecha_registro']
      parsed[:freelance] = request['freelance']
      parsed[:email] = request['email']
      parsed[:phone] = request['telefono']
      parsed
    end

    def parse_consults(request)
      parsed = {}
      rut_string = request['runPaciente']
      puts rut_string
      puts request.inspect
      parsed[:patient_rut] = rut_string[0..-2] + '-' + rut_string[-1]
      rut_string = request['runProfesional']
      parsed[:professional_rut] = rut_string[0..-2] + '-' + rut_string[-1]
      parsed[:date] = request['fecha']
      parsed[:reason] = request['razon']
      parsed[:symptoms] = request['sintoma']
      parsed[:observations] = request['observaciones']
      parsed
    end

    def parse_movements(request)
      parsed = {}
      parsed[:type] = request['tipo']
      rut_string = request['runPaciente']
      parsed[:patient_rut] = rut_string[0..-2] + '-' + rut_string[-1]
      rut_string = request['runProfesional']
      parsed[:professional_rut] = rut_string[0..-2] + '-' + rut_string[-1]
      parsed[:detail] = request['detalles']
      parsed
    end
    
    def parse_unknown(request)
      parsed = {}
      parsed
    end
  end
end
